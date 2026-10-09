Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928693C819C
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791590033; cv=none; b=mf6FfCui39WcdGD7PT4R+BGRH7OkjSh5L4HMAqjvpLeAtUN4ILhl4/XZgxObk6owt4eIIJ2DxB4uYvCWWw8564DQYl96hYVTZxnDlgXWDaQgdXz2Cz/fX6jd3/3Voquyb3D6ahOr2EMZUuNXyKzOFlRIOnoXzmJlR04z5AcPJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791590033; c=relaxed/simple;
	bh=93CM+++0sxs4ThBAkRdlnUEcnl6Wrh0X/yNVdViMQlM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SGNW3ciMJHx2viLA12DfYARPNxfzz3utEvC9I19xrcG3D84NVLalft4oCWqcos8W4PuFD0SBVj2C4u2ognK+q5A6qYK1grUJzIoZAClKgtd7R4P9EFArQvzOzjyAVN0QSMVKZpJUJsZoBpWi49O1xH7zSUuaSQF0cMRYPObIX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=NPIjpOwt; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=2dhtIOGJ; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="NPIjpOwt";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="2dhtIOGJ"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699MYGeX1239045
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 19:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=HW7o8H4LnnUqskoUFr591/YC2u
	dA87ejzTRW0GBAVsI=; b=NPIjpOwtkIr3HbwZ0dEwKN7i965bXcP0Hh2VCdGJrf
	eKoLqJn1AP0/Z6qxuzRloEHBsMy9icy6k8YNSmhF5u60u4a74YOa2e/Ab5wa3LyB
	/33ByagXQkAsktPi+DMb68e0sXJe596yxvL9++Pu8zxDdsOEtFcwahYWozz3sXcb
	wGKK19scoQ4Kpla2lZTRqyj1Ye918tBrX+r4v4bPxJIcSPVwecLfabEGzFEDeaHI
	XQp82VnBFWaDTKfBUGS/hayIDDq+ZYOF0hX2dXCXmw1OMyn5zxp157xFjfXww6Pe
	sN8GjfpBfKg4sHGVXdWUOVfn6nxsNhjCZq1lmEH1yyVQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h74tbjyc6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 19:53:50 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53397b6e05aso5755761cf.1
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 16:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791590030; x=1792194830; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HW7o8H4LnnUqskoUFr591/YC2udA87ejzTRW0GBAVsI=;
        b=2dhtIOGJpVj9XHRGR1D3sQsrYzJU/a9jJisTJ61hCbYMX7TObZFSKCI0hMU+ktmfIA
         KpKluWIuH9TD2X0St+aqwcaFnxhkTXiBoVecY3g1BC0wZtwN2o0V6OJ6lZR3Y9h1eq3J
         KncovtSNp5z7ZFP0IWxuVevo3GkRPhHJarmsa1XkF21rp3kPnIWpwHSOeBYH+udz0jb0
         ncbhZPaAnJjS+DQOkIt4zOrpMxRKSox12jSFSMOSuJfJsXl/RGpotYLvsgw/NK38fudI
         gXGhXboG7iCzzQ/Y61TDvWO/ha3jivsvR6kukubbYfZX5nj1ziaXEDkyWOEEYaMsgGA5
         GCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791590030; x=1792194830;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HW7o8H4LnnUqskoUFr591/YC2udA87ejzTRW0GBAVsI=;
        b=YiZ8BV7AXMd3IjvDXOxZMIwNsxqvXn+xlWJemKeQy2dCd1WnfXjq8Pjt7a+J2u57pi
         z7VFdUbXsWfswGdH3rC25N/xjX44M+npx1us9qQdZoOVU3bXTASM08jMDpzZfSoe6NvU
         E4UlDFJXeNGvqSjrLamAoZV7oQksY4ypf9zl3wzlw3PLxe13PCY8zToUgQ0Rd6fx4Rsl
         pxuGP7wIHhdQaobPPAbFvUENIvsOaijg68EzeNndubh0On57fnuoVTX3oBsmOOGriaFo
         bs/Jfv2SbvcvQknRCtEciqjjYIJSm16oi2mBBQfsApYj/7j3fOepZiC8g5aIaHL+tQOY
         YTIQ==
X-Forwarded-Encrypted: i=1; AKwUvBweestXNgSQBTvjB8BCh6o/Fdayjjpq7D1TrKdrLlRybYty/+UJLYgV3iuHOzPTnxDejSMMA7WPjt1ZUQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJsObkxoYj3cUZZLjqbSzLJpE6ZC5X4S0uDO81SR1eWziHl5Zok
	fXICCClrIaemKmfYPpNtvbKBrVK12Mrszl98huWop26W6lD1A3xU49PGDVdNQ5csmZi3u++Esh6
	WOYw2OeHRW4ltW2j9+L7MskSOiJ41//IyNoXFwZuxVl5bAy9y178zbI5wy6jt
X-Gm-Gg: AYBFou3kFkwuIKinekVLASXqGV8Kj62I1/uANYWIE+r9OjK5HrL6CD6/sCnecti1u2P
	3UqIJ5XyJxJ+pMLZWg5paFX+5mkl9hyYolMF7unNEP7IOB6x2yE63WcHcC8aoSHLpN6wN4g8DOV
	gjjd1glXpjy/3IH7Dw6udC9OUlVuQ/5IEpvlbHMjhnexmYsG9yn5hpxXgJcYzijicCXT/yZcd/9
	XrZeQOQnYyzmnvDJzuUbcOUksahv3QLB58IX1CrYFnKs76YRydI5rkjKlIkWYeW3pUQdsgXKDpR
	dC7Gh+LCpnjYV397hQ5EjHs+9HfSNdutz+iT++htLzA86aXO2tmIBONYrgLBv5KNBx3VF24+8Vj
	5eb4GrQ/HJBs58LJ4s1gzKhZGoapgrRuwApugrRtnWIJ84iA=
X-Received: by 2002:a05:620a:a403:10b0:93e:c287:e774 with SMTP id af79cd13be357-93ec287e84bmr320931385a.56.1791590029648;
        Fri, 09 Oct 2026 16:53:49 -0700 (PDT)
X-Received: by 2002:a05:620a:a403:10b0:93e:c287:e774 with SMTP id af79cd13be357-93ec287e84bmr320929485a.56.1791590029113;
        Fri, 09 Oct 2026 16:53:49 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984889fsm304517485a.13.2026.10.09.16.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:53:48 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH blktests v2 0/4] blktests: tests for the direct I/O
 fallback, splice, bio trimming, and atomic write fixes
Date: Fri, 09 Oct 2026 19:53:44 -0400
Message-Id: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIh+yWoC/32NwQ6CMBBEf4Xs2ZqWpBU8+R+GA9CtrCKYbmk0h
 H+31LvHybw3swKjJ2Q4Fyt4jMQ0TymUhwL6oZ1uKMimDKUsjaxlLbrxYTEKR29kEZADC3OSThv
 jtKs0JPHlMdfJu0LiMwXNr+Glu2Mf9s2dHYjD7D/5P6ps/LuKSkihXNW6yhhtlbn087g8O2qPa
 Bdotm37AlcR98bTAAAA
X-Change-ID: 20260909-blkdev-fixes-tests-670f566f5f85
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791590027; l=2409;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=93CM+++0sxs4ThBAkRdlnUEcnl6Wrh0X/yNVdViMQlM=;
 b=v+HSFPaHz68547SUaYMiC0bLxYWaT3+5iIrHmvtTX0X+lt+eYJzS43XzoJTpaDaW4wBgNk3hW
 DLenuCWgegSBHwWrmws2mwAFhLu5fnLK0DSCCnUZgkYDHu1Sy+we1xC
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfX5uqBk86AW+E7
 NTa7NlunBlnOcRmG+fYAEGxUr+JZbKSxY7tVCwHgL8o/CDhPCZIau/flhQccATG5KfYhsw5UZrw
 g6ULIK5hxo+tWc0ZE/GefD9JdYIv7TUVuaZFOTwg14pJjiWlhwYJ
X-Proofpoint-ORIG-GUID: mHCsZsA6xKg5mGll6r4wSGI03ShH1aio
X-Authority-Analysis: v=2.4 cv=A4D5rKWG c=1 sm=1 tr=0 ts=6ac97e8e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=7ahRDkP6BUYRUllUUs0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfXxWdJ4HQUUUoU
 0uSTOE4P235C8mW3N2wFM/MgWrcDzh6dz5fQ+0Dke7u1j/M5GlXWhTG1crpfZbvcStYbaP0s6tB
 q1q8oBH5p6geINllcM6BgB/xO6t6dlv/n/HzX43Pf2rcvFwrN81oFwZX+mFbltHfu0oWIkn9FWS
 XytHoKTBmLcJmFdmk+1yeS5zbHImdaunkuvnjzeUXMA2ejl44aGlocW6cv0nbtcwGKcMaoccEo9
 mIol+xySY6Ivpm66SrT5m7AIUifiBciAgC5CqZg6RBMmzuM8EJG/ZeQYWTjQ6MSZeCBcGfBO3EZ
 SKMV1i1csejrJjc04dP9QKxdgjGAt72e1qZIudHSJjNNB5JGjmo3yJuSYSGy9OhKYL6R/WM3Jct
 hGw0a+BWhHE1OvJWqFQbKjquL/WbE0wjRSm3IZnV+ZrcH47b+UDUBLGfhX2TB5Zf2SKk1/lBqeZ
 VsonaXsApQxzfrAU9HA==
X-Proofpoint-GUID: mHCsZsA6xKg5mGll6r4wSGI03ShH1aio
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=10 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=10 lowpriorityscore=10 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090095

Four regression tests for block device fixes under review [1],
following block/048 for the first patch of that series.

block/049 races partial O_DIRECT writes, which finish through the
direct I/O write fallback, against BLKBSZSET. block/050 does the same
with splice(). Both need CONFIG_DEBUG_VM to report the folio order
mismatch, and skip on kernels without a 64K block size or with 64K
pages.

block/051 issues trimmed O_DIRECT writes from a hugetlb mapping to a
device with a 64K logical block size and checks that no huge pages
leak, covering both the dropped and the shrunk bvec.

block/052 issues a RWF_ATOMIC write from a buffer whose last page
cannot be pinned to a scsi_debug device with atomic_wr=1 and checks
that the device holds all of the new data or none of it.

[1] https://lore.kernel.org/linux-block/20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu/

---
Changes in v2:
- Rebase on current master.
- New block/052: test that a partially pinned RWF_ATOMIC write is not
  torn, as requested by John Garry.
- Change the kernel patch links to v6 of the series.
- Link to v1: https://patch.msgid.link/20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu

---
Tal Zussman (4):
      block/049: add a direct I/O write fallback race test for block devices
      block/050: add a splice read race test for block devices
      block/051: add a pinned page leak test for trimmed direct writes
      block/052: add a torn atomic write test for block devices

 src/.gitignore          |   4 +
 src/Makefile            |  10 ++-
 src/atomic-write-torn.c | 131 +++++++++++++++++++++++++++
 src/bio-trim-pin-leak.c | 191 ++++++++++++++++++++++++++++++++++++++++
 src/dio-fallback-race.c | 229 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/splice-race.c       | 171 ++++++++++++++++++++++++++++++++++++
 tests/block/049         |  57 ++++++++++++
 tests/block/049.out     |   2 +
 tests/block/050         |  54 ++++++++++++
 tests/block/050.out     |   2 +
 tests/block/051         |  64 ++++++++++++++
 tests/block/051.out     |   2 +
 tests/block/052         |  70 +++++++++++++++
 tests/block/052.out     |   2 +
 14 files changed, 988 insertions(+), 1 deletion(-)
---
base-commit: 87eb7c2c006101090609a2994df272c9395fd058
change-id: 20260909-blkdev-fixes-tests-670f566f5f85

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

