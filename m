Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B7C433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14CBF2073B
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590605579;
	bh=IzmIC3jCbsY7O2IfmPtRly6W+l04C4nWbvVFB0I2evI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l7YzR3U0UoA4u0JV31M5DSjdmyDSvXVB7bGjOeZOclbyiHLN3r+ly7Wh7OkDxrhZJ
	 F1k7IZOhmosmwiaCUVLCDQTnTArZWQ5qJMF7JXujrlb/z3rRcI2aqu8vKmjMQ6B2SW
	 O8OIoylkLgFWMc0gS8L8gTcZQrD/L9uRy2CecA8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgE0Sww (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbgE0Swv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:52:51 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E298B2075A;
        Wed, 27 May 2020 18:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590605571;
        bh=IzmIC3jCbsY7O2IfmPtRly6W+l04C4nWbvVFB0I2evI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkq12V8jNl27N+ZiNuzBv9aCKbVOrDpnJ8Rva+5sPH/Ygob2MClJIEsPMyuqweUxe
         bPt7JjpLTdgd8jGVTPTPVSKB6UGKPilKnnzh1ahSVmwS2bZmFpHLsvHcZK/nhaL01n
         UmglV77JpW5i8iewow5OeCAvebQ1v4VMO3LoF/XY=
Date:   Wed, 27 May 2020 11:52:49 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Alan Adamson <alan.adamson@oracle.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] blk-mq/nvme: improve nvme-pci reset handler
Message-ID: <20200527185249.GA3442470@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200520115655.729705-1-ming.lei@redhat.com>
 <22083f76-43f5-38a1-0e2d-84b626a6fd50@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22083f76-43f5-38a1-0e2d-84b626a6fd50@oracle.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 27, 2020 at 11:09:53AM -0700, Alan Adamson wrote:
> [  139.895265] CPU: 5 PID: 2470 Comm: kworker/5:1H Not tainted 5.7.0-rc7+ #1
> [  139.895266] Hardware name: Oracle Corporation ORACLE SERVER
> X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
> [  139.895271] Workqueue: kblockd blk_mq_timeout_work
> [  139.895272] Call Trace:
> [  139.895279]  dump_stack+0x6d/0x9a
> [  139.895281]  should_fail.cold.5+0x32/0x42
> [  139.895282]  blk_should_fake_timeout+0x26/0x30
> [  139.895283]  blk_mq_complete_request+0x1b/0x120
> [  139.895292]  nvme_cancel_request+0x33/0x80 [nvme_core]
> [  139.895296]  bt_tags_iter+0x48/0x50
> [  139.895297]  blk_mq_tagset_busy_iter+0x1eb/0x270
> [  139.895299]  ? nvme_try_sched_reset+0x40/0x40 [nvme_core]
> [  139.895301]  ? nvme_try_sched_reset+0x40/0x40 [nvme_core]
> [  139.895305]  nvme_dev_disable+0x2be/0x460 [nvme]
> [  139.895307]  nvme_timeout.cold.80+0x9c/0x182 [nvme]
> [  139.895311]  ? sched_clock+0x9/0x10
> [  139.895315]  ? sched_clock_cpu+0x11/0xc0
> [  139.895320]  ? __switch_to_asm+0x40/0x70
> [  139.895321]  blk_mq_check_expired+0x192/0x1b0
> [  139.895322]  bt_iter+0x52/0x60
> [  139.895323]  blk_mq_queue_tag_busy_iter+0x1a0/0x2e0
> [  139.895325]  ? __switch_to_asm+0x40/0x70
> [  139.895326]  ? __blk_mq_requeue_request+0xf0/0xf0
> [  139.895326]  ? __blk_mq_requeue_request+0xf0/0xf0
> [  139.895329]  ? compat_start_thread+0x20/0x40
> [  139.895330]  blk_mq_timeout_work+0x5a/0x130
> [  139.895333]  process_one_work+0x1ab/0x380
> [  139.895334]  worker_thread+0x37/0x3b0
> [  139.895335]  kthread+0x120/0x140
> [  139.895337]  ? create_worker+0x1b0/0x1b0
> [  139.895337]  ? kthread_park+0x90/0x90
> [  139.895339]  ret_from_fork+0x35/0x40

The driver reclaimed all outstanding tags and returned them to the block
layer. This isn't faking a timeout anymore. The driver has done its
part to reclaim lost commands. This is faking a broken block layer
instead.
