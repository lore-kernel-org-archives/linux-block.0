Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580892;
	b=qP5c+Nka2Z+yeGz5njXebx+Y9adTAMylazOPDTpNEKGQZAzoMEgje5vdFdD4RePs4Gl1
	 l0dg6FLrdQbj9H2cl8Wl6zJNWB1Bwa6ulFNoBtvyoyj+DeIIeNORTKCTzZPVd9eZEUw1c
	 ZI0zR3I21PG/X5eNr7grF/9cJ/Ivqad4qiAOemeS31EP7zcLImeIJDYtBUM4/myYMiqec
	 aR/GudEg6MUMOivgCl7UxVKt9sj6Hv7XCYx4rK4DXXyvx/3npeqx3YayJRGAvZQqjNZdK
	 EffJB8AwI6Om1sVgq/EWdFX45Pih/brKuYPWFieoLzHMX+LtD9+SAQ4iYqWqn9zLgnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580892;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=P4cHTt6FfayCtzuU1ZE9TymPXrimZ4PH2J4IIPYQ8W4=;
	b=AkRsea1iaE4g3O382rPlb9aL2sH/jOUQH11Ji5J5JOGCT/lRmAAJ1xNUWGj4ofDByh9y
	 X17OH39V1QAmHGNt6jhhABKSy2nkjMxK24rfL08fHhToDI+oC9ZJidnqB/b1DXDO/IFxG
	 AWfgGgDttdGHECSv9zcIX6qYvWLuKI5ZkdiidWyqldeWtEo5vLjDfZB5oaDlZgSmJSw+7
	 8CW6Cr1nZ+W5P8e7nuO1Sl/CBoTPdMynfTLApnfG8yQaXEefNSX9jgF73chdlR3/OeDEJ
	 D6xdAw8xRQWzsitaaWSfZoyyNRl2JEsg+d817XZfapVYQxgE7HiSa38czS4jPQaOqKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bAwwnK+k;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50088606A319;
	Wed, 21 Oct 2026 11:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50088606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bAwwnK+k
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j8mjG0slGzKnwP;
	Wed, 21 Oct 2026 13:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792580882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P4cHTt6FfayCtzuU1ZE9TymPXrimZ4PH2J4IIPYQ8W4=;
	b=bAwwnK+keC/NY8FGQISdUPcKOKHGYFCYsbaqez9cpnR3a/DCViN+kyoS8XlfApzEdpYwJa
	c2+zih4B2S/rXOe8Do+8QXlfCLzf0oD8pO1Uo8CMLWsP5FDtYLddTurSzJr25xmXTn3+T7
	FRzi7APRPeDbUNzecXPTVjXvb6TfCBpXDkNmkSoe3jJYDAklhp+7h/QK/BMNXvHYukJM4v
	z/yLQD3MY4JlsI3Tnlj7oTMXQGwrYlz738fOiTn/U0/lMbmapVwFuRDizfpUIsR7bkTGzy
	zop2RXD3HEBTty+ySZsBiPiRdUYwhBHeofuOTW2eNXESo08lIvMjQmFH1QAmfA==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] partitions: aix: fix kernel-doc
Date: Wed, 21 Oct 2026 13:07:10 +0200
Message-ID: <20261021110710.1721073-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b9fe99b60fdc467f228
X-MBO-RS-META: x5jrrny8cxpq8czs7eprnureosojr9p4

Add ':' to fix:

  $ ./scripts/kernel-doc --none block/partitions/aix.c
  Warning: block/partitions/aix.c:80 function parameter 'state' not described in 'read_lba'
  Warning: block/partitions/aix.c:80 function parameter 'lba' not described in 'read_lba'
  Warning: block/partitions/aix.c:80 function parameter 'buffer' not described in 'read_lba'
  Warning: block/partitions/aix.c:80 function parameter 'count' not described in 'read_lba'
  Warning: block/partitions/aix.c:113 function parameter 'state' not described in 'alloc_pvd'
  Warning: block/partitions/aix.c:113 function parameter 'lba' not described in 'alloc_pvd'
  Warning: block/partitions/aix.c:138 function parameter 'state' not described in 'alloc_lvn'
  Warning: block/partitions/aix.c:138 function parameter 'lba' not described in 'alloc_lvn'

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 block/partitions/aix.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 689837deb..adea48f4a 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -68,10 +68,10 @@ struct pvd {
 
 /**
  * read_lba(): Read bytes from disk, starting at given LBA
- * @state
- * @lba
- * @buffer
- * @count
+ * @state:
+ * @lba:
+ * @buffer:
+ * @count:
  *
  * Description:  Reads @count bytes from @state->disk into @buffer.
  * Returns number of bytes read on success, 0 on error.
@@ -103,8 +103,8 @@ static size_t read_lba(struct parsed_partitions *state, u64 lba, u8 *buffer,
 
 /**
  * alloc_pvd(): reads physical volume descriptor
- * @state
- * @lba
+ * @state:
+ * @lba:
  *
  * Description: Returns pvd on success,  NULL on error.
  * Allocates space for pvd and fill it with disk blocks at @lba
@@ -128,8 +128,8 @@ static struct pvd *alloc_pvd(struct parsed_partitions *state, u32 lba)
 
 /**
  * alloc_lvn(): reads logical volume names
- * @state
- * @lba
+ * @state:
+ * @lba:
  *
  * Description: Returns lvn on success,  NULL on error.
  * Allocates space for lvn and fill it with disk blocks at @lba
-- 
2.55.0

