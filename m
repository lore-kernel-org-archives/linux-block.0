Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6C0C4742C
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 17:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FCC221FD
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 17:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbgKPR1t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:27:49 -0500
Received: from verein.lst.de ([213.95.11.211]:55400 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732052AbgKPR1t (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 12:27:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5790F68B05; Mon, 16 Nov 2020 18:27:46 +0100 (CET)
Date:   Mon, 16 Nov 2020 18:27:46 +0100
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
Subject: Re: [PATCH V2 3/3] Revert "block: Fix a lockdep complaint
 triggered by request queue flushing"
Message-ID: <20201116172746.GL22007@lst.de>
References: <20201112075526.947079-1-ming.lei@redhat.com> <20201112075526.947079-4-ming.lei@redhat.com> <20201113012722.GD1012796@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113012722.GD1012796@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 13, 2020 at 09:27:22AM +0800, Ming Lei wrote:
> >From a519f421957a1205918e9bcc15087d15234e4e9f Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Thu, 12 Nov 2020 09:56:02 +0800
> Subject: [PATCH V2 3/3] Revert "block: Fix a lockdep complaint triggered by
>  request queue flushing"
> 
> This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.
> 
> Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
> locking' by nvme-loop's lock class, no need to apply dynamically
> allocated lock class key, so revert commit b3c6a5997541("block: Fix a
> lockdep complaint triggered by request queue flushing").
> 
> This way fixes horrible SCSI probe delay issue on megaraid_sas(host_tagset is 1),
> and it is reported the whole probe may take more than half an hour. The reason

There are a bunch of overly long lines in the commit log.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
