Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C2DC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EF920868
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EF920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbeLFQth (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:49:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44161 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLFQth (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:49:37 -0500
Received: from [191.13.27.189] (helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gUwpX-0000lC-M2; Thu, 06 Dec 2018 16:48:52 +0000
Date:   Thu, 6 Dec 2018 14:48:47 -0200
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: create slaves/holder entries for multipath
 devices
Message-ID: <20181206164846.GF4269@calabresa>
References: <20181116130805.16225-1-hch@lst.de>
 <20181116130805.16225-3-hch@lst.de>
 <20181128083816.GB4269@calabresa>
 <20181206154432.GA26584@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206154432.GA26584@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 04:44:32PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 28, 2018 at 06:38:17AM -0200, Thadeu Lima de Souza Cascardo wrote:
> > I will send a followup that includes your two patches, fixing up this one, plus
> > another two because that is simply reverting the revert of Hanne's patch. Which
> > means it still has the lsblk bug.
> > 
> > Then, we have two options: do not use GENHD_FL_HIDDEN on multipath nvme disks,
> > or expose devt for those disks. I am sending a patch for the second option.
> 
> Can you please send it out so we can look at it before the 4.21 merge
> window opens?

Just sent. Sorry about the delay.

Thanks.
Cascardo.
