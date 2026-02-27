Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606C346E5E
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210490; cv=none; b=sLJfiPvIZGLsIJi9T7gA4I+BEuwCkJK2ft7IvfrV2JsUC6T2glVK8vhr8AzMgYwyinK8qaESK8y4HSln/jYZlpVCPfU1LHEPUUZn0dZtEX3mn2Qo1AkhpgzVNASd+u2pxk+igj+c/LDW88UhEeeIO8oKMLAwY/7r+A5BlS9WgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210490; c=relaxed/simple;
	bh=BEeIa88RvYQBpBW8wSWS7+9ZmJtRT8takeYNLITWrCY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GvcUqb4YlTDVhZTrJCJfGHPZQxT1JY4MKEzSA6JsJELjL3Ccg1GyXoEgTAtJVbHlMnTBP3Jpql8Wk3m/fcMq1NOA8qZLExfuHRMBFGB1vJKuyd8FU7fuLqyylHoi/e6bpEWih/qvmXXj5fwxHfLoXVYW95akEV1d3uMhu+T0NRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=WJ4WE7fY; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="WJ4WE7fY"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RGNJQw1565668
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 11:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=kIopnbRq4jN3V/2gTsORTjLWBT
	vRkSveHkD2aWFgnTg=; b=WJ4WE7fYoUyiLGjnYIFC46Hw/0vUjE3nebGm34U/zr
	VZ/f462QjOtqeQqZLHDTtDdmUbsOAHcPrqc/Lvwfx91+uB0xBk8rkq5l4I5FzvrW
	aRsGK8IBpv2Im9i6x0aKDjoeIfX4KrI5kRkOqkW8bYQ5cbetHnqRZ1vnjc/jjE7Q
	2G5FNrqaZJh1N4OAXDAioA8u07YK/p2dQj6SVlccARRyT7vd/9vSGC0EeUPjQjhy
	Iay7JWvyDMuBOyZ2x5+pA6A2MPMgoo8Mj+2c13tnG7vnxK+D2zslW1qwNxiiVvEF
	SY+rN3sSzrh8QadkH7FOQtja5UpCp/iDBWPU4r3bYXWw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ckdsa0rc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 11:41:25 -0500 (EST)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-899c5d3d00fso280166066d6.3
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210485; x=1772815285;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIopnbRq4jN3V/2gTsORTjLWBTvRkSveHkD2aWFgnTg=;
        b=FIQRCRy841TWkmxH0yiqHQ6yFbcIJALcjuS3KWmAPUf6szlvdq6Zu+4c0YLC8NgILK
         J2irFrcXepDfDj74m1UDsOYbIblX3V/bHbRvOVmRDpcj1lZaTCnc272TP390naLDfmiE
         JyHGcYrojj4Ipa2HIKj2LNJbyckBzflBCWGlV+pkuQ17sbB2pLgLg+kK7i1bWSnOW4m1
         LPuqUK5G+F4g9npVTS/uWbBNQlT6XLhaqFU+GnxjncvHiQ6PUf+MISNdps4BLkBY+qQ+
         xbr4BUKFk5I2ZnDIGcIqUejp/xdOCTJx+wJ3+O/+DfVoMibtF2BT4A2TgwUcV2k6hOLa
         50ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXfX6qkVQPfWcDYdNx1/GZYL6dMuDPW3Vv8SVEeKP70fw4NQrOGftaH/5OITLdXXBpNQxaAJytH0DHlOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2kkDvj6jiLAauRVDhvHZkJVceUI8Txmrf3Q4zXlzBxdrIOx7
	D9ck+zYYzOm/sq34h7ksY+JIWed+uci/wYz7FYXQBVRNyLTcQR2Qw2IWu/U4lV+UPdAYLXuL4wn
	oYYHwhWzE69IV5ZXK+k3oZULVRA7mZkmlMr30OOwCd0HAFigNULBi8UUtRQZX
X-Gm-Gg: ATEYQzwijNg61PXsooUbCMCTij/iQK10SHSWD30EwqpJAzCirYkDV8JrkRzKjYWpqBC
	/q1TXZOWplySRtXn13rD9IcVNut+9jqkQTVVhbHQaknl+J4fvB967ZQHDQD6Pm+tiFFhJt7qqPC
	untYhk3ju18f1Ir/JC/t06hROj514QYsXSBzjI8sTlEeJbtV9mQansSElOfhJO1gTmGtowZRZyn
	dlZxYn8cWIYBxbPHGZiiSUqGT5Wz261LH/MEkEdtltFvEALH/dVUQKYQEt3naGq8cFSXky9U41b
	oGwvbLXYKfXDbQcMeZQR+umzn86GmkwesiuNQ/4IEwb+SRNe3AH6KaJIlQw6ckvwALN0eCfLok8
	/T6y7oP/GNHjL/W4bn5OYEOsEediyWDcBo8v2rrCl1F95tiYQq3YbqDekC1rtkyweSac=
X-Received: by 2002:a05:6214:4109:b0:88f:a4a0:2ddf with SMTP id 6a1803df08f44-899d1e5070dmr56245596d6.46.1772210485141;
        Fri, 27 Feb 2026 08:41:25 -0800 (PST)
X-Received: by 2002:a05:6214:4109:b0:88f:a4a0:2ddf with SMTP id 6a1803df08f44-899d1e5070dmr56245036d6.46.1772210484479;
        Fri, 27 Feb 2026 08:41:24 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716caebsm46535886d6.15.2026.02.27.08.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:41:23 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH RFC v3 0/2] block: enable RWF_DONTCACHE for block devices
Date: Fri, 27 Feb 2026 11:41:06 -0500
Message-Id: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLJoWkC/3XNywrCMBAF0F8pWTuSR1+4EgQ/wK24SJOJDdZGk
 jYopf9uyEoKLu8d7pmFBPQWAzkUC/EYbbBuTEHsCqJ6Od4RrE6ZcMprylkL3fAA7cZJSdUjCNE
 yIbSmZYUkbV4ejX1n70ou5xO5pbK3YXL+k39Elk9/uMiAgZG6rpsKTcPMUblhfnZW7lHPGYv8B
 +DVFuBAoaHYSFWmPW03wLquXysbLKrzAAAA
X-Change-ID: 20260218-blk-dontcache-338133dd045e
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772210483; l=3619;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=BEeIa88RvYQBpBW8wSWS7+9ZmJtRT8takeYNLITWrCY=;
 b=P2OAzuWnRvGmfMu3FKgpEoLuWT0SusPENu+T5BBqjDCAzaIIHtNgLjq1p6L6MeydJbtozid2B
 FzfMGcUqZEjAp//Ioln1ll+QavLMRrtpcuVgSj1+WlZ/W6AWGzIkaUw
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: t47WZhv8P5dsQX9sNHjb4J1WqgmoOsFY
X-Proofpoint-ORIG-GUID: t47WZhv8P5dsQX9sNHjb4J1WqgmoOsFY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE0OCBTYWx0ZWRfX+nQuPi8MTCTI
 grn0OtmA53JgstRqgG581syXuBkVAooiLlHagbqOLGZNkyMS78SmGFZPgfm3vbWDUWg7h9yLpjr
 +xz07F4OUgYYrrxg4XCbZy+Liehp1j8a1as/ATW5+405YYxeNETBZJMJpZ3wbpUXF2LnyPiYyWL
 DAvB6ocPEDILU9MVt64CR+koJiHwKzqijQyaj1hNnxCL81ClL5VHZ9II9woPEFJXyzAUbbWxGkl
 bZxqyG98il9Dn2Y2R2K6AorB/kzdhbXQVQoh2AKRvaFMQxSHxpSfEFImlaiUgjIk52wJsJMuU1p
 tGRr5lIyJDUuO6xyzcvosFHVDayEdd5Kwtwc0JGZBPic2nAFfrPh8uj7IFs/tC/owk9PzKyIe1a
 zQFoj9kJTqJaBS5T860K0sSTWXA1sw+P1sWuRyEtFjpUNUGKnxuJlyo4PJYwLLoFdV1wyauNVnI
 k2tGu7lzhJW3L67P+mw==
X-Authority-Analysis: v=2.4 cv=fu7RpV4f c=1 sm=1 tr=0 ts=69a1c935 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=VwQbUJbxAAAA:8 a=sdoS8YJ70VgF2Jk85QkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 bulkscore=10 clxscore=1015 lowpriorityscore=10
 phishscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270148

Add support for using RWF_DONTCACHE with block devices and other
buffer_head-based I/O.

Dropbehind pruning needs to be done in non-IRQ context, but block
devices complete writeback in IRQ context. To fix this, we first defer
dropbehind completion initiated from IRQ context by scheduling a work
item to process a per-CPU batch of folios.

Then, add a block_write_begin_iocb() variant that threads the kiocb
through for RWF_DONTCACHE I/Os.

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
   1         993.9          1799.6
   2         992.8          1693.8
   3         923.4          2565.9
   4        1013.5          3917.3
   5        1557.9          2438.2
   6        2363.4          1844.3
   7        1447.9          2048.6
   8         899.4          1951.7
   9        1246.8          1756.1
  10        1139.0          1665.6
  11        1089.7          1707.7
  12        1270.4          1736.5
  13        1244.0          1756.3
  14        1389.7          1566.2
----  ------------  --------------
 avg        1258.0          2005.4  (+59%)

==== WRITES (/dev/nvme0n1p3) =====
 sec   normal MB/s  dontcache MB/s
----  ------------  --------------
   1        2396.1          9670.6
   2        8444.8          9391.5
   3         770.8          9400.8
   4          61.5          9565.9
   5        7701.0          8832.6
   6        8634.3          9912.9
   7         469.2          9835.4
   8        8588.5          9587.2
   9        8602.2          9334.8
  10         591.1          8678.8
  11        8528.7          3847.0
----  ------------  --------------
 avg        4981.7          8914.3  (+79%)

---
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
Tal Zussman (2):
      filemap: defer dropbehind invalidation from IRQ context
      block: enable RWF_DONTCACHE for block devices

 block/fops.c                |   5 +-
 fs/buffer.c                 |  19 ++++++-
 include/linux/buffer_head.h |   3 +
 include/linux/pagemap.h     |   1 +
 mm/filemap.c                | 130 +++++++++++++++++++++++++++++++++++++++++---
 mm/page_alloc.c             |   1 +
 6 files changed, 145 insertions(+), 14 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260218-blk-dontcache-338133dd045e

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

