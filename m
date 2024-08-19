Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9B45945
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081106; cv=none; b=M3L9F1M1yjCjq/WkMdApZbcYzD5dVozdhbdYnVYSDRRdt3xBO2/Nte+2iTZzmir801hVSUsmgvjpbXF5KC6eJIh4K61N1cWLiVYEvvbEF/WQDwPalot8onzE6I/6zToTomlLe03YPE6Wp7ahvwRvcWrY0bf8032g7S8akof2RWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081106; c=relaxed/simple;
	bh=TJmJQUiwnbhFDO0dR5PTBvjw5qaj+CjPFgOgMQwvdoc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=mO5ly6hyX5qeumV305hkVw/neFgwuNKzVNtK1nhJ+4uJTYlcRiLKpd7i0euDzwhBqIRHiasNk3EcnVg74/+aQ0rBWL9ukLqb0nElV0kZ6Fxk+F/A50ZwKTEWCafpq4P4iu9TPgFxo5dclCnvkWvcC0A0g3RDh8A+xG8rDNeeruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pKHHmQlD; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pKHHmQlD"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240819152502epoutp014e42dbbe44520553d697acf8cc627845~tKqDG7Gaa3033130331epoutp014
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 15:25:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240819152502epoutp014e42dbbe44520553d697acf8cc627845~tKqDG7Gaa3033130331epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724081102;
	bh=TJmJQUiwnbhFDO0dR5PTBvjw5qaj+CjPFgOgMQwvdoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pKHHmQlDwd4gasc692DHs4Yqe1UdBdCiHi1UCD5XVnRVnduIxdbsYkGkvs1uSawFC
	 FV4OwxiwUbrqDHL6DF2/5xhGqCjdTdDUxHp1l2CqyqbU0JCPzP5YxxXLDLRyEPdxmu
	 4fRoQv6O1bSOYNQdWQY/tFuA0mYQ2PYx22CgMYA8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240819152501epcas5p471b63506b16f54703ea8f07b50f4f1dd~tKqCRo5uL0281902819epcas5p4K;
	Mon, 19 Aug 2024 15:25:01 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Wnbxl72f3z4x9Pq; Mon, 19 Aug
	2024 15:24:59 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.45.09743.BC363C66; Tue, 20 Aug 2024 00:24:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240819152348epcas5p3ce3b8c731b7c575467d63651c47010cc~tKo96k_CC0506305063epcas5p3H;
	Mon, 19 Aug 2024 15:23:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240819152348epsmtrp10c08441ee0c39005826f5a4bf308d5f5~tKo959w-00096300963epsmtrp1w;
	Mon, 19 Aug 2024 15:23:48 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-2a-66c363cb2d0c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CB.EF.08964.38363C66; Tue, 20 Aug 2024 00:23:47 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240819152346epsmtip27cdf6143b47815ed27845806ac2cf05c~tKo8mlIgV3120131201epsmtip2z;
	Mon, 19 Aug 2024 15:23:46 +0000 (GMT)
Date: Mon, 19 Aug 2024 20:46:25 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, kbusch@kernel.org
Subject: Re: [PATCH v2 2/2] block: Drop NULL check in
 bdev_write_zeroes_sectors()
Message-ID: <20240819151625.3ahrfy5ng3au24df@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240815163228.216051-3-john.g.garry@oracle.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTU/d08uE0g9WvLSxW3+1ns1i5+iiT
	xYVfOxgtJh26xmix95a2xfLj/5gc2Dwuny312LSqk81j980GNo+PT2+xeHzeJBfAGpVtk5Ga
	mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
	kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnfFkzWe2
	gp8sFX86PzM2MG5n6WLk5JAQMJGYe3ItG4gtJLCbUeLJEv4uRi4g+xOjxN2Tl1ghnG+MEgdv
	9DLBdKzdu50dIrGXUWLm+j5GCOczo8S/3rNALRwcLAKqEkd6o0FMNgFtidP/OUBMEQENiSOH
	pEHGMAvkSqzcvYAdxBYWCJZ49PoqK4jNK+AscfnReShbUOLkzCdgh3IK2Ems2faJBWSThMA9
	dol5LesZIe5xkVg24zgrhC0s8er4FnYIW0riZX8blF0usXLKCjaI5hZGiVnXZ0E120u0nupn
	hrgoQ2L2s7VQT8pKTD21jgkizifR+/sJVJxXYsc8GFtZYs36BWwQtqTEte+NULaHxIo9P5gg
	QXoUGED/oycwys1C8tAsJOsgbCuJzg9NrLOAYcQsIC2x/B8HhKkpsX6X/gJG1lWMkqkFxbnp
	qcWmBUZ5qeXwKE7Oz93ECE6QWl47GB8++KB3iJGJg/EQowQHs5IIb/fLg2lCvCmJlVWpRfnx
	RaU5qcWHGE2BsTORWUo0OR+YovNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgt
	gulj4uCUamASurqy/NT2bEX7gIV1V/a/s15eaXicZU/JhOCWGPU1b7bN0JP6fkK8eMb/SxWp
	13h4V2xp+pmTW/Ji7t9bNz91bs7l09sY+T5QIfO+sce20AUidwSWP/EJ7/vXe36hY/mRZxZq
	alNz7m08wB+0LGKm4/Ld84Ic9O7tu2y1cV/NOeYdcqzP/bf6rJ4ySYBV1L0x89ORTlbGe4mS
	zirmDF/VbCYL7DSZU5W+4eYXV4c2bo+5R35nh2xZ4nr6I9v5fRI8EatKmRS2Fpb+n74h9ehO
	3gMnPofHPVrdZC8mcu7Cy82q8luSiiybdn27LXp8fZxKxXSxK2t0JS8E8ghmplgse5e01nD6
	zIIDfg45E5P5lFiKMxINtZiLihMBXhQ9CBkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSvG5z8uE0g/n3rC1W3+1ns1i5+iiT
	xYVfOxgtJh26xmix95a2xfLj/5gc2Dwuny312LSqk81j980GNo+PT2+xeHzeJBfAGsVlk5Ka
	k1mWWqRvl8CV0fL5DlvBaqaKBc1/mRsYm5m6GDk5JARMJNbu3c7excjFISSwm1FiyZvzUAlJ
	iWV/jzBD2MISK/89hyr6yCjxo7kDKMHBwSKgKnGkNxrEZBPQljj9nwPEFBHQkDhySBqkk1kg
	V2Ll7gXsILawQLDEo9dXWUFsXgFnicuPzoPZQgKFEjPnXGGCiAtKnJz5hAWi10xi3uaHYIuY
	BaQllv/jAAlzCthJrNn2iWUCo8AsJB2zkHTMQuhYwMi8ilEytaA4Nz232LDAMC+1XK84Mbe4
	NC9dLzk/dxMjOKy1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHe7pcH04R4UxIrq1KL8uOLSnNSiw8x
	SnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUwCZ2T+vhv2UO+jgz1CNHmlq2XM8+27Dyz
	SJ0v5fr/kzLVItZF29PfX/4QZSEyO9DqXsYzD4+Ju1hyKnea7+CRClpeddPss9bt6avvzJp/
	9m9u/out03XDa3+fPasQwS6fX55g/T7IKzr46XHuuYU9nHZvnuVxcHvZyt7N4s40nNd3JLlj
	pbxl7AG3Z5PeSy1VnlC7WLniWFz3zZi4mT93/mbsvNuSfvNEdEDA4xkJaarC59kvvrq2PXbL
	HdHbiyNdL7VemrXtTMBRfW/+JL5TSyMmZ4Z0T3DvlU2fuchL5t+dtvqZT590vd7x6ltX3tY6
	/x63+Q0daxklVmy4vkH/eNyuN3f+pl4+X3RYa/8xISWW4oxEQy3mouJEAIWpVhHaAgAA
X-CMS-MailID: 20240819152348epcas5p3ce3b8c731b7c575467d63651c47010cc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----rEVyOeUC1-Pd4ykAKehEErIJv_6LE1Y2HSCt3w26tRlypI58=_8807e_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240819152348epcas5p3ce3b8c731b7c575467d63651c47010cc
References: <20240815163228.216051-1-john.g.garry@oracle.com>
	<20240815163228.216051-3-john.g.garry@oracle.com>
	<CGME20240819152348epcas5p3ce3b8c731b7c575467d63651c47010cc@epcas5p3.samsung.com>

------rEVyOeUC1-Pd4ykAKehEErIJv_6LE1Y2HSCt3w26tRlypI58=_8807e_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 15/08/24 04:32PM, John Garry wrote:
>Function bdev_get_queue() must not return NULL, so drop the check in
>bdev_write_zeroes_sectors().
>
>Reviewed-by: Christoph Hellwig <hch@lst.de>
>Signed-off-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------rEVyOeUC1-Pd4ykAKehEErIJv_6LE1Y2HSCt3w26tRlypI58=_8807e_
Content-Type: text/plain; charset="utf-8"


------rEVyOeUC1-Pd4ykAKehEErIJv_6LE1Y2HSCt3w26tRlypI58=_8807e_--
