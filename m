Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795280989;
	b=OF9f1gNxgaZUGB4VkztfTaGeTSbwMpjNnPlooDos5TmAmbhPXTzfppG4QBlv2Y8N2Tve
	 iiz+/NggDaZCSawgX6vIxlWju+7NcJjeKralpecGNCPGUKj7BqQyLygGL6Blyc3cgUHUr
	 Cl//0EAzJ25xuXlCk2CM2D8GeHG+iloTgMp+IW0fdMlyZnBYl7QpqWmRpkNfEGre/pkqq
	 iM2uuUGczWXBj3fwdsvG0Hawp5wVu0+0jG8yf9nS9P2hv7tuYs0Q0ulRy8qcuQ9K9SLPy
	 3KKt1yTzMiqCkPSZG7+lpNnTwFriVQzYjBSKrV+wlSiB7XYDda/8eFvET7QhwFxWX1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=+/DGpjCF1AMbD6J8UfGRizKwiMAblO4BBrSABe5kffk=;
	b=J/yV/Yv+lKsUaIns1+SjZu4e6rRUqkpikYVAPIDHcxnPub69/Nifbe18SBIAWALqK458
	 IFKsKI4S3ptv0yLC/YYawpCoc+Yqh5Roj9dP9sU68I9xqO8TC5bZq2zr62gdU6RV51pvi
	 AZhK3sOFjC4UonfRYZnZfTGjU2aOBCRa4LqkRAQUNzB7uaP7vCQNVyaCtKoiHsf11hlOy
	 Lfo4/jNp3G2BB6Dzb4E4ePwbB0RDg8mcAVXU1s0wpljAmrEPKf9GOHtlt7T948jFe7VEL
	 907FUoehSEq+q/HCS2xedh9Vne0uKK/CVzpWwDEP7Rlotjq8xAe4uRInEH/LVEjxZ8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBG9O+Pa;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64717606A32A
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 17:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64717606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBG9O+Pa
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-385c497bfddso176701eec.2
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795280988; x=1795885788; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+/DGpjCF1AMbD6J8UfGRizKwiMAblO4BBrSABe5kffk=;
        b=FBG9O+PaG46G74PboDUZtRyJfjw4wJ7Vv0L1Fr3Xx/8ZvoTyIBK+C/wqKh8uCFct9n
         VJIakphsTpYnSLK93XCjiis2PzQcVmI9kOtO5IGsDl4KfR+eKwdaZ3EohsZDYUf0n+4h
         TuNTv/EpOgT8UiB8OpeAsbkor2TaZxcCETr55ZJEJ0oCeoowlMzbS2pnE8oQrYd0N/hf
         eyE6/fUnySBSa/YEQGzuM195nDjFrWMPsSX1yRNheMmRfCm1oCTWE5TyD6T3ZkMUwzK6
         tQijLxlZIRRWn/2Ztk/MChpbADDMolkvHVxrmW0kXXYlKh3CmiRtHaeix61Mm0sRSSLU
         sqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795280988; x=1795885788;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+/DGpjCF1AMbD6J8UfGRizKwiMAblO4BBrSABe5kffk=;
        b=q1C1geO93Jy0ECOaZyQjWnkQn1ZrZuvGbHh8tq/MbVXO/SmaSRU7G3JeCON7vwbMtd
         Zicd5pO/sPfjS+/1X3TF5iEuXuUXVHlh52ROIXCoewvQSQtMVzOddsvUP1Trofq5/D4D
         /a56I2xYHfpJwgr8JS+ffSFejx4Kfzgi6e3gSr68FA5a02sjrMifbbG4tOhhaKXg7BG7
         RIz3LPZA/fHP5v4CM4ttJYAvJSOWexsT8VxUKlYqhREouPw1C4usjf4yR49DGyR/3FQ3
         RzLG1Le55ZKmNaXqUCtl+7Tb/SIL6+VUWccNWFmaxeRAmZwtbLdpsnMKTg7ozdv/gVVG
         /R8g==
X-Forwarded-Encrypted: i=1; AL+hErELzqtADYTNjBj/HDc/7WhN1R+87Q5T5H8XVD8wBDDBMDH+tyfk0xjTz6w563y4lA89JdQpEkGXQ9cF6Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8tnwPydUnOdORzG3+Kc0fIzlJAUuYxjwa6Z02Amn+LzPCx6z7W
	hSaE63Rp3szPcfnOBiQMPuFuEFgKw8WtnvOjuXtFevQ4cuS1NhncyNSa
X-Gm-Gg: AZFdTZfyIa4OAaI4OzUkKr1rh/q/eNAeVi9jQ/JuG457oS7mz9vs3C2PxT7YE8Ytz13
	s/sz52vwbSER8TCpigUgAYZw6HEDPnAKmpu/RC8FAMFNazlJ7eXse6RsgMM2JNPhuLfA1GGh7fh
	YsmyTctSMNc/8Dv3LaULKJgsuBh1+adrwTwsEkyXMQwrUDvq5Ekbklj9P4cYWzERYI/Wt+C57eO
	4Qxk6VISuc2z6QkO4GNGwmCbUp8rzk50BRebsFwEKSict2YzHTnS0tTH9hTOm5wbVMZWfIz8u3d
	rVXeD1FWkDhR5v2kAwqoji15qLUs+n07tkwoFI5FojK3asTSyGXDIboGcKoDjNWQ+mycuM2l6dK
	lstTdObTHvtnsDdfALd0r5qjOppzDWJX1aBufi3N0P7bJBKs38Q0AihyCMRzItSqAFjL1PQO0jH
	Px1ZYnZIT0NXseUWgvmQqU8pXQtSt9dk3KHNX5iGMqlOGzznOL9HSmSgq//ZoRtQ2GLfoIOkCnF
	uVW/DvJnNIp3XEnGUDGvhLtClhgPRjRX+1VCIay31z+JwapANNho/lK+wGtvPYuq2DJzqlZeT6K
	IhfyhWn159rK06J+WBGy/JV7oXAt3EYgdxSZ1BlYuWGbuuWT9c2bVSJsT9XQSH+GDus=
X-Received: by 2002:a05:701b:2919:b0:1b3:a881:a67b with SMTP id a92af1059eb24-1b5568a8a08mr8858631c88.1.1795280987955;
        Sat, 21 Nov 2026 09:09:47 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm22813152c88.14.2026.11.21.09.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:09:47 -0800 (PST)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [PATCH RFC 0/3] zram: avoid copying spanning LZ4 objects before
 decompression
Date: Sun, 22 Nov 2026 01:09:23 +0800
Message-Id: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETQAWsC/yWMywrCMBAAf6Xs2YVmhfq4Cn5Ar+IhTTe6YtqwW
 0Us/XejHmdgZgZjFTbYVzMoP8VkHAq4VQXh6ocLo/SFgWpqnCPCt/qElu8yYc9hTBlTQo0B102
 M1PnNtt55KHlWjvL6rU/QHg9w/kt7dDcO03cKy/IBajr+PIEAAAA=
X-Change-ID: 20261122-zram-split-decomp-mm-rfc-36ff2ba7809a
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Xueyuan Chen <xueyuan.chen21@gmail.com>
X-Mailer: b4 0.16.0

When a compressed object spans two zsmalloc pages, zram copies it into
a contiguous buffer before decompression. This series lets the LZ4 and
LZ4HC backends decode dictionary-free blocks directly from the two
fragments.

I measured the time to swap in 1 GiB of synthetic data on arm64 with
4 KiB pages. Each page started with pseudorandom data of one of 16
lengths, followed by zeros. On this workload, 32.6% of compressed
reads spanned two pages with LZ4 and 34.4% with LZ4HC.

The table shows median swap-in times over seven pairs. The last two
columns summarize the percentage change within each pair.

  Codec  Workers  Baseline (ms)  Patched (ms)   Median   Range
  LZ4          1        1403.81       1344.45   -4.21%   -4.64% to -1.61%
  LZ4          8         222.57        216.36   -2.73%   -4.19% to -1.97%
  LZ4HC        1        1403.35       1336.99   -4.74%   -5.07% to -2.90%
  LZ4HC        8         222.10        215.77   -3.16%   -4.39% to -1.27%

These timings include both skipping the copy and switching decoders.

I used Codex to help implement this series.
Do you think the swap-in improvement justifies maintaining a second
LZ4 decoder?

Assisted-by: LLM
Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
---
Xueyuan Chen (3):
      zram: allow backends to decompress from two input buffers
      lib/lz4: add safe decompression from two input buffers
      zram: use split-input decompression for LZ4 and LZ4HC

 drivers/block/zram/backend_lz4.c   |   1 +
 drivers/block/zram/backend_lz4.h   |  19 +++++
 drivers/block/zram/backend_lz4hc.c |   2 +
 drivers/block/zram/zcomp.c         |  28 +++++++
 drivers/block/zram/zcomp.h         |   8 ++
 include/linux/lz4.h                |  18 ++++
 lib/lz4/lz4_decompress.c           | 163 +++++++++++++++++++++++++++++++++++++
 7 files changed, 239 insertions(+)
---
base-commit: b95f8bb86713c860ce8536d22a988b949b884d5f

--  
Best regards,
Xueyuan

