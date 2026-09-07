Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A9403150
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763315; cv=none; b=YIeCWb+5wG4SAF8YuFlqI3tN9k+yBI5IlXXMIuOhkL9s22/EH96CBLktOuNdRzjNqMXNsNmpN4l5/HymThV4DWoUvrNlOoQ3L4+WIyHAmul6BA8IMP/z8wf95QTjz7qm4Kml/p+oxq1qM+Of8xVyvYMeT/Rg0qu2XwiKe0qLcIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763315; c=relaxed/simple;
	bh=1cJY6sL+Q6oG2/VnhFlaXz7tgv3rZc5fSR5r9wiilcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSGvPbFgf8c2we8iW6zpYSPJek6YzEXp8SDr6E+nKJcxI9x61va8gBrSta/o1EIq91/Zf4WqMRUe0ynneK4YHdD8iP1vO/TrGQvx77+Dph3CL/9htUguKZoEdzxAZ+6O6dCwSThDLsiEqBIRXTFb+DtumSH3CImcWErD0sj7Igo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9QbOWEP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9QbOWEP"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso3274801a91.0
        for <linux-block@vger.kernel.org>; Sun, 06 Sep 2026 23:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763313; x=1789368113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vvpO/+VHQl+z4w7f6yOyVn2oZshJZNt+Vlm/SjhRNLI=;
        b=n9QbOWEPubRmudynV5jhJHNME6N0aBKMpxH7MFo7ob+wBluIf59xWfYxptknsKtU7r
         c+zAKNtY9z1SzZT5AKfDujDWOOzvhw9/V/pedX7IvvtVuEzmZz/vg3BSlHDqA2KSLNar
         fAF4SN/iq+xWTW4XORM8IoO7smJOiCMhb49Dd6qi/EL501Q1Ra1pGYpCn8lta5chuoac
         eqxn9kSvTYnVzs1UG22fn+bAG1anA3N92RlXGR13p+rwHEQlhxSyF8GC9ZfKfECdh81r
         2uMXtLI3+8ssDhVgsvxuplUgSfO8SEo3Grei6DwzzdXHmynuhM+Div8sFLqnIABf3Mik
         b5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763313; x=1789368113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vvpO/+VHQl+z4w7f6yOyVn2oZshJZNt+Vlm/SjhRNLI=;
        b=Zr4INzSmngcGZkEBYMULIJJZiAEEgONg9tGcfYL90dXVUZ15ILsm7DUsUX1E7tcD7Z
         6uBafrj3bDo1i3f3eUkFqlp7ORdZS7VmDQ3RckQjsy5/Swu4RuVMEbeMQcY6aAJAqmo3
         org7v2EaMlckITdueigC+lMU+JOA+M8mGNYpreIC0rf+/J44afuhhO5n+d3U+SYK4yB3
         ddftK+sC7sNMMrPOmYOmI2ZjZBjebU7c0uJUzpGFnO0VgQvw8MxH+70U7iuerDjVFRf1
         AZDP1T2sHhMndpMsIkcbHZ6g9ZTMca+AaRMnwnRjm/sU0mbmHbAet17rzaQ3K0q4TfXN
         cqkw==
X-Forwarded-Encrypted: i=1; AKwUvBznj9o1TUw+WCHZrQSnTxIuJFGaZ8MHjU3GmCOxrPBQhGwa/TakNCLZGNddj75ApHWwePB8PLuE8fktig==@vger.kernel.org
X-Gm-Message-State: AFuF++lO95s78ee23VrVNMMi0fsPzpaPOGDPmjt2arC2nM8LxyrgmOxL
	38RD61NLNvQnfMkoDKdJ21cHVYvXid9NSupzijYxbLgvzMPLl7/u0rXV
X-Gm-Gg: AYBFou25ag9+1cicwpyMZYe6NRrDYsqyHDbGKqGJOsM+3slHwccIB+8DhnA9KOmQAaF
	o/U/z6LUYdYErx9N2YyTOLu2cUtwQrriplJHh+8RH3CtrCcsCCToFWrqvRMJW1vmZjbEoV0UvQr
	foSPOq57ysd53H2xTvTnNoqn5GJy55MSm7wGMwbwBjJQ3R/zFUazpuBLEwPbqd+2O/AmNaHw03+
	UVlQnBbjwrgTHJv0jIqtK5alCv0flLX9efQnMsUX/7V7ZWY0nd6dgzyIup6mf/d4yBpk5T3bkzV
	Oi6CMeAG5dp4ed+RGtkbyjZe0mrO+DE4GYASsCaJwbE9/RJVCjlvZFy2UWljGmkZuXkPWc6UmIQ
	P+ASjWhUs0E+4M7JqDFupCs43704L2HjIlExPsYxTRx26vpE6pyyEewUxS4Z/id9JGo0gLHlTXp
	W2ZCptObjDyJBBU4sK/Og0s4/dnjayhjtna/j1IdsIhyV3h9SLS77CyNtdIoCBC2nPQoMfvM4ux
	mAZSnttGEfXpMK80MYq6oAd
X-Received: by 2002:a17:90b:5905:b0:398:9bd5:490b with SMTP id 98e67ed59e1d1-39b262133ccmr31094553a91.18.1788763313430;
        Sun, 06 Sep 2026 23:41:53 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm22413038c88.0.2026.09.06.23.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:41:53 -0700 (PDT)
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
Subject: [PATCH 2/2] selftests: core: fix repeated word 'and' in comment
Date: Mon,  7 Sep 2026 12:11:38 +0530
Message-ID: <20260907064138.38689-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064138.38689-1-hemanth.selam@gmail.com>
References: <20260907064138.38689-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'and', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/core/close_range_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index f14eca63f20c..88e7ce6ee977 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -506,7 +506,7 @@ TEST(close_range_cloexec_unshare_syzbot)
 
 	/*
 	 * Create a huge gap in the fd table. When we now call
-	 * CLOSE_RANGE_UNSHARE with a shared fd table and and with ~0U as upper
+	 * CLOSE_RANGE_UNSHARE with a shared fd table and with ~0U as upper
 	 * bound the kernel will only copy up to fd1 file descriptors into the
 	 * new fd table. If the kernel is buggy and doesn't handle
 	 * CLOSE_RANGE_CLOEXEC correctly it will not have copied all file
-- 
2.48.1

