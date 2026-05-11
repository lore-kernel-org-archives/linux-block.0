Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920637E30D
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536318; cv=none; b=ko54mOZrDgEgE+pqUkHUAxlSVxdBAx9yaT6B0hMrODntq6rHdahFreNTkaiAI9tL6LPlLCrsHDzQk0OYqJZt2ONYY53Prze4sIKj7a0X029O+2cevB1+IV7ZPWX6HVMdC92DQjwU/qEgXwdOZ8wXCmQq60413taoRqUk2yvZItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536318; c=relaxed/simple;
	bh=H884xHAasWhJMrJEAQrb8OdVWipJmcLKpX0XCXbKWAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPkvw+Gy3+Gb9/QZ+VHp+Ss42REVzUXb2ZOGEeY/aP3e3H6n1567YQkXJgi+yKZ4Ty8pheyezYGZyusgJKHsc855Qb+Szykyj+7UCUaiW3p3SFbOREGAMHeH1ia2siRqobtI67uFNCfMU3VF1BkS0s3YOSAMQOJ2fhwzrWIZ+5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c836qKmL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c836qKmL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so13785465e9.1
        for <linux-block@vger.kernel.org>; Mon, 11 May 2026 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778536315; x=1779141115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNrh6D5SHjoaH2WyyedqLt7IdCIpYru9M1cGpz/UP08=;
        b=c836qKmLSZ/guB0D49Qeaumcb1R5sbopcwh1yebzG/iFPdQFvS8IUFF9CrtLFepw1e
         I/swRcQXoIfI4ueEIvxINExBoWcll8KtMmnSw3cnDpADTuNgUNcKR8oHXjq3ma5eYGei
         yI/hwRn3Y7npFSnBZS6LEKaRMuTiuGlc2pNyPstCB5mQYf6rO1c/uyf8GesY0BSm3TLt
         nIwkUyngYiU1OK7KbTsDttwpOmS6nyXMjtkaGoet/vGMogLsORiuNoKCNBMMZIqD+iVi
         YmmZGABXtAjp6KUftXYJpSKQ23D6knZYaVgAEidCLsbELtEuvnxk+DqGi6OT2yT0YvH6
         GTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778536315; x=1779141115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNrh6D5SHjoaH2WyyedqLt7IdCIpYru9M1cGpz/UP08=;
        b=O5mx76HkDbDjS47ch93cF1ASkMyM3FKynDhCUyzBviZ8RtQIAUE+1MRP6BDiTB5G+d
         q322Uy4D9Xrunk4u8c6fhsZkyrp2sd4mio2NGmbbW0wGLI99LtXcgzh0UnTISULU9qp5
         tT9uMYcshAFzUwpD89pWM7MWwK4emAUl2m3enAjPbeSPqS3iNHK7cwBGNEcTK/nAPgwv
         2Uq40RKU7ZuZEHPygUgTaS2ncbm8UrwIIec80X5H9rVJ+rPGaelRBvXkvLVj/GNLwasF
         uNJ3KiVkXQZh8kI3DAuN6WyOnAQHtSHerEU9CMP/KYcfoHIIvCi/Yg8g3Gsw2Wvu65dF
         F+Aw==
X-Forwarded-Encrypted: i=1; AFNElJ8QJAkYMIKcVht7XKip0+qSQ0IjyaQJPn4vuToOtWb6H5+Xp5msPTIYlfJZ2HRr305yfHKY5IVyRXc4Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCb7ex69r3uI7I2l+eYXIkQqfgszKbgulFgGuNI3bSpQDFenjY
	L76bqDIvo0aHUVrGW80ZaFFb62ii3irAtaI7C5GQxlpkk0VvJ8BDfh6TozImR8dFcWbEtg==
X-Gm-Gg: Acq92OEYv/0gjGEhgiugBCiBhcdOUH8ir1iQ2AE2u4DpMylAuiiOFmP3I9d2GzvvFeK
	9hc6sy1Ui6BQGzzueWgG9VU2qZzv1NPEZgD/zZOG6mIrkvwuYqeBUPHgbXnVzTp7qDWedj5gv3R
	o8DtvxCOLfnfc6133G7HzHynHEmcXIV79DdSasZPxpx+NZnRwsIYtKx2F3fIWluZUnvzGvZuPk3
	05YxnEAmm9SHgxCHzOZW93ILqhBxpHjILpL2AKPiuHB4IL6Lbq+BL8s0d2IGYoR7HNbIfw1WoU/
	4bGi4Nqzdg4JuYvYsaQnDceZd5W5WZBxui3kMaN0IBGeBSKIJAjDVLQEL2tpzu4QSHipqyQknch
	cSMa/pxRCUh/Z/ZrN+N7YNVUaWJv5iw8DCg11Wi5hVxWOpk0zTMur0QyFK0FyOQIbgYiESbp5EI
	s1A5RnlijhgwI968fPw7cE28iKfUNskIGJqMh11Nkn54gP54rwne87XNyi+ot61zrS6m+630pQ/
	1WqNHXkfJE=
X-Received: by 2002:a05:600c:15d1:b0:48d:112c:f582 with SMTP id 5b1f17b1804b1-48e51e1e415mr254346135e9.11.1778536315089;
        Mon, 11 May 2026 14:51:55 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f42a845sm2918695e9.20.2026.05.11.14.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:51:54 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] block: don't overwrite bip_vcnt in bio_integrity_copy_user()
Date: Mon, 11 May 2026 22:51:51 +0100
Message-ID: <20260511215151.346228-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bio_integrity_add_page() already sets bip_vcnt to 1 for the bounce
segment. Overwriting it with nr_vecs breaks bip_vcnt <= bip_max_vcnt
on WRITE (bip_max_vcnt is 1), so the gap-merge checks in block/blk.h
read past the bip_vec[] flex array. On READ the read is in bounds
but lands on a saved user bvec instead of the bounce.

The line was added for split propagation, but bio_integrity_clone()
doesn't copy bip_vcnt and BIP_CLONE_FLAGS excludes BIP_COPY_USER.

Fixes: 3991657ae707 ("block: set bip_vcnt correctly")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 block/bio-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e79eaf047794..869746412949 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -308,7 +308,6 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 	}
 
 	bip->bip_flags |= BIP_COPY_USER;
-	bip->bip_vcnt = nr_vecs;
 	return 0;
 free_bip:
 	bio_integrity_free(bio);
-- 
2.53.0

