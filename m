Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762F38CFF5
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774651137; cv=none; b=bTdloNdUHoldmWZOkObNCxDrKXjqdunS0Be5z8KJakZrF5P6tfOGn7EhUxOeoowHioHL+UmAKRb9HDbzqCsHHSuhponF7lZYvYDcR5oebHQ/4+Youj9gUhZnbI12HxUGK75OMUbQhssvWOdSpZHVoyGBD7ux1iHS0JkNigIhQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774651137; c=relaxed/simple;
	bh=tWEaLGzALvjbVivZA8s/D6qNeOk1XqPK9YnkDYSyAgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVAIHWvknB7/kUy58QItnwpwSPsgCXdvya3k/+vk5Zy9RgImDL4UE3tp1TwciBNbzzjmiDiX9lyi9Oen7lI3R2jmYMU1wTj8xsV3ci/xS0gtRmYE26Y+EqZNKDUrZ5/Kmg9z6bVMPgRW0GFcHQFxnw4qoQ349qywMnlosJ9Iduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=f9VYsN1J; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="f9VYsN1J"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso2632869f8f.1
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1774651134; x=1775255934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8kGJT+PX/v6FfB6tXPwBVdQICjIFXaurNYHjxAWpMc=;
        b=f9VYsN1JFlWUyOzU68vwMOJ2Mq5TId4Bj/88WzEMWbFaVOzewpozFT7O0MtHdrcqNK
         IkErtciCAHoLgiqCVxoixohu6f7DyidfvpFd6BQGYIYOr21JvYiBHXqwcageCMDLg8yX
         AQP6OIaPws4lC+AkPsRdkL+aaqxEYZLLGha2DK3qefmG9GIfeNJJzTzJLUmAuEN25M9Q
         2GZLz4JTC1uXSUJgfHxzfb62N95xD0vRHXdMRw++5TIyxnABg7BoF86t0+8XaWGNEWUa
         4z4LPoG3SiEm7CwnPaRWuak1Ty+jsbiilkhJWecLsayRlgebc2MlL5aOOFFAXTyCGTxu
         LhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774651134; x=1775255934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8kGJT+PX/v6FfB6tXPwBVdQICjIFXaurNYHjxAWpMc=;
        b=pxWjbLzxHVDS3sIcvKr3MOxR6w2p5L9TD6UfWaBKrE9xFhrhyhORrYcB1p5zJayz9E
         eAN8ZUwibczdDqCwSc5P9erBGRnQxJx/3+xQ1Q68ApoqWn1DTtCNTio86Cj7TYs9HUpW
         Wql/UdwBY7Lp7bsTXM0OditV7GB0h0iWCrLuW5EsZxr/b5IKxvqSLUCsG30lMGBaFePZ
         4lbCf+xle8fFIi3KtZOkZeCb/tpC1nPvqnUZ6f4ESUEqlZNhfyxJvyccYzuLzhDQsK0o
         TbWxxfcWavTCYsSqsxEO4M2y17U3fJzCt7bYYu/Nl+dOQQhwB4f3iFUId+1qk07kNnkI
         spLg==
X-Forwarded-Encrypted: i=1; AJvYcCVzjf9IFpPRdY7GwK+Zfk0M+g8rAZsTaK2HciEXTcpMka8J2vOdmFelbALEKefFY+c82fzK/BsWLDvO7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaccLLXG3ZHH3XPUaPQcoG5oP8uq1wI7FlH6yq8gjMsJzGQRt0
	FVJut2cJDoG2RNp5IGBy/oH+Bb++MwDluK/0xltQmZtNIGhAHP9EwyQrG3BpqcF9zWQ=
X-Gm-Gg: ATEYQzyVj4vUz0khncNj/q3UFAQgNn1LFpCd9q53ODfG6pA+Ev71F0MlYSkgJ4l9OK3
	Eo3rBIzfmeB0EY0hAeSU+vr1xkFlBCqcjK3COy7QV/3NfOjlH2zjP5gU9vNYp7cm77PgaV4V7k5
	KPudNT6GenaAVy/P0QVUsoRyzFgyl2ePWuK3/T5BlQBavRMzgvI8CJ/WTjSDWJLlfAgKW+D1CLK
	VwiEKChuRnZVL4i4v/ZhdEq+wXiJn4aFxwPGd4V4Au6QDsBk1TbpXBwZOe12VNRhvEAWuH7ymbT
	+R29f17+TfXKmIQlZdtvotOlJXXrwcftXmPzvWy9o4ZsUW2PSDfkQ+FEwcb+cObzp+5FOwF+olG
	tcelhWpg46wasUwrpBwMurFggmpuBc71JM6tk6hPixTr6uhytFHo9v9x5WkrufKAj8mPi7ZFllD
	VCgseEFLvN7WY6/5yjYp2MOKQp1qC5VZMlAB0wXx4azbRbb3ZoCrgwBmDiy5os+Q4U4U9CrmZIJ
	bjTESqNpBPxUj4PvB29CHcsx+6hWWqQ
X-Received: by 2002:a05:6000:430e:b0:43b:42e2:f4fc with SMTP id ffacd0b85a97d-43b9ea4a677mr6761038f8f.26.1774651134038;
        Fri, 27 Mar 2026 15:38:54 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247079esm998990f8f.25.2026.03.27.15.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:38:52 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 03/20] drbd: introduce DRBD 9 on-disk metadata format
Date: Fri, 27 Mar 2026 23:38:03 +0100
Message-ID: <20260327223820.2244227-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new header that captures the DRBD 9 on-disk metadata layout,
enabling state tracking for mutiple peers.
It includes the per-device superblock and per-peer slot structures
needed to track bitmap UUIDs and sync state for each peer.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Co-developed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_meta_data.h | 126 ++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 drivers/block/drbd/drbd_meta_data.h

diff --git a/drivers/block/drbd/drbd_meta_data.h b/drivers/block/drbd/drbd_meta_data.h
new file mode 100644
index 000000000000..af77e8d53f02
--- /dev/null
+++ b/drivers/block/drbd/drbd_meta_data.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DRBD_META_DATA_H
+#define DRBD_META_DATA_H
+
+/* how I came up with this magic?
+ * base64 decode "actlog==" ;) */
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
+	__be64 bitmap_uuid;
+	__be64 bitmap_dagtag;
+	__be32 flags;
+	__be32 bitmap_index;
+	__be32 reserved_u32[2];
+} __packed;
+
+struct meta_data_on_disk_9 {
+	__be64 effective_size;    /* last agreed size */
+	__be64 current_uuid;
+	__be64 members;		  /* only if MDF_HAVE_MEMBERS_MASK is in the flags */
+	__be64 reserved_u64[3];   /* to have the magic at the same position as in v07, and v08 */
+	__be64 device_uuid;
+	__be32 flags;             /* MDF */
+	__be32 magic;
+	__be32 md_size_sect;
+	__be32 al_offset;         /* offset to this block */
+	__be32 al_nr_extents;     /* important for restoring the AL */
+	__be32 bm_offset;         /* offset to the bitmap, from here */
+	__be32 bm_bytes_per_bit;  /* BM_BLOCK_SIZE */
+	__be32 la_peer_max_bio_size;   /* last peer max_bio_size */
+	__be32 bm_max_peers;
+	__be32 node_id;
+
+	/* see al_tr_number_to_on_disk_sector() */
+	__be32 al_stripes;
+	__be32 al_stripe_size_4k;
+
+	__be32 reserved_u32[2];
+
+	struct peer_dev_md_on_disk_9 peers[DRBD_PEERS_MAX];
+	__be64 history_uuids[HISTORY_UUIDS];
+
+	unsigned char padding_start[0];
+	unsigned char padding_end[0] __aligned(4096);
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
+	__be32	magic;
+
+	/* to identify the most recent transaction block
+	 * in the on disk ring buffer */
+	__be32	tr_number;
+
+	/* checksum on the full 4k block, with this field set to 0. */
+	__be32	crc32c;
+
+	/* type of transaction, special transaction types like:
+	 * purge-all, set-all-idle, set-all-active, ... to-be-defined
+	 * see also enum al_transaction_types */
+	__be16	transaction_type;
+
+	/* we currently allow only a few thousand extents,
+	 * so 16bit will be enough for the slot number. */
+
+	/* how many updates in this transaction */
+	__be16	n_updates;
+
+	/* maximum slot number, "al-extents" in drbd.conf speak.
+	 * Having this in each transaction should make reconfiguration
+	 * of that parameter easier. */
+	__be16	context_size;
+
+	/* slot number the context starts with */
+	__be16	context_start_slot_nr;
+
+	/* Some reserved bytes.  Expected usage is a 64bit counter of
+	 * sectors-written since device creation, and other data generation tag
+	 * supporting usage */
+	__be32	__reserved[4];
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
+	__be16	update_slot_nr[AL_UPDATES_PER_TRANSACTION];
+
+	/* but the extent number is 32bit, which at an extent size of 4 MiB
+	 * allows to cover device sizes of up to 2**54 Byte (16 PiB) */
+	__be32	update_extent_nr[AL_UPDATES_PER_TRANSACTION];
+
+	/* --- 420 bytes used (36 + 64*6) --- */
+
+	/* 4096 - 420 = 3676 = 919 * 4 */
+	__be32	context[AL_CONTEXT_PER_TRANSACTION];
+};
+
+#define DRBD_AL_PMEM_MAGIC 0x6aa667a6 /* "al==pmem" */
+
+struct __packed al_on_pmem {
+	__be32 magic;
+	__be32 slots[];
+};
+
+#endif
-- 
2.53.0

