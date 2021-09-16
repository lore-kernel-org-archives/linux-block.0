Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A1CC433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 07:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD09E60F25
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 07:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhIPHnx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 03:43:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54814 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhIPHnv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 03:43:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5124822327;
        Thu, 16 Sep 2021 07:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631778150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCOcSg2Lok2Xe/3d3QCt1RsJoDaruUgtOg7FmU+88Ug=;
        b=x1V+iAeM4BTYJSnLr+/qx6olGpmwCXFmQeqQ0RKp8UQM1lQfKGeJVAmlNtgF5CCnU9LQgU
        o6OeGPvCJxoiKjMCDS11VdLoxU/ZaWZlhzTL3v0pO687/IyP56kS/TUJ1afkMDK1j+6Sur
        DgVqAza03pnfOAfrwjBDZ80yVltCuZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631778150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCOcSg2Lok2Xe/3d3QCt1RsJoDaruUgtOg7FmU+88Ug=;
        b=xvfd8rosZwKCCK9owedrW7ysfRUJLZLwxcBsxDj0DpTApkAJP8ziwWbQ8mU1BYutIfjvtq
        GZgFazbJhn3BWvCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B76913A23;
        Thu, 16 Sep 2021 07:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f1ydDmb1QmFRGwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 16 Sep 2021 07:42:30 +0000
Date:   Thu, 16 Sep 2021 09:42:29 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH V7 3/3] blk-mq: don't deactivate hctx if managed irq
 isn't used
Message-ID: <20210916074229.7ntbn7prnv3fmmm2@carbon.lan>
References: <20210818144428.896216-1-ming.lei@redhat.com>
 <20210818144428.896216-4-ming.lei@redhat.com>
 <20210915161459.ks3pbqceuj5x3ugu@carbon.lan>
 <YUKpLmOPM1BNN5lF@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUKpLmOPM1BNN5lF@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 10:17:18AM +0800, Ming Lei wrote:
> Firstly, even with patches of 'qla2xxx - add nvme map_queues support',
> the knowledge if managed irq is used in nvmef LLD is still missed, so
> blk_mq_hctx_use_managed_irq() may always return false, but that
> shouldn't be hard to solve.

Yes, that's pretty simple:

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7914,6 +7914,9 @@ static int qla2xxx_map_queues(struct Scsi_Host *shost)
                rc = blk_mq_map_queues(qmap);
        else
                rc = blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
+
+       qmap->use_managed_irq = true;
+
        return rc;
 }

> The problem is that we still should make connect io queue completed
> when all CPUs of this hctx is offline in case of managed irq.

I agree, though if I understand this right, the scenario where all CPUs
are offline in a hctx and we want to use this htcx is only happening
after an initial setup and then reconnect attempt happens. That is
during the first connect attempt only online CPUs are assigned to the
hctx. When the CPUs are taken offline the block layer makes sure not to
use those queues anymore (no problem for the hctx so far). Then for some
reason the nmve-fc layer decides to reconnect and we end up in the
situation where we don't have any online CPU in given hctx.

> One solution might be to use io polling for connecting io queue, but nvme fc
> doesn't support polling, all the other nvme hosts do support it.

No idea, something to explore for sure :)

My point is that your series is fixing existing bugs and doesn't
introduce a new one. qla2xxx is already depending on managed IRQs. I
would like to see your series accepted with my hack as stop gap solution
until we have a proper fix.
