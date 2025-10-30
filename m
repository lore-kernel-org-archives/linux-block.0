Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236B2DECDE
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 04:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761799201; cv=none; b=UgoF3U0JjTG2NqLsEElYtTYNnZTdPQQJwX3xdLtvAywDROrHCII44GGTLr2MnkTl3V+uZa/mWqeWUkr1u35MHLWzQnMeZofesHEWR4GsZRR+jI0TJvJh9AZekGuWD0SOD5nkVJZ1591eTPQmCjQsodtDAI9zZKgry2dmsVa2kgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761799201; c=relaxed/simple;
	bh=ylCmhFM7cJmjVhYJQQKlRmvgfFCYeLYyHkxtenDhaV4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vz00MCaZaPGaTEJRT+nz96I24/w3p+2H3pfqJkg7MdcLxRrrEaMtrSYlg9ZAykagSu0Yl4jjKZbfUlmaWYpkz9TWPowSWA7haKAMzD8dIm04UcS0MBW+v5+JFI1bGZSjwdPIE4W9y05+HgEvu8tS17n1tCadW/f2Mm0FX4wXDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0aTCYT7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0aTCYT7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290bcced220so5404945ad.1
        for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 21:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761799199; x=1762403999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dGqbfRti9hKegZ5HASb6KUqvXOdBftPi9jvd9UavZPQ=;
        b=B0aTCYT7K1yXb2RR6r/0i5hET/gfnJP2Pi/6iI2EgSmrow87oxpL19lDPrl6AT9P5c
         vpraF/Cne7tLVawv15lbI5DKs43TuhPzrcsqfnspHK3CuIYNdpWMKH3drN7ZeJbj3yJm
         dy/Eppp3qT28xty/vP9ah+I5Ogw5gp8euNWEkRuuVnaxiRcfx6E8VWSf1WOupSwBNU1y
         audHMcJ6K3Z0jis2Nwj0QTGDLDdOUInQRtRex6zCw7yNy4dQNDHb1fBn2wVZZIVNg8VP
         x+o9gINBDn110bsYY/9RGshiyqQMsqCd7WqXavjEds4t+rVNyNsxFcJtK6MdXLwNYDrk
         Rhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761799199; x=1762403999;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGqbfRti9hKegZ5HASb6KUqvXOdBftPi9jvd9UavZPQ=;
        b=vW2ZJIUztFS1C7fOd0de5jMm3UqSKvEKyff5JiprKzbXHaL4gGk/spg2AuXZk8PRIc
         zdmXgiDk1YKCjectVSJxcM8cbECAvmp+dTkuQISnqKpcc+NyjU7IW4JIA5yWOgrp/sVj
         gZ3/4umirYaJp4DXUgKpMmSYlGmVrl0yxfkvVrhvnOEqn4fWz0usQYc+zxt7Cf8evxHH
         oWY05sEG2RitxyT0xNWzZmFe1Lyf+SqCmcrVrp6ia3YcVxUfA8qjvdJnFc/uFlqm27Hf
         wtQjO0Kc0z14QzczyEtMT7OhngjDc+6bXKFu2CZV7I4LKg5FanlWFfDO29pyD8sJVxxl
         Um3A==
X-Forwarded-Encrypted: i=1; AJvYcCVp75c7Yc/uwhHHadsGHmEB+qyrUpvyytjaVe7TqRlASoHkV49FH9jaGENJp/WtPe84/bHghG9Y2IsJaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjb2P27lPpf8IgkwLfaIDy8SAwTrFsE7CGN5FtImHv0nivkCOF
	jcd6yuoamxPk3KoL/A4WDp678OF4f0HhGVPhKwaFAfOuP/OMfouzOALvyj6V1pYmkZ2zbtWjc2C
	AIay0EzLmnNpZVQ==
X-Google-Smtp-Source: AGHT+IETAfRwSZjXvtbywaaxsUIs6gs/rosu5l5QM3+aYkJm9qGMcrBnPPBbsvi03WTHK/FOtH1RVHn61ndsrg==
X-Received: from plhs12.prod.google.com ([2002:a17:903:320c:b0:27e:ea91:acb6])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:ac6:b0:290:b53b:745b with SMTP id d9443c01a7336-294deedabdfmr66533655ad.39.1761799198776;
 Wed, 29 Oct 2025 21:39:58 -0700 (PDT)
Date: Thu, 30 Oct 2025 04:39:18 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251030043919.2787231-1-cmllamas@google.com>
Subject: [PATCH] blk-crypto: use BLK_STS_INVAL for alignment errors
From: Carlos Llamas <cmllamas@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Make __blk_crypto_bio_prep() propagate BLK_STS_INVAL when IO segments
fail the data unit alignment check.

This was flagged by an LTP test that expects EINVAL when performing an
O_DIRECT read with a misaligned buffer [1].

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/all/aP-c5gPjrpsn0vJA@google.com/ [1]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 block/blk-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 4b1ad84d1b5a..3e7bf1974cbd 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -292,7 +292,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 	}
 
 	if (!bio_crypt_check_alignment(bio)) {
-		bio->bi_status = BLK_STS_IOERR;
+		bio->bi_status = BLK_STS_INVAL;
 		goto fail;
 	}
 
-- 
2.51.1.851.g4ebd6896fd-goog

