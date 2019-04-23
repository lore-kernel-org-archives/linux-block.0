Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F59DC10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC59206BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfDWHEd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:04:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:60082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWHEd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:04:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63D4CAE78;
        Tue, 23 Apr 2019 07:04:32 +0000 (UTC)
Subject: Re: [RFC PATCH v2 08/16] bcache: return error immediately in
 bch_journal_replay()
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-9-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <64c405c1-61ef-abe7-b5ef-e2174320fbb7@suse.de>
Date:   Tue, 23 Apr 2019 09:04:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419160509.66298-9-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 6:05 PM, Coly Li wrote:
> When failure happens inside bch_journal_replay(), calling
> cache_set_err_on() and handling the failure in async way is not a good
> idea. Because after bch_journal_replay() returns, registering code will
> continue to execute following steps, and unregistering code triggered
> by cache_set_err_on() is running in same time. First it is unnecessary
> to handle failure and unregister cache set in an async way, second there
> might be potential race condition to run register and unregister code
> for same cache set.
> 
> So in this patch, if failure happens in bch_journal_replay(), we don't
> call cache_set_err_on(), and just print out the same error message to
> kernel message buffer, then return -EIO immediately caller. Then caller
> can detect such failure and handle it in synchrnozied way.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/journal.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
> index 6aa68ab7cd78..bdb6f9cefe48 100644
> --- a/drivers/md/bcache/journal.c
> +++ b/drivers/md/bcache/journal.c
> @@ -420,9 +420,12 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
>   	list_for_each_entry(i, list, list) {
>   		BUG_ON(i->pin && atomic_read(i->pin) != 1);
>   
> -		cache_set_err_on(n != i->j.seq, s,
> -"bcache: journal entries %llu-%llu missing! (replaying %llu-%llu)",
> -				 n, i->j.seq - 1, start, end);
> +		if (n != i->j.seq) {
> +			pr_err("bcache: journal entries %llu-%llu missing! (replaying %llu-%llu)",
> +			n, i->j.seq - 1, start, end);
> +			ret = -EIO;
> +			goto err;
> +		}
>   
>   		for (k = i->j.start;
>   		     k < bset_bkey_last(&i->j);
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
