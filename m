Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520564;
	b=FvUgLG1o/ljK/AX7WtGUAEzCOplRjSFF6dBDrbcixFHcoCo2kxb7Itr+bcxa2vV0Pa47
	 n5Elz4y1dcV1QsDXITqyA2SCDFRnW39dOoVIJAC+YxgQRhWgvb9mc0sOLbNsOM63FSwSe
	 LTfSlU+XJa9CEhs6wexuaFg3fZrcoC5Qt6I3xvvptoER+64dXOvtDoh1OhfBckJdf6JtT
	 lRp1DQQuXmazNkXxG8xkNA30iuH0pqYscE7kVGgQPynxjCAnzRgGEqbZp/sXsJABz7dau
	 pUDdwBfYo0eH/RhHHMqF2WxJSl6ITZVSUjX11VxkukcmZAUNE1R4+JNezYtITR9stxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QBkELidHnujeG3xBjThPr+adF0FJwgUwsd5WBy30Lkc=;
	b=p8ggt3ZoBsxSo5Yj4AhjbR+Ojx0FH3QZhSZrw/xg1AsJtashAyOG8ewK2BtI8RM14UHA
	 JUdhDA/aB2dAM5zVHea9MM78D5RGpbt5GI2BXdY3ANZ9P/2OGLLl9bYjeubIJ5zThNqvg
	 LiPOXk6e1ZrKe2s/w5kb6GEd14kx0OJJTBTK7ieykOywQl+Cun6rkLORZT0pCLGumvfow
	 owsoZUyhZvwUBJbpU9f6rtFLpSO2F+7j8jcTr3rmQk0P1as8I5z1RyVy0thkAFFlix05o
	 YPNJL1hikwYCDguxaqPRyXzhuaxd2Bj5qz7hiUx39l3VJS0iuyphCibuH68y1iAgiMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UCiKwgE1;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B0606A329
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 18:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C33B0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UCiKwgE1
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514b90bb89so9736888eec.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520563; x=1793125363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBkELidHnujeG3xBjThPr+adF0FJwgUwsd5WBy30Lkc=;
        b=UCiKwgE1munICdPucccsS61rgAr8sNDaXJOSU/TLALuS9a1Dr23yGosoCSNij4gb5N
         aMItYkFB9I8uAu5e5l+qi7ilgNrv+u4c8WgoXeTS2GplpXRa/KlRUxzGg2cl+GEGAuEe
         pfHXIe5HE5dtKMBixNO6bpP/CdhGjFqSW0Wg29BHp8X704DryyV1PnCKszt4YDmpZyLS
         IbIz4GjiQxwRTdUwFuZbSaEv5et6adr71xuAb+NOjTVvvCgAgMwK5hFVWtP/4DHYs+xd
         Ydjy65sfKvXYuJcbyZ+TmlK+G44mejeyiWB5i58vYOXiJSAyxZ6YImS5hyFm8+g5Mew/
         DPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520563; x=1793125363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBkELidHnujeG3xBjThPr+adF0FJwgUwsd5WBy30Lkc=;
        b=tPN0hMi6ByPVZutyPwOJR8Ib6+d+LlIFLSxfQdLaKdFHGgI5LdqX+aqbkVOfnW+M1P
         j7hN5Wy9LjFUI+c73lFfAO/RXlTunqLreYXd7nh7jfRkk3+XDDyGzLLKnVcKbBFgqEqA
         qkhqbN+iulV9O+CDFstOBhmUuZE/422KSaKF6UPvYQnRflwcl9C1iS8n5+JjWTb/ybUS
         u0VVknOn3H/z1CetCkZ6Gh2qoA8MVmwDcBfUww9hCK7ez8x68Uc96hiiXzwso3e7Y/yA
         aXzm5hIJiXAgkKRPSPinwsxfzB1RR6lWv8Wz3U+ELZVTTsVvkmeAh9SDQZhoV5s3lRPr
         wZiA==
X-Forwarded-Encrypted: i=1; AKwUvByHq+qgiTN9crgP8BC/8I6iPnOrZwi9QiheGpnJTaHreETfj8rk9rp/k/In7Ks0286R/QpYBaTFYt1PBw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI6mHAsEfbdYMTO6yiog7u/6cFlr+3uCarXnKOWCQpnkwupBN6P
	dDCUOoB7r/a18CL1TmdzbflC1kEvE5El8t9UxVmBNDsIMTwQUKKiclFW
X-Gm-Gg: AYBFou2RzfkuQLLJx599Yt7WZOV7cGQrrSU50R02+0hxbs/gev25GWR/F8OLJu6TjJ3
	Qu49GMPfi+2Nxfss5gxOGqo2KixjmCtJNL8EifmS+Wy7ZZ5kbNea4hfrn7hjwuOZ396S44xwEzj
	unrWxP4BZWSWVbJccLMvUtWXUkfOrNterjWmbM1TFt1UEyIS+3WR0orkyI/VajZPNtH8NQcHFWV
	8i8mij8Dd1VF7fxUn9XpQoK903a3g7HI0yP28M+pcP9RF6wliGCxPcJwEc/RIODytgGB4O5osr6
	D91P0lLBg42JwdzF81ODstlETDL7P2qDNLVRKdFFwMdjhm0sGtvbecDzc+/OB1eonYLHVmEYSll
	h0F94BEPqaqf/t1OrBvE+tt5twogxPl3lEW997UvUnjT9ns5OjHH54mlYgu09p0LdGQ5hkLLkpG
	g+r6eyyQMSVObjHXUbHHrBC0/e6kIvEK6RVNNKKSyGNEMnZy3o95E9qj4OAN9QNkHRW3WXeOsuU
	lPzjoMXVoQ1xNj2SNC9n/UyP013g5AbN6K09LWr4T/E1jTWomQvNYs=
X-Received: by 2002:a05:693c:65cc:b0:367:23b6:94e1 with SMTP id 5a478bee46e88-3674e25bf5cmr71459eec.41.1792520562401;
        Tue, 20 Oct 2026 11:22:42 -0700 (PDT)
Received: from localhost.localdomain ([206.206.192.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc8439sm402866eec.11.2026.10.20.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:22:41 -0700 (PDT)
From: Yibo Liu <yiboliume@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+0845f49852fd568f@bugs.sh,
	Yibo Liu <yiboliume@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drbd: validate digest size in checksum resync and verify requests
Date: Tue, 20 Oct 2026 18:22:00 +0000
Message-Id: <20261020182200.236875-1-yiboliume@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

receive_DataRequest() sizes the digest buffer of P_CSUM_RS_REQUEST and
P_OV_REPLY packets from the length the peer puts in the packet header,
without checking it against the digest size of the negotiated csums-alg
or verify-alg. w_e_end_csum_rs_req() and w_e_end_ov_reply() later
memcmp() crypto_shash_digestsize() bytes of that buffer; the D_ASSERT()
on the size only logs a message.

A peer that sends a shorter digest thus causes a slab-out-of-bounds read
in the worker, and a peer that declares a huge length makes the receiver
attempt an oversized kmalloc() that triggers a page allocator warning.

  BUG: KASAN: slab-out-of-bounds in memcmp (lib/string.c:676)
  Read of size 8 at addr ff11000007b9d630 by task drbd_w_r0/601
  Call Trace:
   memcmp (lib/string.c:676)
   w_e_end_csum_rs_req (drivers/block/drbd/drbd_worker.c:1182)
   drbd_worker (drivers/block/drbd/drbd_worker.c:2189)
   drbd_thread_setup (drivers/block/drbd/drbd_main.c:314)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

  Allocated by task 605:
   __kmalloc_noprof (mm/slub.c:5439)
   receive_DataRequest (drivers/block/drbd/drbd_receiver.c:2715)
   drbd_receiver (drivers/block/drbd/drbd_receiver.c:5371)
   drbd_thread_setup (drivers/block/drbd/drbd_main.c:314)
   kthread (kernel/kthread.c:436)

Reject the packet and drop the connection unless the declared digest
length matches the digest size of the corresponding transform, or if
no such transform is configured.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Reported-by: co+0845f49852fd568f@bugs.sh
Signed-off-by: Yibo Liu <yiboliume@gmail.com>
---
Changes in v2:
- Drop patch 1/2 (P_DATA_REPLY size check); this is now a single patch.
- Check the digest length only in receive_DataRequest(), before the
  buffer is allocated, and leave drbd_worker.c unchanged: with the exact
  size enforced on receive, the sizes compared in the worker always match.

v1: https://lore.kernel.org/all/20261015222800.85928-1-yiboliume@gmail.com/

 drivers/block/drbd/drbd_receiver.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a8..d45c4e68f83b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2711,7 +2711,17 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		break;
 
 	case P_OV_REPLY:
-	case P_CSUM_RS_REQUEST:
+	case P_CSUM_RS_REQUEST: {
+		struct crypto_shash *tfm = pi->cmd == P_CSUM_RS_REQUEST ?
+			peer_device->connection->csums_tfm :
+			peer_device->connection->verify_tfm;
+
+		if (!tfm || pi->size != crypto_shash_digestsize(tfm)) {
+			drbd_err(device, "%s: unexpected digest size %u\n",
+				 cmdname(pi->cmd), pi->size);
+			goto out_free_e;
+		}
+
 		di = kmalloc(sizeof(*di) + pi->size, GFP_NOIO);
 		if (!di)
 			goto out_free_e;
@@ -2742,6 +2752,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 			goto submit_for_resync;
 		}
 		break;
+	}
 
 	case P_OV_REQUEST:
 		if (device->ov_start_sector == ~(sector_t)0 &&

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.34.1

