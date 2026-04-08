Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC48937D11A
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689751; cv=none; b=rFUeg467Ey41AAL4wlOtsLGpXxPq5SajkC0EwxxHbtdva/aVBFLTxPC2u4AGL+evrmcXLG/UADxM0YtLpfbIdETi1uEmVf77Ca8WiyzlWtAEVtyp1wb+URd2+/zp9jHgegobzwcBGj+sQvJ4RcMJyXjt3//gnHotWLvEFcBq9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689751; c=relaxed/simple;
	bh=eNN6J7KwolysQ9oupsl6H8UQYb2MhLRSQ3CeNcukCUQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P/YZr2qUii8JvvUdoFS6K6zak1HNnP8+LKQ21zheAcMocaqs/n81MHj+ZAd9gpeFlnBBZtLJdXuvrPN1ShGn7O0MhJ5Adh5BnbsrWmVeFYEmC4zIvi2A5SRwqdwm2pfLZPfhq0PiFAPMpkkRIlyOdCbd4fCRsf1eURpM53p4pTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=VqbPU0RZ; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="VqbPU0RZ"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638MvraC389424
	for <linux-block@vger.kernel.org>; Wed, 8 Apr 2026 19:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=PWaV4qCR/WGGXD8PVteuM8/cl1
	9CMqRooAS/C+4Q208=; b=VqbPU0RZujwiTAEJPIBnECXVe7ODtgxPEJo66qu1VD
	0/Xa9xK3Oc6vEndNQ/p/ZuDOOL1bEstmtnZgEOpGkNzTVfanRqeT014axtc6VlTx
	EDffkx+F394AfXYf7/6+JCUlR1y0ZqThIpvXWa4YD6B9zk4e7NRQEXyu5MxJh73t
	YlW7N9GxmjO6QVyr0GSIFwuRxsy+S5HJwMCOsQNJvwV599WLcM2JE6qTKGc3IWHu
	4SNTTegj+V/RwXMjCiqmfBoR74Zn7dkl9kRdM0s4sZCeQQ11mMkAB0YL+58nPJSV
	1O09q4eBrFZpCl84ZtIJK6FcyAMznJ8Afhr7p/QHtAbA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3r8ng5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 19:09:07 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cfc1634e43so20861285a.0
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 16:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689747; x=1776294547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWaV4qCR/WGGXD8PVteuM8/cl19CMqRooAS/C+4Q208=;
        b=Oq95ThSm1njCccecoL6Jynxz8yfoXFhvyDsCXMNbxJqL5iWL6BeaSM4bSoNcLNFGUn
         rrCERwC5wlgiaXI3kukTsPDdaMWCTzBA3FJ5PuQXDAtibew7/XU9TUYbzOikOKAHlctv
         FFFUTJkJri9ARauAYLfUpuxk7mjlHEdrBq4JjboJqwKhumait0XJJL0NqcKfw3wBxtQH
         f8NPEZfIhIvF6cgDNeAT4foDwhmhiqmsYkvY/oz3VhL7sZf9eQnQajlMheWZ2KO90rcp
         5TWTVX4rXoJEtCWa6dt8B+41Pv6E18OndeY45N7V36QRD3gobmJqOwR+06Frm3Iyv1me
         5mfg==
X-Forwarded-Encrypted: i=1; AJvYcCUiLFQRwoar+7LhXNRcQrjVitgecqcuqwA6lJmOz6KD/pRPwxI3URE3BIxXkl/BBh4ZYhfblwetiHS1hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWq/xY6ncpQCALjuIF4buyxCGV9epFZdIQoxdg13bZV3/CLfv
	FF976UDsOa0mKJLupof/UXNQ5bFM0tMz6arG/ylPzEFu+yDI0XOTKJ5jKdIxwNd4ERrC/wZs9XA
	6G1KfO09tUQqWJK6g6wHztiHHcs5gwBHjBRvP5XjZar5fXaFQFDKoVr1nh66cK0qRzKcM
X-Gm-Gg: AeBDieuQRsXB84OFP7gvO6DX8qnq1WxNplHrJ6Sv0MRrkSZ4GOd8z1fkazrL5qKTurS
	gCQqTUA9ijUr6m0pchn3AIAxyCu21SbmQPHqYuS6ESWTbX1sKN1RHxmxinQqk8Q46QD1iQ/gc5d
	QuA2vVx8wnXLOhV9nmqrGG3EE/SZZDmpPWsTjoSeU8DU0yusl3CRwjq3PhPawfvAUqmlgx46NcQ
	3zgtFrQP1ADbuBcNcel6A9J24t3z4v4TYl2o5AdAHbFanCCp691B7A4ZwF1+Si6DpBDb4/gXLge
	0OR9sJqufWCb86pqbwvlhEbm/athpq/bQ6orQEPYMvqe3cvZt2hUQ8yVcmEfz/j6Ng2keeApyUs
	Ur8+uUhyAep5bDKqoQ5UVvPrBCLppxQLB
X-Received: by 2002:a05:620a:8812:b0:8d6:255d:877a with SMTP id af79cd13be357-8d6255d91c8mr2446190385a.15.1775689746875;
        Wed, 08 Apr 2026 16:09:06 -0700 (PDT)
X-Received: by 2002:a05:620a:8812:b0:8d6:255d:877a with SMTP id af79cd13be357-8d6255d91c8mr2446183485a.15.1775689746248;
        Wed, 08 Apr 2026 16:09:06 -0700 (PDT)
Received: from [127.0.1.1] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8dc1514d382sm125665485a.4.2026.04.08.16.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:09:05 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH RFC v5 0/3] block: enable RWF_DONTCACHE for block devices
Date: Wed, 08 Apr 2026 19:08:48 -0400
Message-Id: <20260408-blk-dontcache-v5-0-0f080c20a96f@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAADg1mkC/3XOy07EMAwF0F8ZZT1BSZxHhxUSEh/AFrFIY4dGU
 1rUl0BV/53QzVSdsry27rFn1lOXqGePp5l1NKU+tU0O5nxiofLNB/GEOTMllBVKFrysrxzbZgg
 +VMQBCgmAKLQhljtfHcX0vXpv7PXlmb3nYZX6oe1+1huTXFf/cJPkkkeP1jpD0cn4FNp6/CyTf
 yAcV2xSG0CZPaC44E6Q80HnvigOANgCbg9ABgKCuISAprBHgL4BcP+B/gN0aSyWGqLVO2BZll/
 hJmQrdQEAAA==
X-Change-ID: 20260218-blk-dontcache-338133dd045e
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775689745; l=5327;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=eNN6J7KwolysQ9oupsl6H8UQYb2MhLRSQ3CeNcukCUQ=;
 b=bHlGuFQrrz6YhG5yOASexdE8c208+vSdTnDa69D9htKWSJqGlq3xd+2vFNoibaB4KXVVHi6Gf
 O+kgQh51awBAp3IkBP15pRJ2W7MKUTTcyJZMZ40qWyf4cXW7q7Hj++4
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: Tr53ET-yZaiXmdx-OZxx6mqLfTCWvOmX
X-Authority-Analysis: v=2.4 cv=UplT8ewB c=1 sm=1 tr=0 ts=69d6e013 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=jj9FZi3_KS3zrj8-0pEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Tr53ET-yZaiXmdx-OZxx6mqLfTCWvOmX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDIxNCBTYWx0ZWRfXyRxFTn7ocWyt
 r7q55f+x6NJiCiTX5T1QzWk+wdtrfxG8NTIPv5Y2y5+xwjS15A5zXLxLI97i8uf8U28NbuHZtU6
 hyJVzcWSRMb0svcRJUDeFPH/NoJUtGxFVMbQuiIhP5X1y3soLNE7oqiZk/AwbotDcYJTbigSSNJ
 GoU+WMByY6O5h//87psZiWNqzfMmSFp55h7S9T/ZUCTdLyCM9bt6bqJAA2F+eIN1j83DNkOQgXQ
 qwuAH+grm6JBsqMS7dwUOBPnNY34sjJc2bBQ+2Fysb49I2dcks22G+5GTDyJsWnQOEU8LHcb+a0
 n/8E/K/R2Jos8sFY2YBE8gd/jqkGVESk0YTp/OueJmqp09kEt2IRxC9md++O7b9fuUcYvdxxKdc
 EFeHRxHuQn1R3keK4WFus7BejyQNeQKKrB1rTkHKGDBxYcRBK7D3PCUl355LsjRuXElqwGJIVmM
 NHKLIwO5VqgeZJTn0jw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=10 spamscore=0 phishscore=0 lowpriorityscore=10
 impostorscore=10 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080214

Add support for using RWF_DONTCACHE with block devices.

Dropbehind pruning needs to be done in non-IRQ context, but block
devices complete writeback in IRQ context.

To fix this, we can defer dropbehind invalidation to task context. We
introduce a new BIO_COMPLETE_IN_TASK flag that allows the bio submitter
to request task-context completion of bi_end_io. When bio_endio() sees
this flag in non-task context, it queues the bio to a per-CPU lockless
list and schedules a delayed work item to do bio completion.

Patch 1 adds the BIO_COMPLETE_IN_TASK infrastructure in the block
layer.

Patch 2 wires BIO_COMPLETE_IN_TASK into iomap writeback for dropbehind
folios, removes IOMAP_IOEND_DONTCACHE, and removes the DONTCACHE
workqueue deferral from XFS.

Patch 3 enables RWF_DONTCACHE for block devices, setting
BIO_COMPLETE_IN_TASK in submit_bh_wbc() for the CONFIG_BUFFER_HEAD
path.

This support is useful for databases that operate on raw block devices,
among other userspace applications.

I tested this (with CONFIG_BUFFER_HEAD=y) for reads and writes on a
single block device on a VM, so results may be noisy.

Reads were tested on the root partition with a 45GB range (~2x RAM).
Writes were tested on a disabled swap parition (~1GB) in a memcg of size
244MB to force reclaim pressure.

Results:

===== READS (/dev/nvme0n1p2) =====
 sec   normal MB/s  dontcache MB/s
----  ------------  --------------
   1        1098.6          1609.0
   2        1270.3          1506.6
   3        1093.3          1576.5
   4        1141.8          2393.9
   5        1365.3          2793.8
   6        1324.6          2065.9
   7         879.6          1920.7
   8        1434.1          1662.4
   9        1184.9          1857.9
  10        1166.4          1702.8
  11        1161.4          1653.4
  12        1086.9          1555.4
  13        1198.5          1718.9
  14        1111.9          1752.2
----  ------------  --------------
 avg        1173.7          1828.8  (+56%)

==== WRITES (/dev/nvme0n1p3) =====
 sec   normal MB/s  dontcache MB/s
----  ------------  --------------
   1         692.4          9297.7
   2        4810.8          9342.8
   3        5221.7          2955.2
   4         396.7          8488.3
   5        7249.2          9249.3
   6        6695.4          1376.2
   7         122.9          9125.8
   8        5486.5          9414.7
   9        6921.5          8743.5
  10          27.9          8997.8
----  ------------  --------------
 avg        3762.5          7699.1  (+105%)

---
Changes in v5:
- 1/3: Replace local_lock + bio_list with struct llist, per Dave.
- 1/3: Use delayed_work with 1-jiffie delay, per Dave.
- 1/3: Add dedicated workqueue to avoid deadlocks, per Christoph.
- 1/3: Restructure work function as do/while loop and only schedule work
  originally when the list was previously empty, per Jens.
- 2/3: Delete IOMAP_IOEND_DONTCACHE and its NOMERGE entry, per Matthew
  and Christoph.
- Link to v4: https://lore.kernel.org/r/20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu

Changes in v4:
- 1/3: Move dropbehind deferral from folio-level to bio-level using
  BIO_COMPLETE_IN_TASK, per Matthew and Jan.
- 1/3: Work function yields on need_resched() to avoid hogging the CPU,
  per Jan.
- 2/3: New patch. Set BIO_COMPLETE_IN_TASK on iomap writeback bios for
  DONTCACHE folios, removing the need for XFS-specific workqueue
  deferral.
- 3/3: Set BIO_COMPLETE_IN_TASK in submit_bh_wbc() for buffer_head
  path.
- 3/3: Update commit message to mention CONFIG_BUFFER_HEAD=n path.
- Link to v3: https://lore.kernel.org/r/20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu

Changes in v3:
- 1/2: Convert dropbehind deferral to per-CPU folio_batches protected by
  local_lock using per-CPU work items, to reduce contention, per Jens.
- 1/2: Call folio_end_dropbehind_irq() directly from
  folio_end_writeback(), per Jens.
- 1/2: Add CPU hotplug dead callback to drain the departing CPU's folio
  batch.
- 2/2: Introduce block_write_begin_iocb(), per Christoph.
- 2/2: Dropped R-b due to changes.
- Link to v2: https://lore.kernel.org/r/20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu

Changes in v2:
- Add R-b from Jan Kara for 2/2.
- Add patch to defer dropbehind completion from IRQ context via a work
  item (1/2).
- Add initial performance numbers to cover letter.
- Link to v1: https://lore.kernel.org/r/20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu

---
Tal Zussman (3):
      block: add BIO_COMPLETE_IN_TASK for task-context completion
      iomap: use BIO_COMPLETE_IN_TASK for dropbehind writeback
      block: enable RWF_DONTCACHE for block devices

 block/bio.c                 | 83 ++++++++++++++++++++++++++++++++++++++++++++-
 block/fops.c                |  5 +--
 fs/buffer.c                 | 22 ++++++++++--
 fs/iomap/ioend.c            |  5 +--
 fs/xfs/xfs_aops.c           |  4 ---
 include/linux/blk_types.h   |  7 +++-
 include/linux/buffer_head.h |  3 ++
 include/linux/iomap.h       |  6 +---
 8 files changed, 117 insertions(+), 18 deletions(-)
---
base-commit: f384d0b7710d3edaab718c02bbae46a4d3fd09de
change-id: 20260218-blk-dontcache-338133dd045e

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

