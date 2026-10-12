Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD904BCADC
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825485; cv=none; b=n5rKJfftQ8ESpevvlJZSBVhhlvaIW5+zjJgQ4sw7G3rU+kX7Z6zUXzyRfSdBL2SSd0gWjLfPR7YsnD4OjjgKMHfF0FoPJQeY5vaK5tl73ztFACafLOVdR0jQfYk68+VdberlsV1J7gHqPB8Zg6xsRFYF9RRE3e6Jktz0m1XHtqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825485; c=relaxed/simple;
	bh=q4uoRFSF58GpRp3uOtRFOwVzT/xHulFohw37lU8PDrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2Qqpck+6lRpYOAtMQBL2MGmiM1Akr2N4pySTTL5JhhTK9ZfowB9yeKaBwQvBr+tv5myckmsxdi9Ki/DCX66lP0kA1kSR0sJnyg42HJkHJidaMXx8bFVESIpc/YZp7nvi4jaZQKxXxg3kbhriwe9UOd9f64UQptt9+jlEJtC1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Oxc+dy98; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=3tzUSwnD; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Oxc+dy98";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="3tzUSwnD"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CGcHm8976392
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 13:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Cj4I
	PCNzq2NySFVKs4csvRqiTj50jw4uLChrhjAwWmU=; b=Oxc+dy98buPUjNc6rtmM
	vQV0bbTnvTyCrC4Y/Bo58nfwImwsxUGgAKOv5a4F7iob+fwaSS46hFEoE+IM3I5k
	OgH4y9BSVzLYpI0PEc/bXn6LAF7L3kEPz8vmB6vB0nr1UvwpfvvryzCUmwmCiUMA
	sOYcLrHPdT0z+AVMy8X386JIDIqbmSLUxfFX5scovrVuZ5Ls7IT8Ac2wQCbrLUC5
	1ab+tQTOSH5fr5Bm6nRgU5FD9J6/e4uH0k6lQV6tWSt+Ccsg82fYwV196Y2l5i6W
	TtTVJR07Iyb9ai4XQB7WSucyct6KZ0Jlc0R3TNGEU07gZ+dVPNCdi1qwV+DovaFE
	oA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h8w933u1w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 13:18:03 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53513d2a70eso50142301cf.3
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791825482; x=1792430282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cj4IPCNzq2NySFVKs4csvRqiTj50jw4uLChrhjAwWmU=;
        b=3tzUSwnDKqkw56noT4Uwe6M1eeipR4FPN0H2vOlkfqXr3T3POVTKZWpWtRQi4Mzfyk
         uUjt2PvCUYn7+15iCYkstFGU5iDCKiLhYVwUsMZrfTt7m2nOxovHUAIsgdtWWf/VLv6T
         sMFDvLsM/cZUQu1ihlBIWkIlwCNGHJXpQrvHk5ro0HAMGfx14F2lNV8N9haEWds2aXBi
         X8pydQx2lksGvk7cqCJ/ju9hVrB7iBV2K2pz+nWZDaFXmIYY3k/nSERqgYqL2R81TDZe
         pyTuxtHVT9n6b0htYrqOzQaqeSm3g6G7/t3uQx++VxLtt4uxMXLIkSrJekhzFIJsa2Ti
         rqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791825482; x=1792430282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cj4IPCNzq2NySFVKs4csvRqiTj50jw4uLChrhjAwWmU=;
        b=mNybPeo65S3PhGjIyXVShNfg+EuAvZjkC4Y1Df31FfEIxP+X+MG4LATJnnZTgRYk6M
         qH0+AQOc4GTJOlNTHJl6pimP9L7J4P/9xyE8WGdKw3s1pbhCf+FNYyjV6J+djhPy9qlR
         YRuDWVM/KqfsyBHaPLzilqSb/LtgBfCXvZFYwtRx97XuU3JSoPrTUpx+cYtZEXkHIqLz
         mHEPtd9n6MgDA0NfOs6oOWK3FdVA8rihg1u2zoNn2zG/QG3bDCbbkd8USQeazsfYcpxp
         gL6BxvmXaJxQJU9WQNujCHa4g1WN9xQqjBWsX2KtQszeC7AuBfFG80bIXNoJH9Hy3ogp
         TLZA==
X-Gm-Message-State: AFq9FYIfjttW3S0n+VIYFgC8KWlsrrmhOA91uKwoegw2kbWDGNVlyh2S
	InDIDq/9AAr6X4nKhFgiUrOA21NxliOH678jp6zB2jrMAxEtzDGY0rENmOC6mkLS/WMIlKKZU2e
	09Ggf6H8w1ajnHQ+1RZzMGDFB/CMosAYfH2kDyCbH/FMEQmQDgsrkrqPHfeof
X-Gm-Gg: AYBFou2TPWNqCfbe4MiO7KWgGNJFM15EWOmXgAX3RB346SOdjZEcU6ihed+ONcxh9Mb
	K8EBUY93+IwIDh4wrSyqeLRpp6jAhPuhps1IuVouVcfijppNZOzdDtZoF1YDKlCZKT99w+bWnmX
	mERGK3iCNj3WkvIFwJfrZLhIb9v3nA2579fklCk1N9sz0pR8HyaMFWdq3a8qtv0VCypeB8W/x+s
	6wUlEgxL63vaZKEgQjca8MBs6dwOwjtND4U7PxJssntiwOf4O2fMdiaJnIjcmp8cyklV5iS0/7T
	j2VumkbJMGdXoZ7MLpNXN4hmV1WeIq3Bj5cQDYFsxLGHFRBt8zSRSxG2rVNJfcWslvmMpVVOrbd
	qCaKuLfnAwnf0aNlFd39Rciaw9fyvQ5uikNACS05d8pAh0L0=
X-Received: by 2002:a05:622a:4c08:b0:530:42d4:4c9a with SMTP id d75a77b69052e-5359fdaa13bmr173319661cf.44.1791825482527;
        Mon, 12 Oct 2026 10:18:02 -0700 (PDT)
X-Received: by 2002:a05:622a:4c08:b0:530:42d4:4c9a with SMTP id d75a77b69052e-5359fdaa13bmr173319151cf.44.1791825481943;
        Mon, 12 Oct 2026 10:18:01 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-231.net.columbia.edu. [128.59.178.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b79a186sm84105241cf.20.2026.10.12.10.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:18:00 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 12 Oct 2026 13:17:42 -0400
Subject: [PATCH RFC v2 3/3] ext4: don't advertise atomic writes for DAX
 inodes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-ext4-atomic-no-fallback-v2-3-c4b30c60e500@columbia.edu>
References: <20261012-ext4-atomic-no-fallback-v2-0-c4b30c60e500@columbia.edu>
In-Reply-To: <20261012-ext4-atomic-no-fallback-v2-0-c4b30c60e500@columbia.edu>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Zhang Yi <yi.zhang@huawei.com>, Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@linux.dev>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791825472; l=1770;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=q4uoRFSF58GpRp3uOtRFOwVzT/xHulFohw37lU8PDrg=;
 b=pqzdVoU82abKus8NPYExlPZk+xRiblaHpuqxXj3zR0h7FSfEWr1BnScVZYp/JL9utwUifR43m
 YWekI+OTEm8CCnnwq9uzdboC0VgpA7Oz4uMdlb7Yyv9RQTImG5F4KwO
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX41Y4eHzIaQXg
 RKY6kNorIRp4WNADbzzlwqs232zOptbDj8FK5AM21fsNCuxXqcmVVqbLcs8f4CveW8IPYd5qU6T
 hqpfr1XRO2Xb2GbEWtOql/DFCTajKM5t9kGC+lcY38S7XX4wpY/pdeXk9V79I1Qi8Y5dNLL2Kuy
 +AL86v92D8q8AeV3+JrPI27MOjhy5lFZmAqKhbQ8lxFHyIO+kBWdxZYeDu/vgRhjOGlnccVuYfq
 45ShG6jqqococXVfspX87M1kNn6qDUDae3gvyo3hR+LHUfTFwdoA1DlLw25iCiAG0ffqT91hu76
 GkXekWOJI6ENeZXlWtR9msCg2XMyrMIpBQ0Y7M4TeQxUgOnZ3NjMt9HGAuQY8nKntxZzwaDot5a
 eJONGusXqLEniTceFMuoJIf2I0oRwOgdL4fn/TqBjyRK+/x4eM8h1xRNRzBaiGt/g2wPsef0g9U
 R5om7UEFdKTG44uqhKA==
X-Proofpoint-ORIG-GUID: mnle6kmYfT32flzXKC_l1Eg5npmLn31n
X-Proofpoint-GUID: mnle6kmYfT32flzXKC_l1Eg5npmLn31n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX/WJDV77nsGNS
 cRWevWsFSrzwjdm4or44+b0Zv6EUEPRIXcKjnZrtU8Wcx+Cr8DY4FiqFj/umuzLawO233VtPVwJ
 zuQRZq9Ab+VfflbcV/C6Amppy6xufWIM0XAVc9kN5Js7SDuefWOH
X-Authority-Analysis: v=2.4 cv=cYxHPXDM c=1 sm=1 tr=0 ts=6acd164b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=9fnr1hFzp71kSIFw8uYQYA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=WDUyjk1rXllw49Jjrx8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11933
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=10
 clxscore=1015 impostorscore=10 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120068

ext4_file_write_iter() hands DAX inodes to ext4_dax_write_iter() before
any of the atomic write handling, and the DAX path neither checks
IOCB_ATOMIC nor provides torn-write protection.
ext4_inode_can_atomic_write() doesn't exclude DAX inodes, so on a device
that supported both DAX and atomic writes, statx() would advertise
atomic writes for such an inode and the VFS would let an RWF_ATOMIC
write through to a plain DAX write.

No DAX-capable block device advertises atomic write limits today, so
this isn't reachable. When XFS gained its corresponding check, Ritesh
Harjani suggested excluding DAX inodes in ext4 anyway [1], so that what
is advertised matches what the write path can do. XFS does the same in
xfs_inode_can_hw_atomic_write() and xfs_inode_can_sw_atomic_write().

Link: https://lore.kernel.org/linux-ext4/87a54e4cdn.fsf@gmail.com/ [1]
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ext4/ext4.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5115f067a9f5..1520baf581b6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -4060,12 +4060,13 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 /*
  * Atomic writes are only supported through direct I/O, so an inode that
  * can't do direct I/O at all (journaled data, inline data, verity) can't do
- * atomic writes either.
+ * atomic writes either. DAX inodes bypass the direct I/O path entirely.
  */
 static inline bool ext4_inode_can_atomic_write(struct inode *inode)
 {
 
 	return S_ISREG(inode->i_mode) &&
+		!IS_DAX(inode) &&
 		ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
 		EXT4_SB(inode->i_sb)->s_awu_min > 0 &&
 		ext4_dio_alignment(inode) != 0;

-- 
2.39.5

