Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C15DC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00486208E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00486208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbeKPSv0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:51:26 -0500
Received: from verein.lst.de ([213.95.11.211]:47995 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbeKPSv0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:51:26 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BE45F68D60; Fri, 16 Nov 2018 09:40:04 +0100 (CET)
Date:   Fri, 16 Nov 2018 09:40:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 5/6] ide: don't acquire queue_lock in ide_complete_pm_rq
Message-ID: <20181116084004.GA15331@lst.de>
References: <20181116081006.5083-1-hch@lst.de> <20181116081006.5083-6-hch@lst.de> <20181116083732.GR23828@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116083732.GR23828@vader>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 12:37:32AM -0800, Omar Sandoval wrote:
> On Fri, Nov 16, 2018 at 09:10:05AM +0100, Christoph Hellwig wrote:
> > blk_mq_stop_hw_queues doesn't need any locking, and the ide
> > dev_flags field isn't protected by it either.
> 
> Is it a bug that dev_flags is no longer protected by queue_lock after
> the mq conversion?

Most if not all users weren't under queue_lock before.  As far as I can
tell it generally is set in the probe path, and without any obvious
locking.
