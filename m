Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F1C282DD
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9373206BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfDWHJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:09:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbfDWHJr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:09:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E776CACC5;
        Tue, 23 Apr 2019 07:09:44 +0000 (UTC)
Subject: Re: [RFC PATCH v2 13/16] bcache: fix fifo index swapping condition in
 btree_flush_write()
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-14-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0f302a9e-3718-e042-abb0-0ed518ee1583@suse.de>
Date:   Tue, 23 Apr 2019 09:09:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419160509.66298-14-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 6:05 PM, Coly Li wrote:
> Current journal_max_cmp() and journal_min_cmp() assume that smaller fifo
> index indicating elder journal entries, but this is only true when fifo
> index is not swapped.
> 
> Fifo structure journal.pin is implemented by a cycle buffer, if the head
> index reaches highest location of the cycle buffer, it will be swapped
> to 0. Once the swapping happens, it means a smaller fifo index might be
> associated to a newer journal entry. So the btree node with oldest
> journal entry won't be selected by btree_flush_write() to flush out to
> cache device. The result is, the oldest journal entries may always has
> no chance to be written into cache device, and after a reboot
> bch_journal_replay() may complain some journal entries are missing.
> 
> This patch handles the fifo index swapping conditions properly, then in
> btree_flush_write() the btree node with oldest journal entry can be
> slected from c->flush_btree correctly.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/journal.c | 47 +++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
> index bdb6f9cefe48..bc0e01151155 100644
> --- a/drivers/md/bcache/journal.c
> +++ b/drivers/md/bcache/journal.c
> @@ -464,12 +464,47 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
>   }
>   
>   /* Journalling */
> -#define journal_max_cmp(l, r) \
> -	(fifo_idx(&c->journal.pin, btree_current_write(l)->journal) < \
> -	 fifo_idx(&(c)->journal.pin, btree_current_write(r)->journal))
> -#define journal_min_cmp(l, r) \
> -	(fifo_idx(&c->journal.pin, btree_current_write(l)->journal) > \
> -	 fifo_idx(&(c)->journal.pin, btree_current_write(r)->journal))
> +#define journal_max_cmp(l, r)						\
> +({									\
> +	int l_idx, r_idx, f_idx, b_idx;					\
> +	bool _ret = true;						\
> +									\
> +	l_idx = fifo_idx(&c->journal.pin, btree_current_write(l)->journal); \
> +	r_idx = fifo_idx(&c->journal.pin, btree_current_write(r)->journal); \
> +	f_idx = c->journal.pin.front;					\
> +	b_idx = c->journal.pin.back;					\
> +									\
> +	_ret = (l_idx < r_idx);						\
> +	/* in case fifo back pointer is swapped */			\
> +	if (b_idx < f_idx) { 						\
> +		if (l_idx <= b_idx && r_idx >= f_idx)			\
> +			_ret = false;					\
> +		else if (l_idx >= f_idx && r_idx <= b_idx)		\
> +			_ret = true;					\
> +	}								\
> +	_ret;								\
> +})
> +
> +#define journal_min_cmp(l, r)						\
> +({									\
> +	int l_idx, r_idx, f_idx, b_idx;					\
> +	bool _ret = true;						\
> +									\
> +	l_idx = fifo_idx(&c->journal.pin, btree_current_write(l)->journal); \
> +	r_idx = fifo_idx(&c->journal.pin, btree_current_write(r)->journal); \
> +	f_idx = c->journal.pin.front;					\
> +	b_idx = c->journal.pin.back;					\
> +									\
> +	_ret = (l_idx > r_idx);						\
> +	/* in case fifo back pointer is swapped */			\
> +	if (b_idx < f_idx) {						\
> +		if (l_idx <= b_idx && r_idx >= f_idx)			\
> +			_ret = true;					\
> +		else if (l_idx >= f_idx && r_idx <= b_idx)		\
> +			_ret = false;					\
> +	}								\
> +	_ret;								\
> +})
>   
>   static void btree_flush_write(struct cache_set *c)
>   {
> 
Please make it a proper function.
This is far too convoluted for being handled via #define, and it would
avoid cluttering the function namespace with hidden variables.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
