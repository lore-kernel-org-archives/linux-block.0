Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC0245031
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516627; cv=none; b=siipEBiYd+D4u3BBBVvFTDjxFJJr0FMEUq6Ud9Usx8JSqyZ0gr2Pw5b1xyAt9r28Bz4LkcCCRyL5gXHKLKSqxPIcC8BU2hGd2otCwIexL1nkpscR7irm/tL6RXkdgqjLmR98yZ9Jchpfvh8wWIMA5XFgqcLIAnaSopjucXC9ZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516627; c=relaxed/simple;
	bh=Kx8N1bylWHtbc8Bcfrw3QypXu8hIDc8UcqEu1LGE9cI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePe1nfl2mVv9VnDbALeFn0lvhsLIDtH6vFKPEYKXwpyMWp3yMKW9eaqpktaJOvz5YtrUg5c60FEBGeGfxiUcEAi6SQ88uvPZF6kwXTQsWswOZRwtZ1sTGbrFQ5j+sNhVwznPhpn67QqUKanP7FvG4WDHbFY5S59l9N5OQ1akB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W0ACdi1p; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W0ACdi1p"
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-b735158ef24so12532766b.1
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 21:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516624; x=1766121424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ai5WkR4oEYh5O0EvOPkNqS4qWJnvXURC4QkhQFv6TA=;
        b=W0ACdi1pwQRQFoB/Jyibb7GcNiq2H9lXu03g12eBDRH8C6mtU80AEUwtSi4yzgn0xa
         KlJ31uDLXgOjO1I+wf1JkuLdSiLiYvT4kjzDJ+MgocZXF5vS+UU8p6MXpUO9O0gB2iq6
         9cWv14cJ20ujfu3eSbDffVl/qUa7XbWtWQWFltTmFbMjC53alc2DMoBFAGrRlTap6NBs
         RQegHuBNZJVyXnT++eEwSFWyRnTPAS20h+3ogHCkfcbxsemvmGaKy1hGCv5VsGdE6FS1
         EYsfXy6LCWiBE/BoYq89PlVH/+3uyhTgm9rjmehIt1NX08cbXWKj6rFgPAoybKMFuZCA
         d+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516624; x=1766121424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ai5WkR4oEYh5O0EvOPkNqS4qWJnvXURC4QkhQFv6TA=;
        b=UiUVg6Sws4DJQH019mQVBEPTdSkXQBQJb/yTHoJHoQDn2OXnsFB7LWoe4mPeSU3Td6
         Yz2mLKZobYx82r2jS01Bk8l27yT3hfJs6bSY6rd7nrEnvEMBrLFJ0L5x+KVPCb03zUna
         9MYLre2aDfUAnTLOhWA7aciUUeqd3WJgkVGOpoUWbqHHTsmeLut11AwXEnbjAktwYKeL
         9W9WTtwMd3udikr8VmYB7RoCilM3WBd74TilB1nfy90HR5spbK1bXcYDtL0G5E5U+pug
         I2E7QeInBuiR1rkJMZXEbxSXbL6q5r7IMAhKfn1pT0MrBqNAGfup0Is1F6jRdJ3PiAPK
         WVGQ==
X-Gm-Message-State: AOJu0YwkOwWOwuSZItZ0in9IbDfh1HuvtDRyaTBqxo2xdmq/7O5NFmFV
	ZBF7wIhwwb6ELsC0mpX4FcDUKubaMjjecWeVi0n5YcohWRbV65qv8H1i4gejPFpxdp0pK33nvDn
	tOatxAug93Z0KUZw83CV1zUDVJRpkDv24Wjb+3W1r7s0kbI8ooUUt
X-Gm-Gg: AY/fxX518lea4XfAs65Yozn6PlIyhNTioHj0BSHSg1aeFh8cXT0APVDd/EAj0ioXAmF
	sXKqbATWqxvOuQEAqgZSnw4bMfEBEEcFBURosOLK177tSxa2LWn/BQNjZ832xIZigBu/xdmSdz3
	+aW3EWcPvLyM5iPAP3o92cuAgZskDkLSEJA0tjBr6Qy3GhY58a9hdmAEFg9ZDeDaAg9LzRNcx1J
	ZzqDxFP/ZAZvFUX0+MTnLQ0bNVyImr2+vKlhUA/TtIHyQyvST1ufUJDv0ENxQXEiSlXBqpf9d7p
	7Pl23N9YKCS61lSuVPG4WHshVWD1uHgiPe2l1CZQywYHbxegOhlhnwz8fhyhbCs0bvI1sk2ESBk
	It9KY6VdBcgnWQO0DcDMDyVOgnfg=
X-Google-Smtp-Source: AGHT+IGJPg4q2IDeX/L7bg7HAM9XpF8sJyvqLzheZcLWMRdmnfuidnrD1FeMw27GjSBDHq5hw179fL9B+2OP
X-Received: by 2002:a17:907:3f20:b0:b73:51f6:e070 with SMTP id a640c23a62f3a-b7d23aa416emr34917866b.7.1765516623708;
        Thu, 11 Dec 2025 21:17:03 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b7cfa54ea05sm89263266b.51.2025.12.11.21.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:03 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6B56634079F;
	Thu, 11 Dec 2025 22:17:02 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 64581E41A2E; Thu, 11 Dec 2025 22:17:02 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/8] selftests: ublk: add user copy test cases
Date: Thu, 11 Dec 2025 22:16:50 -0700
Message-ID: <20251212051658.1618543-1-csander@purestorage.com>
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

 tools/testing/selftests/ublk/Makefile         |  8 +++
 tools/testing/selftests/ublk/file_backed.c    |  7 +-
 tools/testing/selftests/ublk/kublk.c          | 64 +++++++++++++++++--
 tools/testing/selftests/ublk/kublk.h          | 11 ++++
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
 20 files changed, 336 insertions(+), 27 deletions(-)
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

