Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A563BC67839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 08:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767992086D
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 08:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767992086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeLLIcS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:32:18 -0500
Received: from verein.lst.de ([213.95.11.211]:60691 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLIcS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 03:32:18 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9A76268DCF; Wed, 12 Dec 2018 09:32:16 +0100 (CET)
Date:   Wed, 12 Dec 2018 09:32:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
Message-ID: <20181212083216.GA30124@lst.de>
References: <20181206164812.30925-1-cascardo@canonical.com> <20181206164812.30925-5-cascardo@canonical.com> <20181206202200.GA32080@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206202200.GA32080@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 09:22:00PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 06, 2018 at 02:48:12PM -0200, Thadeu Lima de Souza Cascardo wrote:
> > Without this exposure, lsblk will fail as it tries to find out the
> > device's dev_t numbers. This causes a real problem for nvme multipath
> > devices, as their slaves are hidden.
> > 
> > Exposing them fixes the problem, even though trying to open the devices
> > returns an error in the case of nvme multipath. So, right now, it's the
> > driver's responsibility to return a failure to open hidden devices.
> 
> So the problem with this is that it will cause udev to actually create
> the /dev/nvmeXcYnZ nodes, which due to the previous patch will always
> fail to open, which is a bit confusing.  I guess we could live with this
> if we add udev rules to supress the creation or something, but in general
> it is a bit ugly.

Thadeu (or other distro folks), any comments on this issue?  If not
I'd like to just move forward with the first two patches for now,
and it would be good to have some reviews for them.
