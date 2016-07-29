Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41435 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbcG2Bj1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 28 Jul 2016 21:39:27 -0400
To: Florian-Ewald =?utf-8?Q?M=C3=BCller?=
	<florian-ewald.mueller@profitbricks.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH linux-4.7-rc7] blk_stack_limits() setting discard_granularity
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CAHJVUehBe1zKvp==CUs0YkmRt5sT8qOES6bPnaeNKKsfuZ3Zrw@mail.gmail.com>
	<yq1shv1bh75.fsf@sermon.lab.mkp.net>
	<CAHJVUejnP=sxzrryZDPz4Y_PutF8yAV3LJSdQJGnvD+Cy==08g@mail.gmail.com>
	<yq1oa5j7sqx.fsf@sermon.lab.mkp.net>
	<CAHJVUejV6d0qk-Yrjqu+OfUoLrus8JctXuzwsNgMyfumUs6_+g@mail.gmail.com>
Date: Thu, 28 Jul 2016 21:39:19 -0400
In-Reply-To: <CAHJVUejV6d0qk-Yrjqu+OfUoLrus8JctXuzwsNgMyfumUs6_+g@mail.gmail.com>
	("Florian-Ewald =?utf-8?Q?M=C3=BCller=22's?= message of "Wed, 27 Jul 2016
 10:13:26
	+0200")
Message-ID: <yq1h9b92pfc.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Florian-Ewald" == Florian-Ewald Müller <florian-ewald.mueller@profitbricks.com> writes:

Florian-Ewald,

> My (new developed) distributed block device uses a block size of 64K.

> So, because of the distribution functionality to different underlying
> slave (dm-cache) block devices, it has:
> - max_discard_sectors: 128 (64K)
> - discard_granularity: 65536 (64K)

> The discard sizes of the (underlying) dm-cache devices are:
> - max_discard_sectors: 536870912 (256G)
> - discard_granularity: 268435456 (256M)

Why do you set max_discard_sectors for your device to 128? To my
knowledge dm-cache does not do partial allocation. And consequently any
discard less than an aligned 256MB will be a nop anyway.

-- 
Martin K. Petersen	Oracle Linux Engineering
