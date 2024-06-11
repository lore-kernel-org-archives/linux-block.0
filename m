Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 20A401E52F;
	Tue, 11 Jun 2024 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091484; cv=none; b=XeSrzlstpx/h4PrUd6NC7o5ClPNlSG8n6x/njjHgdb+qymh+/VDw09vnWhqnsDbD9C3YLjw0pzU4ynk16rzwapNDIrib2wvgw/DGqPGW/v4QRxleHxU3VkDDZkg7PAxmyajjFNAIDHFWIlU8638dp6/TC0q++Kbt3C3Z9veoXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091484; c=relaxed/simple;
	bh=72lUgCjhFS9CofYliVXKecRiALBrHqQMHHGrzotam3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E+6y+rJwW1O1Reay45jEkx3EkDljJ/bE0yBbtHmRTwL4oH3a7BDocTArjiQP86u5ftSTIg0/f7wPwRN8KnsMWyJy1PXmkUh5/4daz+OsI1cn8zDpivf/4LCcIfYgnTLiwzD80ad4b7fPPQAbx3yg3WhDdo0RWRsCrEIlnlpYziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 3201060198657;
	Tue, 11 Jun 2024 15:37:20 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: jonathan.derrick@linux.dev,
	axboe@kernel.dk,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	jarkko@kernel.org,
	gjoyce@linux.vnet.ibm.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] block: sed-opal: avoid possible wrong address reference in read_sed_opal_key()
Date: Tue, 11 Jun 2024 15:37:00 +0800
Message-Id: <20240611073659.429582-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static checker (scan-build) warning:
block/sed-opal.c:line 317, column 3
Value stored to 'ret' is never read.

Fix this problem by returning the error code when keyring_search() failed.
Otherwise, 'key' will have a wrong value when 'kerf' stores the error code.

Fixes: 3bfeb6125664 ("block: sed-opal: keyring support for SED keys")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 block/sed-opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 14fe0fef811c..598fd3e7fcc8 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -314,7 +314,7 @@ static int read_sed_opal_key(const char *key_name, u_char *buffer, int buflen)
 			      &key_type_user, key_name, true);
 
 	if (IS_ERR(kref))
-		ret = PTR_ERR(kref);
+		return PTR_ERR(kref);
 
 	key = key_ref_to_ptr(kref);
 	down_read(&key->sem);
-- 
2.30.2

