Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D967B16F288
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 05:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430194; cv=none; b=jTz4fb7G6JLCGVARyaMbmjAKyz1llgMha87Tlqdc+KvDEdLB2Ft+FNwG5Duaci+fmfBN0oUeliUcDrq0RyaGWdFnjuNqn9esOs9zHGLNxEQF2nrMVzbFeoaz7G045dn1Hof7ARR1Ru1pQKz39IlsG7+FRO5uL/2HRiu2sJDaMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430194; c=relaxed/simple;
	bh=2Kuiif2dhHsWPbvITqBFFhHHPdqylQ/rqZvih2fi9gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRlLVFiwlZiBMA+C2p180uz43+c03niSx5gh2Eeg8tnu/yl4kbCt/nEf05odg4E+wh3ZUemAMWd2se8kp9TOGoQ36ZRnO5f3vcYi2ioPw9mR37AcFVOq8ZI3JTPMlN0QIXwjW0tBwCPCo+pHsr9POqDRPpju9sQH9PBbQpA+YXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eY+tE0oU; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eY+tE0oU"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-297dfb8a52dso814135ad.0
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 21:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430192; x=1766034992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L5ySB+zP/+ngwEt9P7uRrvQEemvqRZ5JaxXp8HWdYg=;
        b=eY+tE0oUHg1Sqfq+ilJmo9wEhSXL6F/gH1vlNwGxZX/Fhky0+/CVhBuaLSnwSRgMbo
         r+ZeFivMU6Er/evciFOPVvpOeUkS3Az4+WaoXxYBlBd19cTdXdTxj50EG5HzUCun3Y+3
         HK6lW/Ugn/TaSQIcdTlts6Yucj3u7Y4B3WBPx7W2DcR6co4az+z8t0Ih1S/V1vvJexk0
         mDQCeezdSn9IjqINBe+I157O3aVIZHqaRqQsmwlu5Al0ysLGkzvQplPhI/KwONmdABmH
         qaYIYpHVd0tv91/eEx5Bz7YZcpQchEEIuGlscwVk0lu8Rl+PVd3PdxcMdD+wxALOK/qr
         QWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430192; x=1766034992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/L5ySB+zP/+ngwEt9P7uRrvQEemvqRZ5JaxXp8HWdYg=;
        b=APbIGb5nI6TX3HTINAyYRXCBtIyTbwyC+C4sYIWe2bCJVBJdppi8I/5pZOE6QCDTvC
         uaPvrY22SKTBJth5RP72txZtvLnWcXRHFyCFUvWuarGNQwAAiEw8YmyDLV1TzRgp+McN
         sXzr2zcJEcjF4T5fjbmER89mojIVhmA6ZnLXfHWNMIK0cXn97z7ObcA9kHvWNeG9GXuz
         UrAXEsfTXOzcAlzU8HVUJVLZBsocb+7DOF0st1mmwnRw7wX53CIPaWVP/K09qimbtxYN
         QsmdH2yWYA6eePbtUB70l2WZcmF+VJqfLQB9VH/VgdYKQphDXgaOncxwiNbhv3N2uLgr
         /ecA==
X-Gm-Message-State: AOJu0YyJo4ZlVeZBA6DgX3w/B/Ryu3IyMBIHzi1w5QiFdTPf/7rWd6Ke
	Cpcm/hmBH1f/uAw3aimRLQHRMObnzaFCt2U4pZBW1pWlLMUixXLKgFWgGpxCOHeJn1rU7jii8u0
	tWp2Pov9IwmXEO3b3DMH+z7myfswQs7CYtUry
X-Gm-Gg: AY/fxX7H9U2MNFzLFliIx5xcXqq2dgrpam5fQtw50g4w9QmmrQ+MVxnjq09iFcckMm+
	BsKbYOvCwTBNmNCjzubWiPlQOAPtmQp10X/Oyxgu5iodno5DzxIqiehtRUQ26YXeJmRAA9UnrGh
	den2nEqPh1MD+JHGT8BnDMTP/6xo3DKHhyYiKskLDolUwBzwa1tVoHM7yz+T0ZOuPgu+AHdevGN
	31Hmapb5AEGnJ3fAfViyZnM1eE7I8jnl+GsTEwieSIpeXjt8sQM07DlBv5pKRApLW0d52cF0cui
	CK5CFw+KHnMwBXe9tvkw2ziVAE056DyTftBlQRz9FaTCzr2dqb3rMg8DKbxALxuDt/8jSgOSJuA
	LzkdWy9rvE8t1q9MedvSZ85MbgUSfkc6zHSbGyDhaZA==
X-Google-Smtp-Source: AGHT+IH8WKveI6H+vWfK0UUbFaVJR8xJcdqZMu1+kP/Km+1TUj2IgDadCIrCvsLyDPsHNoLshHkWfyq+njh8
X-Received: by 2002:a17:902:e807:b0:299:db45:c5a9 with SMTP id d9443c01a7336-29eed3234b5mr9070595ad.9.1765430192066;
        Wed, 10 Dec 2025 21:16:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29ee98825e9sm2100645ad.7.2025.12.10.21.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8C7FC34079F;
	Wed, 10 Dec 2025 22:16:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 89EE4E400B8; Wed, 10 Dec 2025 22:16:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/8] selftests: ublk: correct last_rw map type in seq_io.bt
Date: Wed, 10 Dec 2025 22:15:56 -0700
Message-ID: <20251211051603.1154841-2-csander@purestorage.com>
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

The last_rw map is initialized with a value of 0 but later assigned the
value args.sector + args.nr_sector, which has type sector_t = u64.
bpftrace complains about the type mismatch between int64 and uint64:
trace/seq_io.bt:18:3-59: ERROR: Type mismatch for @last_rw: trying to assign value of type 'uint64' when map already contains a value of type 'int64'
        @last_rw[$dev, str($2)] = (args.sector + args.nr_sector);

Cast the initial value to uint64 so bpftrace will load the program.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
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

