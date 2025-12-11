Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F0878F20
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430195; cv=none; b=RFnGlw/J7KURQgmc46bmW8D7AvQcl1N5MnpTHC+3kLlk9hhKNWSUDRNlHwiQ/QzSEehD8mkb2aPt2QN5sj3zpkBPgyhsN49QnaYUpXK1nzlcCjxFfZqSavDDVo//MCuS7mb760XmodLR3DXiyh+bjfBegExttH2flFxcOmibiEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430195; c=relaxed/simple;
	bh=8qOJtiA6XHp28x6wRFTwTNp0IucDuqFRVR0W+H1pxqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rk2ebs24Qx5nMcgz8iKcps8Fm9sAkin8XTkBRfBkwXaIlJn2B9mmdczjpNTPbtRmMR0i7j+aqn6q3KUAwCPFMKysygM6tT5IvRZm/mVKKYGThGQ7DLAHzxp5rauCCAGzrXJWPPC90LTy4E5xOv78hXaOCPX6/THun2y0pm2c/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GGZ5oo2y; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GGZ5oo2y"
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7c6c99ab031so110186a34.0
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 21:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430192; x=1766034992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYcoseH5JgdGnDsS6/FYsWYdHdJE/J4Cwcg2CuVmw64=;
        b=GGZ5oo2y2n0X4StzmG+JXrYa5HyHypf86LAMSZhdwqSm3sStt5mt7HiOUBiwPDxuUI
         Yw3iPMX/aNk2WG/YvPC/iYKzRS2tEY/piinOUMfXWcWBjvXq8PeMZ6s/qPVbE3t685hf
         88048ZGlqJD+zmbefe5nKUhHJKPBmJaDA7qKLPM3U3l1F7zVQXV+QPwjZkEzR05GBKWY
         4YogbxPGaPYFZE+lXhLwwRNXcGxnmHk7r0fc/tZm3LzuF4b9ZwtmTphysrBrwbi57N8u
         Imx2uEZXac1P/ooh+kXIzpFGppJTRigbNJRlZBya7pmP5czbpln5BZ+FWO6NxpLbOA3n
         lpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430192; x=1766034992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYcoseH5JgdGnDsS6/FYsWYdHdJE/J4Cwcg2CuVmw64=;
        b=pJt3pvJ8p3BEtA6URniqrY1DbxtJrtBYSTETpWRzcPAL3P4YbJzI8pYWndOsJAUhXi
         0OG5+e1Fm2EWwru/bxvhJHky72J84rLPILovUWfSh28ElX5bN8SQ7lCy3ZcXnUAw3c0b
         8nFjBlfuwSMy+BzC1NSCgsJZ+tsjIYr497q9F0qmRGyxdbA2/Pke6zONMbKu0LwcsKMa
         nqkMkqbwtcuJi934Z3N/izysX9J3kSFjrx/pZqUUyQOcsmzeY8TEFVIVRUwJISCLa/bC
         fMnU+0T8OP6g4y4jeCmeBAhpWGb6m6qxFkJd47uGlXu6ESjFDW7NX5u3lNj3WY4Yyy4r
         GD7w==
X-Gm-Message-State: AOJu0Yw38OQdaYeRVIwtKCvLoFK6UrPVKzrzG9d9xqpUd9AD0gQWSdOt
	9ddFhkFdLkYwyvDg1y/xhcSvEEe5lu1prUQWLV1x4gRETc1Mj+VMFGpiqXOqHQpl1AuJJvi0Mqa
	be/S8ty8XTDjJQ0HuKF8Zq7AM4POBCGvOACvm/DwBMZ9TwIxn3Z6M
X-Gm-Gg: AY/fxX58Khcz4y6kjXgyufmciMy580oQY9dZmKdxjO1tNTGjzafVB+NRjjlaMNIMKkt
	K9zeidSalwyFUbsD/qWTw87WnyiG8gzOe5zO4ZE6/+Wc6Anm2FGUZXzEklG6zok4oxGB1o2Oox5
	wORuNCeQjsR4vznBfmeCqbbCN12C0E1gg83oQD2GuEhrLOsbKYh0Fm4ig8vWsBwXn3QTgX66ilr
	+/XTng1svYSbGml4HRVvbDEmXQyugIdLbkce+xC1FwOP2/cDTil5TX8C9e4xPvIY4/UQBzIFmEE
	uSj4IiMM9yCOeBhbCDeT1fBvGXsysUQYhAAeGkhGSthsEj4pHO5tiXBZUerfTBQxUBtOT8nFa3d
	4g/sBsXbNWQO7I3gatr5rXme2j4Y=
X-Google-Smtp-Source: AGHT+IF7kuKU1dPaXTTDGo7PixAh9OWTqtoT167eLT1jITjiGyOtsNEP/s4KYfWR/Z1qH4/D6IPi+pev8POD
X-Received: by 2002:a05:6871:6608:b0:3f5:94d:f6ab with SMTP id 586e51a60fabf-3f5bda5c39cmr2448079fac.4.1765430192480;
        Wed, 10 Dec 2025 21:16:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f5d4e1e554sm246177fac.3.2025.12.10.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 61DBB3401CC;
	Wed, 10 Dec 2025 22:16:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4AE75E400B8; Wed, 10 Dec 2025 22:16:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/8] selftests: ublk: add user copy test cases
Date: Wed, 10 Dec 2025 22:15:55 -0700
Message-ID: <20251211051603.1154841-1-csander@purestorage.com>
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

Caleb Sander Mateos (8):
  selftests: ublk: correct last_rw map type in seq_io.bt
  selftests: ublk: remove unused ios map in seq_io.bt
  selftests: ublk: fix fio arguments in run_io_and_recover()
  selftests: ublk: use auto_zc for PER_IO_DAEMON tests in stress_04
  selftests: ublk: don't share backing files between ublk servers
  selftests: ublk: forbid multiple data copy modes
  selftests: ublk: add support for user copy to kublk
  selftests: ublk: add user copy test cases

 tools/testing/selftests/ublk/Makefile         |  8 ++
 tools/testing/selftests/ublk/file_backed.c    |  7 +-
 tools/testing/selftests/ublk/kublk.c          | 74 +++++++++++++++----
 tools/testing/selftests/ublk/kublk.h          | 11 +++
 tools/testing/selftests/ublk/stripe.c         |  2 +-
 tools/testing/selftests/ublk/test_common.sh   |  5 +-
 .../testing/selftests/ublk/test_generic_04.sh |  2 +-
 .../testing/selftests/ublk/test_generic_05.sh |  2 +-
 .../testing/selftests/ublk/test_generic_09.sh |  2 +-
 .../testing/selftests/ublk/test_generic_11.sh |  2 +-
 .../testing/selftests/ublk/test_generic_14.sh | 40 ++++++++++
 tools/testing/selftests/ublk/test_loop_06.sh  | 25 +++++++
 tools/testing/selftests/ublk/test_loop_07.sh  | 21 ++++++
 tools/testing/selftests/ublk/test_null_03.sh  | 24 ++++++
 .../testing/selftests/ublk/test_stress_03.sh  |  4 +-
 .../testing/selftests/ublk/test_stress_04.sh  | 14 ++--
 .../testing/selftests/ublk/test_stress_05.sh  | 17 +++--
 .../testing/selftests/ublk/test_stress_06.sh  | 39 ++++++++++
 .../testing/selftests/ublk/test_stress_07.sh  | 39 ++++++++++
 .../testing/selftests/ublk/test_stripe_05.sh  | 26 +++++++
 .../testing/selftests/ublk/test_stripe_06.sh  | 21 ++++++
 tools/testing/selftests/ublk/trace/seq_io.bt  |  3 +-
 22 files changed, 350 insertions(+), 38 deletions(-)
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

