Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6B3DE447
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425467; cv=pass; b=GPKvo2N+TSvGkhzszOM/NpTwkRiwbsSG3Z73yxgybL6TxOrCwKPU//ha6dSxcLzHvEwrp+Ta9aEtZ61TEOqZtyALLmQgubhtGuQqmb6pY3GF5oUfWrJiNZdLw4YbXJ9sS3b24t1zp6K7FpcMvnmpNaHugl44NYqbwLcSMutPqys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425467; c=relaxed/simple;
	bh=IFLiBLH2CQlJfYJQUH1DiMqZU4G90xmzuB1KhGFsVR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZxN8iU1dkBynZbHvmWTL1QwwOEftC+xgeT2ccaEX3ULxYvbCGjsHDumNGHp3MUsvlSPpc61i+6dzOW4I72hxR6ezPlPN2WSFftH1C8R2XVyh84a19gzUUg66mQXajjMScTuK31pQTI+MLLaLzQO9i20JNceBJIS76XgzkG8rQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=WRcFEG4d; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="WRcFEG4d"
ARC-Seal: i=1; a=rsa-sha256; t=1773425445; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LIkC9eU3Vy41CSlU4P9hKNIa/+2tAiFJnc/Hh/W9wuqowgWlGKBMQPyxyjtwp0b1Xmv0u3nVjVVmReqtUN7VvMwrDQyX4yCd9MtLKDidATkZSL5uovjSbnXNuIbr/Js3MIoGqv6QP4OxbwWOOcLjM3SIl7+6B/XC7jqlugLLDWc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773425445; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q2wEFWHClElXL8mEWY3utSjA7/avsVmLg4tZS6cFKYo=; 
	b=RFMzj+6LlNVWBdukgoBSriHR66jw62/3/oC3XQIZE5cwmXiSTJlo0m3ERS0wnTfAdGo4MNEgisgkv7Mo//4agl0LsRJgghPUiZ6NPO9f4jqHgez13D+4fnQoVkDLP6+4UN4hCH/xwBq29S45M6f7ohGYhflWA3+MyLI7+4gBV4g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773425445;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=Q2wEFWHClElXL8mEWY3utSjA7/avsVmLg4tZS6cFKYo=;
	b=WRcFEG4dmjAbFZ1LMoCIMgSiJiGJPvDnPPynUPAfURSGiQLxfdAl6axTHd48g30W
	ySBh/z4RChKDuZjq74W/zDVpDeZlCzqILvHNWNgHZ+T4DLwLC2FqozTXMU/bwYcbPUQ
	V/19QRgJASTp6KuzA6UKjxL//CLvlUKktuHrAH1U=
Received: by mx.zoho.eu with SMTPS id 1773425442308668.2028255196005;
	Fri, 13 Mar 2026 19:10:42 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 3/7] lib/iov_iter: fix misplaced parenthesis in iov_iter_restore() kvec check
Date: Fri, 13 Mar 2026 18:10:34 +0000
Message-Id: <20260313181038.30018-4-objecting@objecting.org>
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

When restoring a kvec-backed iterator after a short write in a kernel
socket sendmsg path (e.g. an NFS client resending an RPC call), the
WARN_ON_ONCE guard fires a spurious warning on every first call.

The closing parenthesis of WARN_ON_ONCE is after !iter_is_ubuf(i),
leaving !iov_iter_is_kvec(i) as a separate && operand outside the
macro:

  WARN_ON_ONCE(!bvec && !iovec && !ubuf) && !kvec

For kvec iterators this evaluates as WARN_ON_ONCE(true) && false — the
warning fires but the return is skipped, so execution proceeds correctly.
The warning is the only visible symptom, but it is confusing and may
mask real issues.

Found through code review of the operator precedence in the condition
expression and confirmed by tracing the macro expansion.

Move the closing parenthesis to include the kvec check inside
WARN_ON_ONCE so the warning only fires for genuinely unsupported
iterator types.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 325669b103ed..6a7959bfc849 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1471,7 +1471,7 @@ EXPORT_SYMBOL_GPL(import_ubuf);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
 	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
-			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
+			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i)))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;
-- 
2.34.1

