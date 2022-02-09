Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54527C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 17:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbiBIRk6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiBIRk5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 12:40:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92563C05CB87
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 09:41:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2A83D210FB;
        Wed,  9 Feb 2022 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644428459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wc5G1RG6K97036MFkvPflN06Nxzy0tnq7nM1LeNxTps=;
        b=FxW9cBHARLolJRgCH10PYEAkukW5U0sDs4Ae1ZH+G60pbpA3TF4aXXbaHMGtNzSVYeKmFf
        POlGdvEq6EyjwnuQX0DVsLQLtu3gcxSjUECHuNskXclcNtlx88l1DqczVrIvle3ATo8kRG
        ppAIo5GPXJChAg9FRywFLhl3rVImA8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644428459;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wc5G1RG6K97036MFkvPflN06Nxzy0tnq7nM1LeNxTps=;
        b=5C4eRn/fRtu+kWxo4lmd+5zJZuAI/H/xLcUUu3oxzFgPUBn4Kou1GcPS8CwY5qYq5ftKqh
        LNJN6wau0nN0nqDA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3E600A3B83;
        Wed,  9 Feb 2022 17:40:48 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 56A0DA05B5; Wed,  9 Feb 2022 18:40:55 +0100 (CET)
Date:   Wed, 9 Feb 2022 18:40:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/4 v5] bfq: Avoid use-after-free when moving processes
 between cgroups
Message-ID: <20220209174055.yrlipalcrtetxelm@quack3.lan>
References: <20220121105503.14069-1-jack@suse.cz>
 <4b44e8db-771f-fc08-85f1-52c326f3db18@huawei.com>
 <20220124140224.275sdju6temjgjdu@quack3.lan>
 <75bfe59d-c570-8c1c-5a3c-576791ea84ec@huawei.com>
 <20220202190210.xppvatep47duofbq@quack3.lan>
 <20220202215356.iomsjb57jmbfglt4@quack3.lan>
 <6ec28c27-1dce-33e3-1cb7-2e08892471bb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ec28c27-1dce-33e3-1cb7-2e08892471bb@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 08-02-22 21:19:14, yukuai (C) wrote:
> 在 2022/02/03 5:53, Jan Kara 写道:
> > Thanks for debugging! I was looking into this but I also do not understand
> > how what your tracing shows can happen. In particular I don't see why there
> > is no __bfq_bic_change_cgroup() call from bfq_insert_request() ->
> > bfq_init_rq() for the problematic __bfq_insert_request() into
> > ffff888106913700. I have two possible explanations. Either bio is submitted
> > to the offlined cgroup ffff888107d67000 or bic->blkcg_serial_nr is pointing
> > to different cgroup than bic_to_bfqq(bic, 1)->entity.parent.
> > 
> > So can you extented the debugging a bit like:
> > 1) Add current->pid to all debug messages so that we can distinguish
> > different processes and see which already detached from the bfqq and which
> > not.
> > 
> > 2) Print bic->blkcg_serial_nr and __bio_blkcg(bio)->css.serial_nr before
> > crashing in bfq_add_bfqq_busy().
> > 
> > 3) Add BUG_ON to bic_set_bfqq() like:
> > 	if (bfqq_group(bfqq)->css.serial_nr != bic->blkcg_serial_nr) {
> > 		printk("%s: bfqq %px(%px) serial %d bic serial %d\n", bfqq,
> > 			bfqq_group(bfqq), bfqq_group(bfqq)->css.serial_nr,
> > 			bic->blkcg_serial_nr);
> > 		BUG_ON(1);
> > 	}
> > 
> > and perhaps this scheds more light on the problem... Thanks!
> > 
> > 								Honza
> > 
> 
> The debuging patch and log is attached.
> 
> bic_set_bfqq found serial mismatch serval times, bfqq_group(bfqq)->css
> doesn't exist, is the following debugging what you expected?
> 
> @@ -386,6 +386,13 @@ static void bfq_put_stable_ref(struct bfq_queue *bfqq);
> 
>  void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool
> is_sync)
>  {
> +       if (bfqq && bfqq_group(bfqq)->pd.blkg->blkcg->css.serial_nr !=
> +                   bic->blkcg_serial_nr) {
> +               bfqq_dbg(bfqq, "serial %lld bic serial %lld\n",
> +                        bfqq_group(bfqq)->pd.blkg->blkcg->css.serial_nr,
> +                        bic->blkcg_serial_nr);
> +               WARN_ON_ONCE(1);
> +       }

Yes, this is what I wanted. Thanks!

> 
> The problematic bfqq ffff8881682581f0 doesn't merge with any bfqq,
> which is weird.
> 
> The pid from __bfq_insert_request() is changed for the problematic
> bfqq, and each time the pid is changed, there is a bic_set_bfqq()
> shows that serial mismatch.

I had a look into debug data and now I think I understand both the WARN_ON
hit in bic_set_bfqq() as well as the final BUG_ON in bfq_add_bfqq_busy().

The first problem is apparently hit because __bio_blkcg() can change while
we are processing the bio. So bfq_bic_update_cgroup() sees different
__bio_blkcg() than bfq_get_queue() called from bfq_get_bfqq_handle_split().
This then causes mismatch between what bic & bfqq think about cgroup
membership which can lead to interesting inconsistencies down the road.

The second problem is hit because clearly __bio_blkcg() can be pointing to
a blkcg that has been already offlined. Previously I didn't think this was
possible but apparently there is nothing that would prevent this race. So
we need to handle this gracefully inside BFQ.

I need to think what would be best fixes for these issues since especially
the second one is tricky.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
