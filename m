Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AA1EB21
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819152; cv=none; b=pTzk+Lf0Aq0wiZzf74IzjhkVQ23Gzy3msaxNN0hNprDVEoTgk7hEiOJ+M42tltWmRXUibkJGd5ssOci6712xDCmKKx1mXzHoGAFGTPd068ISDiFnt+nzMFd4SPSbSrMNph+hj4L04kB+7ia4oyUeICTMQN31knGMORx8j9B/IkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819152; c=relaxed/simple;
	bh=1eccIISYqvnEKmw23BCurpF5bGx/iXGcbUmObz942UU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ljulbN9FtgLtYB8h5LZb+XOmJSHQtMNLRgCpvR8mb//Qh72vG1Qw1VIvFIAWy5+sPbeTQE9cF7beCIFnSvIR9fMIIgQUTHEi4FtwS7g1aE13qgNXNPK2yhfUrmyLtMqae271k5jBwhdOR4SAWmzSG9zhhJsdGk7+qZ2Edlx9b/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=idF4f0Xi; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="idF4f0Xi"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240701073221epoutp0270491af5c73e47f3ef8c8501ffc3d88f~eBmW5CJCN2168121681epoutp02J
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 07:32:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240701073221epoutp0270491af5c73e47f3ef8c8501ffc3d88f~eBmW5CJCN2168121681epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719819141;
	bh=WWxKY9oZHJuFLW7GFgRgK3KCqiFp5Mp6py/ldwZb0+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=idF4f0Xiqo7+NthdZVlic2KC/dFKGWHa711zJne34VwXuh1dyvTA3PtyrB2Zml9O5
	 BRrd7ikhtFSowscKS27GrjzA3Cg+ozx26VhsZfHzmJYaRuSC+4tIn4DEW1bNIUgeG9
	 2zcJbyLtDp0LOmd9LWWLivVrOjO3V/2W1t/1KAWA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240701073221epcas5p10f0caa3928d8dfbd1ea0b307ed09c781~eBmWqBc9E1699116991epcas5p10;
	Mon,  1 Jul 2024 07:32:21 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WCHn00t4vz4x9Pw; Mon,  1 Jul
	2024 07:32:20 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E9.2B.07307.28B52866; Mon,  1 Jul 2024 16:32:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240701073115epcas5p3e2758375e272cba80281fe0ac37394d0~eBlZdJv7g3170731707epcas5p3c;
	Mon,  1 Jul 2024 07:31:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240701073115epsmtrp1a718b5b491b28138bfef63f31c6f7263~eBlZcZpUS0471704717epsmtrp1E;
	Mon,  1 Jul 2024 07:31:15 +0000 (GMT)
X-AuditID: b6c32a44-3f1fa70000011c8b-7f-66825b8264ce
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.9A.19057.34B52866; Mon,  1 Jul 2024 16:31:15 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240701073113epsmtip202f1b5eb771d3ad76dc6fca5098d946d~eBlXyDV_J1952619526epsmtip2J;
	Mon,  1 Jul 2024 07:31:13 +0000 (GMT)
Date: Mon, 1 Jul 2024 12:54:05 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi
	Grimberg <sagi@grimberg.me>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: io_opt fixups
Message-ID: <20240701072405.pnlqogwgyw52xwk3@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240701051800.1245240-1-hch@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmpm5TdFOawbfr0har7/azWaxcfZTJ
	YtKha4wWe29pW8xf9pTdYvnxf0wW616/Z3Fg9zh/byOLx+WzpR6bVnWyeWxeUu+x+2YDm8fH
	p7dYPD5vkgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ
	0HXLzAG6RkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1pi
	ZWhgYGQKVJiQnTH1aF7BDPaKs6t+MTcwtrJ1MXJySAiYSCxY9Y65i5GLQ0hgN6PE3juTGSGc
	T4wSl07OZINwvjFK/Jn7jBGm5c/EDqiqvYwSL861MEE4nxkldmx6xA5SxSKgIrHh4EeWLkYO
	DjYBbYnT/zlAwiICShJPX50Fa2YWuMUoca/rP1i9sICUxKZtc5hA6nkFnCX+n1IACfMKCEqc
	nPmEBcTmFDCSONe6hBWkV0LgJ7vEiTVbWSAucpE4d6iJHcIWlnh1fAuULSXxsr8Nyi6XWDll
	BRtEcwujxKzrs6DesZdoPdXPDLKYWSBDYvlSLoiwrMTUU+uYQGxmAT6J3t9PmCDivBI75sHY
	yhJr1i+ABqSkxLXvjVC2h8T5lU3QQGlllFj/7CbbBEa5WUgemoWwbhbYCiuJzg9NrBBhaYnl
	/zggTE2J9bv0FzCyrmKUTC0ozk1PTTYtMMxLLYfHcXJ+7iZGcPrUctnBeGP+P71DjEwcjIcY
	JTiYlUR4A3/VpwnxpiRWVqUW5ccXleakFh9iNAVGz0RmKdHkfGACzyuJNzSxNDAxMzMzsTQ2
	M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgenZvZnV2WtuupVbyr9avMbd1/Ifa7Gt7ak/
	j98+2fj0tx1Tq+HrtXO9t9uyGmy+o88Wv1X/rPGF/Nvr976690wtjG+z/K9y3d7ovIYE79aA
	pjzD/WtdX26+Inv4ZdOWsv3S6/UmMzwqLxdlvfnP+7T+zUk1LL8mup5sLMgpuatqtUjvkBjT
	fGObT+zHNLxv+zlmb7nzs/z/ymlav56r6HX+OipnZ/53S2HNEnWpAMPqidM3rGG/uvHuvsuc
	WgzLHus+vrSZ7cun7gT/G9EaskJmW4Lvnnll0BDDu/iizvG7Qjq2Vr3GOrdWMenNrlrLYd0+
	aUH25wuHdlnNlNwyf2HvXI65B7avSJ8/VWnHihf3lViKMxINtZiLihMBj/RdBygEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvK5zdFOawd7jKhar7/azWaxcfZTJ
	YtKha4wWe29pW8xf9pTdYvnxf0wW616/Z3Fg9zh/byOLx+WzpR6bVnWyeWxeUu+x+2YDm8fH
	p7dYPD5vkgtgj+KySUnNySxLLdK3S+DKeDq1iangFEvFj46fjA2MF5m7GDk5JARMJP5M7GDs
	YuTiEBLYzShxYcV1doiEpMSyv0egioQlVv57DhYXEvjIKNH5qQDEZhFQkdhw8CNLFyMHB5uA
	tsTp/xwgYREBJYmnr84ygtjMArcYJfZ9VAaxhQWkJDZtm8MEUs4r4Czx/5QCxERDicMrd4Jt
	4hUQlDg58wkLRKuZxLzND5lBypkFpCWW/wObzilgJHGudQnrBEaBWUg6ZiHpmIXQsYCReRWj
	ZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnDIa2ntYNyz6oPeIUYmDsZDjBIczEoivIG/
	6tOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoEk2Xi4JRqYGo0bhLL
	aBUvv5eZ7CDzIiWmy8Xws9bOEtXt7aYXq7i5FhyeVfj24/Pj22/4mM1t3cB/skzEw/nA+yo9
	3vUfFZ6bfzs5acKGSVd2VRnvmGhysPIHm83TgooITjH1G9VGp6O25cwRzM+STcspyLnnulV5
	WdqULkFjWRH39VMvHd9wdl3evNMBlyre7j3Mb+Ac8Gfq/v/y7MGsPOdVEisT9qj8jEqZVeH8
	Uy1CdMrRrYKy0k9UotWjvMVcpzTwMHxL+Vm8u/5g3psDKvfV4xdL92QULUjYpGV4SmNL92XG
	hcrRO97snn7QqeSR0j/vsDzGC93cu+76yxwsD5Ju6LdfeG2fzOH29snyKgUH6/bXKrEUZyQa
	ajEXFScCAGZzINfoAgAA
X-CMS-MailID: 20240701073115epcas5p3e2758375e272cba80281fe0ac37394d0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_a96da_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240701073115epcas5p3e2758375e272cba80281fe0ac37394d0
References: <20240701051800.1245240-1-hch@lst.de>
	<CGME20240701073115epcas5p3e2758375e272cba80281fe0ac37394d0@epcas5p3.samsung.com>

------LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_a96da_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 01/07/24 07:17AM, Christoph Hellwig wrote:
>Hi all,
>
>I recently noticed that on my test VMs with the Qemu NVMe emulations I
>see a zero max_setors_kb limit in sysfs.  It turns out Qemu advertises
>a one-LBA optimal write size, which is a bit silly.
>
>This series handles this odd case properly both in the block layer and
>the nvme driver as a sort of defense in depth.
>
>Diffstat:
> block/blk-settings.c     |    5 ++---
> drivers/nvme/host/core.c |    3 ++-
> 2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_a96da_
Content-Type: text/plain; charset="utf-8"


------LZGu4PYXs2BAW_XTHz_lwyKyr.30uhOcduHjiEfMHTkCTgtA=_a96da_--
