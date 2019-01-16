Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD59C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 14:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44B920657
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 14:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404701AbfAPOwn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:52:43 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:12903 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfAPOwn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 09:52:43 -0500
X-IronPort-AV: E=Sophos;i="5.56,486,1539648000"; 
   d="scan'208";a="84674941"
Date:   Wed, 16 Jan 2019 15:52:15 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] xen-blkback: do not wake up shutdown_wq after
 xen_blkif_schedule() is stopped
Message-ID: <20190116145215.igakzdkklc6f7h6k@mac>
References: <1547646461-29803-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1547646461-29803-1-git-send-email-dongli.zhang@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 16, 2019 at 09:47:41PM +0800, Dongli Zhang wrote:
> There is no need to wake up xen_blkif_schedule() as kthread_stop() is able
> to already wake up the kernel thread.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/block/xen-blkback/xenbus.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index a4bc74e..37ac59e 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -254,10 +254,8 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
>  		if (!ring->active)
>  			continue;
>  
> -		if (ring->xenblkd) {
> +		if (ring->xenblkd)
>  			kthread_stop(ring->xenblkd);
> -			wake_up(&ring->shutdown_wq);

I've now realized that shutdown_wq is basically useless, and should be
removed, could you please do it in this patch?

Thanks, Roger.
