Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFAB3B7778
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394781; cv=none; b=sCVm9zICFjpNNCC1NReKjg/ZN0qKtocUr8iZCWSVa3Y9/pi984LMkrOS1mB6QG3tQuPjlcHbZHAIKViMGxSmaiBp5V2UgXb96+5KBf66d5N0nVXoDKWGAzHSH+QA9v4WnTaHa1OtdjGYI4uldalWNcnA7HHtoK8BXVV3n9Vh3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394781; c=relaxed/simple;
	bh=aWu7BOn5GohnRYxURL3oAHwZ5cHf4aE4kBCU34sAm1s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UE6Fwj42/5Y0Je6BQdzeNOtUrKmEUdAy3b+xzgDA4Jh++v7eXzfRnJEN+/SJqOQOmLT5vSSWH7kv3cbDs3N57cE0PRyMMK/46YV35Z9lJ/BokU5IX434NWf4JGXHnauvIr9YnzcLyMh1IaueSfSsDFf1jKEwEV2y1c5KILz4Gbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=uU43ShrF; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="uU43ShrF"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6YBtx1887860
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=Nh80I+Q86ue/QvLYmdk7AAI26t
	QVa9m2Msk1A1FG0Nk=; b=uU43ShrFazA4tvr8sWy125pCBFiKOZ35wt17opAAE0
	5SUrElN5h7WWWLjaV4SQZkx24E1fUMmGTHchhcxUxi4i0bnkNUsFtEyHp5foc8Vq
	3+VnDFkCOg9ZWqf6DYg6xofJQSoqwHxnSyL9gx9SH29q+1fUY2Ivro+YGZw72ysx
	aoIrqk0Yg1tj85VK7ZDmme9UoZ4WAPoJbugj3l4KZaMVZjqdKvwiwe93N3Ih7leb
	GFP/7LsDyPgdgyg/f8ktUSx6QX1xKOFvz1UcRz5y/RY4Cw9ohquoaYEl22Gau2eD
	RJU1lP7zJUUr++Aaq2xRf1eI6/rA0XmyLQatnu06z2dg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fqud416q8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:24 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e5e38fbc5so210323885a.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394738; x=1785999538;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nh80I+Q86ue/QvLYmdk7AAI26tQVa9m2Msk1A1FG0Nk=;
        b=B8mL5QxsS3yWu3xCqprOisw9Gev2hSNq6ByRcFfbkVdDXNUS3sspg1g/SD1yYDON2W
         kbyvHjEKo2zZ+fgWkXy1d5yj815DFasxLNCe8SioxUlnEtavoh/tMCzpsoBpH02SHrvO
         BSw4asXX4dfFHebmJpeQNzlIKwOk7JWAEnXhIakjr2f+U63ew1nneJXHGozEzWY8ryWt
         WZodFMOqc3mlhdFZzMbrF/N+WJot4IA0UbUBFfBpWhUFtUwKNQbrZj6cffEqnmNSIqmv
         qUk24NHvjeaslZsImGyUcSgASz6S7raf/deyRHXVKjDhnLuB8E+Uha6QyMvwmrWg/k9f
         MRGw==
X-Forwarded-Encrypted: i=1; AHgh+Rq+jHXFHr7kFC7CjfVvzH4ULA/iP9Wjdr1JdD1T6rlpviV0Aj660+LyIyajhlinuwEpB3Wsl0xE3oGO/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXuJ6yu4aIrMmmwuN55DUDoy/7KViQYjZ9GaXNjFdpwjgsr06
	hR0Th5MY59FQ0xuXAm50hEicox7VEG3mnvoqb8kS7k9CFf4ykFihiN/9LwB963IFy7hW4xq3l5S
	i8e6QEojlArpkx+W2u8GeXKSggxLlN7FBJC7yZbTxVX8Io6/3KjbnSqHTA92C
X-Gm-Gg: AR+sD11YyHP6vIV0KNxMYT+ODKHBGmQJnKCod2a2nbaicxtuvAQYu+mBNIKHWbXmFYc
	H3X9sn8+qVOa4xMpUMdsG+fZLnMuRfe1UnTd/10wvW2k2957B1zNvUQw8sJqF2iiEA3K+gVPWCe
	r8vQDaFYiiWjNN2WeIvqz9sRoj8/+yA/Sk7fiH3ilxF370kLxcmCSMvxOG2n24lx4NHBYSC1LSC
	Eo1ErzBu6CR4ZWSjnTOdTeLDz29yDmcuDoCtf3PcpXD90Rap2jFsbzZ32IvdiYMDslio6HOqBVI
	v1vVozMJCb8zN2EBAhQxvktubnJIze3dj3atvpefi/g05aJxMqkKoGFp0tFNY5OMqx+nkgt9dza
	kCVehlId+ogh32mUZ2PxO1jwfM//HWGVi49XalaG8/f+/Vg==
X-Received: by 2002:a05:620a:470f:b0:92e:6c8a:2a1a with SMTP id af79cd13be357-93485f8799dmr141187385a.7.1785394737599;
        Wed, 29 Jul 2026 23:58:57 -0700 (PDT)
X-Received: by 2002:a05:620a:470f:b0:92e:6c8a:2a1a with SMTP id af79cd13be357-93485f8799dmr141184485a.7.1785394736887;
        Wed, 29 Jul 2026 23:58:56 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221bc7sm349752485a.7.2026.07.29.23.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:58:56 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v7 0/5] block: enable RWF_DONTCACHE for block devices
Date: Thu, 30 Jul 2026 02:57:50 -0400
Message-Id: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO71amoC/3XQy27CMBAF0F9BXtdobI8fdNX/qLrwY9xYpUmVQ
 FSE8u84bIJCWN6R7tHoXtlAfaGBve+urKexDKVra7BvOxYb334TL6lmJkEakMLxcPzhqWtP0ce
 GuFJOKJUSoCZWO3895fJ/9z6/am7KcOr6y50fxXx9JY2CC559MsZqylbkj9gdz7+h+D2lM5uxU
 T4AUq8ByYFbIOsj1j64DUA9AnYNqArEpOAQY9LObAG4AOr5A5wBDNqkgCob3AD0AiA8baArABk
 cRAn+YLY2MAugBa4BM2/gJMnsLVobVsA0TTdQ43q58gEAAA==
X-Change-ID: 20260218-blk-dontcache-338133dd045e
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Tal Zussman <tz2294@columbia.edu>, Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394735; l=8495;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=aWu7BOn5GohnRYxURL3oAHwZ5cHf4aE4kBCU34sAm1s=;
 b=i7kTq/xKpl6wc2j1Nlg01vDlZMOfxoqdmbN5qS3mBj8WIj2cibNqh2r2fUl9u49JQrAsz/EcW
 GCakIuY/GaWBl034kywR3hYqCwil8RdUzFGTe0/O1kZ1rWNv7dkSFK1
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: uCoaWQPy7Eto_a4GG4DDynj-43BC3DgE
X-Proofpoint-ORIG-GUID: uCoaWQPy7Eto_a4GG4DDynj-43BC3DgE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX6SASNLGIiGSj
 6YozkluFm1YBcn88YlhmLFsU0+VAja3pvKKZCigwmCV7LriQ14bbp506NiqcR/XmBSMUt8OqXim
 wAJPM0r0WSzNqv7u4QO5rG7NBocvcXCG5NfhaoMOnTJwg2glJOz3
X-Authority-Analysis: v=2.4 cv=b4KCJNGx c=1 sm=1 tr=0 ts=6a6af64f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=RwdnMBCSlJgOLVuh71sA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX/W3/4tX6LesC
 PlS05L1IAeuQOb/FvY+L19JCq7m/Q+YSmcAG8jjeCcpvXEozSaYUR64Mx4iRgJimKc6PIXu1viz
 YKc/V8Sy2ZseqruEKNHNV/4nEZ3SO32OSopUb8XqEqcsskIZA4FYGiwhGCaNkPKtYmph9ONem/5
 V9XfGVwIrZnZbniIL+OAREmFFt0IDs898VOoMRhbFC08tzVdOwQnWBZvVGoIQZIXJT7kn9BcmWB
 Wfi74ujb0KXp2gRuuHg7fPLG05JfsD8QTwpgEQrsWzTmcdageSBXUZ/3/fXeZ2oXrVrKRDtfQPo
 OCa37UacOZ/gFsUBU6703gxTmy0ucW5Eoq2cANFuByW8w9J7DgZmH+e/n41lmRjQo8sDR9OZT4P
 pVyUJj8F/M92qNXTGkcdrTW2hgsHIeRlErnprZers+OH2TPBq/XwdWuzS5OMGF+k5tf0UwybVms
 a9pNYlHh6lwtbEooVWA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=10 suspectscore=0 spamscore=0
 lowpriorityscore=10 adultscore=0 bulkscore=10 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300048

Add support for using RWF_DONTCACHE with block devices.

Dropbehind pruning needs to be done in non-IRQ context, but block
devices complete writeback in IRQ context. To fix this, we defer
dropbehind invalidation to task context. Add infrastructure that lets
bi_end_io callbacks run from a worker, in two forms:

  1. BIO_COMPLETE_IN_TASK, a bio flag the submitter sets when it knows
     upfront that the callback needs task context, as in the dropbehind
     writeback paths.

  2. bio_complete_in_task(), a helper that callbacks can invoke from
     bi_end_io() when the decision to defer is dynamic, as in iomap
     fserror reporting.

These queue the bio to a per-CPU list and schedule a per-CPU work item
to run the completions from task context.

Patch 1 moves erofs's atomic context detection into the block layer as
bio_in_atomic() and converts erofs to use it.

Patch 2 adds the block layer task-context completion infrastructure,
with both the flag and the procedural helper. This builds on top of
suggestions by Matthew and Christoph: the procedural helper and
bio_in_atomic() come from Christoph's "bio completion in task
enhancements / experiments" series [1]. The procedural helper is unused
in this series, but has multiple users planned [1][2].

Patch 3 wires BIO_COMPLETE_IN_TASK into iomap writeback for dropbehind
folios, removes IOMAP_IOEND_DONTCACHE, and removes the DONTCACHE
workqueue deferral from XFS.

Patch 4 sets up DONTCACHE support for buffer-head-based I/O by setting
BIO_COMPLETE_IN_TASK in __bh_submit() for the CONFIG_BUFFER_HEAD path.

Patch 5 enables RWF_DONTCACHE for block devices based on the previous
support. This support is useful for databases that operate on raw block
devices, among other userspace applications.

I tested this (with CONFIG_BUFFER_HEAD=y) for reads and writes on a
single block device on a VM, so results may be noisy.

Reads were tested on the root partition with a 45GB range (~2x RAM).
Writes were tested on a disabled swap partition (~1GB) in a memcg of
size 244MB to force reclaim pressure.

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

[1]: https://lore.kernel.org/all/20260409160243.1008358-1-hch@lst.de/
[2]: https://lore.kernel.org/linux-block/20260723145000.116419-1-hch@lst.de/

---
Changes in v7:
- Rebase on v7.2-rc5.
- 1/5: New patch. Move the atomic context detection into the block
  layer as bio_in_atomic() and convert erofs to use it, per Christoph.
- 2/5: Drop the 1-jiffie completion delay and schedule the completion
  work immediately. Use a plain work item instead of delayed_work
  accordingly, per Jan and Christoph.
- 2/5: Drop the local_lock and use local IRQ disabling instead to
  resolve PREEMPT_RT concerns raised by Sashiko.
- 2/5: Drop the need_resched() requeue from the work function loop, per
  Christoph and Hillf.
- 2/5: Use BIO_COMPLETE_IN_TASK as a sentinel in bio_complete_in_task()
  so a callback running from the worker does not re-defer, per Sashiko.
- 2/5: Requeue pending completions when a CPU comes back online, per
  Sashiko.
- 4/5: Check for op_is_write() before deferring to avoid deferring read
  completions, per Sashiko.
- 4/5: Set BIO_COMPLETE_IN_TASK in __bh_submit() for dropbehind write
  bios instead of introducing block_write_begin_iocb() and threading the
  kiocb through buffer_head writeback. This was dead code.
- 5/5: Drop the blkdev_write_begin() conversion accordingly.
- Link to v6: https://lore.kernel.org/r/20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu

Changes in v6:
- Remove RFC tag
- Rebase on v7.1-rc3.
- 1/4: Revert to using a bio_list, per Jens.
- 1/4: Restructure and simplify work function loop.
- 1/4: Expose both the flag and procedural version, in order to allow
  static and dynamic deferral decisions, per conversation with Matthew
  and Christoph at LSFMM.
- 1/4: Use bio_in_atomic() predicate, per Christoph.
- 1/4: Use the CPU hot-unplug protocol from mm/vmstat.c, to take into
  account use of delayed_work.
- 1/4: Mark the workqueue WQ_PERCPU.
- 1/4: Add comments.
- 3/4 and 4/4: Split into two patches, per Christoph.
- 3/4: Drop the cont_write_begin() change. Block devices don't go
  through cont_write_begin(), so it was out of scope and was left over
  from v1.
- Link to v5: https://lore.kernel.org/r/20260408-blk-dontcache-v5-0-0f080c20a96f@columbia.edu

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
Tal Zussman (5):
      block: introduce bio_in_atomic()
      block: add task-context bio completion infrastructure
      iomap: use BIO_COMPLETE_IN_TASK for dropbehind writeback
      buffer: set BIO_COMPLETE_IN_TASK for dropbehind writeback
      block: enable RWF_DONTCACHE for block devices

 block/bio.c               | 132 +++++++++++++++++++++++++++++++++++++++++++++-
 block/fops.c              |   2 +-
 fs/buffer.c               |   3 ++
 fs/erofs/zdata.c          |  11 +---
 fs/iomap/ioend.c          |   5 +-
 fs/xfs/xfs_aops.c         |   4 --
 include/linux/bio.h       |  39 ++++++++++++++
 include/linux/blk_types.h |   1 +
 include/linux/iomap.h     |   5 +-
 9 files changed, 180 insertions(+), 22 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260218-blk-dontcache-338133dd045e

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

