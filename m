Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC240DFAB
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777250117; cv=none; b=CH9DI19/m48LitkHksPEVmYhKhXDlbxfPGqn1nVwTTBx6BLyk2b+O71QywBq4L4fbNjAc1cDhtONQH7my9iyfCavoXvBkCNNL0O4+NC4BD6EZRO6hM8cePLtzWZyixljIkkJGwnOr1jzQzemJJTrAkPXzrQLIvkuALqBakfG6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777250117; c=relaxed/simple;
	bh=fCvHW7fWCd3Kq2gMA1wDd2US2P2TT4ia9wrBjyDLH3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMgcx6uInzo2MpvVn3KFOZadvHjqXMAQVjp28SFqK2RfPriqPHhRypV/5nlxYlji5qDo28I05rRg0xdY++vxNPh76uco9XXUyDZAWYFvOq/Ru5PrFMMvfStYsI49nkbKARgXT4h8EraWH28AZK34wEBwR/iYfN+pN+ZXaikPqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVRfMTIe; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVRfMTIe"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56eee0ba462so5883741e0c.1
        for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 17:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777250115; x=1777854915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hlYyxAHFErN0O8bIJbsJS4BCeC/JRIpc/oeR+h/cS4M=;
        b=SVRfMTIe2g/u3EKUL2I42sjO9S+gHeCv9d/OLKLQD/tgG1YXtOVzypRYKr38LpvGTW
         Wo2qd+lf73nXMvInrfjlcAKLWZ3uV5KA6f2ex8l/O6o4bmOV31+Efr6nnXQ4PwJ1WbIa
         rFKOB0cqrmGfNDD8IJz+rzpUhlQLZpMsfAeYDSxRcDSKkvl5aV4WAuchbNXUY5J+1sMF
         2gFrsFFi5N401W+qrVIjJhgQLNoAuNup5OhQD+a9j1IQXC9Z9Fh9Vs44INeACSNdeQ3Q
         qof+LDpsPt+cICE7PARfbEzpOLPuaNOghm2WtWgCDGNhDskbo1+pi2tAzh6riXAVHuR3
         1tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777250115; x=1777854915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlYyxAHFErN0O8bIJbsJS4BCeC/JRIpc/oeR+h/cS4M=;
        b=F3mPzawNGxMu8d4E/hQhC7RxyBe0i8UfzfOEkr2eVVn0+90rjo3Num/tuMX/kFsr12
         988GfRJF8Ae/E2ghCoSuIDtdM8eI7c5DklIN5GLU0zOrhigUC0NlIBZ2NJ1nm4PB5xKz
         C850ykLbEXojkYTJkq77SqZx0G0R9IkkMczKaSWVy4IdHJbwZyE++J1TLwMWrB/fmBWW
         XVNukx6mR8h7k5ucmlep6jRPg1gcqNg+IgLMz1Cs7/S6rsEnnDhxNrnwFIlCLdukE0m8
         NexlApd0iL/7oHu+4SNeoiDny5QJg3LX5dWDHlAUVXLtNu7/L6X64XFZ2lxKmtflZbEJ
         Spzg==
X-Gm-Message-State: AOJu0YxNYy/qISqzuigKivko9tLiVFGHCkatk3LE1LNEPpfJws+rHitj
	O5g2O9G3CANXQOGCWRuWEqec7HkzkGKJHHS+kB6D0TYkohIC1Wk865AN7uwSgzM3QVo=
X-Gm-Gg: AeBDietMFryeUrWevCczeQRjfy1fV3sFBdaJfRPoVGrm4+vpHlpwuf8n/J9c07sInU1
	vMmVPkbK7ZTuWhZpiQFMuZlHszhNoFRJkdVMaX9zIbrvFrYtOGivWU3+NbwOLv2MUfGRoS4ygV5
	l9BVOG9OXF2TUlEz20ZBsiZpqh4VD02q+Re4XBOvrjahhs7pdCV+60aJTAwSSnDX9xPvofhtQ8z
	/9IMRr6nrV9F2nd5jUTi5SZR/i3QE+7PVY33sG+M2wZmeMj3GEJLpyQFykTn2+yWur6RYESJSlU
	ZftPWfRp7p3nbl6FHRt9Yu1XYSk9wQp0rY5G/m5TZ7z+L4XnpANchVA7jkymYkFyuegSWm3xAKP
	ZK7v0BjKrL1j4TDnT5jDLvRYVQvyzJgyk+yRQm7EXOOEItAtPC9WjnKNGfbcwuJGkocdykjb6Ng
	HHhaT2yIsRJuBz9D8jbvzUgh5fqA+ZtPpYYbd9DAw/Q5QUCkMccozV
X-Received: by 2002:a05:6122:8f87:b0:56b:8ba0:fd58 with SMTP id 71dfb90a1353d-56fa66be43fmr14917079e0c.6.1777250114838;
        Sun, 26 Apr 2026 17:35:14 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa9351ca8sm16854880e0c.18.2026.04.26.17.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:35:13 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
Date: Sun, 26 Apr 2026 20:34:56 -0400
Message-ID: <20260427003457.1264511-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an NVMe namespace is configured with embedded metadata (flbas bit 4
set, NVME_NS_FLBAS_META_EXT) but no Protection Information (dps=0) and
no NVME_NS_METADATA_SUPPORTED, nvme_setup_rw() fires WARN_ON_ONCE on
any request that reaches it with REQ_INTEGRITY unset.  The WARN was
observed repeatedly during NVMe fuzz testing with a FEMU-based fuzzer
that performs semantic mutation of Identify Namespace responses.

The trigger requires three conditions to align: (a) a namespace
transitions through the EXT_LBAS non-PI state (head->ms != 0,
features & NVME_NS_EXT_LBAS, !(features & NVME_NS_METADATA_SUPPORTED)),
(b) nvme_init_integrity() returns false through the early-exit branch
at core.c:1834 without populating bi->metadata_size, leaving the disk
without an integrity profile (blk_get_integrity() returns NULL), and
(c) a request that was admitted to the block layer before the namespace
update reaches nvme_setup_rw() after it.

The admission gap arises in two places.  First, the plug-list flush
path: a process with dirty pages queued in a plug before the namespace
update flushes them on file close (blk_finish_plug -> blk_mq_dispatch
-> nvme_setup_rw), bypassing any capacity-zero gate.  Second, the
cached-rq path: blk_mq_submit_bio() at blk-mq.c:3155 may find a cached
request; if so, the bio_queue_enter() freeze-serialization guard at
blk-mq.c:3174-3176 is skipped and the bio is dispatched immediately.

In both cases the bio was submitted without REQ_INTEGRITY (because
blk_get_integrity() returned NULL at dispatch time, so
bio_integrity_action() returned 0 and bio_integrity_prep() was not
called), and it reaches nvme_setup_rw() for a namespace where
head->ms != 0.  The existing BLK_STS_NOTSUPP return correctly handles
this dispatch; the WARN_ON_ONCE is a false positive.

The WARN was reproduced six times over four days of fuzzing (April
2026).  A representative crash shows the plug-flush path:

  nvme0n1: detected capacity change from 2097152 to 0
  WARNING: drivers/nvme/host/core.c:1042 at nvme_setup_rw+0x768/0xfd0
  PID: 785 (systemd-udevd)
  Call Trace:
   nvme_setup_cmd / nvme_queue_rq / blk_mq_dispatch_rq_list
   blk_mq_flush_plug_list / blk_finish_plug / blkdev_writepages
   sync_blockdev / bdev_release / __fput / sys_close

Replace WARN_ON_ONCE with pr_debug_ratelimited so the condition is
logged at debug level without splat.  The BLK_STS_NOTSUPP return is
preserved; I/O to the transitioning namespace is still rejected.

An alternative approach that addresses the root cause at the
integrity-profile level is proposed in patch 2/2: populate
bi->metadata_size for EXT_LBAS non-PI namespaces in nvme_init_integrity()
so that bio_integrity_action() returns non-zero, bio_integrity_prep()
sets REQ_INTEGRITY, and nvme_setup_rw() never reaches this branch.
Both patches are sent as RFC for maintainer guidance on the preferred
direction.

Tested: Compiled on linux-kcov-debug (6.19.0+, KASAN/DEBUG_LIST).
Boot-tested under FEMU with NVME_MALICIOUS_RESPONDER=1
NVME_SEMANTIC_DATA_MUTATOR=1; ran 4 concurrent dd processes plus 500
rescan_controller cycles.  No WARN, BUG, or Oops observed.

Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 drivers/nvme/host/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d1711ef59fb..4e20c8f08e4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1039,8 +1039,12 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
+			if (!nvme_ns_has_pi(ns->head)) {
+				pr_debug_ratelimited("nvme: %s: metadata (ms=%u) without PI or integrity request, returning NOTSUPP\n",
+						     ns->disk->disk_name,
+						     ns->head->ms);
 				return BLK_STS_NOTSUPP;
+			}
 			control |= NVME_RW_PRINFO_PRACT;
 			nvme_set_ref_tag(ns, cmnd, req);
 		}
-- 
2.43.0

