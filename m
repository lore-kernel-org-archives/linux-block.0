Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D0873463
	for <linux-block@vger.kernel.org>; Sun, 17 May 2026 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778996211; cv=none; b=gUz5vIrRlqi6Q5wLfPfPiIMvU8ST+H29EkSyAfMv1/4qUBFrC+VIZ1DASQjNOMa46YBr1YtghBZp+7ZPOzK1hUGsfcRU+odhYKVmQnkHtyuZ66y7I81Tn73YXIJJSAfpYPE3Q+JFs7T7NzisWKqVlEs7rdjSTCA9kBaCs8NH3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778996211; c=relaxed/simple;
	bh=afjwGEe2oEassWdXpr0gGPe/aGW7hgJc7rpQoXMPtS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+UP9BgH9bIu1S1k/t7v6/HLrwUJGBVcEhkztWCMCC+z6bE98NEihuiswqHke/9BhSY6KoSAVdwa6vqig587haC5WwbuJbTV5PsjMnz7Zo6UpuTo3odNbwKGyy16VUM5hg9wCGG+wKSbC94JZQvRE/GDZ6jlMU9wltuRg4ilKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAqlmN+X; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAqlmN+X"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-95d3492fb1eso776939241.3
        for <linux-block@vger.kernel.org>; Sat, 16 May 2026 22:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778996209; x=1779601009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0E7jjUk3MC5+CVl+LevXCEF8IwXtzIWnXoqor7xZUmU=;
        b=dAqlmN+XkNvqY/ThgJGau9bnj9nK4hdjSyprmyXgwhVd/rjHdLjpKH5Dkvrzt4Fssi
         8EvpDE9j/GstX2bluPQV0KNo+kd3Wp7jFK3gEJ4gabrxNL/pwXvJLqHrbGE2CPz30vfg
         oKotwxwKXcK4trzD/hUJl4QZod6hyZ7ZTARA9XzJKVXpRNIL7ise9YMwmxVwkaJl36GQ
         5+lO+sb6vn1Iv6dSxsxFQqCzBRuGVOp3EpGpMGO1LtkPMwsvcnQenwqdTaoNHkNQNCO6
         +hlkC9W5WQvQJFmQMMKyFJsNhzE/VdwFDticD71fnEKHAEACyLIWI7Z7oprcbLVg8o/e
         jyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778996209; x=1779601009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0E7jjUk3MC5+CVl+LevXCEF8IwXtzIWnXoqor7xZUmU=;
        b=s4VsqLcnNGcxRD+gpgTojve/xRAZGdqf5IxrVXbX46F7L4S8hLV6WPezEpLdAsYHzG
         CjBaWMJ7z32/gBV9csX84Eidn1kAyj2X0OaXEpd2DF9IqvtTEDT+nsdp2FPB2X7RCLRd
         GXZRapy8vBc00jOGMdXrUiAWJprY6ydLKzlBBETIoQnO5bL2EK0uBcXt8XCOal0MJy+N
         YglyP9L55gsjmKjbz8U+eumOafbz6yf60A+kDjuWKPEErlvK7SJfRxVvLkngdcFadVir
         BAc2CztSn9ZbvlQ//8DNt3qFMpFD1z+/S4M1OLM0NN/L65oJed7jC6NoEPuauDU/3uQP
         QcdQ==
X-Gm-Message-State: AOJu0YzCNB/QjcW6dSeJ3aofTRtNJwkRfn6oKsQJsIjH5sbLu9rpPj/G
	vjQjATB2pm9Nl82xSg2peI9TuStDu6jQk74O6AxC266sBSp7UIsK9439
X-Gm-Gg: Acq92OGX1h5jBoAAtzZLLMX2kDRlaPCaX7J9LWCC3MHHiGcX3eE9U82LO8PswXbz+5j
	3+MwvtxC+MPbZDkqHgaGxl4+GYYlwNfQcQiDoS+p2ISHjgoXnasbR66xAQeXcgfCi5rOxBcx2kj
	xAMk8tAn0fAqn0+b37ELo9VyCnnfsUDPRWETWpendlj1/vbnsMA6hgOY8cKAJvlSA56oZjV79l/
	kXmiaMPJGcev0I/JF5/ZxO8SJidiNdaKqhszxYRvEIM5TkGJ2Ge/YnPEYzO5ns3HpwXiNMV4e/s
	IZ9uPzIV7tXzZoU5j+gmC6LMwoHwHHjzWOfoyzGyn8Shroh0RLgPL8Es7iMSMkBDUFD6K/Hco0G
	Ua+W56lqOyg53ChB4pUN9XXna/2FsQBpkraLLCCGHWf89zNtE9k/ipcbp/CpHUnMKRQ/10HunSS
	zImvMzDJsPzoR09Eb10y1AWMGywWT47QsCkJnZUIuNTA==
X-Received: by 2002:a05:6102:3053:b0:633:7d88:c77d with SMTP id ada2fe7eead31-63a3fe9f462mr5371583137.29.1778996209295;
        Sat, 16 May 2026 22:36:49 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2c99f63sm3347932241.1.2026.05.16.22.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 22:36:48 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	iam@sung-woo.kim,
	daveti@purdue.edu,
	weizhu@fiu.edu,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH v2] nvme: don't WARN on I/O to a namespace revalidated to unusable metadata
Date: Sun, 17 May 2026 01:36:35 -0400
Message-ID: <20260517053635.2282446-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_setup_rw() fires WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)) for a
namespace with head->ms != 0 but no PI and no REQ_INTEGRITY.  This
occurs when Identify Namespace reports flbas META_EXT, lbaf[].ms != 0
and dps == 0: on PCIe nvme_configure_metadata() sets EXT_LBAS without
METADATA_SUPPORTED, nvme_init_integrity() registers no profile, and
capacity is forced to 0.  It is the host-unaware geometry change Keith
described -- an out-of-band format on a shared namespace, or a
non-compliant device seen on rescan -- not the host's own Format NVM,
which freezes first.

The freeze in nvme_update_ns_info_block() is not defeated; the WARN
just does not depend on q->limits.  It depends on ns->head->ms (read
live at dispatch, set inside the freeze window) and on REQ_INTEGRITY,
never set for this geometry.  capacity == 0 only gates submission
(bio_check_eod()), not dispatch: a writeback bio that passed
bio_check_eod() under the old capacity sits on the task plug holding
no q_usage_counter reference and is flushed by blk_finish_plug() after
the update committed head->ms != 0 (dmesg confirms: the capacity-change
line prints before the WARN).

The I/O is already rejected correctly (BLK_STS_NOTSUPP, capacity 0).
The assertion fires on a device-reachable, already-handled condition
-- a panic under panic_on_warn -- and its premise does not hold:
metadata without PI or a registrable profile is a legitimate, unusable
state.  Add that explicit case and emit one dev_warn_once() instead.
Fully fencing already-submitted bios over a revalidation is larger,
TP-level work and is out of scope here.

Tested: built on linux-kcov-debug (6.19.0+, KASAN); boot-tested under
FEMU, 4x dd + 500 rescans, no splat; reject path verified by code
inspection.

Found by FuzzNvme (Syzkaller with FEMU fuzzing framework).

Link: https://lore.kernel.org/linux-nvme/20260427003457.1264511-1-coshi036@gmail.com/
Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
v2: drop 2/2 (faking an integrity profile); supersede 1/2 with an
    explicit unusable-metadata case + one dev_warn_once() instead of
    downgrading the WARN; rewrite the log with the requested mechanism.
RFC v1: https://lore.kernel.org/linux-nvme/20260427003457.1264511-1-coshi036@gmail.com/

 drivers/nvme/host/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d1711ef59fb8..32ccb56c4aaf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1039,8 +1039,23 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
+			/*
+			 * A namespace with metadata but neither PI nor a block
+			 * layer integrity profile is unusable: nvme_init_integrity()
+			 * registers no profile, blk_get_integrity() is NULL, no bio
+			 * ever gets REQ_INTEGRITY, and the capacity is forced to 0.
+			 * A bio that passed bio_check_eod() under the old capacity
+			 * and was batched on a plug before the namespace revalidated
+			 * can still be dispatched here afterwards.  Reject it; this
+			 * is the expected terminal handling of I/O to a namespace
+			 * that revalidated to an unusable geometry, not a bug.
+			 */
+			if (!nvme_ns_has_pi(ns->head)) {
+				dev_warn_once(ns->ctrl->device,
+					"%s: I/O to namespace with metadata but no usable integrity profile (ms=%u), rejecting\n",
+					ns->disk->disk_name, ns->head->ms);
 				return BLK_STS_NOTSUPP;
+			}
 			control |= NVME_RW_PRINFO_PRACT;
 			nvme_set_ref_tag(ns, cmnd, req);
 		}
-- 
2.43.0

