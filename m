Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17DD2D7DEB
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559836; cv=none; b=gG4FqS3M9kuxiapZEVsYOO+HICv0O/JcoTlFNeOTwR2dRoV0LqMYnSd0nCagO/fKjzaHcVXFNo5M5X6Sp7c+BMUEVLAU7L2JKw6XET4U61YtuV+WHj9kksYwNeI+nbFZdlrc/yGclObLysmRoC08oqn4DUyBzl+tu6jOfCuvYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559836; c=relaxed/simple;
	bh=YPuVcHbnYS22d6hiURGBWQR+n+8hL0om5JxsTfAyHEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt1gD0s4e9PjJD0fmy3m8elI6sEU6aeX18k3xzsvxjJfQXuv8QXOQ+5OpEAjiazbvsjFBVOnMFGPXezxhTAiGjaG0Clhm96c5D6Nr+RmchyOi+AZmxmJGgf5n++Ie3IuqvzseNozKCxhsJbhxKXBEtlA2vvPqxj2cJbunKALl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K6Raha8E; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K6Raha8E"
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7cac7d08c27so95199a34.2
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559831; x=1766164631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N5v+Qnf2iY02nSmpCLdO2pcb5orICXH1PEBjkRChjU=;
        b=K6Raha8E3H6nbXlSquauYF9TLp5zzyc7PVPuiq7LbOalWe89nvNAzW1CEPjveCFftu
         zsqf2vwKZ+0C7ht5yzv4LhhliV+LVI/K3TxGfSjan0xB+wY/VKlJx9dsz5ixKmg9I2nl
         xPgXf+0BG9NMJjTHVyW9oU4GQKPVZ+UVmVfhN2t/tRnmrvbwxOjgzTAEscGThLdRcmrz
         v+ZVTFKLsdCIl6Tv/06qqS990ppNY3EQLT9M9opgAsE7SrFMkwDr8oF4BRjBUNzJrVXT
         M6Ls/bcGBFYISVAWyL1L34e+m16ZgRM1Oot0vC3IHc3TvWRwZn/FeWIN7TLhJEIxBXmY
         ry5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559831; x=1766164631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0N5v+Qnf2iY02nSmpCLdO2pcb5orICXH1PEBjkRChjU=;
        b=aWgw0GfyIoC0sDr47mH8QTYsA0G3e2V2wAcZNayBS9rUzMCNo9HDENpsOQiJqDzp8f
         4jZXBM5wieYW9A77uyxSG1P4av5drNVlM3Za3fKGLx0zM3RnF0Ls4foSyrJIKkuD3LYi
         Q68fVgyYOlUNL23OTH5KkHl+X5IfltrPkzeoE5hZz8/d3ysDLyl2o6QZJAdW2lDwge67
         FoNctv98tVSxosZEZUeMC5ORtQMZG4hs3ncgh/kJKsL7KWZ81TaE1tBhlZ6jAuo9eetm
         dygnwLT265g3eZcGOmepWlI+t8/MhyxGXxM5+V6VnkwjztDOyoUd5TJh+1thmX6+k/4m
         OWlQ==
X-Gm-Message-State: AOJu0YyzD84k+Uj0YzLwkpldxADPsVN/DCUvkaCQ90BgAQ9gEgHKkmK/
	9yeBJedUYO047Po2LCE6JAK+jwBXsP8LifCZ7rFVUvfUKdd5S8Ac/RM91mvzQDWgOO0cRbkxEP9
	j5K+dzKr+eGH6KaeEHaNZB6502i5yuro6V1s7
X-Gm-Gg: AY/fxX7seSuTS42V7+6SvNPJatHsBoUK/wKNXebZxmEKRY1n1q6OGEPmh9eXk7TUSlA
	XTvQQhDfHeJ6Zg7ATtu0c++gMndhZ3dapH7u2j1VXX1ZmSl0BH47Pts15dZwnLvdsbhPwXweyw8
	rQUDNbFM6ZUPm3aw+cSNXOuS623a2PgsMRI+3NA2feKGr6p7rCrPoyeQkTaInVZ6cYQ/WNN2TgP
	v/CzhGe3ijXoFCejdP68TjxIx/RLMre3tZjmfgbnAPSy+/axKVBm/saRCH13WplAYziGnUrou3i
	W8WjHXx4pn91uCqFS4eMpHiVjiDh6c6X8+Ry3RM9JDDOwDNKQUsqhMBAxc/Mpc93f4dglX6fxn3
	30tj1LT6+YDFMZhqwK3NALvUt16N0cUQE14BQZcJe/Q==
X-Google-Smtp-Source: AGHT+IEBD6jX7Ww+IQHxxqsewOUV0b+S5G2Tpohbpjk+hc1S1mfL5EZowmGcc1H0jPBMIqA1EEmegMce+Lv4
X-Received: by 2002:a05:6870:9a1c:b0:3ec:323e:b5e8 with SMTP id 586e51a60fabf-3f5f8371574mr1362511fac.0.1765559830613;
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f5fe30cae5sm289656fac.7.2025.12.12.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CA552341BBA;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C81ABE4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 6/9] selftests: ublk: don't share backing files between ublk servers
Date: Fri, 12 Dec 2025 10:17:04 -0700
Message-ID: <20251212171707.1876250-7-csander@purestorage.com>
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

stress_04 is missing a wait between blocks of tests, meaning multiple
ublk servers will be running in parallel using the same backing files.
Add a wait after each section to ensure each backing file is in use by a
single ublk server at a time.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_stress_04.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index c0c926ce0539..efa8dc33234b 100755
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
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
+	wait
 fi
-wait
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.45.2

