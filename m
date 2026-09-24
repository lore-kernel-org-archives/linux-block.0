Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CFC372045
	for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258828; cv=none; b=BA0xh1Oc9zDQ+WWNg4DRnklKoFXjW6X9FnQZazG+ux7OcJZbbWc+h7tnE80pyhMDE8bqpEQFuatEkO3+pK/7ykFpefB2UHWMi7VNRqXfDp6Oh4GgO4kj5HEqemPL0KwSJZFk6yVOH8vAVGgeN2VnX+iFDZj0RszpxRrR/Ro/UW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258828; c=relaxed/simple;
	bh=GC6+lg7Gi2oM3B60HChdLke11qcKRYNxpaj36DtcwJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k6zRYZ4r1nAoG6YPJT0LhHZbLxJuEt/9/AaTAqs9Q0fMUE0JzFw+PeSanYX+Kh/RsFNJ/tmLjbJDbv1ElAyFMJ00DVGjfQpcBGWS9+YHCTVVL/YfFYCMLh2aZ78rrGcrd33BX7aVJsXGHgoNvkG/M6Xk/IPjARDOkff/LUs1HRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhCUVUYS; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhCUVUYS"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so11865105e9.0
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790258825; x=1790863625; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h4+moVG7ALNUHSWlTD3Rr/Ll9jrIrLEWhCFkgg7SYzk=;
        b=LhCUVUYSPeZH+cNDphxOsZY/J1K4tXqfTxOR17XGWUQCi2wMJ6o44O4MyChpS6heOl
         Mc4Wtg0Osx5W3MVWRImmWRfN+knhalJ8mDRK3arUSMG4VyqIAb6NGhZy5XyOU5tpq/Xq
         BE47J3WPXYd5bZ3OM/Nw1k2jLZURNddcJWRPz+h8X0yr0LT1CR93vUetrEFT69F7HwjB
         f3BBlfERuoGPDHJ2l/he5CBC6/dHCRDNTifRYQOXWManOV/wINKXPNbyVdAdFhgfnQzd
         5q2sfn+/57TcFfNVQDzrAD4WHsaVoM+gx9o3h/ow0KDvMMl2q0LaucoAK/V9qcr9Ia4g
         Lluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258825; x=1790863625;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=h4+moVG7ALNUHSWlTD3Rr/Ll9jrIrLEWhCFkgg7SYzk=;
        b=iVkpC9eb1MmZZ1VLDzfYKFSLZZDX/45ux951uLMoM1Y4mon/oAvsILFM9MA+5yVz5O
         bXw2K8dyL7gdGzmfL+LsEHODBeJTI+HXgReD2utqSZ5gsMeZnuBqgV97DyjL1d1hvL+v
         P5milT/KfbAp6gzmZ4bFRCefmF28gIt0FHfs0y/VTsg0jVAaKbSl/t9TOF2COD3JBKiW
         1+C71+VslDADOLzQ2LCUb0ZHbBm5VmTQkOd3KG4tzpkAvQseecdu3fvf5R67GeEiELPJ
         3RqSSopH5Vg+4nYuMifXQ05tL8nwOs5m5fBEhKV/0rKDvFTL4Olc6di5T0MHjYD3MqIe
         55oQ==
X-Gm-Message-State: AFuF++lDx63sIJtdFdu4PtycFVKstG1EycL7EP7PdDpsOHcH706bs7YB
	b96ewXWSscT19s5zE/S0++VJHxp17veMthbgNgnkGa/f84wojb867Ss5
X-Gm-Gg: AYBFou3FYoRp66Ho5u5jfwM7bhBTBvVXFbUkUCB3WuBKFndvqa8dbDVgAGdpYvNd3wL
	fBNK/knr5JOLuuKXBjjOyYNFYhczqA7Op8ZPU2FfQiF9qpjV/41Vrd7694WOK2h3FZKEXsKXiVb
	IyGyYj4OrTR76hX1NFJ9VqsACj9hUNeHbyIZCRoVFYSV9RViAo4XNAOAn8Hxp+dj4hXw6YxhXTK
	fywNpxDhzsW8FEjmxfQn/9SpIQFMG6xFg1pSxKlLSFadGXzcDi9sMrdUQWoxo+uXTRuFGVdS48y
	qqzyJv5EeOQX6yRmcAUp25KV19m26A10+Ldkwrk3+UJ4xP0/Qm7fXrMCAffdwnXx4BKFINgEpWM
	jEb1toWjYMIIrKvuO3hvm+6clNR0ltuBW3N4pOZU2JsHm+c5ihSmjXnG/oZzDU/WAa2rFm/Kfwa
	GMEh0A7miUKTaP5tSCk8Y9H8MBzXkwS9fi+wysry0yS1aQGwxUe9zbW5xy9CzWLRG7Rvlj6xTpH
	Zs62DH65vNknJOx99FuUjJ6h+OQfgnZi1hS3mf0MONrJw/VpvkvbRAIMsvfDAOlpPsAAfDodbLV
	1A==
X-Received: by 2002:a05:600c:4689:b0:49f:bc8a:b103 with SMTP id 5b1f17b1804b1-49fe66841f8mr45428675e9.0.1790258824470;
        Thu, 24 Sep 2026 07:07:04 -0700 (PDT)
Received: from [127.0.0.2] (0xd461ec5f.inet.dsl.telianet.dk. [212.97.236.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5e07bdcsm64234815e9.15.2026.09.24.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:07:03 -0700 (PDT)
From: Malte Wechter <maltewechter@gmail.com>
Date: Thu, 24 Sep 2026 16:06:58 +0200
Subject: [PATCH v2] rnull: configfs: add power to configfs features
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-upstream-v7-3-rc3-v2-1-ca56ae7a73e9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIEutWoC/32Nyw6CMBBFf4XM2jFtiWBd+R+GRR8DjJFHWmg0h
 H8XcO/yJOeeu0CkwBThli0QKHHkod9AnTJwrekbQvYbgxKqEFqWOI9xCmQ6TCXmGFyOwttLobU
 3Nhew7cZANb+P5qP6cZztk9y0h3aj5TgN4XOcJrl7//pJokQvbKGEra/K6XvTGX6d3dBBta7rF
 +c8mxXEAAAA
X-Change-ID: 20260917-upstream-v7-3-rc3-0db5699dab30
To: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Malte Wechter <maltewechter@gmail.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790258821; l=1634;
 i=maltewechter@gmail.com; s=20260812; h=from:subject:message-id;
 bh=GC6+lg7Gi2oM3B60HChdLke11qcKRYNxpaj36DtcwJE=;
 b=HBkxMA+FpFwazc6nsQOIkIwjEP66uRgwrFErgqQgHY2Vz3ZG7kCoducPa1Tbgc0gFq/lIGEAB
 ZU0B2/mbhfpAO3hE8VMtY5FCL6iw2ib8J9d3ZOOAMLzcmhll38DV8Bz
X-Developer-Key: i=maltewechter@gmail.com; a=ed25519;
 pk=Ta/JQQMOW0Cbxp+yEwWqWFEyKFRyuQeSoYicwD7yvWI=

features displayed by configfs for rnull was inconsistent with the
actual features available. This correctly exposes `power` as a feature,
which is also consistent with the C null_blk driver.

Fixes: d969d504bc13 ("rnull: enable configuration via `configfs`")

Signed-off-by: Malte Wechter <maltewechter@gmail.com>
---
Changes in v2:
- Add fixes tag
- Link to v1: https://patch.msgid.link/20260917-upstream-v7-3-rc3-v1-1-d0b620bf82c9@gmail.com

To: Andreas Hindborg <a.hindborg@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
To: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-block@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/block/rnull/configfs.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 32c10c3f4d0fd7..5f1cdd54cf48aa 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -35,7 +35,7 @@ impl AttributeOperations<0> for Config {
 
     fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         let mut writer = kernel::str::Formatter::new(page);
-        writer.write_str("blocksize,size,rotational,irqmode\n")?;
+        writer.write_str("blocksize,size,rotational,irqmode,power\n")?;
         Ok(writer.bytes_written())
     }
 }

---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260917-upstream-v7-3-rc3-0db5699dab30

Best regards,
--  
Malte Wechter <maltewechter@gmail.com>

