Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1622C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 12:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9972084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 12:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9972084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeLLMjP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:39:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34817 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeLLMjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 07:39:14 -0500
Received: from [191.13.172.85] (helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gX3nD-0005Nt-0H; Wed, 12 Dec 2018 12:39:11 +0000
Date:   Wed, 12 Dec 2018 10:39:06 -0200
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
Message-ID: <20181212123906.GI4269@calabresa>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <20181206202200.GA32080@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206202200.GA32080@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Well, udev could just look at the hidden attribute. At least to some, the fact
that lsblk would fail was reason enough to revert the patches, so I would
rather apply the entire set.

We could add a message to the log when users try to open them, but given that
some programs (udev is one) would open them without any user interaction, maybe
we shouldn't.

Cascardo.
