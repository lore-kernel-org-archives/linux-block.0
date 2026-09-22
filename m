Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE984383998
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045661; cv=none; b=tbCBdVe6j3FhDtEA13h/LjzoQVccB5Y58wMcLJudvMRlttu3660Y/Q474bzazC/5YHXcNGznc+JeAKHN1ad0QjhkYiMkB9RK46NFYmXSdXVtWgSLu0Dy6dsW0DEDdW8fdvpOq9eVGt1MPiQRgrNwDHih3Gzvzy39QBMQgR4KiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045661; c=relaxed/simple;
	bh=+NX+E9VVrg+IkpOn4F94en4KlIqUN7N51FNbjgbNX0I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l1+sxSlpPnGaAOvQta72mv35LD0w03M466YfNOwBJJu3JPhNwvHY8Af/2ChafOx4QWrK4vCIy2DkmuSZO83bueJ3+UHuD8+B5BQPrPVbb3NP/OcOXuM0+SvT04KlNt22712B9idp7IZKoQ16+2B38QR603jBOi5zxiD5AyJOJV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=khulNkai; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=PTsQBJNs; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="khulNkai";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="PTsQBJNs"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M2X0a6852504
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=OnQKuo+ikBaHSZ2r1ZTqsmXlj1
	SSrmY/7Jz3zqEVUv4=; b=khulNkaiQEEsAjJucAQlTLanmFCW6rkTaT1g2J9MzB
	0wvZTi2o5QoqunAxBk4PcgYncW+ih5BBbpCazzT8o3SiW9BssxaSlaIma4FNPd+u
	cdt303prZ3jyqAOxWCfl3JPzMqJH+8VpoDprOxwRCzLUyQF89EejNIcrHbGRSeKO
	CI87ojfuk+rsbyvYNWsBwh+pFJtEUN0Vq8WMYXxRyntWwfw8omZZBCeYofNKYrZp
	I0oZu0kstDNlUQwNQrNtuQpwVWGFNyIkAbgs3B1DP7Ps6UN9k+r1VuO0wQQjYqHd
	kzavlXYl1UEzRsYyTxngkg/hTcmmnON0rlWukjwndUJA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4guf3vrkhk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:12 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53000c06184so105765591cf.3
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 19:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790045652; x=1790650452; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OnQKuo+ikBaHSZ2r1ZTqsmXlj1SSrmY/7Jz3zqEVUv4=;
        b=PTsQBJNslWp6ICZhYSfMQcFfJzjfWTxBKc4JrMGQEQqut/x4knSSDZFAu2YMlY3TfS
         PWv+5LMNhagWst2LWF4LxcRsJGeyS3rZLXHJoGrGp1LPgtonAYpilHKtmbLhfVYlI9nu
         81THK/E5Fmi+DNbcanm7aJZc2epbmcT5aWhdSmL6kFpLvLB42Ij+5wwbNRDcp9K7bu1G
         P88ZWVHXMfCDJ+SBV28I5ILYtwIEhYQWbJaeFUydm+KK6hPfeWtXu+Jd94sHCS9DuWrj
         gEzBqbwc8pe9xP+1up92+9mdMFb1pTPu92T/E5FhfgJIsYxQji3JQKEj6a2pVuszXsGs
         JPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045652; x=1790650452;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OnQKuo+ikBaHSZ2r1ZTqsmXlj1SSrmY/7Jz3zqEVUv4=;
        b=LqvgX5lHxwF8jRZte65Ju4/P16EGOgwcnE9tCpd3A7LQwHQTPkyHvdFIzIuALUQY7f
         jQhtFB3tAHRXpFkoHkXbhXHmuGkNgneATHqRpG6CkC8nGuvJ57oX4tDsotNIrFm0jFam
         /gQ9DCXuQqQHalnJ2qy0+pp4Q5d/ziJh8iNATkH1cMNcgQFqn+9BTuhpV0JTOyvEn9Az
         UmtdCV6crAgEu95zi+nJLVycszFzr+4RJPvA2KQn5eyo3O66nty+no19QTLB/U2bxetg
         dMQdmdSZcUG7V0p5huiceSNi/8dofwn38HAYkG9rRBZ+IUS5lvVFKDgoUPaiVEDwkwPB
         mocg==
X-Forwarded-Encrypted: i=1; AKwUvBw6lp/QqbmKBtj3TvVg5YY+XU+lPAyo+RuWVELp/8OmDhmiRqNGIqxDsthMuOLXxlHC1uBF8/PC9iE8Tw==@vger.kernel.org
X-Gm-Message-State: AFuF++kmENWoeUkbNFgP6K2DtmHGbGs6mkXoU7ocdeKZQPMWpWL9fOH0
	YlB/gqyERVI9N8kICLIzK37/c3CbmFYo0FQ0y4h3PL3h768RjV9o8qg2AKYpsRur4ernrDUs37J
	6fREAlp0juIa5fVltI0gff6PlBDVk/B2cXfjHC2lRV7nq96sr31uEWvH65aGA
X-Gm-Gg: AYBFou2H3fKfokSh3jtcC5spl2FUCcwSJu3T9LQVDdjDA5u0VrBuPMsGhNmEx1htkrM
	pfFqyz0Z1hUhN8zqvCdClmq+7QSW5nx8OjXQglMQ8rQdPhd7bBexk6rF5PTvGlchciZ6ty8H24Z
	PVlPBxQqeCtmirljds6o9x4XwRzMu03hFkepKFDAkhGhJLb/G958kPQ+SsF1LfSQvUnZEt/JPLt
	43LAq+6JSJrWA+Evxcq5Tu2kc+sRzd4at20Y8NuUaTxuKaaqT3TJdyvrrEbUKVueZWajMKw55O+
	WOCIjSmYNyvjPLQyR+0NsBiDCflgDXgG5yVTJwXEMHTIuE/sjlnQX7iUVQgt72XwlB2Rc+rswG6
	2nsJC1DdiBl1MdnErHULIaQMHvWF5yT02XSFcchga/BNI
X-Received: by 2002:a05:622a:1b22:b0:532:d202:3280 with SMTP id d75a77b69052e-532d8d69442mr38335411cf.17.1790045651971;
        Mon, 21 Sep 2026 19:54:11 -0700 (PDT)
X-Received: by 2002:a05:622a:1b22:b0:532:d202:3280 with SMTP id d75a77b69052e-532d8d69442mr38335081cf.17.1790045651477;
        Mon, 21 Sep 2026 19:54:11 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e18fce9fsm2048421cf.15.2026.09.21.19.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:54:10 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v4 0/8] block device fixes for large block sizes,
 IOCB_NOWAIT, and direct I/O
Date: Mon, 21 Sep 2026 22:53:57 -0400
Message-Id: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMXtsWoC/23Nyw7CIBAF0F9pWIuBAftw5X8YFzwGi9bWFEs0p
 v8u1Ri1cXkz99y5k4C9x0DW2Z30GH3wXZuCXGTE1KrdI/U2ZQIMclYyTnVztBip81cMtCi45kZ
 wiVqTRM49Pg9JbHevHAZ9QHOZNqZG7cOl62/Pf5FPvfc0/E5HThlVJTizkpWzhdyYrhlO2qsl2
 oFM6xG+PJQzD8kLcMJJZlCj/ePFx1esmnmRPFcrADA5lmrux3F8AOD8nHI9AQAA
X-Change-ID: 20260801-blkdev-fixes-771b1c314ebb
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.garry@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790045650; l=3573;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=+NX+E9VVrg+IkpOn4F94en4KlIqUN7N51FNbjgbNX0I=;
 b=D7esfcR0mS5/bQIvufVYDU1AjZfnvVgPBUvy3n92NfMdUOAHeFGbAmZgcxaoo9epoBr1msk+n
 1VK2NxVOWTvAcF0ND3eGLv5Vy9qagdU8VDGJCru7Sbm8+AusI3cvZ7J
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: YqDFM8XdaRRTtk99BPiSfp4_B0fMR4bX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfXwDdMbD39oJNi
 lxBJyoWm9MIARH317TOcPlnnHH/FnPlS4Du5je5f2ZqBy8PaK1TOQQl9DfxQ/mAGHlihYfPoKCa
 zx+D+eN0SMvvmK98c7BlTtZ3YLn9/DonKIHmjhya9C1841VwuCQt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfXyE9iCN1OOkCW
 asbO4+W04j6t6NCjpfZcesVJRyYJPqp5OLwsRsPAWw7vtE3if3EdjOs7asi+b7JBxyQS0aIyNlc
 7pibT6MPrYrHvBCXbWJhAgEiIEymIjsXTh92gZtrX6nBc52NDIa6iZfD9Ta00CoOnwiPGJ2YrIk
 kGpA0v3M7QX4jFhGkIkhz8uwZUomq+/XAI0SPxZyFaRzs6nrepsmHqW/oz1w3KTdsSYAetC52Nx
 8t8wEtFWqMuVJBoVCrGyM44mxNK4jxtzkrFrQ41GJ0vU5Sge0i7JDAcu9hyAbQWsinr09pz8OX8
 ErmBVarVOwdKGZhtGGxH8E5/t2gZVTxlxxD2kLT2kwmkuODF2FSKme0GTRpoRIxFSuG1WklXeaF
 VW94uP7Qf4rJy+lmu/dWXhY7ZmEkZuRGvh3tEg18dvGhvgm1184DI/TJHPH8jRSHPAnO2RGDXU1
 kG725Mciser5ChRuDBQ==
X-Authority-Analysis: v=2.4 cv=U/UHnuru c=1 sm=1 tr=0 ts=6ab1edd4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=-B8mBG0_KnDNrPBDhfMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: YqDFM8XdaRRTtk99BPiSfp4_B0fMR4bX
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11912
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 lowpriorityscore=10
 impostorscore=10 bulkscore=10 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220037

A set of independent fixes for the block device file operations. The
first two were found by Sashiko while reviewing the RWF_DONTCACHE series
[1]. The fourth and fifth were found by Sashiko's review of v1 of this
series, and the rest came from asking an LLM to find any similar or
related issues. Each issue has been reproduced, with the fixes resolving
the issues.

Patch 1 fixes silently lost mmap writes with CONFIG_BUFFER_HEAD=n.

Patches 2 and 3 take i_rwsem around the direct I/O write fallback and
the splice read path, which race set_blocksize() changing the mapping's
minimum folio order.

Patch 4 makes the buffered read path honor IOCB_NOWAIT instead of
blocking on i_rwsem.

Patch 5 makes IOCB_ATOMIC writes fail instead of tearing, and patch 6
stops the buffered fallback from retrying an atomic write. Block
devices can reject both paths into the fallback before submitting any
I/O, so we fail rather than issue a WARN() like ext4 does.

Patch 7 fixes leaked page pins in bio_iov_iter_align_down(), and patch
8 removes dead metadata handling in the async direct I/O path.

These issues are currently unlikely to be hit in practice due to the
specific configurations required to trigger them.

The reproducer for patch 1 is in blktests as block/048, and tests for
patches 2, 3 and 7 are posted at [2].

[1] https://lore.kernel.org/all/20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu/
[2] https://lore.kernel.org/linux-block/20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu/

---
Changes in v4:
- Rebase onto block-7.3.
- Add tags from v3 (thanks Hannes, Shin'ichiro!).
- Split patch 5 into two patches, per John.
- Patch 5: Rename len variable to size, per John.
- Patch 5: Move the IOCB_NOWAIT check up too, per John.
- Patch 7: Expand the comment on counting the trimmed pages.
- Link to v3: https://patch.msgid.link/20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu

Changes in v3:
- Add tags from v2 (thanks Hannes, Christoph!).
- 5/7: Check for a short atomic pin in bio_iov_iter_get_pages() and
  return -EINVAL, per John. Dropped the tags.
- 6/7: Use bvec_unpin() for dropped bvecs.
- Link to v2: https://lore.kernel.org/r/20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu

Changes in v2:
- Rebase on current master.
- 1/7: Add Christoph's Reviewed-by and submit the reproducer to
  blktests.
- 2/7: Skip the buffered fallback for IOCB_NOWAIT direct writes, per
  Sashiko.
- 2/7: Change the Fixes: commit from c0e473a0d226 to 3c20917120ce
- 3/7 to 7/7: New patches.
- Link to v1: https://lore.kernel.org/r/20260802-blkdev-fixes-v1-0-a82fc549fd74@columbia.edu

---
Tal Zussman (8):
      block: use iomap_dirty_folio for block devices
      block: take i_rwsem for the direct I/O write fallback
      block: take i_rwsem for the splice read path
      block: honor IOCB_NOWAIT in the block device buffered read path
      block: fail a short atomic pin in bio_iov_iter_get_pages()
      block: don't fall back to buffered I/O for atomic writes
      block: unpin all pages of a bvec in bio_iov_iter_align_down()
      block: remove dead metadata handling from the async direct I/O path

 block/bio.c  | 68 ++++++++++++++++++++++++++++++++++++++---------------
 block/fops.c | 76 ++++++++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 103 insertions(+), 41 deletions(-)
---
base-commit: 687cb38c4330d52d58dbf426a3eb523850052d10
change-id: 20260801-blkdev-fixes-771b1c314ebb

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

