Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481754848B2
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825479; cv=none; b=oqEX1qivS2isQZ9vkEIoQ7cjIJ2nzeflXS17/CmP77cl1wgOFeql2f6CvTe3fiRTrqB8F0j7cOe/+00zlnaOeneICmU5QrUcGYN1ZJXRqcZOp6iIAuhOVg5MXzO0HgnU9NKjX7aScAMyU9Or9qjqSTYOJ1/wzQs5qqUqFDHWDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825479; c=relaxed/simple;
	bh=VwcAIDWhgnfIn32IVgjlHKqi3+DSTWH8Hd3zm2RoHxY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pKcjPlHI3dpciHwjBGenQotgc1B8g71lKKWDMo3CFfOKPbJIqWES2jVgbBwmvibAIrANCkUnNwyJ20eZj0g2dqFq0i8a7CigasTM1v5MvzUdgAstfso7X4jJFuvl5d/AT+4aWbZGeU1Odx8DaytBTXFgfLdYoyo+rG5jAH+9Gqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=jZVfrS6B; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=TWhHVT8F; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="jZVfrS6B";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="TWhHVT8F"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CGcEpU799959
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 13:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=gC9IoZKL1jmjVDGSQBCOs0WSnE
	J04v+LLCo5re+IopE=; b=jZVfrS6BMkcN6xF7wmJMksC8JBjbOGAsArPipJxydr
	ezuoAPWyeNvN8ir8YAiRFNJ0R6BBy7Km68L/QZrgiE30XDKjRbDaniJZJXl3NBHI
	0jgVTO/gj0/tcp+1KT6M5YiRHbKb8/qLkF3A5q0pgTPg3sjz9GDafQzOzWpydqWZ
	DOhP5OgqN0PwoguvF8/z4qv1ilwDVk4ItGK3sd8epoOQc2EvU9UXTVi+5e+6TIri
	h2Cq9xx7Q8krRZCuc+U/0nk0wjF5fzkfuEY4yQcT1Di8rzWvD4KLRoxviIL4wTB8
	UyFxtRhymolxTYjJEUXKIerpo75sAUfniHjx4AMgd1cg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h91x6sbyq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 13:17:56 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-535213e3a7aso48453641cf.1
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791825476; x=1792430276; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gC9IoZKL1jmjVDGSQBCOs0WSnEJ04v+LLCo5re+IopE=;
        b=TWhHVT8FcA3ar+qzbrOcBHQ/D+ExY2lx3qyyW9yXzyC9h7lnE8mEVYjL6D5ENESwbn
         3WVjtC7JwreoE7MOGVbjl1lwKDvaaAqUuIHyIuILqbKxfQhrQTH14bs9ez3MN3UPkMhE
         56ekvPHANyrJcXy17b89bQGm/QN8TyJzq41y01ylgfQQJFTdffX7RPktRouoHwiO1s0p
         QdLbUpnxqRh2/wAAIOyLkBPnmwTxFm3qvQHrJApGONK1WeIbGsP18aKz20y1qzhVEjMg
         SIjBrow37QdEbRLPqeCCBRlyFZ2qTuxOXwvHAK+xQjyvrlMOLQiGS4GSs+x1f+rrwWpu
         /bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791825476; x=1792430276;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gC9IoZKL1jmjVDGSQBCOs0WSnEJ04v+LLCo5re+IopE=;
        b=TiRhWm/qMSgqXA8jr2EAFZRPdIVRjBSWpufQ9pNsA/24X1AO3syat4Ix/5tqXQnLOX
         FrErEuXcvmc+bMJJuAxhOqZQ9gf+yQjN4d3buWl1EQ9x6BUFDe1sLFDLyzJHOqgMJav4
         /ck+RmXhxSRqC62vQAQ9T/uI2htKq1/Rcvsghyd5S8bPvRwxCDg32CGkmymmxOwPA/LQ
         rfkRT/NqWvQQ0Ee/7rdip18e3GLv6yPjK42T4IY1G/alABgbzw0Xub758YipbWXzFmp2
         VcRBdvjc6qz4RrJn0VcyTCJefDMkT5BObYWtNCdlJ5ASLbqGMmNvVyp+KJgSrgpPtHbg
         Y5kw==
X-Gm-Message-State: AFq9FYL1uNYzalxqXrFRUP8FUSOAaFj4HZU+Z1e12vOaCKIupHrIl9He
	B4DHF9cd3wj+2Rg+ZaaRIT/YsVFtcL/zWJ2Sgh8LbWOQBQJPRypea7/gwmlh1tXduU2b9WEh57A
	hWnrhTY50RadpZYH/FDVgVjEv01cpjYxTzT38FkfSYM69airNL8IvLaJjlMin
X-Gm-Gg: AYBFou34UTwD/k3UPEb4tAMBF8U6aqARet0etFGol/Pc6YMrFwURX4TjV4SEYog6L2S
	i6/x4jXvQLTDGu14nyhE0d+xzJqBJzxkRsn2LdYGrbrUsRTnrejd7ITKmUhfhQHmJYEyIQhr+w7
	y1VkkkI+XWc41WGzKN1w940bYTvhpvmFe8GU/hXkryo4OCpAIHDwZkG2m4QP26xnezwZ5p90OQg
	lUHkMwkVVo4k0BLEhtxCdElDQJaYaS+r1rdWp0pLrEpWRMsagDhkxV+56YbIraCcqjbU54FcTrq
	Vtigj6jWxY0NatOEz4RocwKpTnRvZY5qbWbBQ/8ApbIPY/HOaYABW7KnoMIp7LoxFh1oIwRXzUZ
	EMpQIASy8/U5Dap4SZJ6xfuK018aLEgzR56C7RyyeaDjZy+w=
X-Received: by 2002:a05:622a:1b89:b0:535:70b4:3f81 with SMTP id d75a77b69052e-5359fe556b8mr172345571cf.71.1791825476267;
        Mon, 12 Oct 2026 10:17:56 -0700 (PDT)
X-Received: by 2002:a05:622a:1b89:b0:535:70b4:3f81 with SMTP id d75a77b69052e-5359fe556b8mr172344981cf.71.1791825475513;
        Mon, 12 Oct 2026 10:17:55 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-231.net.columbia.edu. [128.59.178.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b79a186sm84105241cf.20.2026.10.12.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:17:53 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH RFC v2 0/3] ext4: don't complete atomic writes through
 buffered I/O
Date: Mon, 12 Oct 2026 13:17:39 -0400
Message-Id: <20261012-ext4-atomic-no-fallback-v2-0-c4b30c60e500@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADMWzWoC/4WNQQ6CMBREr0L+2pq2WExdmZh4ALeGRVt+pQrUt
 IVgCHcX8AAuZ/LmzQQRg8MIp2yCgIOLzndL4LsMTK26BxJXLRk45QWVVBIc04Go5FtnSOeJVU2
 jlXkRzYSg6qhyayws63dA68bNfIfb9QLlr4y9fqJJq3PFaheTD5/tf2Ab/PdqYIQRoQotRS4Np
 fxsfNO32qk9Vj2U8zx/AXXf3yDYAAAA
X-Change-ID: 20260909-ext4-atomic-no-fallback-b1550a7a3fcf
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Zhang Yi <yi.zhang@huawei.com>, Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@linux.dev>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791825472; l=2239;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=VwcAIDWhgnfIn32IVgjlHKqi3+DSTWH8Hd3zm2RoHxY=;
 b=4nuovofsOXeVA4WMPAoybjCcbpaZs5uqfbQUypnaxQDRlltD3EGo1W5xmcmwVOtiHwmwXYVCp
 lxx3G+HvUHICM+LIhVmmkOMIFhT7F1PBlxEUkkx5tHNwR/9kWBWO/WX
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: jW43ctvJKAWw6rcYa_HLFgIhZrx1v74J
X-Proofpoint-ORIG-GUID: jW43ctvJKAWw6rcYa_HLFgIhZrx1v74J
X-Authority-Analysis: v=2.4 cv=DrDDa2/+ c=1 sm=1 tr=0 ts=6acd1644 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=9fnr1hFzp71kSIFw8uYQYA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=bC-a23v3AAAA:8 a=7FDvDFWMCw6z-JPjW7kA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX+M1US9stVnUP
 CJ0P88zOyw6Ndji4DIUeMmz+ksBTE8YoiSVLc8FcpGTmc/TpJ1bbYvQ1f26QTVsBGlXwYYEaxOR
 IyIwf5YBeRIlPN1NCub4F1HD9GanpNrvX7OfkWHFBmb9tleUfY0kx31Of7/CsQ0wBJAMXl8C040
 SoQ/zbejCaMRHQUDLfBa+x5gBym7rp6BRbaSihfyBPl25lJyT8wBiHWO9o6ndiXljPkxCoQwtPv
 cpr65luY4vLDzWfxzKgwQ6QGb2wtrrprHAIli+p2BCEWdS9BtBGGX+s8ww8IThFWb2+58GA46+b
 pI44+VQ+7PzwSdtIiFKPkzZvZTTiKWwnjaQChIzU0VFhFBAg9RrX1p1/tKdAP5buWaEII++e+Xg
 WQcIPONVy0YNUcWcHhehw+J2IcrsEx/7c2YLYh4Ocvu08gI7OtL/HOg5seY5u3WGRUpAUZhaJPA
 AqbVrb0S3dJq4yEL7Pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX7+WyOS7f92cv
 0tra3CkEdL07eXOiJk4q704xb8ZZvgSPjGdW4l499S92ODf1BIuVNDN1vUpOnviiLYNkLxA4MSz
 RHuodPGTOZgyERPD5I5YcyOgFzMwDzrlRR7bX2QgjdaPe9LfaO8w
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11933
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=10 priorityscore=1501 adultscore=0 suspectscore=0
 clxscore=1015 impostorscore=10 phishscore=0 spamscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120068

ext4_dio_write_iter() has two ways to finish a write through the page
cache: the fallback for inodes that can't do direct I/O at all, and the
completion of a short direct write. Neither provides torn-write
protection, and neither refuses IOCB_ATOMIC.

Patch 1 fixes a reachable bug: an atomic write to a data-journaled
inode is advertised by statx() and then silently done as a buffered
write. Patch 2 makes a short atomic direct write fail with -EIO instead
of falling back. That path should be unreachable today, so this is
defensive. Patch 3 closes the same kind of gap for DAX inodes,
which ext4_file_write_iter() hands to the DAX path before any atomic
write handling. No DAX-capable device advertises atomic write limits
today, so this one is defensive too, and matches XFS.

With a scsi_debug device, on a data=journal mount, and with chattr +j on
a nodelalloc mount, the unpatched kernel reports atomic write limits via
statx() and completes an O_DIRECT RWF_ATOMIC pwritev2() as a buffered
write. With the series, statx() reports awu_min=0 and the write fails
with -EOPNOTSUPP. Ordinary extent files still complete atomic writes,
and the WARN_ON_ONCE() in patch 2 did not fire under an fio atomic
direct write workload.

---
Changes in v2:
- Patch 1 (new): Reject atomic writes on inodes that can't do direct
  I/O at all, where the fallback to buffered I/O is reachable, per
  Sashiko.
- Patch 2: Fail a short atomic direct write with -EIO and keep the
  WARN_ON_ONCE(), instead of returning the short count.
- Patch 3 (new): don't advertise atomic writes for DAX inodes.
- Link to v1: https://patch.msgid.link/20260909-ext4-atomic-no-fallback-v1-1-5a6b9539c002@columbia.edu

---
Tal Zussman (3):
      ext4: reject atomic writes on inodes that can't do direct I/O
      ext4: never fall back to buffered I/O for atomic direct writes
      ext4: don't advertise atomic writes for DAX inodes

 fs/ext4/ext4.h |  9 ++++++++-
 fs/ext4/file.c | 17 +++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260909-ext4-atomic-no-fallback-b1550a7a3fcf

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

