Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE933ED127
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691775; cv=none; b=CIKqK747t+A/+Gf7u2b+jSvzRlZkhAyRzcZGzM/vUX8rZfsGj/vWr66F1lj3DyQZ0TxRNZG33QFKF7GyaocZ2hTztoxKzvuRzzjWWkw+24AIySa47HJOJsLFtzrDMKTpcRAK4BYuYWcJ/IZT8WAP2GZYRC8hyxsFQlivSKNRpGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691775; c=relaxed/simple;
	bh=6mvBoj3B9nx4GqtAC4XdEkz4MZgOFwA9+bgYeplTNUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8pOl3noDJgXX72GSoy0QHmnBeIJ4qg6o2lloKN/EJgRil9HbWJ7eoTTZ8FzR8hGJsY5xdNI/qvFHSzuJ7gP/LUJLCY3GStaDkwNaPAbGgBJ488fp//3bYxJBJKGxpWG9MvHUmkyyioGSSw3g2AnlRVFRVi5Vpc4+jg2x8YtN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HQVBEUGF; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HQVBEUGF"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR593xKkzlffvM;
	Mon, 16 Mar 2026 20:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773691767; x=1776283768; bh=f7uco
	LGhvULKEeflgeJvGOLrdGggYqtY1tW+f5+pHSk=; b=HQVBEUGF4GSMDU9ygUFyz
	nPWn3ZuRAtaGTdALA59GXmhdrjLQ0DN7QUYD9t6YEFA3ixOKoPxsPsKJBmCrMvEG
	AElyggtDGa+lWU77hsJRJgnFWkHifNBTcCB/Ku1VDVrk3MWpU4b3SP6JR7Z4Ikc6
	ij7DRjOkYZMj5xbIMp2k9RG/TQdO0c4EK4zlxT5cpAGT+Zo1BoPbXxgDnazk73Cg
	nYJ6vdjgcYNY1M7HVpaQ6G9N+kXk2pO4lAueXq2/3PTJ+sTry2fzVml/yg9vySLc
	TsfKEC0CWu/bydjYkZ57LDkYmDz+qKblUovCs5r4Hr3/h/4Ce5M/PtU59G/5ayom
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9jp2Xdd9ZCK8; Mon, 16 Mar 2026 20:09:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR4y16VlzlfgPq;
	Mon, 16 Mar 2026 20:09:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2] powerpc/powermac: Remove pmac_low_i2c_{lock,unlock}()
Date: Mon, 16 Mar 2026 13:08:38 -0700
Message-ID: <20260316200901.4111651-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316200901.4111651-1-bvanassche@acm.org>
References: <20260316200901.4111651-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit a28d3af2a26c ("[PATCH] 2/5 powerpc: Rework PowerMac i2c part 2")
removed the last calls to the pmac_low_i2c_{lock,unlock}() functions.
Hence, remove these two functions.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v1: corrected the description of the history of the r=
emoved
  functions and added Christophe's Reviewed-by tag.

 arch/powerpc/include/asm/pmac_low_i2c.h   |  4 ---
 arch/powerpc/platforms/powermac/low_i2c.c | 34 -----------------------
 2 files changed, 38 deletions(-)

diff --git a/arch/powerpc/include/asm/pmac_low_i2c.h b/arch/powerpc/inclu=
de/asm/pmac_low_i2c.h
index 21bd7297c87f..fead8fae08ab 100644
--- a/arch/powerpc/include/asm/pmac_low_i2c.h
+++ b/arch/powerpc/include/asm/pmac_low_i2c.h
@@ -79,10 +79,6 @@ extern int pmac_i2c_match_adapter(struct device_node *=
dev,
 				  struct i2c_adapter *adapter);
=20
=20
-/* (legacy) Locking functions exposed to i2c-keywest */
-extern int pmac_low_i2c_lock(struct device_node *np);
-extern int pmac_low_i2c_unlock(struct device_node *np);
-
 /* Access functions for platform code */
 extern int pmac_i2c_open(struct pmac_i2c_bus *bus, int polled);
 extern void pmac_i2c_close(struct pmac_i2c_bus *bus);
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/pla=
tforms/powermac/low_i2c.c
index 73b7f4e8c047..da72a30ab865 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1058,40 +1058,6 @@ int pmac_i2c_match_adapter(struct device_node *dev=
, struct i2c_adapter *adapter)
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_match_adapter);
=20
-int pmac_low_i2c_lock(struct device_node *np)
-{
-	struct pmac_i2c_bus *bus, *found =3D NULL;
-
-	list_for_each_entry(bus, &pmac_i2c_busses, link) {
-		if (np =3D=3D bus->controller) {
-			found =3D bus;
-			break;
-		}
-	}
-	if (!found)
-		return -ENODEV;
-	return pmac_i2c_open(bus, 0);
-}
-EXPORT_SYMBOL_GPL(pmac_low_i2c_lock);
-
-int pmac_low_i2c_unlock(struct device_node *np)
-{
-	struct pmac_i2c_bus *bus, *found =3D NULL;
-
-	list_for_each_entry(bus, &pmac_i2c_busses, link) {
-		if (np =3D=3D bus->controller) {
-			found =3D bus;
-			break;
-		}
-	}
-	if (!found)
-		return -ENODEV;
-	pmac_i2c_close(bus);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pmac_low_i2c_unlock);
-
-
 int pmac_i2c_open(struct pmac_i2c_bus *bus, int polled)
 {
 	int rc;
