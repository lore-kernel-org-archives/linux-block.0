Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FF1D31A0
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152850; cv=none; b=ngGgf/OSxqVTc5q+rneKUZcEyWZomnKb7OmaIqJtGcAUDbJqGLlONNy84MiAwO4dcNjWJFeiC8HWyWaMxisuh2JGFMhdE2aPfZSAEiUBLoc1sRj1Y3nSlbqKl78rITfMnFbVmiFxRuosRYzWdm1L1ymTpEmqn5Wa7RFLyLdYkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152850; c=relaxed/simple;
	bh=UpH8h7wacK2UebtEp7BuKFTS7/r97CnYIJHpk47clSU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=HoYkgRVKkZaoLZyO2l7+jQnh889fE4A1NB/4WRwp0ITVNFPdFqpDHHlO5Y+bym027TJo6PK5uOkBnMf1ERsk1WEv7BAxhIz3+xtzbXM41Ty7HwRH6vsgzA6o2V8OvyOpygi4fpnKnj98h6P8XiSnERVrGKmokKbZB4Ti0dvT0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YdhFbzJ2; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YdhFbzJ2"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241017081400epoutp03415da55edc395b31f46988d560e53c14~-L1joaRff2133321333epoutp03r
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 08:14:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241017081400epoutp03415da55edc395b31f46988d560e53c14~-L1joaRff2133321333epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729152840;
	bh=pDLpjy6R8XNUqzYH2uFDSvoyNM+DND0gn5dbMA66X0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YdhFbzJ2PBVMDLDvxrXB2iQnqQMetM8y0yHtU7Y4Q9xf/sZ28gi/fh9/vJm2wYmLq
	 XPzmV3XmbRazplPaownqa1q3G3SWgAH76W59xADj5k4M+0OnL9VIwO9k/34cGDaF97
	 GG8DBPWEUk+k99kadXEpzp14msoorN+pxAax0yJQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241017081400epcas5p46e38c0d524781a09f82842562c374225~-L1jR6JUg2577525775epcas5p4z;
	Thu, 17 Oct 2024 08:14:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XTgbB4CC5z4x9QH; Thu, 17 Oct
	2024 08:13:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.DB.09800.447C0176; Thu, 17 Oct 2024 17:13:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241017060905epcas5p35f250dd9dd49791b4e58c143dc5fbc00~-KIfJ3qM32739527395epcas5p3U;
	Thu, 17 Oct 2024 06:09:05 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241017060905epsmtrp251d909dd228d003131b265f0cc82ee47~-KIfEyuUP1835918359epsmtrp2r;
	Thu, 17 Oct 2024 06:09:05 +0000 (GMT)
X-AuditID: b6c32a4b-23fff70000002648-fd-6710c744a439
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.C7.18937.10AA0176; Thu, 17 Oct 2024 15:09:05 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241017060904epsmtip2c8dae186b8b4c86dcef2a7fe1faeb490~-KIeApd6C1460314603epsmtip2f;
	Thu, 17 Oct 2024 06:09:04 +0000 (GMT)
Date: Thu, 17 Oct 2024 11:31:23 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, martin.petersen@oracle.com, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
Message-ID: <20241017060123.GA8191@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241016201309.1090320-1-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhq7LcYF0gy3T+C1W3+1ns1i5+iiT
	xaRD1xgtzlxdyGKx95a2xfxlT9ktlh//x+TA7nH5bKnHplWdbB6bl9R77L7ZwOZx7mKFx8en
	t1g8Pm+SC2CPyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQ
	dcvMATpGSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJl
	aGBgZApUmJCd8fv0IfaCZWwVX9/0MTYw7mHtYuTkkBAwkbg84xF7FyMXh5DAbkaJb++XMUI4
	nxglDjZvZ4Nzrl/+xgjTsqhxB1TLTkaJ81vmgc0SEnjGKLGxwxXEZhFQlTjTeZMFxGYTUJc4
	8rwVrFlEQFHiPDAoQJqZBeYySvxc8BisSFjAXeLp2g42EJtXQEfi7IoeRghbUOLkzCdgNZwC
	5hLzV+5mB7FFBZQlDmw7zgQySELgL7tE344WJojzXCTuf3jIDmELS7w6vgXKlpL4/G4vG4Sd
	LvHj8lOo+gKJ5mP7oF6zl2g91c/cxcgBdF2GxKflahBhWYmpp9aBlTML8En0/n4C1corsWMe
	jK0k0b5yDpQtIbH3XAOU7SHxve0EKyS0uhglbi+cxzaBUX4Wkt9mIaybBbZCR2LB7k9sEGFp
	ieX/OCBMTYn1u/QXMLKuYpRMLSjOTU8tNi0wzksth0d4cn7uJkZwWtXy3sH46MEHvUOMTByM
	hxglOJiVRHgndfGmC/GmJFZWpRblxxeV5qQWH2I0BcbVRGYp0eR8YGLPK4k3NLE0MDEzMzOx
	NDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBaeJeqaqFs7bysS9quna+k2nHCgOzm5Ja
	M2//WGPx+8DLeGeXF6dE9Cz8tuVX+e3w29TxdcdqLWYeacbE6FfBl+Sc8m9typJaZ3xd6pXr
	8sfnlPiNf65ZenS3cNVlBYGTaf+WxVx7obXxis0LletXJBb3CMZ9Pfg8Nvrl/SC+Y+s3X5WR
	nSF20+U05+7bdo3uyhGfOrh3yGx7kzPffK61bPmWL34H5rN8WaUzc3felLJUJ6vzmlyfoh0E
	Jy+rWcH0Pm/L4ucmBlMDeBJ0+phDQ/ZtbWtQTrhtc1lqf/iWufKn+3OudH2oSBDbkcJdmvSR
	S016O8evINFfqi42R+Lta7bsLG1s+fJyz/mL7tzem5RYijMSDbWYi4oTAcRpVEE0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvC7jKoF0g8NdMhar7/azWaxcfZTJ
	YtKha4wWZ64uZLHYe0vbYv6yp+wWy4//Y3Jg97h8ttRj06pONo/NS+o9dt9sYPM4d7HC4+PT
	WywenzfJBbBHcdmkpOZklqUW6dslcGXcO+hY8Iy5YvOBk8wNjFOZuxg5OSQETCQWNe5g72Lk
	4hAS2M4o8X/aEzaIhITEqZfLGCFsYYmV/55DFT1hlNj18g47SIJFQFXiTOdNFhCbTUBd4sjz
	VrAGEQFFifNA54A0MAvMZZRYcWchE0hCWMBd4unaDrANvAI6EmdX9DBCTO1ilJhy8DMrREJQ
	4uTMJ2BTmQW0JG78ewnUzAFkS0ss/8cBEuYUMJeYv3I32BGiAsoSB7YdZ5rAKDgLSfcsJN2z
	ELoXMDKvYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAiOBK2gHYzL1v/VO8TIxMF4iFGCg1lJ
	hHdSF2+6EG9KYmVValF+fFFpTmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA5P/
	CokzhVdufrtuketd23K8WHaVscSPG9YdQv9/WU4VEvgpedpL6s6/6cf2HjrrUXK8z8I4TUeh
	UO0TM0PSNI83oV+3bvKt5mytnbnLfqtQjNduCb6vXt1fNjOzvq8tKuY+wlC4Z9e0vMbv3tEM
	yd/Ee+5PqPMSfjNvgu7H2y0nDkSoXrnY6TQjJJ93kogzW8GLpZ+b/y/uzFyw+9SJ/xze7nZz
	zNM1K5/t3dwl7xvWkHDT1zmT0aFM58LvFee5F6mtrc9f3POHV724jz+19fkK6Q+T1vN7b1Rp
	EumvOFzH5JmTz7c0tdHzfeuqbAOtw1LzFm7nr7g7b8o1sfeHvi9d1au66aaSa9KT3D4WLiWW
	4oxEQy3mouJEAO+aI6/zAgAA
X-CMS-MailID: 20241017060905epcas5p35f250dd9dd49791b4e58c143dc5fbc00
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_4e3a1_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016201330epcas5p33226adcbff73f7df7cced504aea64a13
References: <CGME20241016201330epcas5p33226adcbff73f7df7cced504aea64a13@epcas5p3.samsung.com>
	<20241016201309.1090320-1-kbusch@meta.com>

------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_4e3a1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Oct 16, 2024 at 01:13:09PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The seed is only used for kernel generation and verification. That
> doesn't happen for user buffers, so passing the seed around doesn't
> accomplish anything.
>

Not for nvme passthrough, but all this code is needed for io_uring
metadata series. Please see the need/justifcation [*].

[*] https://lore.kernel.org/linux-block/20241017054900.alfiqn3o37f4kkxb@green245/

------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_4e3a1_
Content-Type: text/plain; charset="utf-8"


------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_4e3a1_--
