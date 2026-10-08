Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF94756C4
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459584; cv=none; b=f9cvslXJDRwkYk5c0SrlzB0famFdQ/34Yd3Ly+Xq4cTU4istFbGYZLTlN90Nk0ezaQ+t06Xgq9xETg96zVs/neLZfBsKPjKg+GoBdv57WH2IuNp1nkFvwv7oXK4cPuy14+tU+eQYJ3CPFheRCM4TmeW8eVY3CR8MvTa/vtH9GtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459584; c=relaxed/simple;
	bh=qh4hwJy1A4Dc07e6LEErqO0jiKfzaOKBZfypbSvUcYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQZgRja7zVE2dJzd5XowUFpajWyb5OaO2WfKIhmP8tMM3+T0j1g/ARle08P6YGMkHPPf51Jae4x6XAquirYvgg0CC5VJAZPisb9ZAOIE2JZ4d3r8bYewEvWHyIAJjMtnxEwpfWWnwl6S4pjXQcO09xL6V0e25cLQ95aroSuEMFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKvxWK1A; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKvxWK1A"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8253bc5a613so3695714a34.0
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459582; x=1792064382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzI+GomAPiikqf4PmaQLaS9iBLTMVvJKMfWT6zXyTF4=;
        b=pKvxWK1AB9O6XQoKZQL19t88JU01tOznW/E/MEdb00dnwdOahcRy0OdtEszSl9lvxU
         CVbTIljwId0hBuXU2CXuH/qwtpBNB4U+WbWXvfYgibyQ/epPV9FLkyNsoPYz2htV0+u8
         yTNQm16fyZ8VyS5yaOXA/OKPoROosMPPjvLDBlVS1YKcaHYhHxQQc8r8egWT1BOBOTHq
         ulQ5HT5z5atV6ETrGNKFCN197gLO7MrRNoj6jCY5Q3wY1d9t21RPNSnoJsY5OfsKFy5R
         L68NdfvXU7Z2oMts9R2Eg6GGmY2PUMArO+1Oo5tS+Ixjb3+TcbKLcaFdEQJPANbC9yhJ
         PPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459582; x=1792064382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzI+GomAPiikqf4PmaQLaS9iBLTMVvJKMfWT6zXyTF4=;
        b=wcN703zpcgdMOQ0AGFuQO8i461eH4okR+IZU/dM+PLGQ8dUJo8mGNpCtVTI4XBw3hg
         QmOoNAkG+cBRuWZLLnUAwuamJpQW85lMB4bH8t3zEHv5KOMNrUzry1XLYlrdYjOICDj0
         D+QExS9I48Zy0DJYLja397Sgpq/Cok11/lVv5S2XJXSQxWLRnR54vxQcKvks73ZgbHiJ
         bgzfQvtrlExbdMIrSKfaQS2TGBoCzN2tauUrHlkQXYZKVQxDzabl1W+pT1fot/v/B4un
         jDf4/S2f1+Zqwqj2vLBUhCTID00hcVSz4kTQ9XxIPjVfoHSs8xLZvow5U0I1zZ8BEKps
         73nA==
X-Gm-Message-State: AFuF++nngCUftY4qw9M52EsfNk9Pl19y9Syqs5gZK7T35Vi6ZyfkNowk
	VB7Tnw8kTDxMYZJr09YXJl/Yymk1AYcNC3hkEtGPpwIJmLZgXSJka7H4XX6QUnGz
X-Gm-Gg: AYBFou1uLQe6OxMVgu9H6biFK1lcV1UubpImacBMZSegi516MLhpubtd3bDrTHBtD0o
	2u7WqySRdjxlMlV21jrCbwuTLJnryeWRkIeSjydDM8iIh4d64M42M2krHgdv1YU5LJwlnUhxWwQ
	2rZcISj6+X44k8IAUR1EdM+FjeTWS/gDOncNECJAqIlzGv1U2XxdXM2zC4VFmGoN6ZVQWLFnBM2
	82VGkvxyAwlLZRM4VmU/QIYl/3LffCTtzcYCDvxSIDMLRqAQ6QtD/tcMm9lxS7VnsjNpSjPLnc5
	GMk/vIz7RATrcJwTrlB3CszT0bJBQUNHGo0/iWszcAUden+Q8s5TsAhfRQTlGnyiNuHTvLKo5C9
	641iPawBnOi+LxxOcNrYkYDSnyaQ/CYkQsDGmeqkb7iiMXN1Ew6CLO2I70+2mZIfaiCrB5X2zas
	h9dUGFunD1v8J62NddbVHeyEd8L1otp8iIbGoNEM+Of1mLNzG18iDuAFQeg/i6/cfRVKiH9CsTc
	dChEWkgQcJM1TePHfQUOGKkG3LYXAduaR0O7dfJaafpOvKes15aDXSzSoox3dBXgWD8Bb1t5S43
	QY8dfmh50JjasB1q+Th8rVayYuc=
X-Received: by 2002:a05:6830:349e:b0:815:e63f:9b90 with SMTP id 46e09a7af769-82aca089b86mr6570521a34.0.1791459581814;
        Thu, 08 Oct 2026 04:39:41 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcb187c8sm6045154a34.22.2026.10.08.04.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:39:41 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 10/11] selftests: ublk: stop a batch thread when PREP_IO_CMDS fails
Date: Thu,  8 Oct 2026 06:39:06 -0500
Message-ID: <20261008113907.4000838-11-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008113907.4000838-1-tom.leiming@gmail.com>
References: <20261008113907.4000838-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since STOP_DEV turns the server away until it closes /dev/ublkcN,
UBLK_U_IO_PREP_IO_CMDS can complete with UBLK_IO_RES_ABORT when it
races STOP_DEV. kublk asserts that PREP succeeds, so the daemon aborts
before it reports to `kublk add`, which then waits for the start event
forever.

Stop the thread like a failed FETCH_IO_CMDS does. The daemon's
START_DEV then fails, and `kublk add` gets the error.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/linux-block/63d8149c093169706e7478e779116b61.josef@toxicpanda.com/
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 tools/testing/selftests/ublk/batch.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
index d8d9ebed5979..dfc81ee17d07 100644
--- a/tools/testing/selftests/ublk/batch.c
+++ b/tools/testing/selftests/ublk/batch.c
@@ -410,9 +410,16 @@ static void ublk_batch_compl_commit_cmd(struct ublk_thread *t,
 {
 	unsigned short buf_idx = user_data_to_tag(cqe->user_data);
 
-	if (op == _IOC_NR(UBLK_U_IO_PREP_IO_CMDS))
-		ublk_assert(cqe->res == 0);
-	else if (op == _IOC_NR(UBLK_U_IO_COMMIT_IO_CMDS)) {
+	if (op == _IOC_NR(UBLK_U_IO_PREP_IO_CMDS)) {
+		/* e.g. UBLK_IO_RES_ABORT after STOP_DEV: stop like a FETCH */
+		if (cqe->res < 0) {
+			ublk_dbg(UBLK_DBG_IO_CMD, "%s: prep failed %d\n",
+				 __func__, cqe->res);
+			t->state |= UBLKS_T_STOPPING;
+		} else {
+			ublk_assert(cqe->res == 0);
+		}
+	} else if (op == _IOC_NR(UBLK_U_IO_COMMIT_IO_CMDS)) {
 		int nr_elem = user_data_to_tgt_data(cqe->user_data);
 
 		ublk_assert(cqe->res == t->commit_buf_elem_size * nr_elem);
-- 
2.55.0

