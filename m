Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852B4C54FD0
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F75520767
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgDXPkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:40:35 -0400
Received: from verein.lst.de ([213.95.11.211]:35600 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbgDXPke (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 11:40:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9685C68CEE; Fri, 24 Apr 2020 17:40:32 +0200 (CEST)
Date:   Fri, 24 Apr 2020 17:40:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 00/11] blk-mq: improvement CPU hotplug
Message-ID: <20200424154032.GB17253@lst.de>
References: <20200424102351.475641-1-ming.lei@redhat.com> <104406f7-70f2-ef3b-6b03-02cf847d5eb8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <104406f7-70f2-ef3b-6b03-02cf847d5eb8@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 09:23:45AM -0600, Jens Axboe wrote:
> > Please comment & review, thanks!
> 
> Applied for 5.8 - had to do it manually for the first two patches, as
> they conflict with the dma drain removal from core from Christoph.

I'd really like to see the barrier mess sorted out before this is
merged..
