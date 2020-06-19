Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20FDC433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8484421548
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592590230;
	bh=doM0zEfqKZpVZluenwhn39/xRJ8aMrZKDLjSLJA1vOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KDGSwvfrrcBBa5FGRbtLKGPenB54UMi2+/K5Ceakph1S25/ZNG0jWiYuN2eM3g3lU
	 sX2ab9cNJ9V9eSNHxoSpDvoijarpfJrdgYst21C1sI9eSGaSNXwceT3/UNJ/+p+NHO
	 ZPscS5Wo0/COPDT+iAKjCNSe1ld/5K117GAFhxRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbgFSSKa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732352AbgFSSK2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 14:10:28 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7511821548;
        Fri, 19 Jun 2020 18:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592590227;
        bh=doM0zEfqKZpVZluenwhn39/xRJ8aMrZKDLjSLJA1vOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vzEZhcirVGdLbZgOppBjgHt6qVF56l26MbgNQ8uWcx7kMR/0jvkhkrIhv9U4iy5Is
         VisRznyV8Pf0/70qsOF1V3qRPbOUoQYDXasJKzWlXkeu4tXtYYoMi2ccDIdBAVOqKM
         TyhY9OoXhMN0TOm0LOR8TGqIjU0Aec2tRI2qifas=
Date:   Fri, 19 Jun 2020 11:10:24 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Heiner Litz <hlitz@ucsc.edu>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200619181024.GA1284046@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
 <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 19, 2020 at 11:08:26AM -0700, Heiner Litz wrote:
> Hi Matias,
> no, I am rather saying that the Linux kernel has a deficit or at least
> is not a good fit for ZNS because it cannot enforce in-order delivery.

FYI, the nvme protocol can't even enforce in-order delivery, so calling
out linux for this is a moot point.

> The requirement of sequential writes basically imposes this
> requirement. Append essentially a Linux specific fix on the ZNS level
> and that enforcing ordering would be a cleaner way to enable QD>1.
