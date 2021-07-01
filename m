Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDFBC11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 09:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70A0613F1
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 09:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhGAJvt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 05:51:49 -0400
Received: from verein.lst.de ([213.95.11.211]:47010 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235300AbhGAJvs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 05:51:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88A836736F; Thu,  1 Jul 2021 11:49:16 +0200 (CEST)
Date:   Thu, 1 Jul 2021 11:49:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: grab a device refcount in disk_uevent
Message-ID: <20210701094915.GA2066@lst.de>
References: <20210701081638.246552-1-hch@lst.de> <20210701081638.246552-2-hch@lst.de> <YN2CrbtFEKwDGff0@T590> <20210701090232.GA31321@lst.de> <YN2IIiKUvquxqx6k@T590> <YN2KiYTtA0ribi9i@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN2KiYTtA0ribi9i@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01, 2021 at 05:27:37PM +0800, Ming Lei wrote:
> 
> Maybe the reason is that sending uevent needs the device/kobject not
> 'released' in viewpoint of driver core world, other device resource(such
> as device name) may be referred but have been freed.
> 
> If that is the reason, this patch looks fine, and
> kobject_get_unless_zero() may be replaced with get_device() since the
> referred memory isn't freed yet.

Yes, sorry.  Braino while looking up the cause.  But there isn't much
of a point in sending a uevent to a partition already deleted, so
I think the unless_zero here still makes sense.
