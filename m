Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48D1DC98F
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650526; cv=none; b=dQdTQX7aQe9x2vr6HO0+F/Lbq6O8IrUqaU8vTlSv/5bSbW5M79o1j/prHZrAlTRb0tS+xUe8hPgdW3L6Z5umDQKGjz3G3lCakoAsrLxOEz/jZfSEvkHb37IKhjJBe2zaEfKz6yHWYwsUWfXKbldpHcyuh8X+T6mpQyVkRD/4ftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650526; c=relaxed/simple;
	bh=muCQWCd0NyaN9lzTxO1cYuDLNEQU/qkLc6MeBwfn3BY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8am2DN0kXUjzv5PTUgAsThZOSJzO7BWhvsWHNPIHIAlt8WkC0xy+ouIuNCnRSdwcCAF5jtu0MJG5VmPcXYW1mZ5Ceo0G5bxglprQpGFAkdNsjNG5gkrbcobFqirxSN82TQUCMtNhkdh7Y3Psh10Vj3wtACUOEflA9VVFStpQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJEhRfOC; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJEhRfOC"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92b21f65b60so95648885a.1
        for <linux-block@vger.kernel.org>; Thu, 09 Jul 2026 19:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650524; x=1784255324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CD7fKokB6Ry/YluPNrNMvEuHGABwEEMEw0f7mAKVksY=;
        b=AJEhRfOCfW3rAg9vU5Jrxd32SdlDvneC6K8AMLXe4h858lgk5uGTffMnaGDVRpX5DC
         KViMEozMM6+e1wjz7fIZFz8uQH8Gi2n8DB100mgGHZUkpwA7eWg57+/ILXFNpt5PuYj/
         +f7sMocY/obev4gFn5ZAjwMcZfGnwkLdvRk49izCNMs4cEfJnt89Bvv5w4/itv23tC0p
         hlIMaY+sBceqdDZQdIsw03FTB574bz6pDcwp2sHauQ5R8xHK+fydTTOfDdMZFT7uXLJV
         hCZzSTQ9MroRO/8yWc2521BGIIuJagzzhfYOVmyIIpkPOBzZhqREEfe+qTSdnpF5HvqN
         gCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650524; x=1784255324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CD7fKokB6Ry/YluPNrNMvEuHGABwEEMEw0f7mAKVksY=;
        b=n/ogi4pF9PMgOUt7e2JfiQrp6BWrjM0GWaEa64xYn5XudlFAMjv8qnM9XJ+SiA6xnv
         w8d8QdnlYCaNJB11CtT1MGIZ3wFrECWzcvkKcgTTWy2OyyrMs0cbyxS6w7MJRUDxxk3N
         W6EWFt0HMu/3dqcQp+czox/x/zrOStcYgr+rf0Mlzo3WIJHuCWS/dkK4T4Txdk9wAoDE
         GXz9p1XXydkD9jft303HvK2S+rzgwryZZoXAlJ9HBnP56LPTix7cBuA/InMy5N2vv38m
         BYVX6rTJpsrZFDIOzWtIucZ3jz9ZkMk255zpsgVzrcbrxUtw4Hkxw1c+E08dOsHWThh0
         klMQ==
X-Forwarded-Encrypted: i=1; AHgh+RruUBPm4t/BpkU2CuNjLeLgPj9v2h3mn9rcHltRgKW1QsdFcFKbXZ+53dQK8AfcGq7S9TooCs+iqxlPPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfp1ZYz+ur4NZL+6mpNJPmcMSZsjnQxG6JEC7NanNkycVEJaG
	9ssXpO7tkhZOE3DcOoantqDcEOtqohxt/gHCuPPzyAHnTyAApzOw62Esg3jB7mIRl0g=
X-Gm-Gg: AfdE7ckhkI/FjumgTB1R9cyCP4xaf4DM10w/2dzl1lheXHKYZIt2QKggpp0lZRl2JNE
	rgpXhVmZGfMp1ZZmiFjHSugPwRcud7xkQ5oWVWyrtkIhbx5w5Vmq2VnlokkZYlCdZBn9Vh0L0oD
	Js2Mk6NfaHMrWI85gyroV2Xu1FYpJSWNxlG/PmJ/YB3CPbXHU9PZ0Vz8xLU2AmIl0+LgmRDNSP3
	qWb7IhjWGFgf3WHwpBAqS1NucEuosqb/QcE/u9ZueXaaz9zg5/RXNHraMbA3+GU9Za7eQINxECW
	ICmsSvwBuevYCMX8jbHYk4DUgZIYvDV5isjWj5R512dtoB4pJwcntyHzV/Nt5/Cd7xCmY/llEL3
	hC6YqkesSXNdkWDxpBAIC1mwh8m3HtaGuJH9SK5vajasBdTq85OSqvG2mhYMn6suG7mAeyAhDFT
	N4DwUgh7n41HZI+bnIilGxo+UnVn4EqT+dLEbZ12+INqDieUgS1Ck3XNxTYkxtW1JMbIhM+iZ/8
	9IxbN2up6SXXMFsblDi3Hm7ZeKu43BO
X-Received: by 2002:a05:620a:280a:b0:92e:5232:91f8 with SMTP id af79cd13be357-92ee4d396c2mr204617685a.43.1783650524232;
        Thu, 09 Jul 2026 19:28:44 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4920asm89455085a.4.2026.07.09.19.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:28:43 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph Boehmwalder <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drbd: reject data replies with an out-of-range payload size
Date: Thu,  9 Jul 2026 22:28:37 -0400
Message-ID: <20260710022837.3738461-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

recv_dless_read() receives a P_DATA_REPLY from a peer into the bio of an
outstanding read request. The peer-supplied payload length reaches it as
the signed int data_size, and two peer-controlled inputs can make it
negative. With a negotiated data-integrity-alg the digest length is
subtracted first, so a reply whose payload is smaller than the digest
underflows data_size. With no integrity algorithm (the default) data_size
is assigned from the unsigned h95/h100 wire length and drbdd() never
bounds it for a payload-carrying command, so a length above INT_MAX casts
it negative; this path needs no non-default feature. The bio receive loop
then computes expect = min_t(int, data_size, bv_len), which is negative,
and drbd_recv_all_warn(mapped, expect) receives with a size_t of SIZE_MAX
into the first mapped page.

The sibling receive path read_in_block() is not affected: it uses an
unsigned size and rejects it against DRBD_MAX_BIO_SIZE before receiving.
Reject a data reply whose size is negative after the optional digest
subtraction, covering both triggers.

Impact: a malicious or man-in-the-middle DRBD peer copies attacker-chosen
bytes past a bio page in the receiver, corrupting kernel memory. A node
that reads from its peer (a diskless node, or read-balancing to the peer)
is exposed in the default configuration; data-integrity-alg is not
required.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Notes:

 - Reproduced on mainline f5459048c38a in a virtme-ng KASAN guest driving
   the real receiver over a loopback DRBD 8.4 connection with a
   man-in-the-middle proxy. Both triggers were confirmed before/after:
   (1) with data-integrity-alg=sha256, a P_DATA_REPLY one byte shorter
   than the digest; (2) with NO integrity algorithm (default), a
   P_DATA_REPLY whose h100 length is rewritten above INT_MAX. Stock
   panics with "KASAN: use-after-free in _copy_to_iter" from
   receive_DataReply (data_size seen as -1 and -1073741848 respectively);
   the patched build rejects both with -EIO and no KASAN. A benign read
   control (unmodified replies up to 128 KiB) passes on both stock and
   patched. The harness is available on request.
 - The sibling receive path read_in_block() is not affected: it uses an
   unsigned size and rejects it against DRBD_MAX_BIO_SIZE before
   receiving.
 - The pending "drbd: rework receiver for DRBD 9 transport and
   multi-peer protocol" series keeps the same unguarded subtraction and
   signed size in recv_dless_read(), so this check needs to be carried
   there too.

 drivers/block/drbd/drbd_receiver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 58b95bf4bdca6..2135c14354a85 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1810,6 +1810,11 @@ static int recv_dless_read(struct drbd_peer_device *peer_device, struct drbd_req
 		data_size -= digest_size;
 	}
 
+	if (data_size < 0) {
+		drbd_err(peer_device, "Invalid data reply size\n");
+		return -EIO;
+	}
+
 	/* optimistically update recv_cnt.  if receiving fails below,
 	 * we disconnect anyways, and counters will be reset. */
 	peer_device->device->recv_cnt += data_size>>9;
-- 
2.53.0

