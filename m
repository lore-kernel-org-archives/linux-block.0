Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8B9C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 07:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D562082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 07:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D562082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeK3TEb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:04:31 -0500
Received: from verein.lst.de ([213.95.11.211]:48651 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbeK3TEb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 14:04:31 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C9E1768BDF; Fri, 30 Nov 2018 08:56:03 +0100 (CET)
Date:   Fri, 30 Nov 2018 08:56:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/13] block: move queues types to the block layer
Message-ID: <20181130075603.GA18936@lst.de>
References: <20181129191310.9795-1-hch@lst.de> <20181129191310.9795-2-hch@lst.de> <c20e4d66-0fc5-ab65-2805-c4b22012c1c5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20e4d66-0fc5-ab65-2805-c4b22012c1c5@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 07:50:09PM +0000, Jens Axboe wrote:
> > in our post-spectre world.  Also having too many queue type is just
> > going to create confusion, so I'd rather manage them centrally.
> > 
> > Note that the queue type naming and ordering changes a bit - the
> > first index now is the defauly queue for everything not explicitly
>                          ^^^^^^^
> 
> default

Fixed.

> Side not, should probably make the sysfs 'type' attribute a string
> at this point.

Fixed as well.
