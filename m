Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183C2D7817
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559836; cv=none; b=CO+clXTaOhrahwRLHxdBSsMCWdIclMmdSjfjbCBAkvoEJ/Q83ufu/TelVT0FiMptLcg0l9cYodEoOgHyHOVxNS38Z8pTc1llAko7LpXGVuYXLVlk2odd4WWJK4liget929AeN+gE1S6JyxpbYUmFanknSv5FEhi+laHlWHWD9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559836; c=relaxed/simple;
	bh=hPIiNC1+/Ul2H1nCS4eIVMyitSwq0Uw4atB11NoOg3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZAoYjd8ch9qeWLk9mFs03ZO+OMnQPLp8mHD/aZuQDgAskNcn5Iu1K5CMry2+/bsJjVFmJ9X/G/GVp6nn023apb7qlKGIqhX/HRvirzI00bWMlPGfoy2kRZcCdYoMiqGBBQX9B83hdLMA36+rXLVh/UXuO0dv54NJ9OUTcYMe9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eSSBfKlP; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eSSBfKlP"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a07fb1527cso786025ad.3
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559830; x=1766164630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yUeSg484LPlwnG9Kq89xJ26zoxj8oGQzdWDtSD7PIU=;
        b=eSSBfKlPQFpdhpEjEf1+YL9zY7UPrry9TrSKiKgab8sjkcESxY5GfJS7CqlS25jI2r
         Jp6cWJ6uIsBo9O0/Db4OT1fYMW+SR7BYoHyZ2EpC+3+fvmsuOuejAXVv273FPyryWwBF
         SZ5tlew/zQI1uaZ+EsoPFZxY/EDSNMwZaoDMzLHQeEP2DAiew9qVDGTDl6l52gKYkUUB
         3dCatX2+4GZQPVJg2epQtDKcie0lL+T+PYaxvPBq8T99XYV6+fv3d7KggPonDCKK6fh7
         RoOIIb6oB3WG4o+my/LMkKwWAvvO6eie5QchP+Bk3EcxGze49W95/S6dKFw8y0DMrhyz
         ILcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559830; x=1766164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yUeSg484LPlwnG9Kq89xJ26zoxj8oGQzdWDtSD7PIU=;
        b=GNb6cgcHLLdJrGTMX1BWHJzRB5jA/+2RLY8ILZRsIIg5dwMO4VwjlWjWe81jD/nAxr
         M/lTyh3hjT0pvLSg5Xfni3+Y5+jKAF4f8FDbJPnUDjtyzwUsj7JOJcf3pVnxyGWxd4pO
         6Zn8XE7hCfN+CQ38r6XP3XAENwbRM5peNeLSVdoQjtsQ41Y9VRBMAeLWayJQu1SWesR5
         w6RAwEN7MDshKEkQGaUms/sFRMyRrx+fUgM6rT3ffvC23upAyaW0I2eyfSDPJKuWuXux
         idcLfyH2QUjTkljEli4j4fZfvdCC7eaFvJ+2BHRoEc77Z53znUIqxXsj2tDr22lLAFBl
         SEGg==
X-Gm-Message-State: AOJu0YzUHwXhy+j2/s+ltPS3tuRdp4bZ9u12OPcq+tJfTba6J/017nzX
	oTwN17DY+s5Oyj4/SiwP2u2Po/XpcVFZgzki+WnmKeMkM4xoRV0BHbfOMn5fkxhnJ3Rc3ctsNA+
	TA1tEuODIjqMaTlZ4lJuqfNOItfjUDo2+pCQUk90bzYSdzFa8FwF8
X-Gm-Gg: AY/fxX43LrGtaVpQlkHhYa1YPrurynAIBumg2WKKnULSW3vMamQn9Py8mlRlifqGTvw
	rQq+f86Pce5kYy6WRscUm7EVG80od8JoADdx0yvgLdMbOWq11AbnfH+fGdeY1uhlZVqVf70Xofl
	4WuLcR3OCHjbNN8oZqgz+CR9k3K1+qXSLgwBo+NQIlTVvDq+L8ZQHBpT6L/VuwYNlvbO9DPwpF0
	FztRqLp3kpEMfN11tIvYitzy2NR7Ye3e2/502bbkLjeMExVzMiXaAwrK+XP5YNUwzBDnHXfOh2W
	mGB5qR0/rhenvZWANROJ/ze6sKcvwwr7E8o2ODwAoJFtb5KgqiUOObE71HCRk9EiqOXg70GZsFB
	1u9+bfLe+N/oRaJXuGogGOAL1yG0=
X-Google-Smtp-Source: AGHT+IEbfoe32paZweyOPDkuXvizadBFpFIsjkgJtJbQ2tnZucwBUDmmD4hh6aIHwvuMRz00hNAN6TCkuBCH
X-Received: by 2002:a17:903:11d0:b0:299:db45:c5a9 with SMTP id d9443c01a7336-29f244d0d77mr22404615ad.9.1765559830547;
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29f2f7acae8sm2502465ad.19.2025.12.12.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E2190341CB6;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DFBE3E4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 7/9] selftests: ublk: forbid multiple data copy modes
Date: Fri, 12 Dec 2025 10:17:05 -0700
Message-ID: <20251212171707.1876250-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212171707.1876250-1-csander@purestorage.com>
References: <20251212171707.1876250-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kublk mock ublk server allows multiple data copy mode arguments to
be passed on the command line (--zero_copy, --get_data, and --auto_zc).
The ublk device will be created with all the requested feature flags,
however kublk will only use one of the modes to interact with request
data (arbitrarily preferring auto_zc over zero_copy over get_data). To
clarify the intent of the test, don't allow multiple data copy modes to
be specified. --zero_copy and --auto_zc are allowed together for
--auto_zc_fallback, which uses both copy modes.
Don't set UBLK_F_USER_COPY for zero_copy, as it's a separate feature.
Fix the test cases in test_stress_05 passing --get_data along with
--zero_copy or --auto_zc.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c           | 11 ++++++++++-
 tools/testing/selftests/ublk/test_stress_05.sh | 10 +++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index f8fa102a627f..4dd02cb083ba 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1611,11 +1611,11 @@ int main(int argc, char *argv[])
 			break;
 		case 'd':
 			ctx.queue_depth = strtol(optarg, NULL, 10);
 			break;
 		case 'z':
-			ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_USER_COPY;
+			ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY;
 			break;
 		case 'r':
 			value = strtol(optarg, NULL, 10);
 			if (value)
 				ctx.flags |= UBLK_F_USER_RECOVERY;
@@ -1684,10 +1684,19 @@ int main(int argc, char *argv[])
 				"F_AUTO_BUF_REG nor F_SUPPORT_ZERO_COPY is enabled\n",
 					__func__);
 		return -EINVAL;
 	}
 
+	if (!!(ctx.flags & UBLK_F_NEED_GET_DATA) +
+	    !!(ctx.flags & UBLK_F_USER_COPY) +
+	    (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY && !ctx.auto_zc_fallback) +
+	    (ctx.flags & UBLK_F_AUTO_BUF_REG && !ctx.auto_zc_fallback) +
+	    ctx.auto_zc_fallback > 1) {
+		fprintf(stderr, "too many data copy modes specified\n");
+		return -EINVAL;
+	}
+
 	i = optind;
 	while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
 		ctx.files[ctx.nr_files++] = argv[i++];
 	}
 
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index 274295061042..68a194144302 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -56,21 +56,21 @@ for reissue in $(seq 0 1); do
 	wait
 done
 
 if _have_feature "ZERO_COPY"; then
 	for reissue in $(seq 0 1); do
-		ublk_io_and_remove 8G -t null -q 4 -g -z -r 1 -i "$reissue" &
-		ublk_io_and_remove 256M -t loop -q 4 -g -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
+		ublk_io_and_remove 8G -t null -q 4 -z -r 1 -i "$reissue" &
+		ublk_io_and_remove 256M -t loop -q 4 -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
 		wait
 	done
 fi
 
 if _have_feature "AUTO_BUF_REG"; then
 	for reissue in $(seq 0 1); do
-		ublk_io_and_remove 8G -t null -q 4 -g --auto_zc -r 1 -i "$reissue" &
-		ublk_io_and_remove 256M -t loop -q 4 -g --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
-		ublk_io_and_remove 8G -t null -q 4 -g -z --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
+		ublk_io_and_remove 8G -t null -q 4 --auto_zc -r 1 -i "$reissue" &
+		ublk_io_and_remove 256M -t loop -q 4 --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
+		ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
 		wait
 	done
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
-- 
2.45.2

