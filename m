Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B598C3DDDBB
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425466; cv=pass; b=kVqdlgFTPit3mC9beFcBES+2GS+wCaHA13UPLFVoHudeTwQyjKlvEsYru9/VgXhv7Nx7L8sp2Jwgc8wVdpFa3E9OuhzGHh6tnMx1+9SMN5HfXW9LdyF65G+JMVCvnPq7esrDsFat0Rlb61whktNV2ePznLo90FDT4QXqPRCn9nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425466; c=relaxed/simple;
	bh=XyVmJJh6HBLEEgKrn9e+j/w1lPeVaDuHvy9BUZiKk98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g8kk21HZTSsJQ/507g5ZlfG8sy+2sgOGgY7bRAGVL2E02ynv7CJXs5OlI3J9pSEW3vi7Ato/AbyZgUpO9AcNjuYBHMzt+2YnGS6kS0DTGiD8FGZINn2wWtoTs3g6hne6Kj1RQHWvwAeEOMT+ybNDxRbJIWOHgCzGJTD1D79r7Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=fHCDvFNT; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="fHCDvFNT"
ARC-Seal: i=1; a=rsa-sha256; t=1773425442; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=CGTd49vNYTG1LGC0zWPqn17mHo2MrVzhZLwXQ/V0OhLkaIVp4YWPxJVCK86nPgZak5HjohOhJJX8EqAP+ZKboMt19FoPUF3jYihFIjsZAeeV4495OaGgxU8xPXXlo7wvl18EdeJUfV/2dwdGNrsIlGhXqKCGJuENzITXB5Z0HTA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773425442; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gKcNwHXcOBWGX1PXnzaNnxCshq5liP1yb7BhLPxxOT4=; 
	b=ZgA642CElb9fMt7lYp0yNIMhH7JADuvsBCPAuNoi5tCUsxzngi6pxzM5OXvaeCqRv4laDiVhv2v9307O4NYlce7/xF4cem+p0nadMNKdsdYIwFsa80DMHvGEu3A++SwQGgVCTFxI/GaZLgY37GdWaQEJbm5WZFmoMhQVAC8ObsQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773425442;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=gKcNwHXcOBWGX1PXnzaNnxCshq5liP1yb7BhLPxxOT4=;
	b=fHCDvFNT44XNTrPW23GcYxy9WZ+HKBP30PqaHeWeC7EmLywAISj6+fF4+iX5hV8d
	WQXAnrTl4pqwW1dwbwj+JcHhMY4Z2DpFXGD/KhHRWuHXBfuXuoEJW/leaCoUR9lxASZ
	JuOhpAexfSVwHlY2s2cw/uN8GpyUQXWP6yN5RkTE=
Received: by mx.zoho.eu with SMTPS id 1773425440312818.9918615536272;
	Fri, 13 Mar 2026 19:10:40 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 0/7] lib/iov_iter: fix bugs found via cross-function consistency review
Date: Fri, 13 Mar 2026 18:10:31 +0000
Message-Id: <20260313181038.30018-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

A systematic review of lib/iov_iter.c checking that each iterator type
is handled consistently across all functions turned up seven issues:

- Two can cause kernel oops: a missing allocation failure check in
  iov_iter_extract_bvec_pages() (NULL deref under memory pressure), and
  a missing NULL check in iov_iter_folioq_revert() (NULL deref when
  reverting past the head of a folio_queue chain).

- Two return wrong values for partially consumed iterators:
  iov_iter_single_seg_count() ignores iov_offset for folioq, and
  iov_iter_gap_alignment() ignores iov_offset for the first iovec
  segment.

- One fires a spurious WARN_ON_ONCE for kvec iterators in
  iov_iter_restore() due to a misplaced parenthesis.

- One can read out of bounds: iov_iter_alignment_iovec/bvec enter
  their do-while loops unconditionally even when count is zero.

- One is a testing gap: copy_to_user_iter_mc() lacks the
  should_fail_usercopy() check present in all other copy helpers.

All found through code review; no runtime failures were needed to
discover them.  Each patch is independent and can be applied
separately.

Josh Law (7):
  lib/iov_iter: fix missing allocation failure check in
    iov_iter_extract_bvec_pages()
  lib/iov_iter: add NULL check on folioq->prev in
    iov_iter_folioq_revert()
  lib/iov_iter: fix misplaced parenthesis in iov_iter_restore() kvec
    check
  lib/iov_iter: account for iov_offset in iov_iter_single_seg_count()
    folioq path
  lib/iov_iter: account for iov_offset in iov_iter_gap_alignment()
  lib/iov_iter: guard iov_iter_alignment() against zero-count iovec/bvec
    iterators
  lib/iov_iter: add missing should_fail_usercopy() in
    copy_to_user_iter_mc()

 lib/iov_iter.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.34.1

