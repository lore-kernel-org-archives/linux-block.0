Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793861981;
	b=erifGp2/Q76efNETZvZLtnMR8TYml1WVECQ73KsNp9deg98yCkCdV2Y1rR6GYFWLRuP8
	 ZU3iPT8g8wpZ4EbTehSdiWjwtHF6qn/jJO/81piCU7612wBflF5LfIR4yJkdxzufO6siw
	 T7vLFAqQPUkjeIc9++u0WEX3nD7g8qHf6bhbgAdR7eFT32ooPYGw8uLD2u6liW5zdat8A
	 lgv/BAvRupmmT9WeL7A6MBn1FkTBdw7L28Zr764NcgrqK6r7d463hmhUtvFKNSXBctliA
	 lRFuakwcOKqeDx9Z2cYphhhfeBbDT/Zb7Pxq+SdoXfaTpQX1UaAgC3phhKyvUz9LJrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793861981;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V6jXYvV9dka+3jN4FlL/QeRxDjLIKwLo+qsWJ9KiY6Q=;
	b=L8wzmpzH78CTI8xVtlduwtBxwRV0HfscWR9wyudXr3MFiU3+1RhDAVlCKLB65dC/7Uub
	 LPqWJW6z9te9NgCjZfM35bG1/jo8fEUKv02qRawPLIzzHreeshXNw7vWW7zRd4lcPvhFH
	 cqeJEBipVW63f/R/8q6EUHnD7vKk+qDettmWb/Y85yMG1RtZ8ugJSWLg/8j27TQ5qav2z
	 w8W3NnFiRB2sLnwSIwWGt0cxQ3Fn2tP1bY/Yx3im+MX0klU/aQnCFu7r0DGM/V/KLcwjW
	 FzXab03O8LPGy1DDiyq4sIs+Z1siECZ0jq35X7Z65Vt1v0U4+sZM1AplFjrVqty+P8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QaWf9wb7;
	arc=none smtp.remote-ip=91.218.175.164
Received: from mta0.migadu.com (out-164.mta0.migadu.com [91.218.175.164])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D6606A33F
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 06:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 448D6606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QaWf9wb7
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BRMlNTa2IFz117u+LpOsOZxcnQTogf6s+dFMFzcP0xM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793861978; v=1; x=1794466778;
 b=QaWf9wb7wFivbY4mUbRehlCWWKN3tB0cW4ajPirSzhAocmjyx9TuV37CtcFab/80djMAdLFe
 jRYRmmPTKw1NfQidftHLvJl0yYWgWkAWXm2oWhCr421bGdGGf0wTAUxeGgQ/rZbnokP26pzIvY7
 ddWpsDXwlLWg655twgRVJAOQ=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 724bcf4c5e474fe1;
	Thu, 05 Nov 2026 06:59:38 +0000
X-Mizu-Trace-ID: 724bcf4c5e474fe1
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
Subject: [RFC 2/6] mm/filemap: refuse dmabuf iterators in the generic read/write copy paths
Date: Thu,  5 Nov 2026 14:58:43 +0800
Message-ID: <20261105065847.196540-3-mengmeng.zhao@linux.dev>
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

The generic copy helpers cannot touch device memory.  Refuse a
dmabuf iterator in generic_perform_write() and the filemap_read()
fallback while keeping any direct-I/O progress, and report a busy
folio from generic_file_direct_write() as -EAGAIN instead of asking
for the buffered fallback such an iterator cannot take.

Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 mm/filemap.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6afec636881f..ab8a5391a699 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3013,6 +3013,14 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			return retval;
 	}
 
+	/*
+	 * Buffered I/O read is not supported for dmabuf; a short direct
+	 * read before this point stands on its own, as in
+	 * direct_write_fallback().
+	 */
+	if (iov_iter_is_dmabuf_map(iter))
+		return retval > 0 ? retval : -EOPNOTSUPP;
+
 	return filemap_read(iocb, iter, retval);
 }
 EXPORT_SYMBOL(generic_file_read_iter);
@@ -4300,8 +4308,14 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 */
 	written = kiocb_invalidate_pages(iocb, write_len);
 	if (written) {
-		if (written == -EBUSY)
+		if (written == -EBUSY) {
+			/*
+			 * Avoid fallback to buffered write for dmabuf.
+			 */
+			if (iov_iter_is_dmabuf_map(from))
+				return -EAGAIN;
 			return 0;
+		}
 		return written;
 	}
 
@@ -4353,6 +4367,12 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	long status = 0;
 	ssize_t written = 0;
 
+	/*
+	 * Buffered write is not supported for dmabuf.
+	 */
+	if (iov_iter_is_dmabuf_map(i))
+		return -EOPNOTSUPP;
+
 	do {
 		struct folio *folio;
 		size_t offset;		/* Offset into folio */
-- 
2.43.0

