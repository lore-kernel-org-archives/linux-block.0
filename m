Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:43132 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbcG0Bv6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 26 Jul 2016 21:51:58 -0400
To: Florian-Ewald =?utf-8?Q?M=C3=BCller?=
	<florian-ewald.mueller@profitbricks.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH linux-4.7-rc7] blk_stack_limits() setting discard_granularity
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CAHJVUehBe1zKvp==CUs0YkmRt5sT8qOES6bPnaeNKKsfuZ3Zrw@mail.gmail.com>
	<yq1shv1bh75.fsf@sermon.lab.mkp.net>
	<CAHJVUejnP=sxzrryZDPz4Y_PutF8yAV3LJSdQJGnvD+Cy==08g@mail.gmail.com>
Date: Tue, 26 Jul 2016 21:51:50 -0400
In-Reply-To: <CAHJVUejnP=sxzrryZDPz4Y_PutF8yAV3LJSdQJGnvD+Cy==08g@mail.gmail.com>
	("Florian-Ewald =?utf-8?Q?M=C3=BCller=22's?= message of "Sat, 23 Jul 2016
 13:19:57
	+0200")
Message-ID: <yq1oa5j7sqx.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Florian-Ewald" == Florian-Ewald Müller <florian-ewald.mueller@profitbricks.com> writes:

Florian-Ewald,

Florian-Ewald> My setup is a new developed distributed block
Florian-Ewald> device on top of dm-cache.  The dm-cache values are
Florian-Ewald> bigger than those needed by my (new developed) block
Florian-Ewald> device.

What are the actual values for granularity and max? For your device and
dm-cache respectively.

-- 
Martin K. Petersen	Oracle Linux Engineering
