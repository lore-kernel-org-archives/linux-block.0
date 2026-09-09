Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996FD3932E0
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991208; cv=none; b=OvB7dIEjRno8hyrmJT2oLCNnjqzXpHyH8lFN2ym1yTzzqe+WOwxCU4tM7TP8xVMdk40GItkl4UFpcd4g2YzcVETiuAQSLeZMlZSnWjXxNgwq9Hc+ycJgNX4Wp02TtM20xK3Fsbonag64x98vlKO7H2wBa+W0YMkCVRBIMd5UGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991208; c=relaxed/simple;
	bh=IM5bPJ73RzhPgBL2kKTtWZGOajovnVJFCt1pXN6VSeM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fGk/MLMOqX/co8n3ZUAmkyyaWqZsMB5ailuhT+djPGpMPrT1NHgutGs/GfsDxKQkgdT4VMrfQ6nhZcAmjrGxFOVYzB5PTJcHwJaoygCmqVbpt9Tb8uwCfe2sga31Lm1fE9uW29qh3HyTOHxkhfLD7YbgtF7ewglLZ9iV0b7wXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=EeF32HdS; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CBHkwrKX; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="EeF32HdS";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CBHkwrKX"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689KYbLK872829
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 18:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=ojQc/MLmhN/Z15Gp0peV5cet3p
	j7vf6d4dSCd3LBLR0=; b=EeF32HdSel6vb00qillnncT3sG1nVcUwJMRQzgwcC5
	/S/6bcT18u0eQOfA8NZ0VBzQJEcL/X4VjM//qC4nYbMa+jqwKLf5IOWKUa4Ia0tY
	/MsmWV44QhZcpWMgz3mTISo8t4MznXDMXcuYiLiLop8W4hqpK9OAzYkliers9FML
	c/zmCMc1k6QdPQ3EOiFik46P3ngELM2RRrtfc+Iy+EYwGXxi2zkb9ce985CBJ0ZJ
	8llblRyjNp2rkRqEyKsHiHjsW3/gOGpzrcUCLlPXAGRo9Rqs74RR+8lnh45HGxkE
	dL8+8YzxkUTcBCBRk4/OVAfNy/+xip3UtAZr5ewMDBmQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcyb1ukv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 18:00:00 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e53b8a302so1197585185a.1
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788991200; x=1789596000; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ojQc/MLmhN/Z15Gp0peV5cet3pj7vf6d4dSCd3LBLR0=;
        b=CBHkwrKXNG8cHRpfX0tbXgin3CKrxfJfr3EkeD2SEB2Xu3xuEEQ1YZouq40tiM0U8I
         q1O1pNLYck7uyt+nDWIwF+lLld10roTznLz6wUtTTfcW1AnsxZljeD80q95mWmGofXuX
         qIL0YgLUjHJjOEE0z6s4Bjg5O2V6SgqM94/LCDAHTcGRBgk9PeFb8PD0lcNJ1J99EOOL
         TbEjHqe2wQdcTDY8KpEHp53S+ApR0vxf93CNCqPBLcGb2EzEBtk2XCUarGfwuiwzNKRw
         P65IFtDcrLILdGeOf0LoMSYUS+h/L0iViq5bxdFxLdqYU6Yadxa58v6RXZDHdfBqf5MN
         4Cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788991200; x=1789596000;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ojQc/MLmhN/Z15Gp0peV5cet3pj7vf6d4dSCd3LBLR0=;
        b=cZkgoD7On57hRay0ZDdkVDitpjn5afQrdICoiphJ5IPJb1HyRo77z72e6+adFOh4U2
         +WzDpvRN3d3uaXgdZxAOMEOyp/KWH/P5MJUI0/+oV1Yh07viNGW2hnuvPmtPLlC9Aw0T
         srbBQF8677Cq4ikEvjBAIo0N3SzGkO7f8svH3U8f0AQu3KIIQKlP1PpHkoDV9A1dmI00
         bQTweRD9aiao6EJWH9xshrGN2kfZhqoQsuhDNvqgwn4qW0rUpHvsY5iQ5okxL5r2Vh37
         WMGNhJ3R+pdN2dXrtTNcJFzDtAfg8/dSz7PW/8l+MfrfXVso5uehmr06C6uTNpN75T49
         aobA==
X-Gm-Message-State: AFuF++kqcZ/yDKTxbCND8tysutAbJFDmH9PkECnAXVi6aHMdmuG/cJ1g
	8yjd9zzgIQ2l+BurjjgjuiFGDqiQ73AavB5rhrLg0b1q10YVYZ3Ks1yZtM6ALPMWfFqaelHIya7
	SoghoIV5VvHy38ldSdpyoBeOB12K3P+xRZfG+mWhK+ag/RbW+BIaXsZlLYGB2
X-Gm-Gg: AYBFou1Bl7TBheKNUTS2cw3VQbDxXjSHamHPN3vguwJGglF7OwCo3aMZDn6IyjHSkKp
	8752sFCQJ+Zvo2BmJy7VtD+XHU97w7J/N11+hF+BgWUn0AbgqmY+ANgLfwnxcEVzfXJ2EkleC4G
	XxajZTTO5eUEvJZvZATIrL7Q12X7UVSSm7oHkO7FbMAMUsKKk10hhCDwOJDFzGWhYz7GBiemOp1
	vn+gSzHS3asHeLUkBodE69HrksuyXXbGUBnI+TPhvDv9TzBdGLBLBc0w9Xi86SYnD2V8d3wEHIQ
	IruJqub5uIOyDzES6L8m4Az57OMuWMe+pbwmk/Y5W1tl1MeXH2SiDcwErMHmmi4bd6Dyim1aaaE
	azuGTtwwx5CBQKA/wts6kLVt+enWWTVjOPUS1JeZ3vAJOLzJL
X-Received: by 2002:a05:620a:811f:b0:939:6dea:374b with SMTP id af79cd13be357-939804f7c81mr3291445385a.47.1788991199857;
        Wed, 09 Sep 2026 14:59:59 -0700 (PDT)
X-Received: by 2002:a05:620a:811f:b0:939:6dea:374b with SMTP id af79cd13be357-939804f7c81mr3291441285a.47.1788991199341;
        Wed, 09 Sep 2026 14:59:59 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbe31c6sm1535326985a.46.2026.09.09.14.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:59:58 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v3 0/7] block device fixes for large block sizes,
 IOCB_NOWAIT, and direct I/O
Date: Wed, 09 Sep 2026 17:59:38 -0400
Message-Id: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMrWoWoC/12NQQ7CIBBFr2JYi4EBbXXlPYyLAoNFa2ugJZqmd
 xdqTLTLl/nvzUgCeoeBHFYj8RhdcF2bQKxXRNdVe0HqTGICDHasZJyq5mYwUuueGGhRcMW14BK
 VIkl5eJwPyTidPxwGdUXd50Ze1C70nX/N/yLPu28a/tORU0arEqzeyr01hTzqrhnuylUbNAPJ9
 Qg/PpQLH5IvwAormUaFZuFP0/QGpAE39f0AAAA=
X-Change-ID: 20260801-blkdev-fixes-771b1c314ebb
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788991197; l=3079;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=IM5bPJ73RzhPgBL2kKTtWZGOajovnVJFCt1pXN6VSeM=;
 b=LPAv0ZJQzU9fZkRPn54Q33PLLNGR8X8hVVtsmCbJ7cEyiJSU74jFWbDY0bNjLriRyU5uoeoPa
 Je9f8KPwK4dAczqUy2qHoQ4rpM2Whw2YqZP+9bhRIXzoHAX6mhWLPOU
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDI0NiBTYWx0ZWRfX6M0BeV3DWURe
 E9dkeCH3ykkr3r84hEhadzC/FrkuipZCGctO+8rubSyp88IcnT2u0tY8s/HzI1QNGdqrjTdGjml
 /0RIU0qaQEmAnKE4XXJPZIdxuFHjyJ4GD3XV23dtHsLnmzOYemcm
X-Proofpoint-ORIG-GUID: TTKWamXFKcGaaAXOQFUeFIZOQPdSQ4oY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDI0NiBTYWx0ZWRfX9Q8KPc7RVRkQ
 fyOvIlnkJrH27kT6t0U5FE49R/DX54rW6eixp2WGscXWbvp1uUGpbvxm/cKQX7/YQFYy5nAjXQA
 GJqByOR4vfF2m71QcMs5A1+zcuVBVG7MDZMtY8YP3OrDFTum0JrxLl+foI5iAfLHBehbyNwVA92
 Ax7Q59HsGqfonbLF8PkYJwi+uEtnLM3uusytDt9x8GaFaw0ov0BvHhC2b9aGk3PCpOha1CPIAIp
 KcmUu8MLM7pfSWqRV2Rt2KYOp7X8rrzvbu3bEfNmJXcFoUdAQUBGFImDHUaivWlO6DS+fPqWBNI
 cD0VQ2IdUx4yFZRr1Xa5gEqQIAjEs4ghWaw+1f32eFZNtJkTaTlV0+lzCxlkhhK1zfp/NEGeroZ
 +PxAqhvDrmiIKx+lLjeEipQm+6QNPTy+wb0g6XOapy2J33t/r5oR7Kaa+Vy6TJTqVp3prJ0JUpt
 qa8LeJ7AkvAlOkuNhUw==
X-Proofpoint-GUID: TTKWamXFKcGaaAXOQFUeFIZOQPdSQ4oY
X-Authority-Analysis: v=2.4 cv=Nq1E4MdJ c=1 sm=1 tr=0 ts=6aa1d6e0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=VwQbUJbxAAAA:8 a=-B8mBG0_KnDNrPBDhfMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=10 impostorscore=10 spamscore=0
 phishscore=0 bulkscore=10 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090246

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

Patch 5 makes IOCB_ATOMIC writes fail instead of tearing and falling
back to buffered I/O. Block devices can reject both paths into the
fallback before submitting any I/O, so we fail rather than issue a
WARN() like ext4 does.

Patch 6 fixes leaked page pins in bio_iov_iter_align_down(), and patch
7 removes dead metadata handling in the async direct I/O path.

These issues are currently unlikely to be hit in practice due to the
specific configurations required to trigger them.

The reproducer for patch 1 is in blktests as block/048, and tests for
patches 2, 3 and 6 are posted at [2].

[1] https://lore.kernel.org/all/20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu/
[2] https://lore.kernel.org/linux-block/20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu/

---
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
Tal Zussman (7):
      block: use iomap_dirty_folio for block devices
      block: take i_rwsem for the direct I/O write fallback
      block: take i_rwsem for the splice read path
      block: honor IOCB_NOWAIT in the block device buffered read path
      block: fail atomic writes instead of falling back to buffered I/O
      block: unpin all pages of a bvec in bio_iov_iter_align_down()
      block: remove dead metadata handling from the async direct I/O path

 block/bio.c  | 67 +++++++++++++++++++++++++++++++++++++++++-----------------
 block/fops.c | 69 +++++++++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 98 insertions(+), 38 deletions(-)
---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260801-blkdev-fixes-771b1c314ebb

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

