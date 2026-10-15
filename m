Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43FE53F6BB
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081796; cv=none; b=SS9sh1sia2MWSVzalTgTYzn3PI09UGo+9wr+20OxD83pAuxmKFG8lGlEh9mcGUFdJodpFpoIpShmdcA7eoiEGWh+5Usd5Us39FAJWUVbxADNTMOS5PURYsQ7wYuaekCgty367YEyZM1pMVyliOmTUSsTimgbI6aiY1yVM2/6r1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081796; c=relaxed/simple;
	bh=5s3gB5oVftv8iYEuJqxh9hunxmPVdJr61C7fLnF7LfM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nmgR9A5FNN1o/PdMEW6JfPP1sv/cDTeZr6Kai6uKLq89cD0VjnNqAVy7w9tp1Bd76pxdJFsIa1sYaeQrcqpzns3SfUF/kY9gOQnCYPSieLdnIOk9bbZjp/dZfO3hFaoB6UtRWG/36v6pUun1crAnYkyZn1Zlo+HPS+ATBh2dieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=POUJueRF; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=euh9+naJ; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="POUJueRF";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="euh9+naJ"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FEYHdx1656202
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=pluyufE8qRrv+KwrWpcxhJStTx
	ZyRtDI5FGJTuOyVCY=; b=POUJueRFLZUSnfRenYoa3H2VL/7UEKA0AJo9NeMVvn
	uCAYS4y0LZA585fiwrYQkBP3Cx7abgaf54UlDFERDPvLnuYIwoNZaI5lRCD3pfY0
	MkkKw6cYk/rzTSeU3utmhxICkxwgvPC/tF0wIWt3/QTSzKrVFBEd2yoinD/zV+BF
	Apuer4IVDWGMldbj4zL90oIngc0neswg3jrGesk1sL2u78G3IkpEMRQnq9xTw1yU
	ERkkmjYV6WntjFk37G2+wyZPEPDjXXPZ3es3UJcwZWyV4vpRdB4iPs9mE+pqpsgl
	2SGA+HyvF4vlT4XkZ2YTI1OmL7mGv76JPEfC1KDUkrcQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4haycat4fg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:29:41 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9104eedb5b0so55574416d6.0
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792081761; x=1792686561; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pluyufE8qRrv+KwrWpcxhJStTxZyRtDI5FGJTuOyVCY=;
        b=euh9+naJXzlKC5cq+ASlSqgxsJyx4pYG0+RpnojhZV8zSaaRLHUPuCffcCTVa5IEA0
         jaxS2jr75cOJicmQb6rZtinFFwJvAkmGRdEgNsef/hpdxzpWNg27HmuJLpAQjogNf/EL
         n3G7tlo4vITn35db0qbaXKvzWUk2KsZFBywLhCD5S+y2aYyljAW5iF1hxfimuOiFsTEr
         N0bTpJjDoFs+chvkcHiUGZDxMJv3lMJit3Sao7fL+nGgYSxC+5/IWmCz10tL80AH7F/x
         mcuXTlQg9CtbNMJtQ0l97+rZS5JeMJa0Oejj/FNCpA7KdTGdAbTcRfJKULLhO465TcIq
         Alvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792081761; x=1792686561;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pluyufE8qRrv+KwrWpcxhJStTxZyRtDI5FGJTuOyVCY=;
        b=ZwS2UCSTtDNGMwppb6GXp1XonQEAeXagNa88nz1mPW6/vgIp6xUfBIRL7Icm52Qxud
         FeuCgo7L/ZTHC0+iZjZAClhCZ2Zs94eJ5T54yyEa8WmFRI1JNkbKNmCCzht1MrBbWaDn
         NpIuciarMXN6S2i+26dd0PkyPrxiZUQiIC6a+ctMe4XSMx5bk6UiOc7Ps/JAdNAWWe62
         7W0TDHy06SKzFrGGZ22UVt6rQkCY0kaILWK4UHZYyVZX4qqfl0KED3r02vllIuxIAuUF
         0z+1X5XxJI4zMY71lamg4I10jcZOW4+1mCekyeXcTAHzlDRX5VthCggKSE2Oe2EJEtD4
         4fDg==
X-Forwarded-Encrypted: i=1; AKwUvByU9bfa9abfMv7cn5cP/HbC3KhRu5w6vxsPeSJmHMthtrEbGrJcqXSSZwcq4/YiKDC2HRI+ES4UdTLr/w==@vger.kernel.org
X-Gm-Message-State: AFq9FYKpBIfA+5FtFB69lSkQ+wHrbvPfiOym/2abPMBeiwvxHoGSA30G
	2haWNgIo+PNz+2UI8BIesasp+cGxDFwyvViBEe0wFhBPmNUjIBFYlJmyWc0h68A0J1fxiJhBNea
	5/3I8gQggyhowq3YT+/s8n+UhPXmHcO1nWGg/KiX4pB41fW94XhKQ/MR616M4G/ePhFFb
X-Gm-Gg: AYBFou3CdOtfRd8o+vyr7v4GBSXRKyAQW+Ct8oSlM7rDWOZ/ZuJHg7TbQgilg4+GYwV
	J0/v2ljziyf+AXm3U8hh2uw9WeT48C2xUavktMIN2dBcDL/Jsw934R3dRyQ/gLBwHS774nYJsGF
	JXk/sXm+GdFeuzsntHUDEN4Al7yx0gDtDMWEWCQfbhYzDzPwuILsrRTOTi8xreTVjwyawaXNOMs
	aSwBOkIWaaZIuDKLgfggSb74iKrx6WD+Up8sojoS/okuJgMu3plbOVO+VSbZ1o2dM0gbRuTrc1y
	WoCvdqEr1qIXL7hORXLOeXYl/y/Z/a1szMZmEOh2Znq38rBMnUiNNLKIJ0YrfCC4twcCn6gUbbT
	O2/QxuDXpxoqAWJZCzKD6fs+k/iI4qyzUF96GbMWkJDpb
X-Received: by 2002:a05:620a:371b:b0:912:1206:ddd1 with SMTP id af79cd13be357-93ebd0e4d43mr3127885485a.1.1792081760661;
        Thu, 15 Oct 2026 09:29:20 -0700 (PDT)
X-Received: by 2002:a05:620a:371b:b0:912:1206:ddd1 with SMTP id af79cd13be357-93ebd0e4d43mr3127879285a.1.1792081760077;
        Thu, 15 Oct 2026 09:29:20 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-51.net.columbia.edu. [128.59.176.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm803716285a.37.2026.10.15.09.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:29:19 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH blktests v3 0/4] blktests: tests for the direct I/O
 fallback, splice, bio trimming, and atomic write fixes
Date: Thu, 15 Oct 2026 12:29:10 -0400
Message-Id: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFb/0GoC/32NQQ7CIBREr9KwFgNUaOvKexgXBT4Wra0BSjRN7
 y7FxIWJLicz782MPDgLHu2LGTmI1ttxSKHcFEh17XAGbHXKiBEmSEMaLPurhoiNfYDHAXzwWFT
 EcCEMNzVHCbw7yHXijijt8wqd3o2f5AVUWJ3rtrM+jO6Z/yPNxL+rSDHB1NStqYXgmoqDGvvpJ
 m27BT3lj8g+Fkp+WFiyGCVL3jSwq0z1ZVmW5QWmIBpVGQEAAA==
X-Change-ID: 20260909-blkdev-fixes-tests-670f566f5f85
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792081758; l=3882;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=5s3gB5oVftv8iYEuJqxh9hunxmPVdJr61C7fLnF7LfM=;
 b=vTvSP8ELCcPMvOsnAbn4MNFAETtsr4b5llasuftOKcTP7kB3TCzFIPv7Z3xeyTzxo0muig+8d
 /Lneqw5GGszD1F79LNwoIL+5rIPWPbqAusSwV4r4kN1mPpowAJSdNwV
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfXz9hxg9wN3CDj
 l21wvs4TNW1y+Ju3anTnh8EToyoBe2ZfrNlxB60RnqzPyECLLN4SM2SYgC9b20SguoJJCOr44WK
 yjD2kZamlfHyU/YoXygFYuLaRT0h7UYUARacNuaHreniUsdTxA5L6+7pP4MRtj5cXO58p4ST8cX
 mRV9msEOfoCcreXDzgyHmsV2ECwwDioYGM/RakBImY3SSBxIQfxQa1HbGheAIdnq2TB5jG8gPBd
 pGb+kT0HpO0VWANIolAzS49F2XWEzllTlQiN3IyYxX7k2hP4/1eS2pfljX/PavNwjDgp0XBdLZy
 daxQQk+IW2VSrt32Bbu8GGmaiXVNaKbRNkjnwBz88her1dXHRBnFMElq90eXPLp82K9cDC5mNof
 oe9TQE+BWQWcIctBpWF1TdVLJjfNJYzGmL3sn8U92zfOGV8lB7nEjthIYWvhjVg/h23kvO80/HI
 KD/N4f18Xs554ZPld1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX9KqOpjPgoel+
 avG5wqjOBUI6BsloPgv37PRCEUhHuQPNeOwhd1KUOwXIouhtEa5Fv4i667iBoCt30O+j2A3Rxzx
 ffMKfse5FK72Be82TsknEHkWb98nSpv5c/JczQQmQRWipX3N8AA4
X-Proofpoint-ORIG-GUID: eVKfdG5aJwwNNDjKGxBHoONPXRuj9hc3
X-Proofpoint-GUID: eVKfdG5aJwwNNDjKGxBHoONPXRuj9hc3
X-Authority-Analysis: v=2.4 cv=FJiOVOos c=1 sm=1 tr=0 ts=6ad0ff75 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=NKoNGjn6KhAaSQkl0TXC/A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=-OctXjc2C0ZX02bfEn4A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11936
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=10 priorityscore=1501
 suspectscore=0 bulkscore=10 impostorscore=10 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150065

Four regression tests for block device fixes under review [1],
following block/048 for the first patch of that series.

block/050 races partial O_DIRECT writes, which finish through the
direct I/O write fallback, against BLKBSZSET. block/051 does the same
with splice(). Both need CONFIG_DEBUG_VM to report the folio order
mismatch, and skip on kernels without a 64K block size or with 64K
pages.

block/052 issues trimmed O_DIRECT writes from a hugetlb mapping to a
device with a 64K logical block size and checks that no huge pages
leak, covering both the dropped and the shrunk bvec.

block/053 issues a RWF_ATOMIC write from a buffer whose last page
cannot be pinned to a scsi_debug device with atomic_wr=1 and checks
that the device holds all of the new data or none of it.

[1] https://lore.kernel.org/linux-block/20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu/

---
Changes in v3:
- Rebase on current master, and renumber the tests to block/050 to
  block/053 after the new block/049.
- block/050: release the mapping and the file descriptor on the helper's
  error paths, and the buffer and file descriptor of each writer and
  reader thread when it exits.
- block/050: fail on a write that returns less than its direct part.
- block/052: release the mapping and the file descriptor on the helper's
  error paths.
- block/053: check that the device supports atomic writes with statx()
  instead of reading the atomic write unit max from sysfs, per John
  Garry.
- block/053: always write two pages, and raise the scsi_debug atomic
  write unit max to 128K so that they fit for any page size, instead of
  skipping the test when they do not, per John Garry.
- block/053: check that the atomic write fails with EINVAL, and report a
  write that went through separately from a torn one, per John Garry.
- block/053: read the old contents back before the atomic write, per
  John Garry.
- block/053: reuse the write buffer for the readback, per John Garry.
- block/053: release the file descriptor and the mapping on error paths,
  per John Garry.
- block/053: report a missing scsi_debug module once.
- block/053: specify that it is hardware atomic writes that are
  submitted as a single bio, per John Garry.
- Link to v2: https://patch.msgid.link/20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu

Changes in v2:
- Rebase on current master.
- New block/052: test that a partially pinned RWF_ATOMIC write is not
  torn, as requested by John Garry.
- Change the kernel patch links to v6 of the series.
- Link to v1: https://patch.msgid.link/20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu

---
Tal Zussman (4):
      block/050: add a direct I/O write fallback race test for block devices
      block/051: add a splice read race test for block devices
      block/052: add a pinned page leak test for trimmed direct writes
      block/053: add a torn atomic write test for block devices

 src/.gitignore          |   4 +
 src/Makefile            |  10 +-
 src/atomic-write-torn.c | 233 ++++++++++++++++++++++++++++++++++++++++++++
 src/bio-trim-pin-leak.c | 200 ++++++++++++++++++++++++++++++++++++++
 src/dio-fallback-race.c | 251 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/splice-race.c       | 171 +++++++++++++++++++++++++++++++++
 tests/block/050         |  57 +++++++++++
 tests/block/050.out     |   2 +
 tests/block/051         |  54 +++++++++++
 tests/block/051.out     |   2 +
 tests/block/052         |  64 ++++++++++++
 tests/block/052.out     |   2 +
 tests/block/053         |  60 ++++++++++++
 tests/block/053.out     |   2 +
 14 files changed, 1111 insertions(+), 1 deletion(-)
---
base-commit: d418e94a3d590640bbc0012bdec1c3e74ce8be11
change-id: 20260909-blkdev-fixes-tests-670f566f5f85

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

