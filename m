Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800CFC433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CE9214DB
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323637;
	bh=3FKReWcTjxvtWSUP+wv760H8pXRYIvClXEOzXJsmKFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2VKnw05WsogtWfPyz3xfHvSWzd1Vyer+Ys9kkpgj35H1TeFrGhfNPyDSXVK2GIS/6
	 BOcZZpGX0O8KIo5Bd08dvhPkFbcV4HkOCbAtU2qTgj7p36nUxXJz/omhBy/zjgAodw
	 cQpW4DhTqj7ddW1JJsa2FcOOdRv2i8jYS+z6RPC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbgFPQHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732437AbgFPQHP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 12:07:15 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005572071A;
        Tue, 16 Jun 2020 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592323635;
        bh=3FKReWcTjxvtWSUP+wv760H8pXRYIvClXEOzXJsmKFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZpcW41sZs78uweTNWmMHceoI27W6QrK2th1ZNmdYMFnEbV45nWsMaStiXP8jtx1q
         44Xj4Arvy0uvR4kWThVQkxNpjeuEfD8gyJWl06RFdKDPiBI0kJIpyT8Trn9spTz8GU
         blNykQbTSBXDvBsj/YCdDFgHUaXQZLzpxd9V0WDo=
Date:   Tue, 16 Jun 2020 09:07:12 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <Keith.Busch@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
References: <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 16, 2020 at 05:55:26PM +0200, Javier González wrote:
> On 16.06.2020 08:48, Keith Busch wrote:
> > On Tue, Jun 16, 2020 at 05:02:17PM +0200, Javier González wrote:
> > > This depends very much on how the FS / application is managing
> > > stripping. At the moment our main use case is enabling user-space
> > > applications submitting I/Os to raw ZNS devices through the kernel.
> > > 
> > > Can we enable this use case to start with?
> > 
> > I think this already provides that. You can set the nsid value to
> > whatever you want in the passthrough interface, so a namespace block
> > device is not required to issue I/O to a ZNS namespace from user space.
> 
> Mmmmm. Problem now is that the check on the nvme driver prevents the ZNS
> namespace from being initialized. Am I missing something?

Hm, okay, it may not work for you. We need the driver to create at least
one namespace so that we have tags and request_queue. If you have that,
you can issue IO to any other attached namespace through the passthrough
interface, but we can't assume there is an available namespace.
