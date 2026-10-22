Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792711278;
	b=LZX6s5JUJLGgbwNrpOhvjdpg37eZ3C7dwTO6YhjimVOeMCcstI7WYYx6EA0/lsadGFsg
	 pnAS6F7PDJd1LEhTWVMBapdtHOE48wrhkmZjvLdD3U7p+68h4wnKzTM9VFIWL20dOb3LO
	 wPWicSyw2KESiXD+ksvlV6ntIf++MtBIxtnWZ7Mp463Klw2e9cR7CA293Qwek3vQPFs4N
	 KuZnAXb4TyK9ZB/AxOAT7cX7u43COKuid5+iPf/2q/GgYqgshEkrfEVeAydGfxrgbDIpw
	 g37Yt9ipDWkoxLSOi9htDI0n7M043yGUOeFt40p0yUQ86DaSMHaLFl5LQO7KQK0LA/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=rtnM1iSGxbLqH9+CwwNDUl2JT44AtoAZO7zKVDfXHNU=;
	b=vPrn1IErU6WA+aulaz20H+5eb3pL2kilc40sIXk7kgU8/b0bQHF0UDm8GwmGppe4OM8s
	 KwcxlKUwm52HvW553VpSI7oMroSTkMf7ucICeCj7LkQbUEjGlf+/bcJI8lSrGMxIQPm3v
	 6q287vdAlOcEY+n4PeOLcGTmuvzWAi37gA4hA6SKmQw5vveIaj9kWmkVEODi8bGg78bdp
	 jAkWPKyzNi8f0UeHH9q/xLyzlNLn3qsXaNDWDWkhyNGdVVPjkyOamjydoG2rqU4mKVzHZ
	 o3yxs6B+fR36XuiRBp+kOtPoqSLKDF7MaJ2uQJJgXo7rk+EC3Gv7nzsIqDZrvC6w4BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="H0Eb24/g";
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922F606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 23:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4922F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=H0Eb24/g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a21053899aso1685725e9.3
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792711277; x=1793316077; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rtnM1iSGxbLqH9+CwwNDUl2JT44AtoAZO7zKVDfXHNU=;
        b=H0Eb24/gm6K93J+ew8VUudC7sy7EMXENiMXElOaUvy1J0YJsW9PQJL3f28WscjwlZZ
         4AW3GrSoD743iTzIGWLzQUc4hGTs2EI8mjASk1QzV0+zNnXciju2140a4aBunrP7jnko
         ajNfQmsjhev5FMYCH8TILvQPxkAXvnlMnIXQEmnDInSvROdBmpeVWpiDPjN7TTXwgPVq
         JwRAGYDTCqPIlIHNk3h2s+t3JcoIRkv9I+RqzpQ4+Nd0zjUdMp9/I0obgcYhxreBs/UB
         d6Sxi9LyRNm1jZsvmMuhWJ4KNUE4Po0PIS6zZODSoIJ4vjwjw0/49N06Of8xWNy75Y5e
         Rsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792711277; x=1793316077;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtnM1iSGxbLqH9+CwwNDUl2JT44AtoAZO7zKVDfXHNU=;
        b=ZY1s0kZE47dczN7v37mSexzVmPAX8gjXC7RrLKhz0a6sdToPefotob4iDh+Vp3WNwT
         7QxTkJlE8kW34O+1JTIWHTDSwNgeSmxlT3WiH1+Byd2IJevxN25S7e02HGwXjBvXOYq5
         tjg0/OiJG7iFCQq/PWW5aC3z1FnrojZXXa/zw2UxePJTWXybgu4MXww/tJGoq06q41OM
         X8NDsi1h8lufj/PDeTLeGEAHL2PdhDUGCSCCwUft5yxBkcOKo9coJHQdNgb6CWTXlhGm
         3oZ/QLPlKHmTAMZzkyml83myajGUoxDyJi/rX1hCEEPQ03vSWPUsLNIRyTn+ClUd3YZK
         Wi6Q==
X-Gm-Message-State: AFq9FYL3I+o3CQmgDGsgFkU/O1RXHkzK265bsSVk4jryGvOpuqGnEVVJ
	IRf2SF8hd3bIRLjshDAULL+fXUjpRzvRySaxiWo3K8OGXCQledEcNf9K0XeUyemgI1dTEFLixg=
	=
X-Received: from wmcq10.prod.google.com ([2002:a05:600c:c10a:b0:4a2:14b1:1f8a])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:e555:10b0:4a1:f377:5c6c
 with SMTP id 5b1f17b1804b1-4a211edfc66mr4801815e9.10.1792711276477; Thu, 22
 Oct 2026 16:21:16 -0700 (PDT)
Date: Fri, 23 Oct 2026 01:21:14 +0200
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022232114.2535802-1-dmnk@google.com>
Subject: [PATCH] loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()
From: Dominik Maier <dmnk@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

In 64-bit lo_ioctl(), commit 7035b5df3c07 ("loop: cleanup set_status
interface") added a check requiring (mode & FMODE_WRITE) ||
capable(CAP_SYS_ADMIN) (now BLK_OPEN_WRITE) before allowing
LOOP_SET_STATUS or LOOP_SET_STATUS64, but the corresponding check was
omitted from 32-bit lo_compat_ioctl().

As a result, on kernels with CONFIG_COMPAT=y, an unprivileged process
holding a read-only (O_RDONLY) file descriptor to an active /dev/loopN
device can issue a 32-bit compat LOOP_SET_STATUS ioctl to modify
lo_offset, clear lo_sizelimit to 0 (exposing backing-file data past the
configured limit), or alter lo_flags.

Enforce the same (mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN) check
on LOOP_SET_STATUS in lo_compat_ioctl().

Fixes: 7035b5df3c07 ("loop: cleanup set_status interface")
Assisted-by: ARTIST LLM
Signed-off-by: Dominik Maier <dmnk@google.com>
---
 drivers/block/loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..f15a5cae5c63 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1708,8 +1708,10 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = loop_set_status_compat(lo,
-			     (const struct compat_loop_info __user *)arg);
+		err = -EPERM;
+		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
+			err = loop_set_status_compat(lo,
+				(const struct compat_loop_info __user *)arg);
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_compat(lo,
-- 
2.56.0.218.g1ec904b173-goog

