Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE92C0284
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516630; cv=none; b=Bh+33CrzIAmSTZ+6n5tkFQ56IZl0gecV6YoLFLDweKJgsYXr38wix1Gfe9D8JjkNDuc0uaIXXw54TaZtIjff4T04bxRRKkUdtP7vdy60x1wB1d8Dy+1Ve07WLYzuxH64g1avIEXdQT/j1HBupOgcIIzD+UgfzFP22jnrxfM1Uks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516630; c=relaxed/simple;
	bh=vSXwqIJgqlSVc1smP8I+ivy5i3pkVVt8KiqpRNZZ4mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8l7YZ6BGBqCURnakVPx+eEWc/rDlkcL/dilqTV/MtoP7wTI3W3JjnfMgZB8eLPDOQtu5fBMQ/BsWn9j3TSayI+klmW5w5n6gk8oJcukbapKtKrpLNXcMN780Li0tOqN6d9e68WqxM63rDLUDpyAoql8qih02U5tjv6sNptHbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QDNh8Nsi; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QDNh8Nsi"
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-b734a4b788cso15833766b.3
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 21:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516625; x=1766121425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+3L8femEvpIo66E++G/m45qvGvJwQnFca+SKH5jlbs=;
        b=QDNh8NsiV09emj53y/qMmPh2CYmVLzOcri1nWHaAvwbBdR3hr0xrwRMtKLHuK8Ia9H
         0PVtHc+dDCbBY1Uah91yC8ASEMLTnXOd4GlzBjM5BpbvLkjfhA30p2TcDlBEY3/fcvg/
         65zD8751W8zMQmWD0qLVBldxcOex7fKBufAN8VaifcpQgw4dbDyWQINJUmLOPpW/ACWT
         JEkk6Bkk3uHR8VPb+Y67kJK9vEPntAWnpLn20fagBUGjzzeWv3NE3uCQ/wOzpEKSGfi8
         /ZYCVZkJSA9b8g+wvcvoLO9Cj1L7EatEESLIrXfNH0bLUTHT6hpGoNI0Wy4yvK+eAsq1
         QeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516625; x=1766121425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+3L8femEvpIo66E++G/m45qvGvJwQnFca+SKH5jlbs=;
        b=XlbuCf6nhYAYQMo3bvM86wur9ihigR/rqKSScGlMN5Rm6OufhEi0tZUvGB82+7XtlF
         HECvUnnp8I90IrIbSI1P6TZrQbEzD4DQUgGQaJA+E+5r/uv954zYV4qCYkg2dMJInvGI
         6KGn/foP/UaUAdoUprqEQXO+Wl1ggqCtGMFlsuG2q6hOG5S+lbqhuQN19kskAZGiiPTM
         StIe/IZUyK5lRPIAWWtgTZ1p9JUYNLAD2Z265sS+fogdZr7fFo5C9FGzEa6HaocGfeFv
         HTLL6MqJypMNq5+hoAElrVnWQ8cm5l+nQWcbFu/pjOIZYxlkikqPa+Smtp0Qz4e/+YKO
         f70w==
X-Gm-Message-State: AOJu0YzjEOt71EZqJ5dkZTcyAVBifPu7Xh1WVeV+fhDDXf2vlpG9bDxn
	VUoqbGooPq6oDG21v0HckU/4pCRaTq/9QHQC2GAG2PtwxqdRtThqkpQTvYYYe45EXQE4h+0t+qe
	oD1eCWaos/kfUPuordaUw2ogz3knWGeCcLVeyy/u+MTGqH4cgHyDu
X-Gm-Gg: AY/fxX6sICirMED8WpoD2Ak9rTmDtLMnTM8T4894eaQJenN/4ymeNfSx8b8+ELfxb6z
	GIwoAKLsWeFedn9+aZBYUlXMwmL07p9eytFmdCMKf+y8XO9X9y0OyWrBcIIwW2UDZB2C0Jwv2eq
	1aA8wMylgWEKxQ2w9UFftFQAwekod5qcnrG45+hrH5cED+psA/guC6+H3Ywv1sdqGML5V1Up+nI
	OKzzb5gP9yKZK0gplX4earM0G29adovnh5AJNFUntb9DMm7y0rmLrLbGrwawWNd81fq0kNn4/ds
	y3ieVC9437VrCMdyY7XfrBrCyBbaqMFPX0sD8AHwg3mpNF1IIHiSEf/xNEpaZ4YF71+I0LNs6+n
	RpgB6titbHO/rO4YcWqc2a6Pg5Vk=
X-Google-Smtp-Source: AGHT+IHgEuWVwR0RX1wTZ7OF90db/MRXj16eInoWlRqFjPQZaS+k3kMpczRUtT6+Vfaf+LABKLHjxjBNmsTj
X-Received: by 2002:a17:907:6d26:b0:b73:59b0:34c6 with SMTP id a640c23a62f3a-b7d23762815mr32323566b.4.1765516625184;
        Thu, 11 Dec 2025 21:17:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b7cfa609a26sm86779266b.86.2025.12.11.21.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7AD3B3420F0;
	Thu, 11 Dec 2025 22:17:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 74D2EE41A2E; Thu, 11 Dec 2025 22:17:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 5/8] selftests: ublk: don't share backing files between ublk servers
Date: Thu, 11 Dec 2025 22:16:55 -0700
Message-ID: <20251212051658.1618543-6-csander@purestorage.com>
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

