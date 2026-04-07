Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489A16FF37
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551028; cv=none; b=AIzELin46YxKdBaIaAJUAKA/BZxkJkL37rBJSUwmsrEDSCL/LcIPBpIyb79JGj7I8fGJQiN3WrwAdOM8p4I1bv6/exa/IvZ++ntWZ/5SOM9S0ND/JDTSR1yUBvGUNpEN2Oe8TOHsK8RgGWQMtkhzsTsLJAEMMGU+PZ4H9fqSUF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551028; c=relaxed/simple;
	bh=XvlssxAvmYGCpwI8ZEirW4hpfH+DiDHpLgbYYBoV+oE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCdLBoYPJA2Nu213UlzkUg3tyOUct6JO2NVILEtwAwvwBSQe2vy/QdugqSsZGt2gjbW1Qiy2qLHYaAKiBgjbAWLKj1osZJHZiN+00ngJ44jVuFcraeUInyIf6mOzNyn60OX/IyaSldcYWdPx2Eb/ul62m07oYb3bvloHAmhHoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbRhy82I; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbRhy82I"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3591cc98871so2027938a91.3
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775551027; x=1776155827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5jLNze9gklUxZaEWk/OWsNNsUPFziBh427FvAqy4MU=;
        b=RbRhy82IM1GZFDR7EYzNDIBN6ay3swEp2HywKye/3C5cSbhGcuHczq4i3XVIk3xh/J
         TPzmwjEbVwmxrZpjqey+nTUQriIcPg2LLb+NiCF/1algwNzeBs+2J9KFOHvYnaHBbL4y
         x0vInomBrzwZpGbPTB7e9EONx3BEn7HQ7UvpIj92009A1FPkVwcPNs8IBYN7jHCqvH/U
         LOQBsscBK1N0pekLkjI9+B7R0hp2wo2PSMAE6DVQqxt7lNgiBr7Cjai3putNOL2/wBsB
         ROnDBZwS+A4G1z3DzA8H8Th21Sdfc5g7nnG1Ne+unc4OFfJycplNzAuOzih/cU+T/uhg
         mptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775551027; x=1776155827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5jLNze9gklUxZaEWk/OWsNNsUPFziBh427FvAqy4MU=;
        b=U9Utet0kUrHaqmrl9sI7IwQNrqnzZsUbkvznoUbYV8JeMeCME5ZJ6jj4xyiAullTOT
         9NKtH3mST5Ha7+fX39Oji+NN86SyomiRNYvaSVzjsqlTTp7cZsU7pYF/pBqSdIf+HXTp
         qXYwm9Bs4WtBDnACO5rdqSJdnUHKlwBKuWmQPEDXlvedHQ8M1QCpzcg80DRbPMyZbD7H
         B+GEwaxmykjbXQeEWIzB9hbCRQDlr8/rXhy64Yg+kiejLEqCHRdYI1ymvizDYFbKng/W
         QDEU1us7lntP8f1gjNtnhre2TYVomW0sEygwUs4aHWh0KdldMNJuO9oIboC/DSSXqpJK
         ZWpQ==
X-Gm-Message-State: AOJu0Yznsjwi3NC5y7e4WrhACQMQ5lsz3szOkx6EebA9bDeD6fGR12hf
	WQGI5qe1LupAPfS7MtWRbbSdAnfjix40FtCC8GzXd729ABj+l3S5C6n2R4BzoAFc
X-Gm-Gg: AeBDieu5kBbjswDnslJRNitkWDeA5aimo2fk2Sygci35jaY8cH2y2rE3zi7hPvuE+3S
	Id2K0WG4mF1FfPLtcs7l8uLbRj5wOoYqSK8Hm/nHcq9SZ2JPcGFujjTeXedCwABe6azM7GErton
	Rr9bl14KBHu3GzAZTV9md7lgWyLJuR1PCqXekJPh6aPc7hlIOX340dIPXjNAk+GemhMh+BCRUWD
	K1P0iDHkZmGpe9octPEvDQE+VMASqyCXCOISqZMGOQG6ENeg+ASvTsfYT20o0WleOjyIDVtGIZK
	78csF4gPLZoPHwskojL5D9PEh2HzZpMliXVLZuq3dbWwfAa5vhYVyiMn3IfCXwLj3MehvXqT2ui
	PTVOaHS2BqamsiKBFd/QdyoXgBBR6UU4bYva84FAytG6brBaRYAskCYv2NOe1t2/AGvFPnsUz3e
	6UqqUImJXqheiwgp3o4pAsc1VHOfB3H/iMD9QkgMMiifRRmo6XEj31/KdogQ==
X-Received: by 2002:a17:90b:17c5:b0:359:f0e1:f8c9 with SMTP id 98e67ed59e1d1-35de678f2bcmr14004253a91.6.1775551026853;
        Tue, 07 Apr 2026 01:37:06 -0700 (PDT)
Received: from Rakeshs-MacBook-Air ([2406:7400:111:95f9:6054:1a93:8626:c74])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c659bedesm14210301a12.30.2026.04.07.01.37.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 01:37:06 -0700 (PDT)
From: gomid4497 <rakeshw728@gmail.com>
To: linux-block@vger.kernel.org,
	osandov@fb.com
Cc: xiliang@redhat.com,
	gomid4497 <rakeshw728@gmail.com>
Subject: [PATCH blktests] block/038: cap submit_queues to min(4, nproc) to fix failure on low CPU machines
Date: Tue,  7 Apr 2026 14:06:55 +0530
Message-ID: <20260407083655.43214-1-rakeshw728@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: gomid4497 <rakeshw728@gmail.com>
---
 tests/block/038 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/block/038 b/tests/block/038
index 56272be..5cbbd07 100755
--- a/tests/block/038
+++ b/tests/block/038
@@ -28,9 +28,10 @@ null_blk_power_loop() {
 
 null_blk_submit_queues_loop() {
 	local nullb="$1"
+	local queues=$(( $(nproc) < 4 ? $(nproc) : 4 ))
 	for ((i = 1; i <= 200; i++)); do
 		echo 1 > "/sys/kernel/config/nullb/${nullb}/submit_queues"
-		echo 4 > "/sys/kernel/config/nullb/${nullb}/submit_queues"
+		echo ${queues} > "/sys/kernel/config/nullb/${nullb}/submit_queues"
 	done
 }
 
-- 
2.50.1 (Apple Git-155)

