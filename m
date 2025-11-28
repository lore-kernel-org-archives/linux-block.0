Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E496719C540;
	Fri, 28 Nov 2025 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764313079; cv=none; b=q3ZP+Z4HshcWzxlY7ON3tOLw3+DsHNlkcI/Uu+Cgn6WO7tpJ1I1mjVYcpuk+ZLI1waX0Fyjvotg3fbk3UFOrnEbNXuiPCiOwoMMNSlbnocucmFoYxxqD155BNoGH2ZP/VwTga+gRRqAmVPsh4P/7/KnaLU1+3MI75NFoZIWgBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764313079; c=relaxed/simple;
	bh=P8sZJV9aLf+jp6I+h4zoTK9enVb+yQzfqwR676HJvrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVCAEPj5Cx5e+hNZUwx4LVyFsyKIg3+jKdM+3yWi+Cxy75glxacPLYzWeW3+FkGay1idgMTtO3Pv7jif8UA5q7bCXQYTrL9KI0RNBXK0kZV99zeyV2YL/RcFJTogFEZ1ShJ2z2pbd1q90ktC5s/nzHxHS/l+UW/aFAmOm35wl8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mEO2GF5R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mEO2GF5R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jVOGZy3H6ghPpaIlNehmyxeJIt4hHGVRTAvl0M9+rck=; b=mEO2GF5R702vVTpfYEaDYxJsw0
	1iC3yyadubJ/NR26jJVhqM+YJWp95r4MRWqJx+Oksc0mBR9oMWz8NYb2Cuewmy7C+3JFI27KWLVt7
	cRBuKvvpnhukkuQau+VEzQh1zVnsjIaKKgqhI22flESPdqBTEZYYsCO+TR4ggWB9YvqlWhdeLSrEv
	6pgHHSVhXMwSWo1H71O6S8Mzkf0gouV7++R6So43EZNnp9PlibXWvNFHn/z+V9TpKCew7f3O6K62O
	/Gt067FExOq4QRestnWC+tHczqGNhjpFWO945DHwA7UBBqWTzI2ddmvIh3c5BnPRUNe6z8HNytEGN
	O+YfJLFw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOsQV-000000004E8-38Qr;
	Fri, 28 Nov 2025 06:57:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] sbitmap: fix all kernel-doc warnings
Date: Thu, 27 Nov 2025 22:57:54 -0800
Message-ID: <20251128065754.916467-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify kernel-doc comments in sbitmap.h to prevent warnings:

Warning: include/linux/sbitmap.h:84 struct member 'alloc_hint' not
 described in 'sbitmap'
Warning: include/linux/sbitmap.h:151 struct member 'ws_active' not
 described in 'sbitmap_queue'
Warning: include/linux/sbitmap.h:552 No description found for
 return value of 'sbq_wait_ptr'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 include/linux/sbitmap.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20251127.orig/include/linux/sbitmap.h
+++ linux-next-20251127/include/linux/sbitmap.h
@@ -75,7 +75,7 @@ struct sbitmap {
 	 */
 	struct sbitmap_word *map;
 
-	/*
+	/**
 	 * @alloc_hint: Cache of last successfully allocated or freed bit.
 	 *
 	 * This is per-cpu, which allows multiple users to stick to different
@@ -128,7 +128,7 @@ struct sbitmap_queue {
 	 */
 	struct sbq_wait_state *ws;
 
-	/*
+	/**
 	 * @ws_active: count of currently active ws waitqueues
 	 */
 	atomic_t ws_active;
@@ -547,6 +547,8 @@ static inline void sbq_index_atomic_inc(
  * sbitmap_queue.
  * @sbq: Bitmap queue to wait on.
  * @wait_index: A counter per "user" of @sbq.
+ *
+ * Return: Next wait queue to be used
  */
 static inline struct sbq_wait_state *sbq_wait_ptr(struct sbitmap_queue *sbq,
 						  atomic_t *wait_index)
