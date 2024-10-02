Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C342564
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864996; cv=none; b=ZIgotraJoxm8nIWBAcHLwUDiecRnzaHlOWBJc3zAY7x3Yp0dUTkGkueKuZ0KCDZnMYtMX+VZQqRp3cf+sWjv6d/0PJILK1n3FuHQf+pp814B0rONXLhP66uecVVv7q/qYGOR6XlPj13vP7lnGg3D6N+/4FN927d0MrRHszL0xQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864996; c=relaxed/simple;
	bh=NuNGaQe1XYDBG/UKLly1YHcwXhE3cmJIYgOSQXOKipM=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=gUCCkE728p1nMlIeDOdTqn3O72LWqsYfm4MTHIwcw6//Aksd18LIzpGvMwxkki0Dkir1PmQqj7L9okQC6GuOSXIO4xnUNWSMH8WhYWEXhjpXVjkRMdvX16CGNa3RVm48K3mp8WfJ+4cBBP0IaVOMpCTx4AHl2kovvKUQTTILpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FdKqEZeV; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FdKqEZeV"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241002102952euoutp02cec4c6e73c7539602965932c84d1aaf8~6nA5MUbtY2046920469euoutp02l
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 10:29:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241002102952euoutp02cec4c6e73c7539602965932c84d1aaf8~6nA5MUbtY2046920469euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727864992;
	bh=B7pqOXXsM4Y87OzYSQIv8cWnQpJASDOO+OelvX9tBTs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FdKqEZeVcduiCxjNyO1FjwA10duqW1kr9fANYEePAhoaRCV92/CdtIUsQbXnPWFKc
	 hMU5xNf+eHv3g7iG9R3k237Vf75iNyodR+DFeA+/4C7SY0scRZnTT74k1tCReduF1e
	 C1zaDTYOLw1B9+x+HqeHhEnqJAWSVoBivv2KWn0c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241002102951eucas1p2a0fdbebc26c60c32df61e59d65b2613b~6nA46Rvm20706107061eucas1p2f;
	Wed,  2 Oct 2024 10:29:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 2D.0A.09620.F902DF66; Wed,  2
	Oct 2024 11:29:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241002102951eucas1p2d81570a43d6e75c85f443a333a0e8b6a~6nA4hpTY32003520035eucas1p2l;
	Wed,  2 Oct 2024 10:29:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241002102951eusmtrp2972f2b67761158907056603808cd1d63~6nA4hF7G70948109481eusmtrp2S;
	Wed,  2 Oct 2024 10:29:51 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-f5-66fd209f8b8c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 32.23.19096.F902DF66; Wed,  2
	Oct 2024 11:29:51 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241002102951eusmtip11d992995ccbcdf598a4a3c6705fa05aa~6nA4X1WuW1301313013eusmtip1g;
	Wed,  2 Oct 2024 10:29:51 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 2 Oct 2024 11:29:50 +0100
Date: Wed, 2 Oct 2024 12:29:50 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>, Kanchan Joshi
	<joshi.k@samsung.com>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<gost.dev@samsung.com>, Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <20241002102950.g4dure7kobtaixgf@ArmHalley.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvwXN5n1XyqRoH9H@kbusch-mbp.mynextlight.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7rzFf6mGdw6bG6x+m4/m8XK1UeZ
	LCYdusZosfeWtsX8ZU/ZLZYf/8dkse71exYHdo/z9zayeFw+W+qxaVUnm8fmJfUeu282sHl8
	fHqLxePzJrkA9igum5TUnMyy1CJ9uwSujGs7epkKXgtU3HnwjrWBcQ1vFyMnh4SAicSFRQdZ
	uhi5OIQEVjBKLDzTzQbhfGGUOHrsJCOE85lR4smLGUAZDrCW+Y+sIeLLGSV6Go8xwxVdvXQT
	ytnMKLHrxCtGkCUsAioSXUfOsIDYbAL2EpeW3WIGsUUElCXuzp/JCtLALDCVSeLes3tgDcIC
	QRJbHvcwgdi8ArYSDd+2sELYghInZz4BG8QsYCXR+aGJFeQkZgFpieX/OCDC8hLNW2eDzecE
	KlnWeZ0R4lEliccv3kLZtRKnttxiAtkrIdDOKXFr22F2iISLxIvVC5khbGGJV8e3QMVlJP7v
	nM8EYVdLNJw8AdXcwijR2rGVFRIu1hJ9Z3IgahwlZvdtYoQI80nceCsIcRufxKRt05khwrwS
	HW1CExhVZiF5bBaSx2YhPDYLyWMLGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBKak
	0/+Of93BuOLVR71DjEwcjIcYJTiYlUR47x36mSbEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVF
	PlVIID2xJDU7NbUgtQgmy8TBKdXANN98Z+8r5vmce3LjHK40h/sv6HP48y6ySoaL8WnjktbF
	eUbRz52efPUTrEiTrMz5yikoqzel6de5R1+in/DKhWo2Mdz40TK/6Wdy6dMrn1em/Pw651ha
	0tL3fQelpepkmGSthWY0Tp31jEPZ8bWws4V/1qT132/rNyfb+eq8XTT3gaH/7uamLeweBvFr
	rukmLuadrfzRWtBxdsS7VX8bst/m6kevm84g+bvw1huRaS8uNRU1nHEu7RHaWLd8ksZthpA2
	wa40rbNnX4WlBjydnXKEi3OayUWpmTeuRlrvm1H8taJzRgi/6Z6LUtFb31u6nBHZ27tpq6TO
	DZsPd44usuc+L7G8fV5KBn/bkdOtSizFGYmGWsxFxYkA7JuxE7gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7rzFf6mGRzcLWex+m4/m8XK1UeZ
	LCYdusZosfeWtsX8ZU/ZLZYf/8dkse71exYHdo/z9zayeFw+W+qxaVUnm8fmJfUeu282sHl8
	fHqLxePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
	1CJ9uwS9jGs7epkKXgtU3HnwjrWBcQ1vFyMHh4SAicT8R9ZdjFwcQgJLGSVmtt9j6WLkBIrL
	SGz8cpUVwhaW+HOtiw2i6COjxPtvFxkhnM2MEje3fQXrYBFQkeg6cgbMZhOwl7i07BYziC0i
	oCxxd/5MVpAGZoGpTBL3nt1jBEkICwRJbHncwwRi8wrYSjR828IKMfULs8Tka/uZIRKCEidn
	PgGbyixgITFz/nlGkLuZBaQllv/jgAjLSzRvnQ1WzilgJbGs8zojxNlKEo9fvIWyayU+/33G
	OIFRZBaSqbOQTJ2FMHUWkqkLGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbstmM/t+xg
	XPnqo94hRiYOxkOMEhzMSiK89w79TBPiTUmsrEotyo8vKs1JLT7EaAoMo4nMUqLJ+cCkkVcS
	b2hmYGpoYmZpYGppZqwkzst25XyakEB6YklqdmpqQWoRTB8TB6dUA1OPxpkZU8M/zK0wk5n3
	zOx5B4ez7YGNp9POvzQIUOlPOue9dIPpYcu0X4J3czlf50x8tz3vzrvgwJdal7tm9k5s+e6V
	81pp5ZeTJS1S2n83cJtt3Bzv289238v7q/q//ubu0K9zZthmfFHk/vqOOTnt/r0d8/naquq/
	fDr8J4V1BeefBtmGVVdCZKZoNk3bWSXcVKR8KeZ4v/CD+TtKF4l9S1upn5b9QcMuYOLxb3kb
	+UzTX1xJVAxauGzPX5GSHM8j0+o/cW6tVAtk+39xjfPNKze1r5u7LX8zN/qxdt9WY4XM5c3F
	hz9f+5R1bp3jabb3U078PcduWcr54d8Uk4XNvzY1LN+V8rjzB8Oeqk4/JZbijERDLeai4kQA
	X14TTmIDAAA=
X-CMS-MailID: 20241002102951eucas1p2d81570a43d6e75c85f443a333a0e8b6a
X-Msg-Generator: CA
X-RootMTR: 20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d
References: <20240201130126.211402-1-joshi.k@samsung.com>
	<CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
	<20240201130126.211402-3-joshi.k@samsung.com> <ZvV4uCUXp9_4x5ct@kbusch-mbp>
	<8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
	<ZvWSFvI-OJ2NP_m0@kbusch-mbp>
	<165deefb-a8b3-594e-9bfb-b3bcd588d23f@samsung.com>
	<yq1ttdx81ub.fsf@ca-mkp.ca.oracle.com>
	<20241001072708.tgdmbi56vofjkluc@ArmHalley.local>
	<ZvwXN5n1XyqRoH9H@kbusch-mbp.mynextlight.net>

On 01.10.2024 09:37, Keith Busch wrote:
>On Tue, Oct 01, 2024 at 09:27:08AM +0200, Javier González wrote:
>> On 30.09.2024 13:57, Martin K. Petersen wrote:
>> >
>> > Kanchan,
>> >
>> > > I spent a good deal of time on this today. I was thinking to connect
>> > > block read_verify/write_generate knobs to influence things at nvme level
>> > > (those PRCHK flags). But that will not be enough. Because with those
>> > > knobs block-layer will not attach meta-buffer, which is still needed.
>> > >
>> > > The data was written under the condition when nvme driver set the
>> > > pi_type to 0 (even though at device level it was non-zero) during
>> > > integrity registration.
>> > >
>> > > Thinking whether it will make sense to have a knob at the block-layer
>> > > level to do something like that i.e., override the set
>> > > integrity-profile with nop.
>> >
>> > SCSI went to great lengths to ensure that invalid protection information
>> > would never be written during normal operation, regardless of whether
>> > the host sent PI or not. And thus the only time one would anticipate a
>> > PI error was if the data had actually been corrupted.
>> >
>>
>> Is this something we should work on bringin to the NVMe TWG?
>
>Maybe. It looks like they did the spec this way one purpose with the
>ability to toggle guard tags per IO.
>
>Just some more background on this because it may sound odd to use a data
>protection namespace format that the kernel didn't support:
>
>In this use case, writes to the device primarily come from the
>passthrough interface, which could always use the guard tags for
>end-to-end protection. The kernel block IO was the only path that had
>the limitation.
>
>Besides the passthrough interface, though, the setup uses kernel block
>layer to write the partition tables. Upgrading from 6.8 -> 6.9 won't be
>able to read the partition table on these devices. I'm still not sure
>the best way to handle this, though.

Mmmm. Need to think more about this.

Seems this is by design in NVMe.  Will try to come back to Mike and Judy
to understand the background for this at the time...
