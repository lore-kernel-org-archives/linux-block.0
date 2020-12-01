Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA83C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 19:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F4086204EC
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 19:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqfI1pGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgLATau (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgLATau (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Dec 2020 14:30:50 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E94204EC;
        Tue,  1 Dec 2020 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606851009;
        bh=uXKPLA1a1Yej4SzJ0DOOepOD0FSpUn7pnq8xtF1CBXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqfI1pGO4DskIFbywYs6IvLJZZiiVpkN59BYg3Uo910IWmZYg6C0UMaeGJ/3PmOgR
         Qeq8c99rohTvQil0+CQUn9Qw/66D7M2rnvuVgHQJ9k459WcVIjeyM55i6iL2RC8Ii5
         JQCd4oYmn888az7/uMbON8qv21SYV8jN9SvmJjRQ=
Date:   Wed, 2 Dec 2020 04:30:02 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-5-javier.gonz@samsung.com>
 <CGME20201201140354eucas1p1940891b47ca0c03ea46603393c844f61@eucas1p1.samsung.com>
 <20201201140348.GA5138@localhost.localdomain>
 <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 01, 2020 at 07:57:32PM +0100, Javier González wrote:
> On 01.12.2020 23:03, Minwoo Im wrote:
> > > +
> > > +	device_initialize(&ns->cdev_device);
> > > +	ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt),
> > > +				     ns->head->instance);
> > > +	ns->cdev_device.class = nvme_ns_class;
> > > +	ns->cdev_device.parent = ctrl->device;
> > > +	ns->cdev_device.groups = nvme_ns_char_id_attr_groups;
> > > +	dev_set_drvdata(&ns->cdev_device, ns);
> > > +
> > > +	sprintf(cdisk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
> > > +			ctrl->instance, ns->head->instance);
> > 
> > In multi-path, private namespaces for a head are not in /dev, so I don't
> > think this will hurt private namespaces (e.g., nvme0c0n1), But it looks
> > like it will make a little bit confusions between chardev and hidden blkdev.
> > 
> > I don't against to update nvme-cli things also even naming conventions are
> > going to become different than nvmeXcYnZ.
> 
> Agree. But as I understand it, Keith had a good argument to keep names
> aligned with the hidden bdev. 

My suggested naming makes it as obvious as possible that the character
device in /dev/ and the hidden block device in /sys/ are referring to
the same thing. What is confusing about that?

> It is also true that in that comment he suggested nesting the char
> device in /dev/nvme

Yeah, I'm okay with sub-directories for these special handles, but there
are arguments against it too. I don't feel that strongly about it either
way.
