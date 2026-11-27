Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765533;
	b=uOd4FYRW7NUAF1mYAdOabBtC0P54gIiNer4i+niU3tmu14v4XJI/fPul/rw2bB9YvOYF
	 3wIiS+2NA1QWdiqlDhDswUYLb8RzpMmvfKhuDi60xEFfD6Xgzi/I7eg5U3TiEM2HdBRfY
	 fARnx00JjlRw/TYhlUxF1py9B6TNVVxWxwYY0F3n6ZkIWQVXRd9yhsNv+XqaQ5OL7u268
	 Q/h6OCfSVCCNq3Y0BnIF3ju68UXVhf7RmzJ9GWv4vWdqnSCKXQtN2udfVs8TAKgoWMMWF
	 0/h28jXi9aI6rEGfvxDyGQ7XDOV28VWEZTi4K7qdcH1oCk9iUF/mWf9tNX3fA+3tkCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765533;
	h=DMARC-Filter:DKIM-Signature:To:X-Mailer:From:Date:Mime-Version:
	 Content-Type:X-Lms-Return-Path:Cc:Message-Id:X-Original-From:
	 Content-Transfer-Encoding:Subject;
	bh=IGjbm17ZvCxvZavs63NqVwJ5WPYcx7Gd6rablI3NUkA=;
	b=II46tOhgt3X7/Gc38f29KwQJYzcvbePM1vYV/vIpoUjpOTUcLrp9oMFeFQ98K/NMMuOM
	 OtrjzKKnl/llXob6vEG7a2QkwKTminglCShvpBetkNY5NLhWCDYtZVkpWG++f/klTcAl0
	 QEcdgZDhtJSLpnN2VURnENdJqxxmnyE648ko4dhgKKh2KfCSRNtNFSweEnRQq+9RsBF1T
	 2Z114UQ5gMyTrcUrZxHdEqQidw9SwNq8PxvCGbAbRGzRqrlj8u4JG4qUPwkjAtWMEA3Ct
	 Wjx6IO/I2rJ4LZyqOBYwAlcVsIAmOECw0RaoOo2YO7+yHXBvnVXlULGw+HMyNdXhYIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=KRqNgSD+;
	arc=none smtp.remote-ip=209.127.230.115
Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8B606A31C
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 07:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAF8B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=KRqNgSD+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1795765527; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=IGjbm17ZvCxvZavs63NqVwJ5WPYcx7Gd6rablI3NUkA=;
 b=KRqNgSD+HuID0Fgs/MUxyVKpSmlbLX2JioyaLg10hQNWE+nFMVYCEQ62BvbezTFmNMP8Ht
 fQN+D2bN+/q6/As1Yl05LshYSlAO/+AC6kEIeWjB3BGACNw6epA1weDQhno0NOacaRkWtg
 0IEj6uRXANDKxkck0bhp+a/4u4QhwJtPQE1EYZ2WjvI3ERTSEwxaPnSoLQ8qMf7XBHx5zu
 TPrHpICn2kNhx1LNBJqrhJG7+Xnfo6SEedab3OhGYQqu2GlPmUSmuLQi98Htkvav5Jy3pC
 8ggRZAvn3R3u00epg7xs//EA4JDiviEqEPdT4vVw85MUwRC5ZbzGzdV4Scg5ow==
To: "Jens Axboe" <axboe@kernel.dk>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Date: Fri, 27 Nov 2026 15:45:00 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26b093514+3061e1+vger.kernel.org+zhaogongyi@bytedance.com>
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Jan Kara" <jack@suse.cz>
Message-Id: <20261127074500.89094-1-zhaogongyi@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
Subject: [PATCH] block/partitions: lock the mapping while reading a partition sector

A concurrent BLKBSZSET and BLKRRPART reproducer reports
"Unable to handle kernel NULL pointer dereference" in
create_empty_buffers(). The relevant call trace is:

  create_empty_buffers
  block_read_full_folio
  blkdev_read_folio
  read_cache_folio
  read_part_sector
  msdos_partition

read_part_sector() calls read_mapping_folio() without the mapping's
invalidate_lock. The race can allocate a folio at the old minimum order
and then create buffer heads using the new block size. When the folio is
smaller than the block size, create_empty_buffers() dereferences NULL.

Hold the shared invalidate_lock across the read, pairing with the
exclusive lock in set_blocksize().

Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
Testing (arm64 QEMU/KVM, GCC 8.3, KASAN/KCOV/UBSAN disabled):
  Unpatched: the reproducer triggered a NULL dereference in
  create_empty_buffers() in 3/3 runs.
  Patched: no crash in 5/5 runs with the same reproducer.

 block/partitions/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index b5c59b79ca7cb..a36eeb235d5e0 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -721,7 +721,9 @@ void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 		goto out;
 	}
 
+	filemap_invalidate_lock_shared(mapping);
 	folio = read_mapping_folio(mapping, n >> PAGE_SECTORS_SHIFT, NULL);
+	filemap_invalidate_unlock_shared(mapping);
 	if (IS_ERR(folio))
 		goto out;
 

base-commit: 5a29cfaf51105039d156dd8a61d2783e8b653667
-- 
2.39.5 (Apple Git-154)
