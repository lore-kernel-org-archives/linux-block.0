Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C5285C8C
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430197; cv=none; b=F99wZDKLauMzdb0K5UVbY+MnY5hlKUdBrd2UQ9gYwkj5WJQ2R1tjB+fVAO4kqHpHk0C2DreRUeKrnzfE0f6gpkJnv3GI2xuLJYrcBtoEE2mNJgt/EDovyG4MzfU+x69bw18+8/ZifVbmgUa36UU7NVld+UhicqYhQKzDs6lnhd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430197; c=relaxed/simple;
	bh=3BcnF+JpBAzJisKJ1uTv6+gdgkHDBERFf0MRmBcrFsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spAiJJRZoEv0m/KqKL+WmG88GrmjxagLt/L/28YDfzA1XZceSquF5bv3kWxpKSZE7CLvyoKRUSwEjiuaz6joCGXqHuIalI0Q0yrd7o6WjeRBaGjElzY4Y+IDPJ+4yXDaNzSsBjtuQp4iqcZTCOScwcZj9fZ7iCvPUlvl5Ei88Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eaunaJP0; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eaunaJP0"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-3e7f43c8191so7540fac.1
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 21:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430193; x=1766034993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfkHHTfuV1VgzCnNWDioK4GO8iHacIvGQ0SM0tegTgc=;
        b=eaunaJP0AaVysylgpySQADTE5qJoHyY/BvgeogFOj/1OJRedL1MnUPeDCk/o0UPCjS
         R79WSrUH8qcePzbGHwpn02BOe+dIIen+QA6cgefeYcqAeUA5OT6Ae0nwQ+4j813XSPOZ
         QmUQvifqCNvIv6IuhbyJs+vXhJ1P7MioAuviJTi8cqhn3JrWSQydg+9RBBowNYFhCG4T
         oCvnNsE6g5VqpIeRnJoaPB1zlKjwlppgJH02VNrMn1hcSIuKCJg9znRj3mx4YWdG1jZi
         TZf4HTg/dG9G8er3mJiD1FMO2lJ75hFNiBwAagFWQ4OpdGgJ9g/MMSHV6lvv3r01Uucz
         v2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430193; x=1766034993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KfkHHTfuV1VgzCnNWDioK4GO8iHacIvGQ0SM0tegTgc=;
        b=RZfvKWLJQq0uRIK1YScGpFmE0sYotuWg/KrmF7+cD44KqecGZy8fpVyjJ1oxYg61Ez
         gzdPVi8nzBfu2ONcgBrIyoMLNavlPJ/BdYaZlnmCeZMyM07op4oJ24eKjKJM4kEp/neR
         FIFghW2tTDPnDBhxPlZUGWkBcfONBfH1BBoYuwQS4tlLhElw2eGOni/ghEwp0cYeOf5c
         YudfRA5oAl9hlEkUNWjIGvmWA8TrfRZH9KGKYokKNJgzC+2Loj72t28PqfEbgBrKjioP
         btnAmGli2EtpNM1YXVQa828n9nqgZU7D61hHoB+sWfCMzUzpP3XGg/MnaOJQYdaXaaOv
         ZOFw==
X-Gm-Message-State: AOJu0YwtUMioiNxkH1MRizGdI3Onhj2KWqkHiOWDrBIZ+yIScUIHFkZZ
	72EPB4TBlExUOASPd6COWHGx9colBw7fJCB23Iad++Q9AmoobPpTWo3c5UtL89Z2Tx5VGWJGitf
	omfzBNOg7vdrI7IQDFxsW1YS59unjo/r5P46JiBIg5924dNB3D30m
X-Gm-Gg: AY/fxX4SSJEVdveX4Y4STOKmhLdL/BECFnq3Lq8hvNHwMLE6AqZcvzElB6YkaAvCmnB
	ex5p3FqZIxGnfQ3AuKJE5VsaRf49r6AecDH9ekqNWBT0rFJhAiFmUNsIjeK3fwVw32Evvuzu8bi
	LKUoSJc2Ina3jBrcG6fyvtkZ9uMOwgzjsyd5OZKSqubIJDjpqBCRGxJZhGupTy7uLA27Rh4XPOg
	UhaD2FknM9qqQeX6M5lo7aGX9uRucMNeNMstgvrB/vUjxeu2g1GW8sTXyJqD9nkmW+0aoC2GANt
	yb/wxgUtEh9LQH6ykMeuutUp6mOEWbO7XmpZmXC2FuTr+iJMlPBYz3s/JPpj3W+7SDNHYReIhQc
	u/fl5s8dSmk2nR//Wp4KTrUVM56c=
X-Google-Smtp-Source: AGHT+IHb3ENL6XXKxhbIoayxGeujs4BLthUNPZTmBQ/rx5/q9AaDNCLok3CtBXuRYAP8aXa/nnfB2DRX5Mgb
X-Received: by 2002:a05:6870:2484:b0:3e8:9d46:becc with SMTP id 586e51a60fabf-3f5dcdd2a38mr548792fac.3.1765430193474;
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f5d51aa8c5sm240626fac.15.2025.12.10.21.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7220934079F;
	Wed, 10 Dec 2025 22:16:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6F9FEE41888; Wed, 10 Dec 2025 22:16:32 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 5/8] selftests: ublk: don't share backing files between ublk servers
Date: Wed, 10 Dec 2025 22:16:00 -0700
Message-ID: <20251211051603.1154841-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251211051603.1154841-1-csander@purestorage.com>
References: <20251211051603.1154841-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stress_04 is missing a wait between blocks of tests, meaning multiple
ublk servers will be running in parallel using the same backing files.
Add a wait after each section to ensure each backing file is in use by a
single ublk server at a time.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/test_stress_04.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 965befcee830..c7220723b537 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -29,23 +29,25 @@ _create_backfile 1 128M
 _create_backfile 2 128M
 
 ublk_io_and_kill_daemon 8G -t null -q 4 -z --no_ublk_fixed_fd &
 ublk_io_and_kill_daemon 256M -t loop -q 4 -z --no_ublk_fixed_fd "${UBLK_BACKFILES[0]}" &
 ublk_io_and_kill_daemon 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
 
 if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
 	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
+	wait
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
 	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
+	wait
 fi
-wait
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.45.2

