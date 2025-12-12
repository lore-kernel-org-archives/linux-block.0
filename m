Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED22D7802
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559834; cv=none; b=S7RjIwdwXYl3WLsQg5SGbt2xmpZLgkJLo1+EnOtzdq2cGSsSQGBLesJu9mmeXTdYZBjSGItZ3oazCpnO52m0QqTZxNlr7j1ivwMW8Alz8LGWUbxneY3/oPLfgfNPDzukkauE/cCS5QvVcz68GCfUgGlnrHlgxBbi1P3RlqLSACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559834; c=relaxed/simple;
	bh=Nv/iP0PPlu7PYFQwI+jBPI8ffRylYj1zxIf1qEKb0tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvQ8CISr3KlcBmlJDknNNRw1kN3LQI9YCTQ3xKBa1QHUSDS7nOoVU1Krzube5jWPVFhvTy2Vx9D66ZNzcHai+XdT6kPObmqyp98SGVfugfjQdwfWGctAZ9se+jEEib9xNr/ovol0aefQ34CHnznz60AE0jo+MLvK3sLW7qcJewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Meavvcpz; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Meavvcpz"
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-63fa0ddcc66so247840d50.1
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559830; x=1766164630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro8OsZF3uJAug4OtKve3tUbRbgxB29DrKAw1agkxt6A=;
        b=MeavvcpzqdlJMYBcwBc0mnEyFxzNxocWJ59dX4c95+WZtAYMrwyaMfcFPDGLZ/eihr
         NztHHNDgvIZHwPiJG5+voyiZvS+8wiJcvRefxEeXLlWwg9rUa6lOYQWlFR1FWiClNduq
         X6+KDRgimp3CDNNXi+/49G+P2xZLlDqz21ezUocPJnBAU63uSXVfK4lgA3lN53aaLZNL
         uo3QbCyoX2IZshopKy9Ta2PDr7VXuYL6/zKr6zexJ95tSHQbzdUhk2NX8/OxY4iDKnbb
         TyZW2K93zyRmf4ggx/sosAWNE2PmTrDTpEraeG5oZdYnFO5CeGN6Z60Iorwhcw5lUbKd
         M6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559830; x=1766164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ro8OsZF3uJAug4OtKve3tUbRbgxB29DrKAw1agkxt6A=;
        b=hFvb2CYNEEzdT9aB2U4eLUTiFjFN2PBcPcFXzIU42pRewz+GXkHqDgsmJdmG0m2GE4
         floizd50p1RjJ93E6euxHtx09QiOQOgLJlp2WHIR7VeQ7NnYSJliluj47Ww473GtMkoQ
         eoTGzEzJRRSt2L99Qd1KJQ5hV1Y8617/C9kV5nXab6Oy2zRIcSimP1VhRTDSyOuCtulH
         gwc6qCic+7z/WzruoA8SmNJ8IYrFYvwby5bEQxyOoI34hpW16A/oMCoK9gVQKqEWS1x3
         dOZ4eiOpqdtqrDgV/P8jrhi6p+wwiRp8K5LZA+exUj0wlZ1HQ5AcVV6umabxc+YGIL7X
         21rQ==
X-Gm-Message-State: AOJu0YxR7JYg9LPlSFXSY8c5ezFBCamNuavwBQ9WfvozLkgx6dpuXZFh
	XQj5lBBpcFNCSKNpVs3maGH7tj5o1YQ+PeMjMWIbS/2FmeUUIGYPleh0tg5yCLRG0WY1RnBzjep
	eQagAFmCjh8kU4+MfVQ4S6UQY0YI21EQCLe1y
X-Gm-Gg: AY/fxX6bxyCUP3swtCK74tWlED7JOzznPkkiP4tjbMJEtLaC9QepLHcEY5dtyqAw4li
	T+PzglDkEJMdJi9iH89V8eWqkgsbdRoYw6loGheR3hWXe94H67ZMYJI/OSkIHmEIIEJPZTFJ6IM
	k7mhDcLLl/kVzvQOFEUk6yhtnrhoZT0W7l6dStEIRPmSTCrRPDLvzXt6vtWG/MgXCnSrWkD032V
	BNdRldNl49Ymd3VxSj0iP/jfVUW/WHkIbxSXw46MbdngfMrazRRLdAA889uVMZGCU5Jtt5HarXh
	ebMZ2JV9evjTUXV2/TTbeaSfw5R9p3zs831lhcd2Mn4BNk6BcjhU1d21e81eqIM9u5AifUFHbe5
	aHcSlYwKPY+Ddjo94osuVkkmqTmA2/WQ9qEhcJl1/og==
X-Google-Smtp-Source: AGHT+IFNTxmApTgusf4sfYV5PLHTCIAoG4zUHXYTcGDGNqkjjCZbCxVmDORyUEFBYVQ5XE3L2oQUlxV8Yis8
X-Received: by 2002:a05:690e:13c2:b0:63f:88f9:357e with SMTP id 956f58d0204a3-64555505a93mr1715261d50.0.1765559830171;
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78e6a405735sm2336147b3.15.2025.12.12.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3D00C34050E;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3AB55E4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 2/9] selftests: ublk: correct last_rw map type in seq_io.bt
Date: Fri, 12 Dec 2025 10:17:00 -0700
Message-ID: <20251212171707.1876250-3-csander@purestorage.com>
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

The last_rw map is initialized with a value of 0 but later assigned the
value args.sector + args.nr_sector, which has type sector_t = u64.
bpftrace complains about the type mismatch between int64 and uint64:
trace/seq_io.bt:18:3-59: ERROR: Type mismatch for @last_rw: trying to assign value of type 'uint64' when map already contains a value of type 'int64'
        @last_rw[$dev, str($2)] = (args.sector + args.nr_sector);

Cast the initial value to uint64 so bpftrace will load the program.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/trace/seq_io.bt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index 272ac54c9d5f..507a3ca05abf 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -2,11 +2,11 @@
 	$1: 	dev_t
 	$2: 	RWBS
 	$3:     strlen($2)
 */
 BEGIN {
-	@last_rw[$1, str($2)] = 0;
+	@last_rw[$1, str($2)] = (uint64)0;
 }
 tracepoint:block:block_rq_complete
 {
 	$dev = $1;
 	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
-- 
2.45.2

