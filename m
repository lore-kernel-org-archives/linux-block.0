Return-Path: <SRS0=vxC1=ZJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CD3C432C0
	for <linux-block@archiver.kernel.org>; Sun, 17 Nov 2019 03:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708F5206DB
	for <linux-block@archiver.kernel.org>; Sun, 17 Nov 2019 03:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfKQDeh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Nov 2019 22:34:37 -0500
Received: from mx.ewheeler.net ([173.205.220.69]:51881 "EHLO mx.ewheeler.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfKQDeg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Nov 2019 22:34:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id 69FEAA0633;
        Sun, 17 Nov 2019 03:27:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id GCXGcbXGoszj; Sun, 17 Nov 2019 03:27:05 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id AEFA6A0440;
        Sun, 17 Nov 2019 03:27:05 +0000 (UTC)
Date:   Sun, 17 Nov 2019 03:27:02 +0000 (UTC)
From:   Eric Wheeler <bcache@lists.ewheeler.net>
X-X-Sender: lists@mx.ewheeler.net
To:     Coly Li <colyli@suse.de>
cc:     axboe@kernel.dk, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 01/10] bcache: fix fifo index swapping condition in
 journal_pin_cmp()
In-Reply-To: <20191113053346.63536-2-colyli@suse.de>
Message-ID: <alpine.LRH.2.11.1911170326310.23583@mx.ewheeler.net>
References: <20191113053346.63536-1-colyli@suse.de> <20191113053346.63536-2-colyli@suse.de>
User-Agent: Alpine 2.11 (LRH 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 13 Nov 2019, Coly Li wrote:

> Fifo structure journal.pin is implemented by a cycle buffer, if the back
> index reaches highest location of the cycle buffer, it will be swapped
> to 0. Once the swapping happens, it means a smaller fifo index might be
> associated to a newer journal entry. So the btree node with oldest
> journal entry won't be selected in bch_btree_leaf_dirty() to reference
> the dirty B+tree leaf node. This problem may cause bcache journal won't
> protect unflushed oldest B+tree dirty leaf node in power failure, and
> this B+tree leaf node is possible to beinconsistent after reboot from
> power failure.
> 
> This patch fixes the fifo index comparing logic in journal_pin_cmp(),
> to avoid potential corrupted B+tree leaf node when the back index of
> journal pin is swapped.

Can this cc stable?  It looks like <100 lines.


--
Eric Wheeler



> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>  drivers/md/bcache/btree.c   | 26 ++++++++++++++++++++++++++
>  drivers/md/bcache/journal.h |  4 ----
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index ba434d9ac720..00523cd1db80 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -528,6 +528,32 @@ static void btree_node_write_work(struct work_struct *w)
>  	mutex_unlock(&b->write_lock);
>  }
>  
> +/* return true if journal pin 'l' is newer than 'r' */
> +static bool journal_pin_cmp(struct cache_set *c,
> +			    atomic_t *l,
> +			    atomic_t *r)
> +{
> +	int l_idx, r_idx, f_idx, b_idx;
> +	bool ret = false;
> +
> +	l_idx = fifo_idx(&(c)->journal.pin, (l));
> +	r_idx = fifo_idx(&(c)->journal.pin, (r));
> +	f_idx = (c)->journal.pin.front;
> +	b_idx = (c)->journal.pin.back;
> +
> +	if (l_idx > r_idx)
> +		ret = true;
> +	/* in case fifo back pointer is swapped */
> +	if (b_idx < f_idx) {
> +		if (l_idx <= b_idx && r_idx >= f_idx)
> +			ret = true;
> +		else if (l_idx >= f_idx && r_idx <= b_idx)
> +			ret = false;
> +	}
> +
> +	return ret;
> +}
> +
>  static void bch_btree_leaf_dirty(struct btree *b, atomic_t *journal_ref)
>  {
>  	struct bset *i = btree_bset_last(b);
> diff --git a/drivers/md/bcache/journal.h b/drivers/md/bcache/journal.h
> index f2ea34d5f431..06b3eaab7d16 100644
> --- a/drivers/md/bcache/journal.h
> +++ b/drivers/md/bcache/journal.h
> @@ -157,10 +157,6 @@ struct journal_device {
>  };
>  
>  #define BTREE_FLUSH_NR	8
> -
> -#define journal_pin_cmp(c, l, r)				\
> -	(fifo_idx(&(c)->journal.pin, (l)) > fifo_idx(&(c)->journal.pin, (r)))
> -
>  #define JOURNAL_PIN	20000
>  
>  #define journal_full(j)						\
> -- 
> 2.16.4
> 
> 
