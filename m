Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562B2D77F7
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559833; cv=none; b=l5NjraZcFBXBxMdeHyAe2jUn1MfZt7HsBGqMko3i6CvBL8LQN8E9+mLohdvayYKAmsIijhSgzgbSuhwctXabQybqBRvlIqwBBB74uBaTQQeorFXJcrr8vCuukj3Ih+/0BmnND5n3pN+5v9pUBwLejzHTXU0124VsaIEOPbL0ilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559833; c=relaxed/simple;
	bh=3eF8wdj4iHtPXdLstraLhCXNJ4/+KGFi7l6xPTGi3Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ft6l6/kSa+6Bw5fDUTbOtSHL966RlhHjFUT8sw6NSYP7HE2xap1XHTuuhb1xo8lqgpIqxzyvAeRuLpHjRcmm6ppKlJCcckJCBaRQef2zPRVs+3EnmQXy1E9pXnCAHzrFJdc94GgWAGbZHTdqKsUyJr46zjTddk2jmj6qUyKA9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WsbL74lv; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WsbL74lv"
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-6446c7c5178so251715d50.1
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559830; x=1766164630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nin3N5YD0QrEQZWUKpcQtJlJJY1LYkKO6ykxYCXjcaI=;
        b=WsbL74lvOKVShquB4GKRSoM/Ur4RVKZwrc6NGtSTN4dGrnO630pkEwvQTERJVVOWAK
         vP43O0MNRZcqvPMuYbG9QUatdJq/OsACi+YR6mO6BlOU7sFieS8CygNJbx7lVHr9hqMM
         kwvK9oGd8fXan8DZOSYW2DmLtwyh7s+2hPZ+zrDg2kSRpGXhbEQH1teUItp3OR/0TJLS
         SNVjqtlNKtU8A+IjTjZnAfhP4shMK4uK6ubKVDuqT+Zmt6usXRK7bWgNaBG4WsgoFUJN
         7i+C+adXJnlpgeUneR/ferszJ+Q7CwLFWoK99dZG/2xKgirHon6o3Ib0LF5DiDlHCflZ
         US4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559830; x=1766164630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nin3N5YD0QrEQZWUKpcQtJlJJY1LYkKO6ykxYCXjcaI=;
        b=dzUbT0dkj6nOlMu8Hvya9wdDr/CmRfOXjaWpvdEUAnDATZVut8hwDzJBVyVNoHEFEG
         LDPx78jO4vvNHjFtC7V1GrajJ3BFwPLKLzLpCYTH+TYvnZnmhyM0jjMH3zargZLpbMCS
         q6ykWTYnkxcFISOX3ChzT4eslbR8+ZDVk4CORk1lCVfZSlsXd3PNKZSswDD0p4gtwVRY
         wiaZE87a2K5rWcno90H5GFMkxRch8m8bou/YIbdaAz0CbFBw3P3a1I/ocilwACdRkwBw
         XqVePSTKo6EuY6jV0ld3PxWzm+cqWpQKCv80qPNUgS/bT9RnAKnEAEEXahBydHILtgAR
         KNPw==
X-Gm-Message-State: AOJu0YwoKRXmKU/5HgcW5Kn+ayTGe4Jp/wUI4dJdEd4IkNo/cZ6L0hzY
	yg5GoMFsufV9jDHlEsEqdxL4mUT1kuD0QpZkH9s/kT1i9e8zS62/g+y9RPX4J8UgiDP7Jqx4f5e
	I1IgMah1Ap4UQsA8JWsJWYwwTtESU2Goo6g2Y
X-Gm-Gg: AY/fxX66gMbzV+YHOUlcVbyDr/2d2S2zaXE2PK/RT50U/ebL5R8k/AeXYKrb9Rr7vTO
	VEvcA4JqlgxTaSQCZDgp5SYDBr1iEfPkhoTGOTAVRcE6ZsiDA8ncjNoprETGHPZkq9UF7EM2tUM
	GLMa7aRXhMr1bX8/zxt0Yr+aPBe6NLiDkDOUcb6ykLUNvbDdPqAgm1uLnZlkKJnkda3QSNM7J6z
	kzc+6qH6J9tcxDKyW6LWAE6ImRTxVE7OwMclDzU5wKVdq3F67J9l08uCYDSzdWYJTA3FT3iuN0G
	szb7pbffxBozlvSJbg2ndXLfiROct4YJM4PDIyjWy1eLMGNVa02gsIVHATBbRTycAi4wi6uWlgN
	JkyUoJo+pEcxBaYWiXTnVAx84OWqeQIDLGSKXBrOnIg==
X-Google-Smtp-Source: AGHT+IGCRZk7BK0zCjm9pcZPSmL33KqF5HPsix5a4+gK0uM8zmeY7npJJbW3aEgp1QhGNReMbgi71EFVM9ki
X-Received: by 2002:a53:acc4:0:10b0:645:52b8:888f with SMTP id 956f58d0204a3-64555681388mr1348992d50.8.1765559829798;
        Fri, 12 Dec 2025 09:17:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78e6a404223sm2118797b3.18.2025.12.12.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F10BD34027F;
	Fri, 12 Dec 2025 10:17:08 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id EA7D0E4232B; Fri, 12 Dec 2025 10:17:08 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/9] selftests: ublk: add user copy test cases
Date: Fri, 12 Dec 2025 10:16:58 -0700
Message-ID: <20251212171707.1876250-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some existing issues in the ublk selftest suite and add coverage
for user copy, which is currently untested.

v3:
- Add patch from Ming to actually implement --auto_zc_fallback
- Add missing -z to --auto_zc_fallback test case in stress_04

v2:
- Allow --zero_copy and --auto_zc to coexist for --auto_zc_fallback
- Don't add test cases to test_stress_05.sh as it's close to the timeout
- Add Reviewed-By tags

Caleb Sander Mateos (8):
  selftests: ublk: correct last_rw map type in seq_io.bt
  selftests: ublk: remove unused ios map in seq_io.bt
  selftests: ublk: fix fio arguments in run_io_and_recover()
  selftests: ublk: use auto_zc for PER_IO_DAEMON tests in stress_04
  selftests: ublk: don't share backing files between ublk servers
  selftests: ublk: forbid multiple data copy modes
  selftests: ublk: add support for user copy to kublk
  selftests: ublk: add user copy test cases

Ming Lei (1):
  selftests: ublk: fix overflow in ublk_queue_auto_zc_fallback()

 tools/testing/selftests/ublk/Makefile         |  8 +++
 tools/testing/selftests/ublk/file_backed.c    |  7 +-
 tools/testing/selftests/ublk/kublk.c          | 64 +++++++++++++++++--
 tools/testing/selftests/ublk/kublk.h          | 23 +++++--
 tools/testing/selftests/ublk/stripe.c         |  2 +-
 tools/testing/selftests/ublk/test_common.sh   |  5 +-
 .../testing/selftests/ublk/test_generic_04.sh |  2 +-
 .../testing/selftests/ublk/test_generic_05.sh |  2 +-
 .../testing/selftests/ublk/test_generic_11.sh |  2 +-
 .../testing/selftests/ublk/test_generic_14.sh | 40 ++++++++++++
 tools/testing/selftests/ublk/test_loop_06.sh  | 25 ++++++++
 tools/testing/selftests/ublk/test_loop_07.sh  | 21 ++++++
 tools/testing/selftests/ublk/test_null_03.sh  | 24 +++++++
 .../testing/selftests/ublk/test_stress_04.sh  | 12 ++--
 .../testing/selftests/ublk/test_stress_05.sh  | 10 +--
 .../testing/selftests/ublk/test_stress_06.sh  | 39 +++++++++++
 .../testing/selftests/ublk/test_stress_07.sh  | 39 +++++++++++
 .../testing/selftests/ublk/test_stripe_05.sh  | 26 ++++++++
 .../testing/selftests/ublk/test_stripe_06.sh  | 21 ++++++
 tools/testing/selftests/ublk/trace/seq_io.bt  |  3 +-
 20 files changed, 342 insertions(+), 33 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_07.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_05.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_06.sh

-- 
2.45.2

