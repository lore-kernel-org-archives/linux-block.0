Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253693EEAEF
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103285; cv=none; b=i2GTYC+KBnxyeift7YQszux2+7V8GSGsM5DwyujfxfUi5Cnz4fMDm2vrPGeW66HiU/KXptoihxWepkCrx9AQyuSF89JEeuVR/BLEcW21+MLZN5cr6N+dQUEky2ULNhSGU7yON5UtATvAs1QFLNL2enIi7GvNIs9zKFPO+zV3PTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103285; c=relaxed/simple;
	bh=vpqF2wsjpDekTjyXB8OhTC5nc9ODzZN9cAbZ0mIUUn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ku/fOHGuaaEfUZvDXnvOwc8Kak94dUxf+8omEqmqvkIaJk49wsd3ugy/mPmZh4I0rO3QdHbT3h6uaCSwM3PPdgKpNvueeGt9cqAlSJ3d6lWVyYOfuEVd70k8yuy2PtntbTxfpGvWFar8AsGKqoNTMJ5CHdldBBfeQXJ2WEWlVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoXHVqKN; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoXHVqKN"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so1710801eec.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792103283; x=1792708083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KBh6utbT9VXAJmle0MXKCsj9AJ6G5GAVRjk69ReJRuE=;
        b=UoXHVqKNuwTzuYJ9WlPsYTcIBnyZacyLbonGXtNgddkWcxM53Epw6RtMkYJd4zRs0h
         9qC+caufG28REaGfWMIBSPfu9foP8A/o/n77ByLKfqFpaya4Px/SM3vDGFBHVy6tShpF
         70wK2LNrbbhfQw+PU5GZOY897wBjjA9cW8cSxhDy5jbQbi2kZqPN08guIAVlQ1hqYCNV
         rRHfpec3x72sN8AiY7aXFA3N+DHSHbLF5/kpVfwTNAx7lfA9kw3f50onI1hRe35oDANX
         RUZm5OU1erGdPJ8JHOQ4z1/XjtBgMY1lSQKDo4guG1Aa8IObXSV3xTck0lEogWtfChKe
         L6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103283; x=1792708083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KBh6utbT9VXAJmle0MXKCsj9AJ6G5GAVRjk69ReJRuE=;
        b=NGXUR4dINca0K+08GotOLuyfT+XGGXRLV6q78lj5cCSk0MB87m+6IhxyGmVMTyvijt
         7mqnNQrNEpNWgbpWjHYzJlzYJ8Zw0E6kaTNVHBa0hzq9TNLZgEv41mwO60zlkU08lvOC
         U0lGHsxovHd8DnTFkDhY6LNAgZ084Y7fYbPsJnEndBgMv8ur9BlMLvAWITmQm8KftMdl
         huSRJWoFdS1HueOpWxQ/5CJzY65vkiv4dGDWinP5QtACx/e80uolgzEXSvbFF8Ap3oCv
         r3tBVguVXVGIAlP4w68MD0MmnElZsjG9OVJDIYc1nGA2kF5k19q37sM5NvxgHuoZyL4j
         WILg==
X-Forwarded-Encrypted: i=1; AKwUvBx0h5iyYDFS1xvrIlw1uKc/koJ5kf0Panvi16Ud2R+vIs9P+Z+BsoR8e+dBU0zKIkVXy0cTUX6bG7QWrQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK3iwJNwg7ISHnoa/uSd6A5oioiac7gSeED1lvVa2SG99ZqI3aM
	OUW+HmzPOebFvZbHyhp50J5M/qpGEdj2Bpl8/1P4j99DGdlgCXlEBezo
X-Gm-Gg: AYBFou2kxQafVGYDv9VREXks/gKaxamXzeLVlUQj7fDv+369K4OFreByxnUmb67hssa
	ExKJoxJsdsg+go5qeXsmljmmBUyAFza94XytiaALaT0CAzUD1U4szu44iAl+jyIjn5Sm+ysjVhT
	x/RHZfE+rLTW+JVYKK0/WCcVfGoltxtqTpsYmRgjkV6CBEUReQy0ivJtqIMa89iQimDayTJw3n4
	lRhcngoygBUxiK8IIwPDORHsi03jA7g1FnNOHARL8tVugRNfFuJqwDZFKtFdSyAB/OSNNzd2S+J
	BjzrnGIL/dAxSOwqC4bes8rK3uaVQe+irml4GI+NsRtFU4dNsJxQ32pjYOKyETuId2/tD5f3j9T
	iPN030XPAzLExgUp2wp3I2Pnkjr/E6Mm8P9+W2HGbElJx2tJ6mh3xMkw22MhqvekNxB213yBG1O
	Uw1d+RESK+mIcGZMvQzb+0BggmowcoF913wsoLXrJbcOyemRn1TgWag1cWGf0//bFDCiT3DTbJg
	3kLM1/JrOlXqLBpfVrYh57F4WVeLBVcaWNScEPCaf773ifftQdXg5VNQf8A/2cS4uWZvIgYxY8=
X-Received: by 2002:a05:7301:4b09:b0:351:2958:1740 with SMTP id 5a478bee46e88-3537e088bf1mr27576078eec.37.1792103282862;
        Thu, 15 Oct 2026 15:28:02 -0700 (PDT)
Received: from yibos-mbp.3500.dhcp.asu.edu ([2620:d8:8000:8078:404b:acf5:562d:50f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081fa5a6esm873307eec.16.2026.10.15.15.28.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 15:28:02 -0700 (PDT)
From: Yibo Liu <yiboliume@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Liu <yiboliume@gmail.com>
Subject: [PATCH 1/2] drbd: reject data replies whose size does not match the request
Date: Thu, 15 Oct 2026 15:27:59 -0700
Message-Id: <20261015222800.85928-2-yiboliume@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261015222800.85928-1-yiboliume@gmail.com>
References: <20261015222800.85928-1-yiboliume@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A node that reads from its peer (it has no local disk, the area is not
up to date locally, or read-balancing chose the peer) sends a
P_DATA_REQUEST for req->i.size bytes, and recv_dless_read() copies the
matching P_DATA_REPLY into the original bio. Commit bd910a7660d2
("drbd: reject data replies with an out-of-range payload size") rejects
a negative payload size, but a reply that is shorter or longer than the
request is still accepted.

A shorter reply only fills the start of the bio. data_size still drops
to zero in the copy loop, so the final D_ASSERT() does not fire, and
the read completes successfully although the rest of the caller's
buffer was never written. With a proxy that cut one reply down to
1 KiB, a 4 KiB O_DIRECT read returned 4096 with the last 3 KiB of the
buffer unchanged and nothing in the kernel log. A longer reply leaves
the excess in the socket, where it is parsed as the next packet header.

A correct peer always replies with exactly the requested size. Reject
any other size, as is already done for negative sizes.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yibo Liu <yiboliume@gmail.com>
---

Notes:
    - Reproduced on block-7.3 (41cab3a71dc7) in an arm64 virtme-ng guest,
      with two DRBD 8.4 resources connected over loopback through a proxy
      that rewrites packets. A diskless Primary read 4 KiB with O_DIRECT
      while the proxy cut the P_DATA_REPLY to 1 KiB of data. Before: read()
      returned 4096, the last 3072 bytes of the buffer were never written,
      and nothing was logged. After: "Invalid data reply size 1024, expected
      4096", the connection is dropped and the read fails with -EIO.
      Unmodified 4 KiB reads succeed before and after. The harness is
      available on request.
    - recv_dless_read() in LINBIT's DRBD 9 tree, which the pending DRBD 9
      rework series is based on, has the same check, so the series probably
      needs this change too. I have not checked the posted series itself.

 drivers/block/drbd/drbd_receiver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a8..97b306676626 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1810,8 +1810,9 @@ static int recv_dless_read(struct drbd_peer_device *peer_device, struct drbd_req
 		data_size -= digest_size;
 	}
 
-	if (data_size < 0) {
-		drbd_err(peer_device, "Invalid data reply size\n");
+	if (data_size < 0 || data_size != req->i.size) {
+		drbd_err(peer_device, "Invalid data reply size %d, expected %u\n",
+			 data_size, req->i.size);
 		return -EIO;
 	}
 
-- 
2.39.5 (Apple Git-154)

