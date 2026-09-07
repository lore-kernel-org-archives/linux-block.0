Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC53E3B83EF
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763307; cv=none; b=MsG6YR5bVrcwdbId2mlarOKk42oo472inGhGR0D7Ec9VUnL19KLse+CPD8USu++9tHTze5uL9Ie2cCIzsuByv5MRimSKQrCaOapLvX1Z2sdvCDcYgJxs5uAp45xMeTHigz7Qrb6uXo0VOmmuFPumJXn4oF08s43MeRe08XOyeMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763307; c=relaxed/simple;
	bh=HYQYm7Ol+ajDdBWB8eOE9bTzmYQUN/ysOtKPbk0gEOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EX8pDffeMN7EHHEo675RvpizbLilO8a3tTnpOh5TJbGe24p2qtnNFFxVbyYHavbzA0v5DD9ibP59f/Bw+//kwB5C/JsLT8j35KKPTratt/14HR374zYfECymQEK7qdeC+iILbl7hzHRVQByIE+yf5dGZRrJ6ipHJMNxmuJwcSgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCoMdSi3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCoMdSi3"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39675172593so2513539a91.2
        for <linux-block@vger.kernel.org>; Sun, 06 Sep 2026 23:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763305; x=1789368105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zflL+q58grc4cagGW8mHiAFMNdUiRsMqNFtJfF7Dmyo=;
        b=XCoMdSi3c4YjOmIc/sur3cFNq1AvOqkdb+tGIpYoz74r0V1Z8RY9sR4YTs0dDd8WWo
         5y0Xk+/kCDlfF0T9KerCa7DzftYkq7EJO7RErTOU7v0clnI8TR23SMCrLKSVsxbbHXee
         /LqrAJTKxoolta6oUyvZUwoAWZ4VT9CDPuxhQOfiwPcsSR7t8ZtBblwqJVPNSZsFOLo7
         Zx6zuL5D/f+Wm5kHFe+LBy++U5iJ32SX6WUbDAoj+PhmOPR26RZcXI1JPMhkKyvXqrNw
         BYM5aH2rkcwiNTX/uxAsO76DJB0YzFMoEYNJMW02kTP82EEaV6Jl+XpZ5cQYUhBcKtb9
         HBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763305; x=1789368105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zflL+q58grc4cagGW8mHiAFMNdUiRsMqNFtJfF7Dmyo=;
        b=CO5Y/IM1EWTUMW6i12tOGHLNzBrxWmtp6bNHP1qkx/2YKHzIhQAcfxEsqypyxnS68d
         fZnvGQDXz+awn/9h2heOYIcZ2jokJ7O8pOCfYY8xye8aHvVc3zMwKK+GmpxcsUe+q/4S
         nJhcxNEzm0fszISgwwjeUcQ5E35GWdnjef3astlAsZ8oZB+IABima10yU1CSuYPmCQ1W
         w8AIddgI5n69e4AKSWzcXq1QRYQ8RKyPGeWYyuolRAgzhcz08H9r7B5Cir/H7fbuLfm9
         xxmtned+U2BISaJibIUEeObVBThoc81EzbfIU7BGPsM5PvwY4tlVmJ+npNldkjqvvoDY
         I5/Q==
X-Forwarded-Encrypted: i=1; AKwUvBz09XSJJCYqq5Uk7b03LtHoplBr00/bO6/3Hv5OYG5Ny9fN2+v0zoBpr5Nh6rls5Imbunc/cBRCnYrDFQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kqBVIyqBwEs1BBCvtSBxcQkIDi9ySHmO6DuB0Ltvg49FOcG2Rf
	rqg0rpRt0gL7hvI52utwRjdz03t1rOmEFE7qqmz9gHknvW0s54Cu8j4S
X-Gm-Gg: AYBFou2L99FFD9C1XY/NQxFhtSRNyA5cdUwtiStBB19+w9q4W0JSWab/g0H5QREITD3
	JRtiB7AcZyhJK8YSDCRyx5RsJdhydnUlq4shmxM3IQJhGGKHP6aKI0ostbwsLgoz+/lVtEaNRr7
	+8QVl4/fgbmJeTE3LaDbRh3H6JPblGOLjP392mgictJNbBCQq4dOuvHTHKggE6aMAW163qW9OjX
	DurbXlDMyiQl1jh4kQfK9kooaz9aI4vp5ETsnOz5Hpxo401wVInsv0/5eTlupLTXDLjpKNFmFoC
	jp9HgKNQt1rG8b/BOet1baq+TSLg0DwKe4CIdKaJo0Q6i4RkGy/xJrvYSsNxsdDXU2XQG1qNg+N
	wdBz3EkRLVbS0FHg8iDAptoaM+zNvJFuDfKSeobOnbv2bTEYm6bJ4gO/grmxQknU2kK0H8yLWgW
	iR2bZQpUCxdQ60x2cR7WIjC8UjjnHq9rpZ2Cjs9f90pwpo/sjfdsitI9kkxtOTi3KnWFIj5idg4
	+1Tho1jUSFiWA==
X-Received: by 2002:a17:90b:2f87:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-39b260fe42amr31090592a91.5.1788763304914;
        Sun, 06 Sep 2026 23:41:44 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm22413038c88.0.2026.09.06.23.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:41:44 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	x86@kernel.org,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Ming Lei <tom.leiming@gmail.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 0/2] selftests: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 12:11:36 +0530
Message-ID: <20260907064138.38689-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corrects 2 misspellings and repeated words in comments.  Each is a
separate patch so that any one of them can be dropped without touching
the rest.

Nothing outside comments changes.  Every touched C file was checked by
dropping its comments, replacing each string literal with a placeholder
and collapsing whitespace; what remained was identical before and after,
so the compiled code cannot differ.

The mistakes were found with scripts/checkpatch.pl against the list in
scripts/spelling.txt.  The scanning, the edits and the changelogs were
produced with Cursor running the claude-opus-5 model, from a request to
find and fix spelling mistakes across the tree, and every correction was
then re-checked by the comparison described above.  Words that name an
identifier were left alone deliberately, even when they read as typos,
because correcting the prose would make the comment disagree with the
code it describes.

Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
is clean.  Nothing else was built, so any patch touching code that
x86_64 defconfig does not compile has been read but not compiled.

Hemanth Selam (2):
  selftests: fix typos in comments
  selftests: core: fix repeated word 'and' in comment

 tools/testing/selftests/amd-pstate/tbench.sh    | 4 ++--
 tools/testing/selftests/core/close_range_test.c | 2 +-
 tools/testing/selftests/proc/setns-dcache.c     | 2 +-
 tools/testing/selftests/proc/setns-sysvipc.c    | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c     | 6 +++---
 tools/testing/selftests/ublk/kublk.h            | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.48.1

