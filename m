Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC5FC433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 16:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiKCQpt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiKCQpa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 12:45:30 -0400
Received: from hermod.demsh.org (hermod.demsh.org [45.140.147.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FB12181E
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demsh.org; s=022020;
        t=1667493703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bmo8YllTKr3d69x36gjkgs95Fvx7JVipXgs5l7SajpE=;
        b=grtWx4gz27MaI1rrH8aHk4Ci/zvX0oOXqQpAYWccAluSSviu00/VA71re3t5kkYr0vharS
        Y8wpILKpZnVRvg++jkzVLuM1GjY10GT1hSqBYYbXWYUwUpLocCtRllSUtgRCmmiI9cOLS/
        SMiG31ityVXUgCamE6hlkRQp40x+lbX0x3xXqVRMxRP9e0J2DX8oHC3dp/oQF4PXI+L6Wp
        6ba2R2EsrFWFLzbXhzhmaeIcAd+Qg0tYUbJ2TNtOMM7U1kQ8PmTpc5ELrpo4IIxmY0afFL
        JSSrwPMvhC0VBME/68jo0vJySVCUJDCPHdM4vcmBl/7OjzwX06rF0YflzjPKVw==
Received: from xps.demsh.org (algiz.demsh.org [94.103.82.47])
        by hermod.demsh.org (OpenSMTPD) with ESMTPSA id c712456e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) auth=yes user=me;
        Thu, 3 Nov 2022 16:41:43 +0000 (UTC)
Date:   Thu, 3 Nov 2022 19:41:40 +0300
From:   Dmitrii Tcvetkov <me@demsh.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <axboe@kernel.dk>, <stefanha@redhat.com>, <ebiggers@kernel.org>,
        <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/3] fix direct io errors on dm-crypt
Message-ID: <20221103194140.06ce3d36@xps.demsh.org>
In-Reply-To: <20221103152559.1909328-1-kbusch@meta.com>
References: <20221103152559.1909328-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 3 Nov 2022 08:25:56 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> The 6.0 kernel made some changes to the direct io interface to allow
> offsets in user addresses. This based on the hardware's capabilities
> reported in the request_queue's dma_alignment attribute.
> 
> dm-crypt requires direct io be aligned to the block size. Since it was
> only ever using the default 511 dma mask, this requirement may fail if
> formatted to something larger, like 4k, which will result in
> unexpected behavior with direct-io.
> 
> There are two parts to fixing this:
> 
>   First, the attribute needs to be moved to the queue_limit so that it
>   can properly stack with device mappers.
> 
>   Second, dm-crypt provides its minimum required limit to match the
>   logical block size.
> 
> Keith Busch (3):
>   block: make dma_alignment a stacking queue_limit
>   dm-crypt: provide dma_alignment limit in io_hints
>   block: make blk_set_default_limits() private
> 
>  block/blk-core.c       |  1 -
>  block/blk-settings.c   |  9 +++++----
>  block/blk.h            |  1 +
>  drivers/md/dm-crypt.c  |  1 +
>  include/linux/blkdev.h | 16 ++++++++--------
>  5 files changed, 15 insertions(+), 13 deletions(-)
> 

Applied on top 6.1-rc3, after that issue[1] doesn't reproduce.

[1] https://lore.kernel.org/linux-block/20221101001558.648ee024@xps.demsh.org/
