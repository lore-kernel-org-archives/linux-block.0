Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111E35970F
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467676; cv=none; b=ADac42WlbJP/h0RK4enD615jKUoHOK72EfPle0MVGIyJ4xg3gKk8Ao6awAcLs0r2fApQtlt0XOe5uptpJY5JX9C47lGfcaZrQFFA+6/TDwnXtyziGdmneAUygO2mN3LncepMgJKdZjJ+8ueoPPL9fpmPfDTSclPOtri6gCupzeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467676; c=relaxed/simple;
	bh=SDa413NBu0hIgtXUq9skjN+ObizbWtqbWL36k4Lizgg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=COx9wZoDD4L6iAGwIAkcWElBX0UTP7LDPmqIkdRy9fq2s2AvOOUkTyyYf9WYRlbQiBoGNKLUzO/P80BWnTTXr88XmiwUSBr+FQBVwSlWxpz4/+YQJF5OQ+027YzqBsD62diGW8J5pKABdDJpqC/32rJhWR4+R4sT+I5YKw/Sr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=DQGQun1h; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="DQGQun1h"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PJSjZo3609733
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 15:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=HA8D23GhyMmgO7Ma7d4u4MjK11
	kduWqDfN99ZCazVFY=; b=DQGQun1hSa+QSSxUr1i8su6bffWvkVZW2sXUVXgnlt
	spnIeP4au9kWZU6PdGp9HPtniIjnetnIaBZ/4Hit3Koj7U7ggQPK9cq5xePIQU77
	YlFwwGlCOaWH4hrsUEsr6/uSlFegWdbd0iMlu24ImT3aWBqZWHzRJg7xvZ5bTEu1
	weYJ8Uu1Jy+hPpNC/TiiyQHTRZWyIgj09wbccT+4egTjtLVkeqs4I16mYSCFUf+K
	fXBQuxcnDsxRTIzsQqwBxNXEQvUnHkGkbJwvMgMLXIzDGFZEiKixwOlC8nFIvy+D
	i7HLIHgQ5vueOIACUJxRXYmWRuwGCH9OOV6nGTk2h7GA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4d4dnrmmad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 15:30:41 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b4b81c632so10002901cf.1
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 12:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467041; x=1775071841;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HA8D23GhyMmgO7Ma7d4u4MjK11kduWqDfN99ZCazVFY=;
        b=GFamPz0TcKH5ApDEawaglvnjpkAEB360q7r6qJsRx5xxDeplXZ/EJW+6suMLlhbtCN
         2y1m0B8kVBNGH90Y2pTCOH2vYGy+BLNSNaaDTDVKgCROpblSL0m9HxYHPWuGdOcW0LNo
         9DkW0zvY/cflzZnG+MXedO2LF9QOQc75o71HZoujgXUFQ9MH5dJYkHpRZHPl7rLXvgG5
         LWqncJP6cFH7wSlPPKqGGma23DgwTguuTLAokkqx6ONi82jEYIPu7casBxCa95gKbIyh
         kHTJXeDh2a0dcrJ13WylPPnku2b7uFEaSZDegryvKiixga504j24Jieo5L3ekvt+m10E
         /O+g==
X-Forwarded-Encrypted: i=1; AJvYcCX+5ZD3WimjY9fFWGfZwkfJuRo0qdQsZNZrg2RtW8Q9pdVGu6BF6U4afGRfuW5lCENzaJ6z1Rhjt1Rc6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+O4hUWHlAf1Cg7Zxh/Y+25ymeEyULkGZuuDFZz153zTAd4YD
	92d72EwfByT9hfQpt1fos8Hj+/86Tdnkrk71AbFbWe33bZX40up2L81MsZ5w/il9IK00DvslpY/
	L7+wkAdjRwKnU4SIhX42ZjdtuTxkKQ62V9LdZVl9Sp6ZaT3e3yJuhBFyaE/4x
X-Gm-Gg: ATEYQzxK5fYe7YztFzRmIfHHNjPKeDs6dc7vOdeiE4DY/1ypUDwv//HhrUgsI7W+wJe
	5JryGUPgCZt0YDX4IP8lM4fQfrl65LeEDCto0Dgm2iLF6AJ+cLGB8nN5MVWh70D6lMAGNG7QNWw
	14gHe0xXNtbq6eRivH6RqBXYbpt10gWPdHnRqfH6dA7VvZWE+JJ1LP5JsXB1ACr0nGko189uvWt
	IcsZnOMwMf5p1afSlIvOFZP+eWdHuarVTdzJyyC/JpYRfFemyelmxKKDL0HnNuIvkGAhhXBrV2j
	OGYPJJuT1DcvXacOx02Np7cIzKlc/rrOEzmvxQMHXakrcpy5K+viFjZTHeBc9pVhP5lXw8Pj7N0
	MKpcVJxr/VoAwJhfO1KsOKQG56lNycKvAw5ptYQ==
X-Received: by 2002:ac8:660b:0:b0:509:3cd:b243 with SMTP id d75a77b69052e-50b80d1817fmr51207711cf.21.1774467040960;
        Wed, 25 Mar 2026 12:30:40 -0700 (PDT)
X-Received: by 2002:ac8:660b:0:b0:509:3cd:b243 with SMTP id d75a77b69052e-50b80d1817fmr51206021cf.21.1774467039043;
        Wed, 25 Mar 2026 12:30:39 -0700 (PDT)
Received: from [127.0.1.1] ([129.236.226.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b9234e3a3sm5534221cf.19.2026.03.25.12.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:30:38 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH RFC v4 0/3] block: enable RWF_DONTCACHE for block devices
Date: Wed, 25 Mar 2026 14:42:59 -0400
Message-Id: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALMsxGkC/3XNTQrCMBAF4KtI1kby0zbVlSB4ALfiIp1MbLC20
 rRBKb27IatSdPne8L6ZiMfeoSeHzUR6DM67ro0h224I1Lq9I3UmZiKYKJjgJa2aBzVdO4CGGqm
 UJZfSGJblSOLm1aN17+RdyeV8IrdY1s4PXf9JPwJPpz9c4JRTq01RqByt4vYIXTM+K6d3aMaEB
 bEARL4GBGVUMVQasrhn5Q9ALgG1BmQEwEi2BzB5WayBeZ6/w0/PZzQBAAA=
X-Change-ID: 20260218-blk-dontcache-338133dd045e
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774464193; l=4705;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=SDa413NBu0hIgtXUq9skjN+ObizbWtqbWL36k4Lizgg=;
 b=rVqeNMymQnbkbA09jjFwfm2fWjVL0ioo1AkqXQ5jcutSE4d0XRwJmwhfNzYW1IkNqhZq2eWVM
 qHy178rbPMXAdte8ZiWpsnVx+A2KACM+e+P4EnG/GBnw2X8s/dYeyYJ
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 2OFzDcCZmrxfwUIl94_uQMnvfDFYK1LF
X-Proofpoint-ORIG-GUID: 2OFzDcCZmrxfwUIl94_uQMnvfDFYK1LF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0MiBTYWx0ZWRfX3AcDYOopkT87
 WS1MNy/qIIsu06nhOBcx90MG4ynmUcUguNAZXu8SyZK+c1pmoeLQP0AW95K00d+h6rdFA2iq27H
 E4DOY0mz7DnkYbG0mcK4YT5UR0GVEY71tLOyAkReJXsyXVVOZf/f0lur1MoF3ZoBYXrmDassx9L
 iAmsnA0fYZqIAHgN8mXJMlRLGwSmCltkeLk8BydT5O+YCNzPts4EMCTeypFD9yUvLznwi0JJRNu
 VBjmxJgoZjmnwKDmsiiPtPJCbLh93DnpbKnJxOxufo9OTUg5OcuSK5DgH77VyeS/uB0xbOVvpoF
 8zchg2r5lR7l6waeLF5AWBV9rtXdQG50q388KjkmbsYIk3kgfNVnEl05EdxNIY+20vz7QOC1KMg
 904N6FmuWScGo1CB8yTbriVcFOKuOYToxI1Qg85PbUWLF4xFoRm7zqdnBc1rwPz5x+J3YptIQv3
 JY2z7n1X039HUoKb+Lw==
X-Authority-Analysis: v=2.4 cv=JMw2csKb c=1 sm=1 tr=0 ts=69c437e1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QOUmeeuX5y9IvSxXHa6D2A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=VwQbUJbxAAAA:8 a=tzuM4wBP0trzEmBACekA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11740
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=10 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=10 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250142

Add support for using RWF_DONTCACHE with block devices.

Dropbehind pruning needs to be done in non-IRQ context, but block
devices complete writeback in IRQ context.

To fix this, we can defer dropbehind invalidation to task context. We
introduce a new BIO_COMPLETE_IN_TASK flag that allows the bio submitter
to request task-context completion of bi_end_io. When bio_endio() sees
this flag in non-task context, it queues the bio to a per-CPU list and
schedules a work item to do bio completion.

Patch 1 adds the BIO_COMPLETE_IN_TASK infrastructure in the block
layer.

Patch 2 wires BIO_COMPLETE_IN_TASK into iomap writeback for DONTCACHE
folios and removes the DONTCACHE workqueue deferral from XFS.

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

 block/bio.c                 | 84 ++++++++++++++++++++++++++++++++++++++++++++-
 block/fops.c                |  5 +--
 fs/buffer.c                 | 22 ++++++++++--
 fs/iomap/ioend.c            |  2 ++
 fs/xfs/xfs_aops.c           |  4 ---
 include/linux/blk_types.h   |  1 +
 include/linux/buffer_head.h |  3 ++
 7 files changed, 111 insertions(+), 10 deletions(-)
---
base-commit: 2961f841b025fb234860bac26dfb7fa7cb0fb122
change-id: 20260218-blk-dontcache-338133dd045e

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

