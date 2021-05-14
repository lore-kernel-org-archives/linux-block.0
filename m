Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CEFC43461
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 11:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39456145D
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 11:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhENLq7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 07:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhENLq6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 07:46:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1B826145A;
        Fri, 14 May 2021 11:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620992747;
        bh=vPOcLTJAbLQBPG5xiHyVQ/jk3if4qn+FmRdZHvC68CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZW68/04MHR/aUrnt8Phfslq713qqBllSrQ21S+z9KeMjDIeSxC51N1RnJvXr6KNBr
         ffbMUYam24ZbzOqeSiN2SshVx9KUVdzSB3Z2ZO8geE+Yph3WRcBcOR1fqkzhqnT4HO
         VbsWDRCBOU50msMTFGA0euQyw9MjZ1yZ1M+rnMpI=
Date:   Fri, 14 May 2021 13:45:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     David Miller <davem@davemloft.net>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel@pengutronix.de, netdev@vger.kernel.org,
        sparclinux@vger.kernel.org, kuba@kernel.org, jirislaby@kernel.org
Subject: Re: [PATCH] sparc/vio: make remove callback return void
Message-ID: <YJ5i6F4zHPAR+HCF@kroah.com>
References: <20210505201449.195627-1-u.kleine-koenig@pengutronix.de>
 <20210505.132739.2022645880622422332.davem@davemloft.net>
 <20210506061121.3flqmvm4jok6zj5z@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506061121.3flqmvm4jok6zj5z@pengutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 06, 2021 at 08:11:21AM +0200, Uwe Kleine-König wrote:
> Hi Dave,
> 
> On Wed, May 05, 2021 at 01:27:39PM -0700, David Miller wrote:
> > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Date: Wed,  5 May 2021 22:14:49 +0200
> > 
> > > The driver core ignores the return value of struct bus_type::remove()
> > > because there is only little that can be done. To simplify the quest to
> > > make this function return void, let struct vio_driver::remove() return
> > > void, too. All users already unconditionally return 0, this commit makes
> > > it obvious that returning an error code is a bad idea and should prevent
> > > that future driver authors consider returning an error code.
> > > 
> > > Note there are two nominally different implementations for a vio bus:
> > > one in arch/sparc/kernel/vio.c and the other in
> > > arch/powerpc/platforms/pseries/vio.c. This patch only addresses the
> > > former.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > Acked-by: David S. Miller <davem@davemloft.net>
> 
> Thanks for your Ack. My expectation was that this patch will go via a
> sparc tree. Does your Ack mean that you think it should take a different
> path?

I'll pick it up, thanks.

greg k-h
