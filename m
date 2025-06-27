Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D897285C84
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018267; cv=none; b=KDmWqJBR2WvLEwzsOZz5MBP00IyNussnOr5BjRIZZrHeb4xHEgomftOyBlxaHogk7M/65jXckEeY/ZWv3nvXQvas5daEH9+XKEsUess0GLaTwfe1LPAdqmJftMy6tjHuyQWM3/eX4KLfKLlcxBYtVFuTnwdWCsLQmY/ASNypLsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018267; c=relaxed/simple;
	bh=RAmv329Xaq38x/JNCC9NLv8ETZtMOW78s5QqfPKBgwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bL15msBYPyGD1CE9Y7+d7i4RCMkOliOuyvdWKMMvEFAnxhPDjnsfIBr6c4VgBr7ct3u1uQOI05qrtcDBPo1+HVeAQpUnKZwOZXEr9UZ1l82gf7Yv/zzH6HpzxTXubVIruVirFiHtQtNNq284zl2HuEbZ98lz0eW/LtpEJ+KC73k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=Yhnnllym; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="Yhnnllym"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so2993089a12.2
        for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1751018263; x=1751623063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mwDy+2proYOLrYP4jEl+UhyGumZmUzGwf/H1c+IwxdU=;
        b=Yhnnllymd1RGK6ar9ILKBRxOJauwPbREPZGKnDGxyYfOPAq6TD96T8+sZeoGtzYksl
         tSHPByeNc4jB0w37dvbhN8gLLu2enwOxxyft1wbdl/2Z9TE8cwV9kzfzPj86IxZ0mrqR
         A1BqSiSKr65tX8lPDqAeMdHHwgHk7OXJDG5zyA6sQCW+0rCuPHyCVHNnW022Q/95Y8Xq
         lPb7Kyv7uw3h2RmY2o0F2cne687MNVhIfM/dcVMitzFqA3sFKx2MLrue6tSRXT/npr2k
         iuyAdF+wUQmzkp5qRISLW191ZInd8rn1xM4H+oswEvOVard+b3XfRXZ4yRVnWhNYT0We
         /qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751018263; x=1751623063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwDy+2proYOLrYP4jEl+UhyGumZmUzGwf/H1c+IwxdU=;
        b=jCtupSXJknboqjm2mFlRjgXw8C1xI2VCGO+oCvVGxavR7c7bykb9wKmLuD5WC/BeLx
         Yyfi2G3msJO50BpqWSmxblTZ+ATFrRT4ZK7gVHzjdMK2rLrMA0Ka19US4w45Cp1XVGBp
         2k8phGRJ0nNG+mGJZGFRkic5x2YX0wlYUC3Qkuob6pfewq5JGuvtie0kH/7XVv4zmgmY
         I4YqUnQWR0rhMiTzsnBQw+OsjsMdRrLnxW/YZCEHvXZEAK7CN1TXmxuyLOhFZobzLqym
         rl1xPLJhJXGqWuN1iLDpLjcrwHbYd8lva3/Wj+Oi4chhgcm8pcjHMjft7x9pWlVN9DXu
         zUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl4ljF0xlRr6rY4IKoaW8wHxd1Yw7PHC+DV++SdsHIWsLrR63tJGiTPSfKm8X3BdumLIFbjuupTM3xhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5YnZyTa3XerLkUj/S0xf+IqJVp6vwkI1kGsz7/dJshwsO/pHp
	a1JAps5duptoftGGuHA53EspO7rPIQ1j2tWjGoB/7Dqxw0qAAm0H3u5mIxsIVGDbUUuBXOqcr9Z
	PWOPI
X-Gm-Gg: ASbGnctCS874ukfgNK3ZZtSAmiK7CpFs6T8kJ/zNUYXGZnUYia8D02Badx7O8YegPqb
	D2hCATD8IfviyIfWdBOLyIQW64sbvnRvh24a77NQKMsH/X+i0SmyNnMY/Hg9v/wW3eHCZAY6Glu
	v7qeI9xdN/E+2l6E4JtWGxYraOz9PhjHBn9S3qf/H6ew9V0x0oNG3m9QapdEeK6baliCVqevyof
	nFRP/oF7h/e6ypUXXr8Sx1Vq3nV5ftNQS6zS+3X6/Cw3C3egYhMAYCYSgMl7jfok/Qi82VUbsuu
	aHdJn+ef/yor7gP+zWPW+yMgFT50E+XNzE3aACwwBKIV5z6Y0kd7UOjtqJfFr6wvoYVpXCd3UIO
	zmarcEWP/tCr98ZDk1IvwvurE7rCl/2fYoaPPrbTrPmLcdw==
X-Google-Smtp-Source: AGHT+IE1SvpNm5CP6mOqFBIwW5hSM+IQAnFj1rNcxOwLH+ZTDysF76MjOPbBHOe49nDHS4m6dEzzRg==
X-Received: by 2002:a17:907:9812:b0:ae0:d7c7:97ee with SMTP id a640c23a62f3a-ae3501517b3mr215390466b.41.1751018263460;
        Fri, 27 Jun 2025 02:57:43 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363a149sm94561266b.9.2025.06.27.02.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:57:42 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Sarah Newman <srn@prgmr.com>,
	Lars Ellenberg <lars@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH] drbd: add missing kref_get in handle_write_conflicts
Date: Fri, 27 Jun 2025 11:57:28 +0200
Message-ID: <20250627095728.800688-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sarah Newman <srn@prgmr.com>

With `two-primaries` enabled, DRBD tries to detect "concurrent" writes
and handle write conflicts, so that even if you write to the same sector
simultaneously on both nodes, they end up with the identical data once
the writes are completed.

In handling "superseeded" writes, we forgot a kref_get,
resulting in a premature drbd_destroy_device and use after free,
and further to kernel crashes with symptoms.

Relevance: No one should use DRBD as a random data generator, and apparently
all users of "two-primaries" handle concurrent writes correctly on layer up.
That is cluster file systems use some distributed lock manager,
and live migration in virtualization environments stops writes on one node
before starting writes on the other node.

Which means that other than for "test cases",
this code path is never taken in real life.

FYI, in DRBD 9, things are handled differently nowadays.  We still detect
"write conflicts", but no longer try to be smart about them.
We decided to disconnect hard instead: upper layers must not submit concurrent
writes. If they do, that's their fault.

Signed-off-by: Sarah Newman <srn@prgmr.com>
Signed-off-by: Lars Ellenberg <lars@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e5a2e5f7887b..975024cf03c5 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2500,7 +2500,11 @@ static int handle_write_conflicts(struct drbd_device *device,
 			peer_req->w.cb = superseded ? e_send_superseded :
 						   e_send_retry_write;
 			list_add_tail(&peer_req->w.list, &device->done_ee);
-			queue_work(connection->ack_sender, &peer_req->peer_device->send_acks_work);
+			/* put is in drbd_send_acks_wf() */
+			kref_get(&device->kref);
+			if (!queue_work(connection->ack_sender,
+					&peer_req->peer_device->send_acks_work))
+				kref_put(&device->kref, drbd_destroy_device);
 
 			err = -ENOENT;
 			goto out;

base-commit: 456ef6804f232f3b2f60147046e05500147b0099
-- 
2.49.0

