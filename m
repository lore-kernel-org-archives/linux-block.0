Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793402784;
	b=Ym8wre1Qy19twJDZFzYg/VApHS/xuQAgBBiQr303gWYkdP9qkkiWU+rxMR5w827jW1WY
	 7YBDFbEazh77jiIWbG9RgSb3GJwgSYSXOfzfbrIq3JL5X2txkv3/Ye5Ez17zaUHdpSj5A
	 7FMQ/SGMFSiVpp+Ao4qXG09hYUoN5xgIzkiBDvQk7RosrPjejg+1L0ZA3pqZs4rmwvAwB
	 ccmqdrIaUegFWWsPwhiorySK0VUfcDoVj+61jiNnTYn1haU36XXaOwBVyxjNqTBSas71Q
	 NEYtSWFj6kEvu/30/iwxV4bnTzQXRm8h9JJB6ztwNnd2kNEKAHCfCP4IWM0l9uul4fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793402784;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/Tb+rbqLnsdrnq+v3f0W5AbyT1d+QqWDWyHW+HgJEVU=;
	b=Rjsg4sGnpq2Kgxe2YBzCO8rHd+rj5W+JGkPPhP1gBqjRLYuyOY4spzW2yJj3rUaKJfj7
	 DKB6G2gUYvKLFHDG2I5WTfjv9T84/0zNhF6ubJ5juSBwD3nDX0UP6bf1kMwoXomB8VmB7
	 kDjXoMwGYZH01iodQbH9+Y9I9Z5itJPQDX5MwVShleqwk9vlCgeUgUfSlsAbiDnyszwq5
	 eJ1VC5kRzR37QZUFuIeCyEsuM75r9Y76/XAXZ9yddi5K5ynTXOhwrsn6SMEQC1suexhkr
	 RUkAtkdGs42avqsu7UDrFBk40+kNNOIq2paGGmVF0QkNqcL+qSO3mNoCy/ev7yGkObw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=WDN9D24t;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=nwqEAgLg;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA6606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 23:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83AA6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=WDN9D24t;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=nwqEAgLg
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UNNfhi2150441
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 19:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=/Tb+rbqLnsdrnq+v3f0W5AbyT1
	d+QqWDWyHW+HgJEVU=; b=WDN9D24tALFaiXAzWXu9I1G3lvS0hQPnvacXTbyq9y
	gwDJWZ3Kli7m1dPvGcnCwu177A0E5DrKEBTkxdOEqX3VmRRgjnLjEsUfut5PUwSw
	V2VskvvgWeLl0VotrPSD8aSjtdswdnLwuf1fN431mJH5mtiDisWjxxUHbcysY9nk
	8kJnAFRN4z8aTVkwg0e7nIXd0Sg6//oE+gmdxOt9Uv/N5B0FfnqorMMacSpZh4+h
	4jKmRHTtptVlb1rjczewytZgaeNIQYg2c6LbSoqbE4zQtBwz5Zu5k/Ez0NMJyt7k
	0F87OTQspR5JxcfQRlQXUC9OvZfA/VbKDmLm/S0AVbPA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hn2x38ss1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 19:26:22 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9440b27c1feso211108785a.2
        for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793402781; x=1794007581; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/Tb+rbqLnsdrnq+v3f0W5AbyT1d+QqWDWyHW+HgJEVU=;
        b=nwqEAgLggUXEHRnu6/MwtQdrqPAewk/jrypBHELqNK9g3NrADi43h75DfnEDYplceu
         23jyA3TysXR1CkcTaHjkm8loOxZJsVuDAUb3mCwlC60ypYW/H4vqdNg8nU6coIQvReCf
         nde/zpsoBP9vrjtwjX9u53QeaMoetrNbzz4Bv27NRt7+k+GZUvxB++LIwJjwNcGbB/gw
         IcS4pv0idK9NRSP+x17r/+h34kPbLcSX1LGnOEez+VcaCTDEws4r7A0rT8hWnzS66ymS
         z5S8fSj9AvIYEWwoR5RmM1tuujCW2QbqJHQ35EtmF90qQL643Zy+yWkq1Xm4MWBYDZaP
         rLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793402781; x=1794007581;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/Tb+rbqLnsdrnq+v3f0W5AbyT1d+QqWDWyHW+HgJEVU=;
        b=vtT0MNw13UFX4YXbCGV9P52df9BBjwWLMeAEvY+emXHUvCu8k7TwQ4CdKcoEx9OM3Q
         0PYdfnWdqXI5nIBR+4qDbcdY3d1YOr8yBodwpDcbeJ1hCMj//lA7LuBxpxdXCoo7nPBC
         VKdDhKxWtopDmD3jSk11A+vEWFYjlzHr6hjq1OiVbQLjgLm+ic9/LaDQxehBchw6mxyV
         ppfni7T5azo2dX5HMYBGwAvpYgiYV518+WNmU5NQgFtJG6++JGSdEiadYYO7co77akVi
         rFHYzuRo22/IJ6RPGa3N0DyghIMdJW79aweSdxstheuMaHgWSFdfNz9N47fs9Suu4mfm
         J04w==
X-Forwarded-Encrypted: i=1; AKwUvBww9epKBaml5qV+l6uwBKEEbXrdvaJzYmVEemqtb98HUIGUHNOOGak/qXFMcmRyRNg29bJ1wuP9BgbQIg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJpjbl7ycCLtk/JkymsjvgRuDe4aY8VFmIfi4uCT7bkYUMNLvQq
	fco7qBXFiPH+fcVEO6F6GCAToeVp7e6mGvUoriTqHnLNT+iuMGpyuR/x2kbNFVhv158057/y4yk
	5A13AfRG6o8KVmvI+dLdXeNbyoN5FOSTQeckap/gYyuDkmERdohO1YQCTXter
X-Gm-Gg: AYBFou0eKBGI0u0kFrjhpfjR1bOOGhR+MD5iF2buIhbHl+Lb4Na03oto1BXUmeq+ZAi
	GOV34P3nIn23ZJR6vqrb/SGyNeKrXAgOk9bMvFzCtgC3N6RTW+8s64oOZvkN58NcUGo4rBDXP8p
	2Mw3BgVu3l4pZy9vnEM9OMbQSBo8Yjh++hEw6c5I7UWH7vO9xx6UeM0Savr8QSigAG6/9f6fyHP
	GX2PGX5QKSPVsE9ztp9fTE4L9RXvZ1Zj/I4VurP39uzVUaNUNK/RbC2jcaVcbjsLJ0ci0GMzrfk
	pcmsYOrpTsIVySdAPptFKIt0s2kYOMzXDfTsdj5MTU1hD0LCrJoeh0FDyDxfY1yDfdFFhwjVqal
	Db10I28yYdcJ6cfv1tqEr2QOX1Aj8xbi0DRszglY8YF+3cXubgylRNDZvtuQ=
X-Received: by 2002:a05:620a:2b44:b0:93c:7948:6e84 with SMTP id af79cd13be357-944217a0ca9mr654250785a.52.1793402781514;
        Fri, 30 Oct 2026 16:26:21 -0700 (PDT)
X-Received: by 2002:a05:620a:2b44:b0:93c:7948:6e84 with SMTP id af79cd13be357-944217a0ca9mr654248285a.52.1793402780955;
        Fri, 30 Oct 2026 16:26:20 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.146.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7c5063e3sm163148635e9.0.2026.10.30.16.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 16:26:19 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 30 Oct 2026 19:26:10 -0400
Subject: [PATCH blktests v4] block/053: add a torn atomic write test for
 block devices
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-blkdev-fixes-tests-v4-1-d8d18808e965@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAJEn5WoC/33NQQ6CMBAF0KuQrq1pCx3AlfcwLijMaBXBUGg0h
 rtba2KMUZeT+f/9G3M4WHRsldzYgN4623fhyBYJq/dVt0Num3AzJRSIUpTctMcGPSd7QcdHdKP
 jkAvSAKSp0CwUzwPGd+htWMjHFNs+P24yB6zHh/nI7q0b++Ea972MjX9TXnLBJRUVFQC6kbCu+
 3Y6GVstsZnihlcvRYofigoK1SbVZYlZTvkXJX1TpP6qpEExQFRBJoWW2Ycyz/MdUWkGeV8BAAA
 =
X-Change-ID: 20260909-blkdev-fixes-tests-670f566f5f85
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793402777; l=12412;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=XJPCL1LbV0JD0hlTwroUz4G4Ol8yYByKK+1YQ+XBgAU=;
 b=mwX5gmqoNFpt3Z7evDZRBsdqZi7KjKL9OHDg6riWezh0b/jOAhpuxrM7iE8u90cfl1GHNM1dL
 gVHPFSrSBYRBe6ne+4pJ4k0MxGKm0ov/ARljup51nSwMYC1JuTKSNtn
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=LqwHWXdc c=1 sm=1 tr=0 ts=6ae5279e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=762CAJ3aCjDnXhjofVn3aw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=RRrp-CHWvF_M4TgCVqoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA5MyBTYWx0ZWRfX4taTmv5zouTs
 HcSassaJ0+I3MAF6F9aC+dYjcV5Kd9cIjHLMVmil3fMO0GdaTNZRfJdqnV1aMf2wj+dYxS962Vq
 /w+dKMqZEdpoBcDGU4zLObRBLUZ3oBA1LzpVRsw1OSHPdW6ICJbSWl+NIpstFUlgpZNnCocSLa6
 wsO6lOAsHUSGTk08mkk2Ajt4qEBsVr2PbRNUij64DGgaubffdSLUyaEIj6OrPBhJZxcl9gpSD9y
 H2s8tfyXDIj6wu5Ii2gopG9KOq8831CnE5iPt74KaEceyfFqV1m0s4MTbTXQY5TVPD5/bjhcqTa
 /kagGxu8tzhjv2okc2flDs9XtTGiX4msgwNSHIJeebLdxPF1O07RUf7syTLrehhkn3WzGgvo2SX
 PCdkyojTh1aT38ufwy5HsfEv8dXM0zLoF5HSYEG9E4RVF8L79itWZ8fU8xWi/SvSQ8hwCYNgKw1
 8vLDVVvPk4SB4qJQ90w==
X-Proofpoint-ORIG-GUID: m_sk_8BXt-RF3zTIVTwqmTy_E-zKZY-4
X-Proofpoint-GUID: m_sk_8BXt-RF3zTIVTwqmTy_E-zKZY-4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA5MyBTYWx0ZWRfX1/79zUATQoX8
 ZaH3Z2TQmuvol820U51IJ+5vK9p62e2/U1I3Nwn08t0h92+NB0a8PSdK0oNUjbO91P6Yx/Y2Am2
 x4V5EMGLfwEm/ZPsMmSioTNVhQ12htMuij5ySpjMwmfnjjo3wq6D
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11951
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 adultscore=0 impostorscore=10 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=10
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610300093

A block device atomic write is a hardware atomic write, submitted as a
single bio, so when its buffer can't be fully pinned, the direct I/O
path has to fail the write rather than submit the pinned part.
Otherwise, it submits what was pinned with REQ_ATOMIC set and leaves
the rest to the buffered fallback, tearing the write at the pin
boundary.

This is a regression test for that issue, fixed by commit 73a0ff6030af
("block: fail a short atomic pin in bio_iov_iter_get_pages()").

Issue a two-page pwritev2() with RWF_ATOMIC to a scsi_debug device with
atomic_wr=1 from a buffer whose last page is PROT_NONE, so that pinning
the buffer stops one page short. Check with statx() that the device
supports an atomic write of that size, then check that the write fails
with EINVAL and that the range still reads back as the old data.

Two pages is the smallest write that leaves one page unpinnable, and
atomic_wr_max_length=256 raises the atomic write unit max to 128K so
that two pages fit for any page size up to 64K.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
A regression test for the block device atomic write fix, now upstream
as commit 73a0ff6030af ("block: fail a short atomic pin in
bio_iov_iter_get_pages()") from the fixes series [1]. block/050 to
block/052 from the earlier revisions of this series are merged.

block/053 issues a RWF_ATOMIC write from a buffer whose last page
cannot be pinned to a scsi_debug device with atomic_wr=1 and checks
that the device holds all of the new data or none of it.

[1] https://lore.kernel.org/linux-block/20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu/
---
Changes in v4:
- Rebase on current master, and drop block/050 to block/052, which are
  merged.
- block/053: build the helper only when the kernel headers have the
  atomic write statx fields, checked in src/Makefile like the ublk
  interface, and drop the local copies of struct statx and the atomic
  write defines, per John Garry and Shin'ichiro Kawasaki.
- block/053: exit the helper with EXIT_SUCCESS or EXIT_FAILURE and let
  its messages say what went wrong, instead of separate exit codes for a
  torn write and an unexpected result, per John Garry.
- block/053: rename the helper to atomic-write-untorn, per John Garry.
- block/053: condense the comments in the helper and the test, per John
  Garry.
- block/053: rename the helper functions to
  bdev_can_atomic_write_for_length() and compare_bytes(), fold the
  readback check into compare_bytes(), and drop the informational
  messages, per John Garry.
- block/053: reword the messages for a write that went through and for
  the expected failure, per John Garry.
- block/053: refer to the kernel fix by its commit now that it is
  upstream.
- Link to v3: https://patch.msgid.link/20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu

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
 src/.gitignore            |   1 +
 src/Makefile              |   8 +++
 src/atomic-write-untorn.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/053           |  41 ++++++++++++
 tests/block/053.out       |   2 +
 5 files changed, 212 insertions(+)

diff --git a/src/.gitignore b/src/.gitignore
index d56d0fb..c299ecf 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,3 +1,4 @@
+/atomic-write-untorn
 /bio-bounce-read
 /bio-full-trim
 /bio-trim-pin-leak
diff --git a/src/Makefile b/src/Makefile
index da25842..5af0c9f 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -36,12 +36,14 @@ C_URING_TARGETS := metadata \
 	metadata-iopoll \
 	nvme-passthru-admin-uring
 C_UBLK_TARGETS := miniublk
+C_ATOMIC_WRITE_TARGETS := atomic-write-untorn
 C_THREAD_TARGETS := dio-fallback-race \
 	splice-race
 
 HAVE_LIBURING := $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
 HAVE_UBLK_HEADER := $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
 HAVE_NEW_UBLK_INTF := $(call HAVE_C_DEF,linux/ublk_cmd.h,UBLK_U_CMD_START_DEV)
+HAVE_STATX_WRITE_ATOMIC := $(call HAVE_C_DEF,linux/stat.h,STATX_ATTR_WRITE_ATOMIC)
 
 CXX_TARGETS := \
 	discontiguous-io
@@ -49,6 +51,12 @@ CXX_TARGETS := \
 SYZKALLER_TARGETS := \
 	sg/syzkaller1
 
+ifeq ($(HAVE_STATX_WRITE_ATOMIC), 1)
+C_TARGETS += $(C_ATOMIC_WRITE_TARGETS)
+else
+$(info Skip $(C_ATOMIC_WRITE_TARGETS) build due to missing kernel header(v6.11+))
+endif
+
 TARGETS := $(C_TARGETS) $(C_THREAD_TARGETS) $(CXX_TARGETS) $(SYZKALLER_TARGETS)
 
 ifeq ($(HAVE_UBLK_HEADER), 1)
diff --git a/src/atomic-write-untorn.c b/src/atomic-write-untorn.c
new file mode 100644
index 0000000..2dfdd9c
--- /dev/null
+++ b/src/atomic-write-untorn.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-3.0+
+/*
+ * Copyright (C) 2026 Tal Zussman
+ *
+ * Check that a RWF_ATOMIC direct write to a block device is all or nothing
+ * when only part of its buffer can be pinned.
+ *
+ * Fill the first two pages of <blockdev> with one byte value, then write two
+ * pages of another value with RWF_ATOMIC from a buffer whose last page is
+ * PROT_NONE, so that pinning stops one page short. The write has to fail
+ * with EINVAL and leave the old bytes on the device. The device has to
+ * support an atomic write of two pages, which is checked with statx().
+ *
+ * usage: atomic-write-untorn <blockdev>
+ *
+ * exit:  0 = the write failed with EINVAL and the device is unchanged
+ *        1 = it did not, or a setup error
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/fs.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+#define OLD	'A'
+#define NEW	'B'
+
+static bool bdev_can_atomic_write_for_length(int fd, size_t len)
+{
+	struct statx stx = { 0 };
+
+	if (statx(fd, "", AT_EMPTY_PATH, STATX_WRITE_ATOMIC, &stx)) {
+		perror("statx");
+		return false;
+	}
+	if (!(stx.stx_mask & STATX_WRITE_ATOMIC) ||
+	    !(stx.stx_attributes & STATX_ATTR_WRITE_ATOMIC)) {
+		fprintf(stderr, "device does not support atomic writes\n");
+		return false;
+	}
+	if (len < stx.stx_atomic_write_unit_min ||
+	    len > stx.stx_atomic_write_unit_max) {
+		fprintf(stderr, "device cannot write %zu bytes atomically\n",
+			len);
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Read the range back past the page cache and return how many of its bytes
+ * hold val, or -1 on error.
+ */
+static ssize_t compare_bytes(int fd, char *buf, size_t len, char val)
+{
+	size_t i, n = 0;
+
+	if (pread(fd, buf, len, 0) != (ssize_t)len) {
+		perror("pread");
+		return -1;
+	}
+	for (i = 0; i < len; i++)
+		if (buf[i] == val)
+			n++;
+	return n;
+}
+
+int main(int argc, char **argv)
+{
+	size_t len, pgsz;
+	struct iovec iov;
+	char *buf;
+	ssize_t ret, n;
+	int fd, err, status = EXIT_FAILURE;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s <blockdev>\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	pgsz = sysconf(_SC_PAGESIZE);
+	len = 2 * pgsz;
+
+	fd = open(argv[1], O_RDWR | O_DIRECT);
+	if (fd < 0) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	if (!bdev_can_atomic_write_for_length(fd, len))
+		goto out_close;
+
+	buf = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (buf == MAP_FAILED) {
+		perror("mmap");
+		goto out_close;
+	}
+
+	memset(buf, OLD, len);
+	if (pwrite(fd, buf, len, 0) != (ssize_t)len) {
+		perror("pwrite");
+		goto out_unmap;
+	}
+	n = compare_bytes(fd, buf, len, OLD);
+	if (n != (ssize_t)len) {
+		if (n >= 0)
+			fprintf(stderr, "old contents did not read back\n");
+		goto out_unmap;
+	}
+
+	/* Make the last page of the new contents unreadable. */
+	memset(buf, NEW, len);
+	if (mprotect(buf + len - pgsz, pgsz, PROT_NONE)) {
+		perror("mprotect");
+		goto out_unmap;
+	}
+
+	iov.iov_base = buf;
+	iov.iov_len = len;
+	ret = pwritev2(fd, &iov, 1, 0, RWF_ATOMIC);
+	err = errno;
+
+	if (mprotect(buf + len - pgsz, pgsz, PROT_READ | PROT_WRITE)) {
+		perror("mprotect");
+		goto out_unmap;
+	}
+	n = compare_bytes(fd, buf, len, OLD);
+	if (n < 0)
+		goto out_unmap;
+
+	if (n == 0) {
+		fprintf(stderr, "atomic write went through despite the unreadable page\n");
+	} else if (n != (ssize_t)len) {
+		fprintf(stderr, "atomic write was torn: %zu of %zu bytes written\n",
+			len - n, len);
+	} else if (ret >= 0) {
+		fprintf(stderr, "pwritev2(RWF_ATOMIC) returned %zd but left the device unchanged\n",
+			ret);
+	} else if (err != EINVAL) {
+		fprintf(stderr, "pwritev2(RWF_ATOMIC) failed with %s, not EINVAL\n",
+			strerror(err));
+	} else {
+		printf("atomic write failed with EINVAL and left the device unchanged, as expected\n");
+		status = EXIT_SUCCESS;
+	}
+
+out_unmap:
+	munmap(buf, len);
+out_close:
+	close(fd);
+	return status;
+}
diff --git a/tests/block/053 b/tests/block/053
new file mode 100755
index 0000000..d0bf124
--- /dev/null
+++ b/tests/block/053
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Tal Zussman
+#
+# Issue a RWF_ATOMIC direct write to a block device from a buffer whose last
+# page cannot be pinned. The direct I/O path has to fail it rather than
+# submit the pinned part as a hardware atomic write and tear the write.
+#
+# Regression test for commit 73a0ff6030af ("block: fail a short atomic pin in
+# bio_iov_iter_get_pages()").
+
+. tests/block/rc
+. common/scsi_debug
+
+DESCRIPTION="check that a partially pinned atomic write is not torn"
+QUICK=1
+
+requires() {
+	_have_scsi_debug && _have_module_param scsi_debug atomic_wr
+	_have_src_program atomic-write-untorn
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	# The helper writes two pages atomically. An atomic write unit max of
+	# 256 blocks, 128K, covers page sizes up to 64K.
+	if ! _configure_scsi_debug delay=0 atomic_wr=1 atomic_wr_max_length=256 \
+	     dev_size_mb=16; then
+		echo "configuring scsi_debug failed"
+		return 1
+	fi
+
+	if ! src/atomic-write-untorn "/dev/${SCSI_DEBUG_DEVICES[0]}" >>"${FULL}" 2>&1; then
+		echo "atomic-write-untorn helper failed"
+	fi
+
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/block/053.out b/tests/block/053.out
new file mode 100644
index 0000000..43d1b4b
--- /dev/null
+++ b/tests/block/053.out
@@ -0,0 +1,2 @@
+Running block/053
+Test complete

---
base-commit: a65cf6bdca19cf98e80ba379bffbf3a67f86fba3
change-id: 20260909-blkdev-fixes-tests-670f566f5f85

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

