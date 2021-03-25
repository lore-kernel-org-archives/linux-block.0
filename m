Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1622C433C1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13CA61A2A
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhCYPOt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhCYPOi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:14:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92E8861879;
        Thu, 25 Mar 2021 15:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616685278;
        bh=EbycO/deHFM530+ruOu412p0Jfev3nG2KiWakLqetXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxlUVWMHYwvolg6D/CjQEqHhZ1nmoq17qMz33zAghoiiqto221fGWVmcGAplrNtoK
         FMSy00KeLMdiGsAQkfde4zgyl6QTJgk33R1t190q5furIs2W41ujDs+DRFrGr5FGbU
         m8BO7nNGIIhfTf8GFvPbvvmHYI67E5vQHhIY2ZGeqi8DxwMFvRHgCE0meXUhJ86VE7
         qBmQx363VMisDJL0QFDNfS9915xjXpvXdz723YeODrCj7KTtWBafBLOlGL/vQADyR0
         ZZVxpdDCmqNK/bDFLdD7VzSP/gau4R5mOOOfwgXovYPyYkDE6zcKEgcVQaf1bzVRhw
         HVyAzyDbCYWYQ==
Date:   Fri, 26 Mar 2021 00:14:33 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210325151433.GA31394@redsun51.ssa.fujisawa.hgst.com>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <YFyBM1qq+AmYQvdl@x1-carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFyBM1qq+AmYQvdl@x1-carbon.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 12:25:24PM +0000, Niklas Cassel wrote:
> On Mon, Mar 01, 2021 at 08:24:51PM +0100, javier@javigon.com wrote:
> > From: Javier González <javier.gonz@samsung.com>
> > 
> > Create a char device per NVMe namespace. This char device is always
> > initialized, independently of whether the features implemented by the
> > device are supported by the kernel. User-space can therefore always
> > issue IOCTLs to the NVMe driver using the char device.
> > 
> > The char device is presented as /dev/nvme-generic-XcYnZ. This naming
> > scheme follows the convention of the hidden device (nvmeXcYnZ). Support
> > for multipath will follow.
> 
> Do we perhaps want to put these new character devices inside a subdir?
> e.g. /dev/nvme/nvme-generic-XcYnZ ?

I actually suggested the same hierarchy, but that was rejected.
 
> Otherwise it feels like doing such a simple thing as ls -al /dev/nvme*
> will show a lot of devices because of these new specialized char devices.
