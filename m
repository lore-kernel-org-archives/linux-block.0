Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com [209.85.208.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353342C4F4
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345049; cv=none; b=LGXz6ZaRpOzeRTN8fwDPUrnIqRi0tYNxRzk3uhdnKPDaCc5zYu0ZvUA+B4ycnRiGVYts5F6lfaE7VxwesvBLeD2LtLctB/LtF09CHeJAHKQ+LapQxW9hzAzUFTTWoiqScN8UH/ScZ0AUA7OkUgkx8lg6LAeMWxM+eKCK17le55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345049; c=relaxed/simple;
	bh=0eEpjpHs2Hw+N83pk9kVaVB0jdeiusPwm0n1mas6t8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0DYvnDdCSx9vvHju+khfX8S9n5VJcROuo92oiKOpI2AuNexN5C111Y5VsAAxaP7lQlG8IwZ4iBKMj3pY3WO6pwabTS+iuxr6ebw08IUiD6iPkeaF9P1P9noOBh5K0zM7okfW5ZfiQ/xkZ0GdZwp3sqOOA1OARzh6TpAcfZI+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lf+xj+d3; arc=none smtp.client-ip=209.85.208.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lf+xj+d3"
Received: by mail-ed1-f97.google.com with SMTP id 4fb4d7f45d1cf-698bf274b3fso199937a12.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785345045; x=1785949845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e9GRQgZT2kCMfd8vXBrFUhFhCJV62HJZFxZzKllKeFE=;
        b=Lf+xj+d3GIOg2wczHVACx80NYq3FSA8ZEkuXtyzK9+mfA51i+fzW52vQU9ssoPUhm3
         o8ryjRfTqcSyNTUjhBInbPKXXbC6KJ8H0HQKMkQ+vRcifNQ9CTp5nzR2IkBLNG3ySTle
         iqvzhnKOu4cAen202DMGdW9dDuCdYCG8k/6U25iwUD/tbotkZQkvmqCK/s4iK2qBZ8m2
         JLALD6qv4pNImv3ShogQrWuEu/DeJril4HYivWJ0NTZ1sq9NFtr4J5flPW78KxDn42HB
         Sd2kWcSsEgqYHCC+yZQCexnQJ3zh+1PZzjaln0QolPwFRbnaBxPZ/B77wn33OAHKcokX
         xLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345045; x=1785949845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9GRQgZT2kCMfd8vXBrFUhFhCJV62HJZFxZzKllKeFE=;
        b=m1ji1wHhINVGrhCqxFp2X0HesNYP5mUJpVlThDKL37l1eV5vLmumUQWCpx/NMF4gz/
         jcYEZCD7LVDiJcdo9F1K+DWlNC7BS/uaL4M5ot0JPhWfVuOcXaJRFkaPz7agn5uz+mY4
         q4kZgIqmQP9nyOZ+4WBLZTwvn0yOFZX/8ASJIib9PsbphaYVXTmIU7dpC7Bqh6i7p5Hm
         zxCaxwbVdHcIpPnE8rPovOelgZ0OwQnT59XDmyK4h3sPQtpzNzQsBkdr6vUPx/RRbpO7
         xGHdlOEAhcWF8CvpsmNokaQ46o3T0KCFeypZmrkzJ7TdTJe1EO0WxSEVuYytveraJOgj
         qNzg==
X-Gm-Message-State: AOJu0YwusY0I+qfMtxdnRDKHcbt5+GuQxsYMxZ05/EjtXdFUZSujJGyT
	qVDyUcA5YWAz6vnNoSpYzkzrq9IqIzmKxmsVSe7ck4i5h5j1UipiCO/sdDIa+MmLo8n4pdp5Jg9
	j2sNcBCLT6h84rMXiAKa8cqZvgFMy1mdzt/iX85B+7ZfuvfhdkdYJ
X-Gm-Gg: AR+sD10Ha6w1jiS6lB9rAPgNKoadzaxCnVCrsZRegFO7p5V8HCeNkqcbXibxYcq25nr
	bcsdIX9H2+frAPh1RXgqsaNItnB7lks92eqvI8WwnkjIVIdrYlLSV1jbinfwJSLkYnPaqR1RCdj
	yoEH27oa2Ao49L1wBqLMWpj81W1tfoqz135YBViQi0baUqBzlrWXM7geJJJDMSEY+UFE/5zBn3H
	TMmMa8o710oaIAQHclAYkcAnP2kcdEWkmZwlu8njDtHOyFpe0WBV8EEbCKTGYV5M+RDYd7MeDtK
	tTfmy4d7sit4xHsv6BhUKgH4agSWFvSW73ed3A+iKPof/blsYtJldDJoYde2kWvC7ZZN2ApUEFT
	wuFOPFxsTHBmpAtVJng==
X-Received: by 2002:a17:907:7a89:b0:c12:6db4:4bf4 with SMTP id a640c23a62f3a-c1f71b487cbmr336902866b.0.1785345044916;
        Wed, 29 Jul 2026 10:10:44 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-c1f83c7b169sm24170266b.8.2026.07.29.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:10:44 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 883A2401D2;
	Wed, 29 Jul 2026 11:10:43 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7E8CAE4017C; Wed, 29 Jul 2026 11:10:43 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/3] ublk: harden user buffer handling
Date: Wed, 29 Jul 2026 11:10:38 -0600
Message-ID: <20260729171041.45061-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ublk devices not using user copy or zero copy, the ublk driver
copies request data to/from an arbitrary buffer provided by the
userspace ublk server on each I/O.

Fix several bugs where the kernel driver is overly trusting of the
userspace buffer. Ensure that an invalid userspace buffer at worst
results in a failed or requeued I/O and can't trigger panics or
undefined behavior.

v2:
- Check import_ubuf() return value (Ming)
- Avoid calling blk_update_request() with nr_bytes=0

v1: https://lore.kernel.org/linux-block/20260727162450.2921500-1-csander@purestorage.com/

Caleb Sander Mateos (3):
  ublk: check import_ubuf() return value
  ublk: check for ublk_unmap_io() returning 0
  ublk: remove WARN_ON_ONCE() in ublk_unmap_io()

 drivers/block/ublk_drv.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.54.0

