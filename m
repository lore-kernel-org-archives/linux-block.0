Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E62E36EC;
	Fri, 25 Jul 2025 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753416856; cv=none; b=RptSgHC2xL9z4/mFJnf9VAdxsQk2rrqPs1nI46YHD9KQLMG90VtiXip1bCAq3xFxYTVANDuA7W0Do01PlR5vjkWKnBKnzgR5R/0RfaETXCZ3oOCOdbJg0w2+WOlFqIjo881RNgTaXiIIa6XOjBw7CralD9Eb1DiBe3y5LHFkIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753416856; c=relaxed/simple;
	bh=+pn4z0ImaHtJwReAXKr+jjjCoFUB95rQqq8hiGXTxdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZysnpfm3JnpImQ8DMwPPRRhLhkg11/0FASL04QQPvuqWPrAlnnvqxCs4F8r0XUo0/7tyt1yFpAYofFWHndxw2ha+olwLuivizw++IIr+F18uWxIMn52V60kcO5pvSS4zkwTWa1ksN/cQlqfXBgH6g3oAAbTGUF6AK0JT7WCkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+PaacS2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+PaacS2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2353a2bc210so16387895ad.2;
        Thu, 24 Jul 2025 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753416854; x=1754021654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRwRxycYYk9J656HpTEAdKZ3WukDqnxUbViNBovsoWc=;
        b=B+PaacS2lCUNEvwws+uZFQc4SIqJVdv7erzTUY6IA7PYNsXSRn5Glp6f0cFjOlgP3U
         f5bBrE4JdMzgOjdgAr+Sj51jMSxlPb8q39h3l7Mdj6n3v4nmcwgRtavEckrPube8Gxe9
         tkoPU7eUJnkF5dFSz4tgm53XGz3C7i4r5t5jNivisv6hBswaQv4qwkANhAWzDkLo/hEp
         88EewM12XiPyQhXUnN3ejmerYFK4DDm3BSP0Z9JaZCKgA3zt1limYkqcBP4IL/Tyll/q
         Y0crJp5eq8AWsARqCsdIq79NysnEI1YdhvKGTstJrbyJw4ov1+8h+eZms9AxPRy/sUGx
         Mo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753416854; x=1754021654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRwRxycYYk9J656HpTEAdKZ3WukDqnxUbViNBovsoWc=;
        b=cdvbtn2amjal5y7Rfm0Isa+uVd9o2sfrIdtxZU77ByJFfdqAIMproletKap+U8yFvn
         43+g4EJlZWdSJQy6GAy4skuyBdB8JCK+7tj6gcRfKhbHaxgptbjkbVx4mym6SJg0ZSH7
         4iZuGAh39Z2DHowcMPlL3mt56fJSedKn2xToXWU5QibNrB6mJV6tv+QYgeoNC0YbdtUq
         m2h2srLKMsGbEdnpBvOBofGDAp9t4IFZ7cEMNmAVl0isCVx4yFmvSs+jei4H/AZNpSnK
         otxujAeC+giy0j0D97BQ11rDxhEQNTV6mDMGRFv8YcRRr/75mOf/b4OqEJtBd5i/Au2K
         U21g==
X-Forwarded-Encrypted: i=1; AJvYcCXxMLcpRbUmuo5b/DjojZoDllXei0js5oWzQlfVKoZD8vfKUL/RvHWKWWA5OzTnx0NZw051sQGodFOExEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcd9ZEeqlN8d8FD7U6pqNT44c3iMJDRRgzmUtgmjM29KUuL/fP
	X8u6en0EbQD9NGzwYqH6xC62Tq/BaLC4CYy6KUQnPqPlYLFr5F02Iymu
X-Gm-Gg: ASbGncvQk2fgtf8mOS+c+F/TBC2D7eO2jZBK4KR7fJ8CL9ka62wUJEq4CFooHbohibH
	SVeZI1WQit7HeNAitQh/1jTKg/Qlz0bRMphIkHO6othXYxyqMohizvWP7cNrXj9pt2SBXhW7fHn
	6SRbK6yxsW7J6uzIYdDVA92rsXMAlpiza2OclhDx43jpQu07jp/Jyv25JBdvng7Sy77kiU9jDdG
	p/u4jM2JMfT6zZrAHVpwge0ueVoioOO6iXpTyTH1NoJ37tfK52c1iCe8cL5s0eU5xs5G1ssmQoQ
	MMOcZHCo2IcUYnyJnzwVnWzD6G3cAQb40xhouzyaIpx9zHPgBQyBQG2H8Vx+60NsxDUEza7zmnx
	ihcl3sDbuWZv3+e6hE5QJPisNy1UXtZpkfyCB4xawXzkpEQvbgp0FhpDn
X-Google-Smtp-Source: AGHT+IEfGhyMvv7biK65HhfruGEzYaI5wloB/sqor7XnJ7lUm5lnZ7KHWGUWt/UC031SOzEST1HhPg==
X-Received: by 2002:a17:902:ce86:b0:234:d7b2:2ac5 with SMTP id d9443c01a7336-23fb3047e00mr8428685ad.21.1753416854288;
        Thu, 24 Jul 2025 21:14:14 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fadc8f669sm6794165ad.12.2025.07.24.21.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 21:14:13 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] block: Fix typo 'programm' -> 'program'
Date: Fri, 25 Jul 2025 00:14:16 -0400
Message-ID: <20250725041416.73567-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 block/blk-crypto-profile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 81918f6e0..72462b6f4 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -237,7 +237,7 @@ EXPORT_SYMBOL_GPL(blk_crypto_keyslot_index);
  *	      will be stored here.  blk_crypto_put_keyslot() must be called
  *	      later to release it.  Otherwise, NULL will be stored here.
  *
- * If the device has keyslots, this gets a keyslot that's been programmed with
+ * If the device has keyslots, this gets a keyslot that's been programed with
  * the specified key.  If the key is already in a slot, this reuses it;
  * otherwise this waits for a slot to become idle and programs the key into it.
  *
@@ -278,7 +278,7 @@ blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
 
 		/*
 		 * If we're here, that means there wasn't a slot that was
-		 * already programmed with the key. So try to program it.
+		 * already programed with the key. So try to program it.
 		 */
 		if (!list_empty(&profile->idle_slots))
 			break;
@@ -412,7 +412,7 @@ int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
  * blk_crypto_reprogram_all_keys() - Re-program all keyslots.
  * @profile: The crypto profile
  *
- * Re-program all keyslots that are supposed to have a key programmed.  This is
+ * Re-program all keyslots that are supposed to have a key programed.  This is
  * intended only for use by drivers for hardware that loses its keys on reset.
  *
  * Context: Process context. Takes and releases profile->lock.
-- 
2.50.1

