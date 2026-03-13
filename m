Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E73DD516
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425467; cv=pass; b=rt2HFMLX/OwwmpbSpuvS+c5yJnpsdE/nugjB2jA+WIS3fuEavVW4EqJDnlnw6UF3UN23wn1X0OsCUwWVBSuo/pYEqLFG8Yk9vxuCQU05lBE86kvXn6uW2FnrEz2//Ux0dhI646pU4pz1sq7OFmiu4Hcl2XYo6zUyGwKyzxvfw1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425467; c=relaxed/simple;
	bh=ye++yCaIi++/JUm3r7TUbvt9fyJotOECRprcKn02vCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUBOx3YNVOt8BmjlK+EZSDCbf0mD+VGUUDYlOTu1TKJN2VJYfxP5h0sJ09wHubSitssnnP05oQb5SYCZLOMyRFjSTBgkJEEbYiPul4fmUic/+/PPtJTl56dwibezxgiZ1TuCFAURsyv3D1O1mK9hRTVCH78M6WIGyQXABzkier4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=dEV+2uLb; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="dEV+2uLb"
ARC-Seal: i=1; a=rsa-sha256; t=1773425445; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=TOGDleYAhSqUoQSR4A9ZvswaPVJYXVvQfirhiVtVN0djwZqUwG4tgP8RtpvF2cPRfGiBVCtMa3k3KE92pk0Bm8RYML8MWRvtcl6eOjei2zURlbmJDvqKZvMBB3jXIXIIXY/xMdUn9nJHdPvqljATmyvVk5FKZopCaBXnaId+J1c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773425445; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bokNmjYprG9JKLLdcrb8B4GkUZ4kLxoTVOtpOc28ExI=; 
	b=g197aCltpWFysutiXQm2vBT7+/OXcZZn62yCNGJmQ3M3x5xvdhlyFS/eRGUdsMofXCpJuWMsB++YK9NspcbeQ8ECBDDVRKic46HqIJCk9o+46dt+LUay+Vao7ACDc4DfXiAf3Z89KHHjcScuec3zdJk3yn5RyA6/4Hmpy2/eI/Q=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773425445;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=bokNmjYprG9JKLLdcrb8B4GkUZ4kLxoTVOtpOc28ExI=;
	b=dEV+2uLb4sRA3wtFtcNe//xiIN5bxsZpLOeASQp6iyjOkAkzEMp7gQ6Ly4+j5K3Z
	jwf5c9mOB/DkxFnag/Ksa2U9qbhwR/kYl3H8XBwOsKk7AoMVbRN6BUEA7Bhj1yjivfA
	O8U98jEmQcPDsihNZlxyVNvb3PXBhV/n9X3UkAyE=
Received: by mx.zoho.eu with SMTPS id 1773425444055232.31153927404955;
	Fri, 13 Mar 2026 19:10:44 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 6/7] lib/iov_iter: guard iov_iter_alignment() against zero-count iovec/bvec iterators
Date: Fri, 13 Mar 2026 18:10:37 +0000
Message-Id: <20260313181038.30018-7-objecting@objecting.org>
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

When a direct I/O path calls iov_iter_alignment() on an iterator that
has already been fully consumed (count == 0) — which can occur when the
block layer re-checks alignment after draining all bytes — the
iov_iter_alignment_iovec() and iov_iter_alignment_bvec() helpers enter
their do-while loops unconditionally.  With count == 0 and a non-zero
first segment length, the subtraction size -= len wraps the unsigned
size_t to a large value, causing the loop to walk off the end of the
iov/bvec array and read garbage memory.

The ubuf path already guards against this (checking if (size) before
accessing the buffer), but the iovec and bvec paths do not.

Found by reviewing the function for consistent handling of edge cases
across all iterator types, noting the ubuf path's explicit zero check
had no equivalent in the other branches.

Add count == 0 guards in iov_iter_alignment() before calling into the
iovec and bvec helpers, matching the ubuf path's behavior.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/iov_iter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 18561108aa3a..a5bb4fbd9d38 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -853,10 +853,10 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 
 	/* iovec and kvec have identical layouts */
 	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
-		return iov_iter_alignment_iovec(i);
+		return i->count ? iov_iter_alignment_iovec(i) : 0;
 
 	if (iov_iter_is_bvec(i))
-		return iov_iter_alignment_bvec(i);
+		return i->count ? iov_iter_alignment_bvec(i) : 0;
 
 	/* With both xarray and folioq types, we're dealing with whole folios. */
 	if (iov_iter_is_folioq(i))
-- 
2.34.1

