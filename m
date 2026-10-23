Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769819;
	b=YBUhiLSw59ZMaX/3lL9XFfluC366y3qw8cx2B3y84DMUFwRbSXgLt1034b9ALcRsYslv
	 YvQ4sa4Qzou599bQNgtDJZrfqQdlLrK5U4ZkS7InGRHmzvje5Dv1NN5/kmw3SF+4QovKZ
	 UFVc/qQuh7OgFwToC2t2gJ+HwftAVSlUlIidLjLehCWl3baEvGU0uu5kO1gTLTKZCa8rV
	 httc3hSY0bZOOM74EUdgkoQkfj1hi8EQ1LH7DblBuA2qSVjIEfebpTEcw30tnzBuUj4Mv
	 cKyDjwJ03WmyUWK9s6DkRNQ75EusnZSbRqOtQcr2LyDtl/wvXkPkOK0FNZz+iFmTclw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4A2LFgNU3Vz3Cd1QkL+GF0Kwq7uWsh+K0kLA3UVTqQQ=;
	b=j+grpfLfQJrhzBmneegZSP8oUUWlP4AdRtb3jzW28FD2hBD+mZ2A4xbGfEjPd+dQjzra
	 MwtUHHCposcmhwgYtnYf7fdRFfvOgNYlN36DgFsBxJdtCwdXqn3WDk43Zfr+fQScIheGP
	 nhpcCRnBvQkqJFDjIDBsSLD61/m1owDHZZJ72feIvBHx3++MZKwIJZDxH1gNjLLteP2FD
	 WtZ11CQMDqTnjDQRt73ZZAgKc/Ql3kEE3DucejVfTQkYJLT8AFneMHiFEesKTXnrAYKsd
	 Ux1wY4ww8HFezBB1UWbPfMYvNMD/kgMlaPEH5mpNQWoQcGW+pq7VMyQsSHXy/0huesg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dKlS8bo9;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84F606A31B
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 15:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD84F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dKlS8bo9
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35cd538de29so420883eec.1
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792769818; x=1793374618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4A2LFgNU3Vz3Cd1QkL+GF0Kwq7uWsh+K0kLA3UVTqQQ=;
        b=dKlS8bo9/2SQaE++bG0l1jBEF+5W6CiLhS8Ya0X6QcdG0+OSjkFSQ7ZTnJQXuOmJmF
         tjcgfjLM6gLXRBj5n4OprkwBA0JBeUCVf+bC4rd4mtVKRE5nIYBd8QvASikib7ifIimc
         ptp9ilY8xK2i0VUg/lkTIj4KD6iQT/NQsNfz9Bpf68eNgrc3VjOeTjrTQAMf1Uu358XP
         dhWArzP4dcdOJHKBixaxNr6NMhO2px9+IaGxtdZhQdZIbAoYmTz46hzbwGczviTk1pNI
         RDn0g206v4cwxuEKfEVs/HGTWXgA+vn2/7reiKIiV7ZffEB0bLda/7QcmfXRcAcNZXYQ
         x/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792769818; x=1793374618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4A2LFgNU3Vz3Cd1QkL+GF0Kwq7uWsh+K0kLA3UVTqQQ=;
        b=2lacnShNrSPZZFZ5zkeVB8KcR8JYCR541cE5MXH/r2dXkHvTRXrwMDExM09Kjc3mX0
         ZzchH7DjXXwSCOk7Kb4bAaQQxo0Ub22CrIp+gp+WHQFenNGeSS7/Mdl3Y8CzKXNgPjOB
         2dzseyjv/4BkevcOgrwbqS9gmeNf74h+xhCUPAA9466uGHpYFfvAoFnva5W8Om/aV4FK
         ZiqKjjchChj2TdY8o3JRU2JsWgOVWSmTgkNv8kR9bUpF1IWVQuKTWK+MIlj3JNs0mG/v
         LuWlJ+Jr3JpKTUekbin5LyTNX8rPLgNnrLVb41JUWPfb+X19rkv4+TuiPzVvPRmgfe7h
         kIsg==
X-Forwarded-Encrypted: i=1; AKwUvByRIxFc6h+1MrxjOSqGeDmfJU6BLvdRFAN8cVayoJJPERpHxIKuvnyr7ff4e3BUJ4PkwsyNA7mVpqMLGg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJeBsiU9GkAUXBNpRj9biXRl1FPTvENWShX56VZSka3fXy07zu+
	hqWnDg772VDWVPU3Xpy/jr1W+05HvvmgdDzhFGpzTtoos6wLUkSjZ7oq
X-Gm-Gg: AYBFou3f9sYNwAjk2q0FsTyCyNm9adFe634tohm/jsF2h0IY3SpYPgSAzeX8rkb0tGT
	3zsT0f0DcHTHPuYBRfAmkWF3wvAyqOsVKTi3ufVGdcZlLzvixlA3LRLevgpfGT/+rSi8zegtjsF
	d8Qh8LQovhfE7kPzGc6ZF9+pTzljksqdqNXP3/lfWD00qmYOkj8hKC5RJHq6AtdVfrIJ2c3wufH
	0n1dicXvBORE1uBMcccK8s/KiChrocff7rK9ykAuQmZ+rUxqkzHRv8waWRHXPV+lu5rSEdTLyxN
	KELZ1X7dveodqBtwx2FBVSeyj26o1YtgoRwUIR8x9w9dbumgut3cd8CsezkHm2Hh9yRdjdr/KZk
	8OuqtaRj7yqx4t1ktKXUEMWBkcrFVZ6gkxA84gnfLFUvt47fSgKrQZDujrhmTqnTQXHT4AEdX7p
	D0Z5d6efuzo4z8pOLYGeCWKyGJXb0sFWTT75j54sQ0OE9sW2Iw+vrz/5wR2vvqskIXtSdAbrx1C
	+9tFRNVgBTFHcy1idMMq+c/h9sfSKIL30hZP13+1PJf073ifbaalq7B1WriPPT9gHARcInaNhol
	6nngqydTWmzNup1IXZj7JBdEY6oI
X-Received: by 2002:a05:693c:88cd:20b0:35c:cd26:3066 with SMTP id 5a478bee46e88-369d985fbc3mr3119669eec.41.1792769817438;
        Fri, 23 Oct 2026 08:36:57 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e6e4e81asm432485eec.17.2026.10.23.08.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:36:56 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: axboe@kernel.dk
Cc: arnd@arndb.de,
	ben.hutchings@codethink.co.uk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] block: Return the soft block size for compat BLKBSZGET
Date: Fri, 23 Oct 2026 15:36:45 +0000
Message-ID: <20261023153645.37546-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

BLKBSZGET returns the block device's soft block size, while BLKSSZGET
returns its logical sector size. The compat BLKBSZGET_32 handler uses
bdev_logical_block_size(), so it returns the wrong value when these
sizes differ.

For example, on an x86_64 kernel a native query of a RAM or loop device
with 512-byte logical sectors returns the initial soft block size of
4096 bytes, but an i386 process gets 512 bytes. This makes 32-bit
blockdev --getbsz and the BSZ column of --report disagree with native
queries, even without a preceding BLKBSZSET.

Use block_size() as the native handler and the pre-regression compat
handler do, and correct the case comment to describe the soft size.

Fixes: 9b81648cb5e3 ("compat_ioctl: simplify up block/ioctl.c")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 block/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 64b4e6c0f696..fb2f4b4d2505 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -835,8 +835,8 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		return compat_put_ulong(argp, bdev_nr_sectors(bdev));
 
 	/* The data is compatible, but the command number is different */
-	case BLKBSZGET_32: /* get the logical block size (cf. BLKSSZGET) */
-		return put_int(argp, bdev_logical_block_size(bdev));
+	case BLKBSZGET_32: /* get the soft block size (cf. BLKSSZGET) */
+		return put_int(argp, block_size(bdev));
 	case BLKBSZSET_32:
 		return blkdev_bszset(file, mode, argp);
 	case BLKGETSIZE64_32:

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.43.0

