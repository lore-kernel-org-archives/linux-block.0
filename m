Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783B128388
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635168; cv=none; b=rIe3l+AISC1kSm2+WqPMJQ3Cue7CpC6F2BUjCIR8CYOgYnHyJdrv+x3dwR+DvkJBdtJ8BxPTQDtjqRovilWysnsRkV3+GxpV9A4ItgO1SC/CKwc7ao6EhIOCyy2YV9JD7mur+VxjsgXkcLhGFUgGFo3LK2CVBL+NosLqiVdQA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635168; c=relaxed/simple;
	bh=xArWOLWzjd4XKQ0fDYq8XHWUb1nrI9NicR7faWMCOA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=LhH4bt5ZzwvbjnJGi/iHEWH0I7iFxfJgjILTAQ//ouqKYoLTX5wQuYlk7yaUsGZovJ3SNJBoangoBVtXTZeDwz1IPiuk9UiGblQeWr+8Y0csgOeQuVPksIjgl1wyxF8BqyeMatVOXz8/EEWw19njRR09IMkYf0M3wxZQbyBT0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=s8jw/kTn; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s8jw/kTn"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240130171922epoutp03271eec0e727aaa4d93d0c1fffc3483cb~vL6N7FmhV2939229392epoutp03M
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 17:19:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240130171922epoutp03271eec0e727aaa4d93d0c1fffc3483cb~vL6N7FmhV2939229392epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706635163;
	bh=u8hkftLGAKfOaphmPbjcvpasYOesn4M0X2vR0auW9TY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=s8jw/kTnPZp98QQb0aR/d8RPyJ6cCKmLXXW9m5fPI/0AEW0PKnpU3mBtYr3tsYraf
	 xK3hPACnBiSx7SnNiUR0g5+gl9sw8FcrsMJP4IBNoEN4Dd99t3LTwwG5sySbTZ2tAs
	 Vr4ZhImoagZmlnDGT8tNn58EDODzYDs/Ofk1iaTc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240130171922epcas5p16505a9a559c1300e8c7e78951ec8a52c~vL6NhQukD0856008560epcas5p1M;
	Tue, 30 Jan 2024 17:19:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TPX2v1ywCz4x9Pp; Tue, 30 Jan
	2024 17:19:19 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	32.58.09672.79F29B56; Wed, 31 Jan 2024 02:19:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240130171918epcas5p3cd0e3e9c7fb9a74c8464b06779c378ea~vL6JavHos0961109611epcas5p3Q;
	Tue, 30 Jan 2024 17:19:18 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240130171918epsmtrp18e1f64daeaaa0c9c751e860c37a9e3dc~vL6JaGT5f2441824418epsmtrp19;
	Tue, 30 Jan 2024 17:19:18 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-a2-65b92f973f59
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.90.07368.59F29B56; Wed, 31 Jan 2024 02:19:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240130171916epsmtip22bb4438293fbdf3bf4ff64adb80cfb78~vL6H_ecil1888718887epsmtip2B;
	Tue, 30 Jan 2024 17:19:16 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 0/3] Block integrity with flexibile-offset PI
Date: Tue, 30 Jan 2024 22:42:03 +0530
Message-Id: <20240130171206.4845-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTU3e6/s5Ug69ruC1W3+1ns7h5YCeT
	xcrVR5ksjv5/y2Yx6dA1Rou9t7Qt5i97ym6x/Pg/Jot1r9+zOHB6nL+3kcXj8tlSj02rOtk8
	Ni+p99h9s4HN4+PTWywefVtWMXp83iQXwBGVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
	qGtoaWGupJCXmJtqq+TiE6DrlpkDdJySQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAl
	p8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtjyZeggpWcFd8a2lgaGOezdzFyckgImEi8/raW
	qYuRi0NIYDejxPRzq5ghnE+MEpcPTYHKfGOUeHx1JTNMy/djv1ghEnsZJX5+2s8EkhAS+Mwo
	cfeiQxcjBwebgKbEhcmlIGERgSSJbW8+s4HYzAI1EpfvngYrFxawlbh1uYcRxGYRUJWYtW4a
	WJxXwFyipf85C8QueYmZl76zQ8QFJU7OfMICMUdeonnrbLBLJQQ+sku82f2VFaLBRWLpz8VQ
	vwlLvDq+BcqWknjZ3wZlJ0tcmnmOCcIukXi85yCUbS/ReqqfGeR+ZqD71+/Sh9jFJ9H7+wkT
	SFhCgFeio00IolpR4t6kp1BbxSUezlgCZXtI3N+7lxUSIrES87c2s0xglJuF5INZSD6YhbBs
	ASPzKkbJ1ILi3PTUYtMC47zUcnhMJufnbmIEJ0ot7x2Mjx580DvEyMTBeIhRgoNZSYR3pdzO
	VCHelMTKqtSi/Pii0pzU4kOMpsBgncgsJZqcD0zVeSXxhiaWBiZmZmYmlsZmhkrivK9b56YI
	CaQnlqRmp6YWpBbB9DFxcEo1MCWGh7ClyLC8Opq+lsmNNUU1ehqD7kvPxtliD/8vt7RU5k54
	m7TI4O3Th8H1y79dbjH77NZ9Tv2+z4u6rG+3JV8lKN88Xcj6ic3C9vsM31OHppjP5nsgtsnf
	pq6TT0LUTn5569YLGreqdYNYg9pUK1fP8A+Z65Den8uu6Lnu/t7XS9sXBk6YY9o28W3f/+uh
	r0SFMk7c275P0/zUeanX7ffvP02sMkp8JHyp8+GLi2dmPzD5OX1RrdKjo1qxxxW+T70brqGb
	uXf6/1S2R6l3v4s+Z5XJc+ZwSW6V+rP25OTeP7VrohftvbdfarK29eM5lVfWTF8z/cz7Lxtd
	3CIl5xyo8NIK8G5w+Ci8sojjV7ESS3FGoqEWc1FxIgAH0hNMHQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSvO5U/Z2pBs97bCxW3+1ns7h5YCeT
	xcrVR5ksjv5/y2Yx6dA1Rou9t7Qt5i97ym6x/Pg/Jot1r9+zOHB6nL+3kcXj8tlSj02rOtk8
	Ni+p99h9s4HN4+PTWywefVtWMXp83iQXwBHFZZOSmpNZllqkb5fAlbHkS1DBSs6Kbw1tLA2M
	89m7GDk5JARMJL4f+8XaxcjFISSwm1Fi9tkvjBAJcYnmaz+gioQlVv57zg5R9JFRYmXrfeYu
	Rg4ONgFNiQuTS0FqRAQyJGav/gZWwyzQwCix7vUuJpCEsICtxK3LPWBDWQRUJWatmwYW5xUw
	l2jpf84CsUBeYual7+wQcUGJkzOfgMWZgeLNW2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GTD
	AsO81HK94sTc4tK8dL3k/NxNjOCA1tLYwXhv/j+9Q4xMHIyHGCU4mJVEeFfK7UwV4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJg1OqgelguvS676IbfnpL7Xwv
	cPJgGPvql3md/2L4uieLHXPN/Pn2CC+3k+yt2/Gz4yYyPNnD5xR734M3cfp1p9VBd55NXu6z
	78upulelCTb8s3TefpwzReuMXfbKvvD11m/NQyx2b/JUPDn9fZuw8G3ffUWXZlrMdpWPneNe
	KmZTVjVn176ts+yzmO5M2t8udU40VHTbbinfx5yZj7YfZ26KEhY8dSls2+b7Pz+c28wq4+F7
	U4t11txLuzQufwg5276z7rTId+4tvxq6Dvzh0BG+XF4mbtu28ev6dwVKPzM2bCqrnbn20NXm
	z8xZhw+U/Izccob3zhVlvuxlDd/Ne40C2UP3VE2eu79kyfN3Gpox143ElFiKMxINtZiLihMB
	d2weaNcCAAA=
X-CMS-MailID: 20240130171918epcas5p3cd0e3e9c7fb9a74c8464b06779c378ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240130171918epcas5p3cd0e3e9c7fb9a74c8464b06779c378ea
References: <CGME20240130171918epcas5p3cd0e3e9c7fb9a74c8464b06779c378ea@epcas5p3.samsung.com>

The block integrity subsystem can only work with PI placed in the first
bytes of the metadata buffer.

The series makes block-integrity support the flexible placement of PI.
And changes NVMe driver to make use of the new capability.

This helps to
(i) enable the more common case for NVMe (PI in last bytes is the norm)
(ii) reduce nop profile users (tried by Jens recently [1]).

/* For NS 4K+16b, 8b PI, last bytes */
Before:
# cat /sys/block/nvme0n1/integrity/format
nop

After:
# cat /sys/block/nvme0n1/integrity/format
T10-DIF-TYPE1-CRC

[1] https://lore.kernel.org/linux-block/20240111160226.1936351-1-axboe@kernel.dk/

Kanchan Joshi (3):
  block: refactor guard helpers
  block: support PI at non-zero offset within metadata
  nvme: allow integrity when PI is not in first bytes

 block/bio-integrity.c         |  1 +
 block/blk-integrity.c         |  1 +
 block/t10-pi.c                | 72 +++++++++++++++++++++++------------
 drivers/nvme/host/core.c      |  8 +++-
 drivers/nvme/host/nvme.h      |  1 +
 include/linux/blk-integrity.h |  1 +
 include/linux/blkdev.h        |  1 +
 7 files changed, 60 insertions(+), 25 deletions(-)

-- 
2.25.1

