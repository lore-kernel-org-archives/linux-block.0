Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D48C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 12:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B4E20727
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 12:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgEPMf7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 08:35:59 -0400
Received: from verein.lst.de ([213.95.11.211]:60410 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgEPMf7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 08:35:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2090168B05; Sat, 16 May 2020 14:35:56 +0200 (CEST)
Date:   Sat, 16 May 2020 14:35:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/6] blk-mq: improvement CPU hotplug(simplified version)
Message-ID: <20200516123555.GA13448@lst.de>
References: <20200515014153.2403464-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200515014153.2403464-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I took at stab at the series this morning, and fixed the fabrics
crash (blk_mq_alloc_request_hctx passed the cpumask of a NULL hctx),
and pre-loaded a bunch of cļeanups to let your changes fit in better.

Let me know what you think, the git branch is here:

    git://git.infradead.org/users/hch/block.git blk-mq-hotplug

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug

