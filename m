Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510992;
	b=fxQBN3DYMLA8cldW6thsXgZMeoiB3ryyw+LiDzVbKu12+612HyFVeOnMVLbZhLpZNygW
	 A/NaYn32Z+qkXBpDAl9JT6/COJ7yzh16VLKTl/hsji0DoJv08epFxLaCNuysSmjuILZVW
	 kWRdrq9AWmQwMCtqs2d5+TvVKzt9v1oHBMl2UmfRZEVEEIGTpNmoVHKg6zPPrpe35GQiU
	 CVyUW245uo+c41tYcHdKCaclD5sHyGGRSHWUryJBGPozJ47Axxm+RnegRlPi1epon74dd
	 8XPak84HITH4EnkqfaonsbimPGQtMvdJ5NPhUHhQrAb8ZASDeTUOZ6txKjdayQJ98xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510992;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Mime-Version:Subject:Reply-To:Sender:From:To:CC:X-Priority:
	 X-Content-Kind-Code:In-Reply-To:X-CPGS-Detection:X-Drm-Type:
	 X-Msg-Generator:X-Msg-Type:X-Reply-Demand:Message-ID:Date:
	 X-CMS-MailID:Content-Transfer-Encoding:Content-Type:X-Sendblock-Type:
	 CMS-TYPE:X-CPGSPASS:X-CPGSPASS:cpgsPolicy:X-CFilter-Loop:
	 X-CMS-RootMailID:References;
	bh=OeIpI24/F3WB52LFABE1SqnVRMCOX+nmt79ZJQb7pzk=;
	b=OCPMhjQDDxSADGbYIh/zggG8x/Fk4xgCvXN3wfrBgnEjOzfppPJUFfdD+qDL4Dx9yXUN
	 ERVVCyq3JIDkPmD7SMoaqZYCNqNHmN0YCi/o92fBuvAcQIKKgT7WSm/EJcfUV2+tEwadP
	 5vXGRWL66bI0nOBO+rLyNfwrSewrx8XlrXWz0pZrA6rWOnpd7cKt3V8p3Dl3hvSyXWHbZ
	 AJ3X1Wm5kQ/a+L0/pC4fEq9rjFet4atIRl265WGU6vSHZ9ZN6yoQ6+0c8FSgYmNGWJ0K5
	 ydb3rGEfpgUwDiqbXy7ORrlq0D08cPm2aNkk/bLDPHX6/YewTNnDPXk4S2dNnAiA8oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=PrOCn4Ey;
	arc=none smtp.remote-ip=203.254.224.24
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9A606A327
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 09:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BE9A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=PrOCn4Ey
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261124090303epoutp01bac13bd1f67e28c57819d1c877471614~q77nnredr2957729577epoutp01-
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 09:03:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261124090303epoutp01bac13bd1f67e28c57819d1c877471614~q77nnredr2957729577epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795510983;
	bh=OeIpI24/F3WB52LFABE1SqnVRMCOX+nmt79ZJQb7pzk=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=PrOCn4EyHRBzCb07htG/ZubDvLHcbN2eCWr/kQVTcyg0mRdH5vjL4j+N9sIcXtod7
	 WAd2LsOlpCNgeRq41bHohcadgNII1Y80xe0ROxcZIF6LrExTig9B/5yljgPHpjdGCr
	 bht1RAWMdGNSVvyi6B9kj5epBWp246IoCXrdEmts=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20261124090302epcas2p1699090c5343d3ab887ece39e23e0758e~q77m87Ro92037020370epcas2p1f;
	Tue, 24 Nov 2026 09:03:02 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.202]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4jYcKL0xxwz6B9mK; Tue, 24 Nov
	2026 09:03:02 +0000 (GMT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: RE: [RFC PATCH RESEND 0/3] block: cgroup-based and explicit write
 stream placement for NVMe FDP
Reply-To: suho.son@samsung.com
Sender: Suho Son <suho.son@samsung.com>
From: Suho Son <suho.son@samsung.com>
To: Tejun Heo <tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "io-uring@vger.kernel.org"
	<io-uring@vger.kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "asml.silence@gmail.com"
	<asml.silence@gmail.com>, KiYoung Lee <kiyoung77.lee@samsung.com>, JinHeon
	Kim <jinheon09.kim@samsung.com>, "ngeol564@gmail.com" <ngeol564@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <03f83d9625a179d35d7e4a5c2ad0e09e@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261124090301epcms2p1d0a27ea82ad2689fc0091c97450a86cd@epcms2p1>
Date: Tue, 24 Nov 2026 18:03:01 +0900
X-CMS-MailID: 20261124090301epcms2p1d0a27ea82ad2689fc0091c97450a86cd
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261123095752epcas2p421880961d49868158deabb5ba9fd6e67
References: <03f83d9625a179d35d7e4a5c2ad0e09e@kernel.org>
	<20261123051521epcms2p2445107f926f3acaa2d51c5e12abea90e@epcms2p2>
	<CGME20261123095752epcas2p421880961d49868158deabb5ba9fd6e67@epcms2p1>

Hi Tejun,

Tejun Heo wrote:
> On Mon, Nov 23, 2026 at 02:15:21PM +0900, Suho Son wrote:
> >   - whether io.stream belongs in io.* under cgroup v2, and its
> >     interaction with the existing io controller file hierarchy
>
> It doesn't. cgroup controllers and their interface files are for
> hierarchical resource control and this isn't that.
[...]
> Nacked-by: Tejun Heo <tj@kernel.org>

Understood. I'll drop the cgroupfs interface.

Jens, would a minimal BPF hook for selecting the write stream in the
submit path, with target cgroups identified by cgroup ID as Tejun
suggested, be acceptable for the block layer, or would you prefer a
different approach? This is for unmodified workloads, including their
buffered writeback.

Adding Christoph, Keith and Pavel.

Thanks,
Suho
