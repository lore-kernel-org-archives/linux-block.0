Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519BAC2D0A3
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 17:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25122221FD
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 17:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbgKPR1D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:27:03 -0500
Received: from verein.lst.de ([213.95.11.211]:55377 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731195AbgKPR1D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 12:27:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A1A46736F; Mon, 16 Nov 2020 18:26:58 +0100 (CET)
Date:   Mon, 16 Nov 2020 18:26:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] blk-mq: add new API of
 blk_mq_hctx_set_fq_lock_class
Message-ID: <20201116172658.GJ22007@lst.de>
References: <20201112075526.947079-1-ming.lei@redhat.com> <20201112075526.947079-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112075526.947079-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 12, 2020 at 03:55:24PM +0800, Ming Lei wrote:
> flush_end_io() may be called recursively from some driver, such as
> nvme-loop, so lockdep may complain 'possible recursive locking'.
> Commit b3c6a5997541("block: Fix a lockdep complaint triggered by
> request queue flushing") tried to address this issue by assigning
> dynamically allocated per-flush-queue lock class. This solution
> adds synchronize_rcu() for each hctx's release handler, and causes
> horrible SCSI MQ probe delay(more than half an hour on megaraid sas).
> 
> Add new API of blk_mq_hctx_set_fq_lock_class() for these drivers, so
> we just need to use driver specific lock class for avoiding the
> lockdep warning of 'possible recursive locking'.

I'd turn this into an inline function to avoid the (although very
minimal) cost when LOCKDEP is not enabled.
