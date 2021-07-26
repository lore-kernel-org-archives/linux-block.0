Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B888C4338F
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 17:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7515560F57
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 17:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhGZQ2i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 12:28:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47852 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242403AbhGZQ0c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 12:26:32 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 000AC21FCA;
        Mon, 26 Jul 2021 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627319220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u/6Vj7OVxSVTlBeyT4j4Pxr6K4YolKwbPh8N6Yh1Nzw=;
        b=YIGoWUw016ZAuST4/iaJe5nf9tPg+3yPg5yp2eqZaNB/Zus7dTToJp9w4F8LlHCb0ZP2g+
        gnqHEkMjd7lkuwJkHBUPIkiUjhGfnGxCEJxvdyfG0wpRGE8yZv4hkqpy9LxFMfp3Q7z3qJ
        rwpQfeQzQk3qxHsFirG+ipcU36FuCZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627319220;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u/6Vj7OVxSVTlBeyT4j4Pxr6K4YolKwbPh8N6Yh1Nzw=;
        b=8D3QE8aI4ZWmDuHC5VfAoJBVV7Q/6X4xqWWp0y3DrpPXMuJxJ78ufsoN5Iq3uZgz2t1gTI
        LHvFLUUQRHUW15CA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DCC6E13A91;
        Mon, 26 Jul 2021 17:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Lsx5NbPr/mCqPwAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 26 Jul 2021 17:06:59 +0000
Date:   Mon, 26 Jul 2021 19:06:59 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Wen Xiong <wenxiong@us.ibm.com>
Cc:     ming.lei@redhat.com, axboe@kernel.dk, gregkh@linuxfoundation.org,
        hare@suse.de, hch@lst.de, john.garry@huawei.com,
        linux-block@vger.kernel.org, sagi@grimberg.me, tglx@linutronix.de
Subject: Re: [PATCH V6 0/3] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <20210726170659.hrh4evhkdqnyjz5k@beryllium.lan>
References: <YPp63niga//Q6GLV@T590>
 <20210722131245.u4dhcqotepxhwgbz@beryllium.lan>
 <20210722095246.1240526-1-ming.lei@redhat.com>
 <OFDADF39F5.DDB99A55-ON0025871A.00794382-0025871A.00797A2E@ibm.com>
 <OF2C4681CD.AF20CBB4-ON0025871E.004D37B6-0025871E.004E3B9F@ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2C4681CD.AF20CBB4-ON0025871E.004D37B6-0025871E.004E3B9F@ibm.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Mon, Jul 26, 2021 at 02:14:30PM +0000, Wen Xiong wrote:
> >>V6 is basically same with V4, can you figure out where the failure
> >>comes?(v5.14-rc2, V6 or Daniel's V3)
>  
> Looks 3/3 was not patched cleanly in v5.14-rc2 last week.  I made the changes
> in block/blk-mq.c.rej manually but still missed the last part of 3/3 patch.

Sorry for the long delay on my side. It took a while to get my test
setup running again. The qla2xxx driver really doesn't like 'fast'
remote port toggling. But that's a different story.

Anyway, it turns out that my patch series is still not working
correctly. When I tested the series I deliberate forced to execute
the 'revising io queue count' path in nvme_fc_recreate_io_queues by
doing:

--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2954,7 +2954,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
        if (ctrl->ctrl.queue_count == 1)
                return 0;
 
-       if (prior_ioq_cnt != nr_io_queues) {
+       if (prior_ioq_cnt != nr_io_queues - 1) {
                dev_info(ctrl->ctrl.device,
                        "reconnect: revising io queue count from %d to %d\n",
                        prior_ioq_cnt, nr_io_queues);


With this change I can't observe any I/O hanging. Without the change it
hangs in the first iteration.

In Wen's setup we observed in earlier debugging sessions that the
nr_io_queues does change. So this explains why Wen doesn't see any
hanging I/Os.

@James, I think we need to look at bit more at the freeze code. BTW,
my initial patch which just added a nvme_start_freeze() in
nvme_fc_delete_association() doesn't work either for the 'prior_ioq_cnt
== nr_io_queues' case.

So I think Ming series can be merged as the hanging I/Os are clearly not
caused by the series.

Feel free to add

Tested-by: Daniel Wagner <dwagner@suse.de>

Thanks,
Daniel
