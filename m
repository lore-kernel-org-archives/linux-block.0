Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205886;
	b=ZbG8tloOSPAh92DUj0CJ0ey5m9dWDBKj1pV09VdMPg0NcotXInu1YmT1XX00iPRp93q0
	 zlguPY2Y1lLvhV+74c8tR8E5i0VsU25jz4IiiBaiKMfV48LcVSzDBAkozfm96iGfwuBe5
	 xb+EQVV38uA7Ez6WkY5ukreGW3jnqTUw0BuXPhrdCUgClWhXW/x4phZ5bkrA0bMqe+nG9
	 W/ThfbE+ygbln0JHimGEFEedZSi85ghM8xEtd6G4OtkuCaHROJ1wwL5E3WlnKY994ab6A
	 VWN95KnlS4ISdBU/iFvKy3MdDt6clwzdFYXlrARX8FUXtc29m5VQmSIolxp/rxAahRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IZPS+6IB8DQHZ0077IRWevsvmr/gqVSnP/MQs8MXcyk=;
	b=XQ/Y1jlyurhEmW9SjHrrtslPQVgp0t38xhidNuu3n4YEaVD0s08t8LMFcccSSyrz6ga8
	 G0Z5JdmEuF9lhyGQShp9NDPo9NJ5NhviXXEt96bVhrvnX0yI/CMImJrGDf2MNBvm1Lmev
	 stYrsVMeibDjddKCW0SLhC3T5AhCGpK/ANOTucPp+u6Yt6o0KUzNdmcug5GYqaHYAG2w2
	 /+TnoRnpUC0oRPbQx2EEqSgMTC/YZzcp5wyhwi9zrsXg6l9d8LfjHpdZturvg5kDNl43j
	 82wKYD14MaCsLRloQprRR9TyMGvuF5TdXaYcP4sM8jcXfW4K7qdKc0ZphczajuGUUEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RVsyF05+;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D4606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED9D4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RVsyF05+
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-843b6f8e2c7so1410950a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205885; x=1793810685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IZPS+6IB8DQHZ0077IRWevsvmr/gqVSnP/MQs8MXcyk=;
        b=RVsyF05+tCedNo+v2kdMxfkFhOX72rxT/nkACdFSTscjKClTMWMZIC4Qa3yCua2Snq
         j152jBAlhOuDOjX9hFrRN9BymoaQOaUjsbVB1yim2P4xbXGd7fZ3+yscnV/lPD7ig4OX
         K/catK9zaS2s5kZHJG3Us3l79HhxZLjx1qWFFEBXU4D2F1hOjTVVN27Lxu3+wBpj15K2
         WDsUfyMgmUNrSa3GCyp7KLRG6WlueYW6N+BWQaTlSREDcCL8C3EIqnSgEvDapbLm3C5z
         KFKQXXYX5ddX9QCewQ2rroRHJSVfgeT5Th+fFxrb6btnpsdhccCf52ZwzJwsBrGj+Qn2
         ZXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205885; x=1793810685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IZPS+6IB8DQHZ0077IRWevsvmr/gqVSnP/MQs8MXcyk=;
        b=fTe+7vRbVKlPBDjud1obHlHvWTZ3HjNrTa87PwpzxJ4O9mMqkFCIo7qK5FDa+ydo/1
         RC6GzzIojbngDd1btKCrTtYV7CH6NhZzh4DTtLmCJw7mvlInV8UIqzCFYol+5CWjLHBX
         3s2H3sJ8bF0sNuKbkCYMf9QGjZDebqlSBcK1MWMupqY3x/lUbYbZ/B2y2ZNZKUIyjzqq
         Dy4zWvFxFB4WPNFehHiZ6g0kyI82WEjqp43iEQ67eFPnEND2jkU6T0pg5wKXsz//UoGQ
         u1yZ/kf1KgxSYs9A6tv0aNmvWgq4zZAW+oq2x2kYK4GDbe5LkLpFMK3/RVFqFN0+Nuy+
         d9gw==
X-Gm-Message-State: AFq9FYJXebF67qvLu0NTmMi93klLiGxiz3qOeyW9YfU7wtExWbj8DPF7
	U/gjpa8guEdGMIn+N2H/Kj6iUZBIglb7dyvQdbj73XMrNTtvWTnKbXZszyJIrUeLeCMRrl9Bnqv
	sYZS8Fs0=
X-Gm-Gg: AYBFou1VrVcta1fe842fNyX+VVSX/jaZVOnmgpgIwAqrGknClSSezs18hAnYBhNDGL3
	Ao3I6Y9CimL3cOzgnoh/Ka0Km1g4R2tVVuCWguswKDT0lSYe4xpuHzLr1VmwRV7WC2ZJQZraV7H
	Xc9igXx7gFEvjIb+rxfaDTHD2MfRjg2bE89wmX6px2HO5dLgvGj3rDMNjqc/7FS/r4NUqJAZUrH
	WZu0pOaUx42W1autVkoYyLs7qwY/2aiuaAFDDlsm1rQwRNIn9XIWZyaJqQJLm5OImfyTkT/2k8/
	Wd37vuvXaIEf+5tt772H64g81DNQXKhPNV+ZXMSQERm527T0JFc0yT+uBNZF8XhDlsFNxQkZYe7
	L0uIwK7OekKsYUTVOxVhZJMdrBzAjnUYumtf62i+Un4RCVJjBo8gtxsnqwM78RR2dBXXCN0j8VA
	x5ycr09GhkaSk+ZVgfP1muhNaddnrpoByPSJ0hfLl3GH5PPFoDOdTx4CYD7SKCSBiwbOWOEoUy5
	V3WVAv/j+DV2zVYO6LzNqLrOSeKGvBIbU1B9ZhWbAkHth+CAipiaN6Fv/Tuc55PW3L8wpLgArAS
	NQB6Jfjxd9e81WdTrvapXN2rsc9Qu+mTPa08/aFzM/2bYnY4jCgc4q0NCoGICCtbLMvHnb6eNg=
	=
X-Received: by 2002:a05:6830:44a3:b0:843:b6f8:de3f with SMTP id 46e09a7af769-85ab7c048d4mr2811653a34.18.1793205884903;
        Wed, 28 Oct 2026 09:44:44 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 21/98] mtip32xx: abort timed out commands of a removed device
Date: Wed, 28 Oct 2026 10:41:24 -0600
Message-ID: <20261028164415.1262013-22-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

mtip_device_reset() returns 0 for a removed device, so the timeout
handler takes that for a successful reset and reissues the commands to
registers that are no longer there, forever. Return -ENODEV so they get
aborted instead.

Fixes: abb0ccd185c9 ("mtip32xx: Implement timeout handler")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 58dc0d63df32..ee5b170e767c 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -456,7 +456,7 @@ static int mtip_device_reset(struct driver_data *dd)
 	int rv = 0;
 
 	if (mtip_check_surprise_removal(dd))
-		return 0;
+		return -ENODEV;
 
 	if (mtip_hba_reset(dd) < 0)
 		rv = -EFAULT;
-- 
2.56.0

