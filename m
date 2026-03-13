Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789C3DEAD4
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425468; cv=pass; b=RSxEMW/+uqGSEkk7qxR4BA0EhjnifKM2ANqrHSKgnWOo0CGFGcpyGDAmo2kxn0ode07gMPuFKAfT8qwMFLJu52F3Y6zTkAc3+CjPRaxtHl9KOsXS3k9eIYoQuW9VGTUkDhPjX0P2uSa552wEq8ENe09anp9w6EsQDgh8IT2H6ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425468; c=relaxed/simple;
	bh=68sInYsoicDg0TLV4PCCCLWw+QLSpuXwS5sMTXmXnKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cI4o+1HbmhbhDhiPTFJNvsCQqaQda7kl3Clv4L/sOkBRS/PtJlMvlffWbm0RzJDbYCJxGjAEA/waV6un1KE7zrTX5yVpktR2U1FY7bzxeuAOQ+gHgBW27ouRNRANz4/uOH2XBk6O0IS8OdJJFPKpwa5OzvlkS8aVxrkPqL47XAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=HnVsUK0c; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="HnVsUK0c"
ARC-Seal: i=1; a=rsa-sha256; t=1773425447; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=OXMNEI/QJQqqDKhlhjLKwo8dObuTOmewG5jl6r2uAaN9TBMKxb+8eGQa76C4lL4djlnlX8/THmCSBQuRtJVGzZDQNKfJq58VqhKZgyvGftOa77P+aiYiwepb/V10Ek6JS2sC5w/vAgBLZ0dZEw16sUhOlxNSj+/uIhafLFjqBLk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773425447; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JlnqFE/JwVAb0ZfMLbMBz0yidWm8ctSkmiGTlsgGfqE=; 
	b=VdktjdFdqzqvRtPpwilaX3xT5oQ6W+WUDo0g2Avgzo7AB7R6thP7vawE6MAJYytZhoiS1d/7AS8knw2PZdf/qBQ6hGP6p969lHdyjTUpYCu0ZqVcbsJVvMtdHSCdYMGT5ImIWQFJhX6Oqfu81suUgK/JVokS4ZEkSwNv+cowlJg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773425447;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=JlnqFE/JwVAb0ZfMLbMBz0yidWm8ctSkmiGTlsgGfqE=;
	b=HnVsUK0cNYMvA4JMAH5JUPbPxj8ZNkvAUuSVZu8EGLGiE1upWRZbOcS3jXWHjCsa
	W5besZAEUQUA81aEH9hInddIlLnVmHhhe6LBOJXalEBiJinjYmpDY0eb6qvx9t9y10S
	+xl+m5p69ly9/bmHYZNUGN7qZT7RKh06HeZieJdE=
Received: by mx.zoho.eu with SMTPS id 1773425444622119.22191903532143;
	Fri, 13 Mar 2026 19:10:44 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 7/7] lib/iov_iter: add missing should_fail_usercopy() in copy_to_user_iter_mc()
Date: Fri, 13 Mar 2026 18:10:38 +0000
Message-Id: <20260313181038.30018-8-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313181038.30018-1-objecting@objecting.org>
References: <20260313181038.30018-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When running fault injection tests (CONFIG_FAULT_INJECTION_USERCOPY)
against DAX/pmem read paths, the machine-check variant
copy_to_user_iter_mc() is not covered because it skips the
should_fail_usercopy() check that the normal copy_to_user_iter() has.

This means the dax_copy_to_iter() code path used for pmem reads cannot
be exercised by the usercopy fault injector, leaving a gap in test
coverage for a path that has its own distinct error handling (it must
not retry on #MC).

Found by auditing all copy_to_user/copy_from_user helper variants in
the file for consistent use of the fault injection hook and noticing
copy_to_user_iter_mc() was the only one without it.

Add the same should_fail_usercopy() check that copy_to_user_iter() has.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/iov_iter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a5bb4fbd9d38..89e04066f737 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -204,6 +204,8 @@ static __always_inline
 size_t copy_to_user_iter_mc(void __user *iter_to, size_t progress,
 			    size_t len, void *from, void *priv2)
 {
+	if (should_fail_usercopy())
+		return len;
 	if (access_ok(iter_to, len)) {
 		from += progress;
 		instrument_copy_to_user(iter_to, from, len);
-- 
2.34.1

