Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F9C63793
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 13:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A0361285
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 13:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhGVMZg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:25:36 -0400
Received: from verein.lst.de ([213.95.11.211]:34217 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231938AbhGVMZf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 08:25:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 94D8168D06; Thu, 22 Jul 2021 15:06:09 +0200 (CEST)
Date:   Thu, 22 Jul 2021 15:06:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V6 2/3] blk-mq: mark if one queue map uses managed irq
Message-ID: <20210722130609.GB26872@lst.de>
References: <20210722095246.1240526-1-ming.lei@redhat.com> <20210722095246.1240526-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722095246.1240526-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 05:52:45PM +0800, Ming Lei wrote:
	 and nvme rdma driver can allocate
> +	 * and submit requests on specified hctx via
> +	 * blk_mq_alloc_request_hctx

Why does that matter for this setting?
