Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:18254 "EHLO
	userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbcHBCKv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Mon, 1 Aug 2016 22:10:51 -0400
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u722AFRW002097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-block@vger.kernel.org>; Tue, 2 Aug 2016 02:10:16 GMT
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
	<yq1h9b92pfc.fsf@sermon.lab.mkp.net>
	<CAHJVUeik5+3mYSFqaONu50XF9sV5+tMpTXqM-Kcijzwj+f6vDg@mail.gmail.com>
Date: Mon, 01 Aug 2016 22:08:21 -0400
In-Reply-To: <CAHJVUeik5+3mYSFqaONu50XF9sV5+tMpTXqM-Kcijzwj+f6vDg@mail.gmail.com>
	("Florian-Ewald =?utf-8?Q?M=C3=BCller=22's?= message of "Fri, 29 Jul 2016
 09:59:54
	+0200")
Message-ID: <yq1mvkvzzvu.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> Florian-Ewald Müller <florian-ewald.mueller@profitbricks.com> writes:

Florian-Ewald,

> Now my experiments show that, at least, dm-cache doesn't complain nor
> rejects those smaller discards than its discard_granularity, but
> possibly turning them into noop (?).

Correct. Anything smaller than (an aligned) multiple of the discard
granularity will effectively be ignored.

In practice this means that your device should allocate things in
aligned units of the underlying device's discard granularity.

> May be that the needed functionality of accumulating small discards to
> a big one covering its own granularity (similar to SSDs block erasure)
> should be done at that driver level.

Do you allocate blocks in a predictable pattern between your nodes?

For MD RAID0, for instance, we issue many small discard requests. But
for I/Os that are bigger than the stripe width we'll wrap around and do
merging so that for instance blocks 0, n, 2*n, 3*n, etc. become part of
the same discard request sent to the device.

If you want discards smaller than the underlying granularity to have an
effect then I'm afraid the burden is on you to maintain a bitmap of each
granularity sized region. And then issue a deferred discard when all
blocks inside that region have been discarded by the application or
filesystem above.

If you want to pursue partial block tracking it would be good to come up
with a common block layer infrastructure for it. dm-thin could benefit
from it as well...

-- 
Martin K. Petersen	Oracle Linux Engineering
