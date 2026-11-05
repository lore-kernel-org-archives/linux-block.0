Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.237
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793861995;
	b=c3O/OKxcX10kTH91xTD4h/KisnPvPLo1F+ef6BofNlGHWN/Lbkc3CBd5Eng3l94rxUc9
	 NyMbVJZT2BxiOHU/RwaCBXZQiuVJMfcx1pTxLXvGFn610dNcFWw3K0tXP6IyG2yk+g6Hy
	 KE8LmNGXO1JAIYWJcsB8ju4sceYl53zpN0prUa785nmClWw0JrRuS0LuUE/vH0qlltQbq
	 NvhHFd8bpcLpPs51RD13ic5ImNcarsSMX1zch18Mo5W45Lg7HA5NzpZ2PoLUjKjoMQMGH
	 zNH3PkBGJ+lOzQ0eO1LnwW6E2BCIV8pImSOCY7d8c/VP63cQJec8canlNDlpSBKrmeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793861995;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=giKD9GBB7SqWcODKYmNlG0gh8SE1gt/R19vK2YjohsA=;
	b=jMRM7mk9gYsfHekVccmzWQT8BdteBrytXimlgaVtpXXWXoHXRgvyuqjakR4AtMP5JUDG
	 ZLnhyNeely3zqV3On+qW/GkS8cM0xV0t0wuTZP0DEy8W7kEL551yb/coLnIZVlKnpBSp8
	 Yjv2VJG4EIZ67seI2J48JycheIvc9v6jA6p5kQ59YpSlwxGO9brTKNGvk6O0Zf2PPWoid
	 v1jgSU8sHZjb3xGaK4y2KCSWBTgSY1IzvsUNogn0gDGN6L9HRT3FTX7PitdHOGv7bGpFF
	 +VN75ae23lVrOi+BKfFZbkjih+pleUS4bj7Z7vYObiRa6uerl78L4UkzKaLnztr/3rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UJkINKzK;
	arc=none smtp.remote-ip=95.215.58.237
Received: from mta1.migadu.com (out-237.mta1.migadu.com [95.215.58.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811C606A31B
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 06:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D811C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UJkINKzK
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ht9W8rG1bvFhZOOVFyVUZBS1JBc1APtNoV+i3qOiW1c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793861993; v=1; x=1794466793;
 b=UJkINKzKdtLYR8KtpZuaFU8oFOUGl8oRWRJRBWewSilr+ADj9oA9XTq+T9+x9L2sd0LBRZ6i
 Z/2TgFvG+kvx8D/3Hx3IU7wQqdyh+09q4ppm9LSPVLNI+LaQrJFS/qWfkiLqiLjqQ0vCkhMYn3y
 KBzd3Uw2/VTZ5LBroZQj6YH4=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 770e8c686bfb0362;
	Thu, 05 Nov 2026 06:59:52 +0000
X-Mizu-Trace-ID: 770e8c686bfb0362
X-Migadu-Flow: FLOW_OUT
From: Mengmeng Zhao <mengmeng.zhao@linux.dev>
To: Jens Axboe <axboe@kernel.dk>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	asml.silence@gmail.com,
	hch@lst.de,
	Anuj Gupta <anuj1072538@gmail.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	Li Wang <liwang@kylinos.cn>
Subject: [RFC 3/6] dax: refuse dmabuf iterators in dax_iomap_rw()
Date: Thu,  5 Nov 2026 14:58:44 +0800
Message-ID: <20261105065847.196540-4-mengmeng.zhao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105065847.196540-1-mengmeng.zhao@linux.dev>
References: <20261105065847.196540-1-mengmeng.zhao@linux.dev>
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

From: Mengmeng Zhao <zhaomengmeng@kylinos.cn>

A dax access copies through the CPU linear address, which a device
mapping cannot provide.  A dmabuf iterator reaching dax_iomap_rw()
splats a WARN_ON_ONCE from iterate_and_advance2() and fails the I/O
with EFAULT.  Refuse it up front with -EOPNOTSUPP, as the generic
buffered copy paths already do.

Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/dax.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index 6ba50142eeb2..6ec08316aa6c 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1759,6 +1759,10 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!iomi.len)
 		return 0;
 
+	/* dax copies through the CPU, which a device mapping bypasses */
+	if (iov_iter_is_dmabuf_map(iter))
+		return -EOPNOTSUPP;
+
 	if (iov_iter_rw(iter) == WRITE) {
 		lockdep_assert_held_write(&iomi.inode->i_rwsem);
 		iomi.flags |= IOMAP_WRITE;
-- 
2.43.0

