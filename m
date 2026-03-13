Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58E93DC4BC
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425466; cv=pass; b=XjAW9j+/43J4Myn8uWAAzgwvbq56fQUHZFlQN1MbyooqIW9u0pcsQvJYyLQaIWJnqTWKZHzjhNB+uMkoxI1HwhwKbCCdhhWIua/jA71Uh7c2YwsgjZd3NwP+chRq902wIlu6zv9mr1lFHvQcO2XGIM4A8xY3kmWjvOd0H/j86y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425466; c=relaxed/simple;
	bh=djYHWh5797V5FFMCTTT8D+SX719WAsRUsR06ws370Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnkhQ0Wxwq3NTE/IlbKPJahx6FvUrKif9w14XwCcNE2AgL5Pp6OSkK+KQTBCa3R2Nk5ffrWbRGYM8hdFUmDr9TISnnFPu+pe3+oqEVmjnJ3KoF9PymN4kxMvc2kD9fLbVAotLSGYw1V1u0NF6igXVcqg6lt0W8oodNtQPMQvBZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Jt5DlSnW; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Jt5DlSnW"
ARC-Seal: i=1; a=rsa-sha256; t=1773425445; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Ft5wvn2YlO3FAA0HXu8fqLV/PKOpVGq8xYFS2CELi38tgzhdWj3jZkwMpDP3hV0djfPPUWSE4fe4qXjPsi+yIJ4g+AzprpOmidcBFl3U017CEksm/G+RGLmWuyeBgf8qeKyDAYxL+QicqCHuTVj3GNdferxR86FwTn3glVZxeZM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773425445; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=orO1a/zODaBIJYN0vC2FaQCr3Has8dtmh84CnFyWWEY=; 
	b=Go1dqoRvaR+OZ3lec31+uCxNqQqinWKJvXQfnz+mhMxX6Aui1/BSmXtPz107iAzln4ulcjzvJ6xsT/QPdJr8G03MUV7RF/dVTwBKSZ/7zBXw8d8L3o7LIzGvZ/BRph8bl82ETl5n++w6zdNG55nSpxw/8xCV9dUNoxBNF05gbOk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773425445;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=orO1a/zODaBIJYN0vC2FaQCr3Has8dtmh84CnFyWWEY=;
	b=Jt5DlSnWZ28ZzIRI/1ZhHQw9ejQNU9J7LYvKWu7l8sRxi+i4/ygSkb7pzcqYNDox
	hAo78DdShsF8+64TXP7ag3RJ0qkveNYEIM3hjA8n+ZUDvAaKAtdGk7Ev4NYS75WDOhY
	EG12+pShTYgfl4R0lYhrPTZ+18vUKpxmqgIlUrSM=
Received: by mx.zoho.eu with SMTPS id 1773425443427459.1214546636411;
	Fri, 13 Mar 2026 19:10:43 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 5/7] lib/iov_iter: account for iov_offset in iov_iter_gap_alignment()
Date: Fri, 13 Mar 2026 18:10:36 +0000
Message-Id: <20260313181038.30018-6-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313181038.30018-1-objecting@objecting.org>
References: <20260313181038.30018-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When the block layer checks gap alignment constraints for a partially
consumed iovec iterator — as can happen during large direct I/O
submissions that get split across multiple bio's — iov_iter_gap_alignment()
uses the raw iov_base and iov_len of the first segment without adjusting
for iov_offset.  This reports the alignment of already-consumed data
rather than the remaining portion, which can cause the block layer to
apply incorrect gap alignment restrictions.

Found by comparing the first-segment handling in iov_iter_gap_alignment()
against iov_iter_alignment_iovec(), which correctly applies iov_offset
via its skip variable.

Apply iov_offset to the base address and length of the first segment so
that gap alignment reflects the actual remaining data.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/iov_iter.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 375512beefc5..18561108aa3a 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -883,14 +883,16 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 
 	for (k = 0; k < i->nr_segs; k++) {
 		const struct iovec *iov = iter_iov(i) + k;
-		if (iov->iov_len) {
-			unsigned long base = (unsigned long)iov->iov_base;
+		size_t skip = k ? 0 : i->iov_offset;
+		size_t len = iov->iov_len - skip;
+		if (len) {
+			unsigned long base = (unsigned long)iov->iov_base + skip;
 			if (v) // if not the first one
 				res |= base | v; // this start | previous end
-			v = base + iov->iov_len;
-			if (size <= iov->iov_len)
+			v = base + len;
+			if (size <= len)
 				break;
-			size -= iov->iov_len;
+			size -= len;
 		}
 	}
 	return res;
-- 
2.34.1

