Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C64A092E
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301586; cv=none; b=NkzS3jkyl8YVK8hQnZJkToOIJMcWtWLlAwIYpRwgd75RTqP/zTX3VnxeigoLQRSakZn9uccNHKWi1UBunczxZhlHPFlpBOF34T2Vu1M7rsFQ/G1SIKLK1W16N2MUXR9HUjEXPA1yo3kOiVBLXpLp9G84uiN0DMKcbJQhrZzo7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301586; c=relaxed/simple;
	bh=oFnOs2XmOIVf+yWnXPvpmM4ppyaTfAn1Cs+9vcHtN8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiJoIzlzAi2a0xzaWd3kwubsdi2khRp4yUnqbusKz/7RO9CftU5rB9FwkZimoJTfrC0V1UfOzWOVoFHwM2dBG//SayYefb4E+8E7rh+cJRpLdRVwHxx54emPpM9BHmxnEx5hRbP3ePKYVLq/9j1pDbsckgqZXivTyigHxyTX9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=FSys7cZs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="FSys7cZs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so29484425e9.1
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301583; x=1791906383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wu57GiQ9p/e4dvrsEubQVsdeq6KyA/NRez7ZJzCadG8=;
        b=FSys7cZskfoRZKpZ+7Q1/Vnt7jfZ2l8ZecosxrPA0mth24QH56IAnnrJQa1r3IVoJI
         4Iq3h8ylfhF6YoWXD/USDkcMc6pqYtdCpXbdXDw2tOhuQPt1EKqViiJF++xEbvlQcUsS
         +KMagw+0diB1iiV+4Rm/YEooGve4XMB8BK0WRQuCARpbNC26ni5N0uZfQZJdKETiQvFv
         qql3+ycwwLFL1TrWROSGE/8GztMD9sX+n7p2OENzO9zTHU21xNMUzWtNQzzMtWaCMOzt
         8cNvaNyrWmfoIlg4W87i591YT4rwJ/x9UoRo9X1lV4PM5d+vSJdwWijh1xw06p5DZrCJ
         wkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301583; x=1791906383;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wu57GiQ9p/e4dvrsEubQVsdeq6KyA/NRez7ZJzCadG8=;
        b=O8cTVJGIZiGNduDOnp6kugT8c5ufY4ZAIzP0cGfF0x+uVgxsXkrDf/d6I8QzVvjIQf
         38tke78AifHi+JpnarCm+l4vABI5QgtsuhRPw/7joDJGLT/rF7KtEeGGcaS2hqz/RG9u
         BFlFzsK/VZ3rTwK4UUBntGeFOSHwLXN9/494rBBaAGwRbHcel2xQmMMtyVeed137V/QE
         +BpgYaOpaKhw314zZqLMLb8xXdpQhG2UCc0nseXL4/kPwt5c1rr/PLzsaP7zYGT4ySgf
         u0aoXl43vQgpV/bdIrzEv4FERhj+7GWJLyk/jxOMz6ewMOxWUOAPDGD2DY+gKWKePMgJ
         2oRQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5q/+Uv93X/HIwtuBnMnRcG8ol7ql0ZSL47M99yOpZkYqGRAHZ51pZ+lKPIFVqSo7zutOe+QkaEegehQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kth6eGy049EF/70O4oV/AFmCWCCO5sFbj2P7TmAXf76gOTJTlU
	thHodjsjenKiO9FEB7zbu5vthAzrgSWmVt5UIxCKqdZls+Ylrb3UP07OSXY9AozZ4xA=
X-Gm-Gg: AYBFou0aqmEJYlB6RbYrACb05lX6XJ8DIxcNhZaznaAIJ0yJ/YoYx/hJO+C6awvDG0b
	HqiSXSdMA1BUXBQm4lcn0bsYojhaVFm6YCG8upwf2ua4mDw+cydPzmzRvpH6Ek3p3m+CV75oCGo
	EYw30rdiE5LT3MR63IXkaMti1TKxn/VbkLsSJ2hCHCA68OfkV+4FcdDy1ZAJJiDI1DwVBn0LBjn
	SGiGjzFJmckVRf487PXE09AAtxnd5mfsc6/xly1EbEPZuwtONhYs4rQC9FiRKkBmPpyhm47+2NY
	Bs6qiDK/acDWZAkDuEwK9cSJ25J6eG0dhPa/C9A6GQOSkaIX3hr1PZmvHvsKVmsC2QCA8yeP1vY
	0IR19KiVM9rBP24frWWW2TkauSUJ6sV5XgZoaDkeq+jX9R3kdC9mZ/AfGr4KrW++0E1fagLy/Ah
	WqWx3D1XMbEVigpz48CuyFxSGfoBhMCm1rtCx9ng5WD7mE10MLwjUTSZWQrKWsjF5nYHgBBe9i5
	WYvmKuMmI1NHsPc9DmmiXZpqE3JEWtgKmJWSkhyKj4=
X-Received: by 2002:a05:600c:3ba0:b0:4a0:236c:8601 with SMTP id 5b1f17b1804b1-4a17b4b6c82mr31553505e9.0.1791301582541;
        Tue, 06 Oct 2026 08:46:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:46:21 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 03/20] drbd: introduce DRBD 9 on-disk metadata format
Date: Tue,  6 Oct 2026 17:45:50 +0200
Message-ID: <20261006154607.3936501-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
References: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new header that captures the DRBD 9 on-disk metadata layout,
enabling state tracking for multiple peers.
It includes the per-device superblock and per-peer slot structures
needed to track bitmap UUIDs and sync state for each peer.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_meta_data.h | 154 ++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 drivers/block/drbd/drbd_meta_data.h

diff --git a/drivers/block/drbd/drbd_meta_data.h b/drivers/block/drbd/drbd_meta_data.h
new file mode 100644
index 000000000000..8f36731025e4
--- /dev/null
+++ b/drivers/block/drbd/drbd_meta_data.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DRBD_META_DATA_H
+#define DRBD_META_DATA_H
+
+#ifdef __KERNEL__
+#define be_u64 __be64
+#define be_u32 __be32
+#define be_s32 __be32
+#define be_u16 __be16
+#else
+#define be_u64 struct { uint64_t be; }
+#define be_u32 struct { uint32_t be; }
+#define be_s32 struct { int32_t be; }
+#define be_u16 struct { uint16_t be; }
+#endif
+
+/* how I came up with this magic?
+ * base64 decode "actlog==" ;)
+ */
+#define DRBD_AL_MAGIC 0x69cb65a2
+
+#define BM_BLOCK_SHIFT_4k	12			 /* 4k per bit */
+#define BM_BLOCK_SHIFT_MIN	BM_BLOCK_SHIFT_4k
+#define BM_BLOCK_SHIFT_MAX	20
+#define BM_BLOCK_SIZE_4k	4096
+#define BM_BLOCK_SIZE_MIN	(1<<BM_BLOCK_SHIFT_MIN)
+#define BM_BLOCK_SIZE_MAX	(1<<BM_BLOCK_SHIFT_MAX)
+
+struct peer_dev_md_on_disk_9 {
+	be_u64 bitmap_uuid;
+	be_u64 bitmap_dagtag;
+	be_u32 flags;
+	be_s32 bitmap_index;
+	be_u32 reserved_u32[2];
+} __packed;
+
+struct meta_data_on_disk_9 {
+	be_u64 effective_size;    /* last agreed size */
+	be_u64 current_uuid;
+	be_u64 members;		/* only if MDF_HAVE_MEMBERS_MASK is in the flags */
+	/* Feature flags. Values prefixed with "DRBD_MDFF".
+	 * Separate from "flags": Unknown features bits are cleared; unknown flags bits are kept.
+	 */
+	be_u64 features;
+	be_u64 reserved_u64[2];   /* to have the magic at the same position as in v07, and v08 */
+	be_u64 device_uuid;
+	be_u32 flags;             /* MDF */
+	be_u32 magic;
+	be_u32 md_size_sect;
+	be_u32 al_offset;         /* offset to this block */
+	be_u32 al_nr_extents;     /* important for restoring the AL */
+	be_u32 bm_offset;         /* offset to the bitmap, from here */
+	be_u32 bm_bytes_per_bit;  /* BM_BLOCK_SIZE */
+	be_u32 la_peer_max_bio_size;   /* last peer max_bio_size */
+	be_u32 bm_max_peers;
+	be_s32 node_id;
+
+	/* see al_tr_number_to_on_disk_sector() */
+	be_u32 al_stripes;
+	be_u32 al_stripe_size_4k;
+
+	be_u32 reserved_u32[2];
+
+	struct peer_dev_md_on_disk_9 peers[DRBD_PEERS_MAX];
+	be_u64 history_uuids[HISTORY_UUIDS];
+
+	unsigned char padding_start[0];
+	unsigned char padding_end[0] __attribute__((aligned(4096)));
+} __packed;
+
+/* Attention, these two are defined in drbd_int.h as well! */
+#define AL_UPDATES_PER_TRANSACTION 64
+#define AL_CONTEXT_PER_TRANSACTION 919
+
+enum al_transaction_types {
+	AL_TR_UPDATE = 0,
+	AL_TR_INITIALIZED = 0xffff
+};
+/* all fields on disc in big endian */
+struct __packed al_transaction_on_disk {
+	/* don't we all like magic */
+	be_u32	magic;
+
+	/* to identify the most recent transaction block
+	 * in the on disk ring buffer
+	 */
+	be_u32	tr_number;
+
+	/* checksum on the full 4k block, with this field set to 0. */
+	be_u32	crc32c;
+
+	/* type of transaction, special transaction types like:
+	 * purge-all, set-all-idle, set-all-active, ... to-be-defined
+	 * see also enum al_transaction_types
+	 */
+	be_u16	transaction_type;
+
+	/* we currently allow only a few thousand extents,
+	 * so 16bit will be enough for the slot number.
+	 */
+
+	/* how many updates in this transaction */
+	be_u16	n_updates;
+
+	/* maximum slot number, "al-extents" in drbd.conf speak.
+	 * Having this in each transaction should make reconfiguration
+	 * of that parameter easier.
+	 */
+	be_u16	context_size;
+
+	/* slot number the context starts with */
+	be_u16	context_start_slot_nr;
+
+	/* Some reserved bytes.  Expected usage is a 64bit counter of
+	 * sectors-written since device creation, and other data generation tag
+	 * supporting usage
+	 */
+	be_u32	__reserved[4];
+
+	/* --- 36 byte used --- */
+
+	/* Reserve space for up to AL_UPDATES_PER_TRANSACTION changes
+	 * in one transaction, then use the remaining byte in the 4k block for
+	 * context information.  "Flexible" number of updates per transaction
+	 * does not help, as we have to account for the case when all update
+	 * slots are used anyways, so it would only complicate code without
+	 * additional benefit.
+	 */
+	be_u16	update_slot_nr[AL_UPDATES_PER_TRANSACTION];
+
+	/* but the extent number is 32bit, which at an extent size of 4 MiB
+	 * allows to cover device sizes of up to 2**54 Byte (16 PiB)
+	 */
+	be_u32	update_extent_nr[AL_UPDATES_PER_TRANSACTION];
+
+	/* --- 420 bytes used (36 + 64*6) --- */
+
+	/* 4096 - 420 = 3676 = 919 * 4 */
+	be_u32	context[AL_CONTEXT_PER_TRANSACTION];
+};
+
+#define DRBD_AL_PMEM_MAGIC 0x6aa667a6 /* "al==pmem" */
+
+struct __packed al_on_pmem {
+	be_u32 magic;
+	be_u32 slots[];
+};
+
+#undef be_u64
+#undef be_u32
+#undef be_s32
+#undef be_u16
+
+#endif
-- 
2.55.0

