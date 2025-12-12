Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396330DEC1
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516631; cv=none; b=C5XYz+JedsXKCcyPV3XhGTrP5tWkKO1ovY0iOjwpJLj2fn2+KavWWCBE9DFn4ryLmhIhsn60Dd+efjBZiVkrPbZ+5ZWuOzIMMW7/gEIRgYowLYBh4V5PgNC9qJwI6zAOD3cp1BM377DsCY3o3sJZdbmt/MSvDL+lXYDUpc5+8Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516631; c=relaxed/simple;
	bh=LNmBK8BbXU2AU/+zkmmJm0DJM/yE4e10w35U+rkx54s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnoEeyLybTq1nv3TUEkWSzZpxDw8I/Py62EcPaBB0ME8Bl9vJMsItH/JCrUxZZU/ZhOcZ1zqc9wZAsMJmkJNdWoR6IXAyqFBD3M2jQ8YmAVWvzCqdpO/izbX5a2ThUE1dsMfoPIBpqIf77mcGtZJscOXeLMYKNZXByOo/plem8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Nz2u28qY; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Nz2u28qY"
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-597c366f2feso53001e87.3
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 21:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516626; x=1766121426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57Jz8InzcWfvhhZ5XG933BN7Op7rlmfOq8wxKbdaTP4=;
        b=Nz2u28qYw34G6gBkzQJVysK6iKSwAXZavxi0d9dcGCg98GWVSoMjlqTbAuRbgLZumB
         aC4SXX7E/hr2/ma/hbf2d0XRKlg5wh6szONuG5T7BM8BPdcFO5GFCM8/mNF7qFDOpxFX
         wnj3gAf7UUBRj++FimRHo3xwSisqtaLN5IgUyaPKDAV2t7mDLR7vtV3+CN0Iq4F1COhE
         8YSQjwtCRPeoJfMUSNYZycRhzNSZK4MDFhylxH0WU+tP+FrsOHLTlvxEbfEc8DAaL/gq
         +hZaoQTX0kCe1uVX9laj7IlqrFnMejrYnccCDVOY+GnpUe6N9Sd8191BEpTOntr8QsyS
         c52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516626; x=1766121426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=57Jz8InzcWfvhhZ5XG933BN7Op7rlmfOq8wxKbdaTP4=;
        b=eQ3euaCb6Nv6NZsH0rSZVGdd+RvbiD7hTIzQI2pVg4zpFGM9+PRPzLuepP8GHYVuzW
         /YbHjsMOg1i0VNkF5VnGZoZsZONRbClxH1UzfgIwWNTcbfIsr8YBWuxQbEIhIvH8JR97
         ET5XVAXTADJLYoSeZOaGAhxOpp0zZpDymGieKz+ZK9gedY+M79xbo9celtWL1mThu+9Z
         WShpUxcgRwSk9auEHT2jz0YoTBt+0hJpxxSCHur2ye7tl8vP3b3NdCZ1BTOQRKOYqJfl
         SFkdIH1bkvQuimC7EE94+LTR5dMpF6zWf1Eqjbyff9uD6/HdOR1o1eEP0t/ly1pQqdui
         8K9A==
X-Gm-Message-State: AOJu0YzaDgAI9L0ZbsJ0Yl7EvLjuFL4A9+u3G7sIU3y3zO/nlpk68TOs
	iSBjMFMPJC1XI4g0CucqqtKkzMtaP5x58QrVgFCFO3jDMBkx7jCZO5Be++PVjKdYp5qT3vG2ifC
	IHfob7rAi4F9O/tLZKG6Sut9YTWCZOALBXFqljT5i3GaEr6n87ro8
X-Gm-Gg: AY/fxX7JJbWkYS8Q8YaEKfAHBkCiPgdvq3ufVC8wy3Kq8knLCBDbM7R8vjgu+EURFZF
	5yKTM3n4nvAjvavpy5cGdazDajjAUn4ACRNdiXUIts1PDdK7kZNg7CjdNHw5IbYjv+t0F5ONh1P
	F0Pt2L59r6hCxHZ8G1M99NBmUavXd6Xoo1ETqWBgpcYJCKfxwFP/62yaLin9F6A3dn1HyFgbn/j
	dGcOjvJAJu8K0SUopLxf5rh13Ta6nbta23AS7IBTTXES6Mrf/pEMlztKAfGuIdWHN8SbvStz6WT
	IX9kXRkvTIKR9AFyzr81MCn9bQnb0OMozeQCwC132NCs5Jj5ufLNbiwwYkc77wqePcNwKK+QGgz
	6ZSBVMsxPkcATcLW1YkGunEOLkRA=
X-Google-Smtp-Source: AGHT+IG+QG4RAXApd1w4Szk42Vway3i7WNOlUKjxhNFoATJnq2vI1qzUk4DNiFXJGExb8HLEcYj2mWe6vKhC
X-Received: by 2002:a05:6512:e86:b0:595:834a:b1ed with SMTP id 2adb3069b0e04-598faaa6ddfmr117200e87.7.1765516625582;
        Thu, 11 Dec 2025 21:17:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-598f2f36fd5sm941967e87.5.2025.12.11.21.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A28873400F7;
	Thu, 11 Dec 2025 22:17:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A07A1E41A2E; Thu, 11 Dec 2025 22:17:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 6/8] selftests: ublk: forbid multiple data copy modes
Date: Thu, 11 Dec 2025 22:16:56 -0700
Message-ID: <20251212051658.1618543-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212051658.1618543-1-csander@purestorage.com>
References: <20251212051658.1618543-1-csander@purestorage.com>
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

