Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD22DC433E1
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FCA2071A
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323580;
	bh=93VtrhpJhW5ji787OKKOrWmym8i6VsEvml8Gx5ybefM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jTkmEEGp4fZkjzsgb7IQwFShTx6OgI5i+XHyDt+VT8p9AhYcNl+JJ1MSAgf1YFwHp
	 CIg9TWa+jJ4ujKQjqUhj1g1hdRhNmJypnJfA+QfABevgAVRJGL8dch3cA0M/9pZzhD
	 mxhkc8fS1lqP9b5MEHwl5swkHHxgRl12WqYOTpFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgFPQGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731083AbgFPPsP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 11:48:15 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24FE520776;
        Tue, 16 Jun 2020 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322495;
        bh=93VtrhpJhW5ji787OKKOrWmym8i6VsEvml8Gx5ybefM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1XBAOSOZAVLefM7gMkWTnOBLIC/o+sLP0+7VEtuCu3NRvJy2+7or2OiFZJ3Bwvmu
         6ytBFCEeyiwIjD76RK/QNMj7Y9UvGuQFL0yclSI1hDrC5aY/XugUZDtLtcexZg7Dto
         OMc0DOvrdUBXfnikI/u/KkngH6dOM2bLGOXWMLZM=
Date:   Tue, 16 Jun 2020 08:48:12 -0700
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
Message-ID: <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 16, 2020 at 05:02:17PM +0200, Javier González wrote:
> This depends very much on how the FS / application is managing
> stripping. At the moment our main use case is enabling user-space
> applications submitting I/Os to raw ZNS devices through the kernel.
> 
> Can we enable this use case to start with?

I think this already provides that. You can set the nsid value to
whatever you want in the passthrough interface, so a namespace block
device is not required to issue I/O to a ZNS namespace from user space.
