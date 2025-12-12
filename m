Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE12D7DC3
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559835; cv=none; b=ut4ECsr50UVe7yKzxJb9yRrRSDBLKQyIIMQ2wRKdsHC5INWeFlcUrfZj2M1WWmZKNXpATjzK11PjZ+oZnk2AwkA3JO3DZ1aYMWsW8yuOHxt7mleyml0ZLhKlyn4VWgXfvEPezCsQik3WsIL/NfB4w4ep3DVQG9WS8j5qiq4MGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559835; c=relaxed/simple;
	bh=10p2JvkCz7yhrUBuz2Ld/a2/xjutHAlTWQJCwGsKMAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4+vo1LNUKbMemiViWdVStc29yDLBvri42BatFUKtlG3Q1vHIWrGuznmueF50XDnLGcflarIC4PtG5BaM1viKv1Ibb3Oiz8ud9HG/6qE+5yALP/Grg95z/IDAEfFjD5i0i/Srm4NjJ9sqQXR7D+Xtjqjyn5MjYfefnPtt1aNbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EhJnjFcl; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EhJnjFcl"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-7baa5787440so140288b3a.0
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559830; x=1766164630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t84ae89m7Sn7pboO/Zmlj4sDWg4NpM9693HZfHYO+4A=;
        b=EhJnjFclCHrZGPamfpV64lrtpMsmtHWIlt5vqsQjZRY6l89v3XBzsiiqftc619dW7W
         vYCFpaRKGfVEmib3Wc0ReXPAz+WxSEVcESQyGNmM06Yte7hH2UQHv0FBYN8R1J3JmWHH
         w+uDHNcl6Rfub+ocfXN+6n7A1VACpaa+oe8jNCNwvghstYRzKxzuXuHbMU0hfYqKwd2u
         4luLyM0p2oeIH1HUivSOkydSyTks6u9Yg7Er1XtMevXPz3I5OfePgZFsXCrIDJ3QtT8n
         lvgCz6xyOqY6Rx2+HL9w1EXA4QZmCrIS9hIIIBrP7FT7rojAehrsmzFRiQhp1tHvX0DA
         rziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559830; x=1766164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t84ae89m7Sn7pboO/Zmlj4sDWg4NpM9693HZfHYO+4A=;
        b=vVmjYi6o3kISdntt+LAxQU812wQXZWVpaxxyoqITShdDBDQQP8mGZ8hTwH6gsrBnId
         P2t+hBSbF/Gd+pPSl+I8wEjuMpmpaU7qb9gLvNgKne7EzsIEJcruFQnXZdixAzJC7qia
         PltvPN1N1OaVvqroHkvCyDX7xZWnK3yiL522J7YnMR2IpcUDj9tvyonppTUuxyilj78J
         pAnToRCTNyJRkBrm299dLfS00ILkr04i72TN6xSf4RopZR55AfWAbD5W7HL4FKEJbeZp
         bxHg3zjO78tQb8PGWWyHcnSFoGmbdkulw/HFLfBc7fMTbtj5SoU7pHXbEBTGaUrmVfyB
         Smjw==
X-Gm-Message-State: AOJu0YzuSy3syRYDVTKLhHDBzQ6JXJ2d2QZSJs/bW9GQD+aAb7FHF1ff
	aaLwRQyf8iNOCLg1xnG2Ve2N5+L1qOWATs8PWOSL4EV9P2L0n0GwHCxG5OktQYn7G8cMOQFvsdt
	0wKNPL9/en7HaW3diQxZwCe9jVwJbiVskPth9
X-Gm-Gg: AY/fxX4JIvjDwu//5f1tG8tQuMOL9gRgpmc6sNm14G238POl6pMNcjnNOxZ7SpQnSnG
	0vOQbIiv3oYz9QqlEmGIY9FF62mmfIL+cFTWbIvwUepWXPb2IKB4j6vLSnR2klnp8ddqAWZDJxz
	MKPGHJHe5DhD2JvGmPgVnq0VZC1ZwuBX4yhVJH/SOq7d81EaDoCKTES1RYeP2C7XmvREZv4b6+s
	oFZ8nOcLQwUQtLxosDPs+wv/jdmE0RFrbR8V3Up/dECSGfJoBMZh34ccgiY3FSIB59Ocr8iMnzi
	HRcegLiZCVNUfJfSYIoMqYm0fUb95Zmrh9EJ7mNgr4St9Qqefbtu1FziMyZM4Oux0unAzUxmPiC
	5Sc3uy3i/yy88+EbM/hl5qB3l6cbCaGC3EA678V9lyw==
X-Google-Smtp-Source: AGHT+IFD5gHVVNWG6BaOT7P35MqSA1ymiemgVdEAiw2PQWit2v+TxRzmrZWLm3GqNrYoDxOX0x77xoAqfsLx
X-Received: by 2002:a05:6a00:3d10:b0:7a2:864b:9c8e with SMTP id d2e1a72fcca58-7f6694a97f3mr2099355b3a.3.1765559830496;
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7f4bf6beb28sm871869b3a.0.2025.12.12.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A452A3409F2;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A272EE4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 5/9] selftests: ublk: use auto_zc for PER_IO_DAEMON tests in stress_04
Date: Fri, 12 Dec 2025 10:17:03 -0700
Message-ID: <20251212171707.1876250-6-csander@purestorage.com>
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

stress_04 is described as "run IO and kill ublk server(zero copy)" but
the --per_io_tasks tests cases don't use zero copy. Plus, one of the
test cases is duplicated. Add --auto_zc to these test cases and
--auto_zc_fallback to one of the duplicated ones. This matches the test
cases in stress_03.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 3f901db4d09d..c0c926ce0539 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
-	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
-	ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
-	ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
 fi
 wait
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.45.2

