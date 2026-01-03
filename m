Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD91B4223
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401135; cv=none; b=mvXooOXpm68QghhdN6mqY1sl9wFkoIjOe+M6ZoszcVZGtRh6sD4IGsJAEOxNrJsjBcbTvjZqY/tBzUMvN7ih0WDYdkFTc8da5RLMHkZ1lGguT0Pfiisya6chu2z1csAAgWKvMTTUaoqlEPDSGNQXfFEyyGVhZ3T/a+2CnT3zVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401135; c=relaxed/simple;
	bh=kDNBpWln3tss6/GnGFcYCJpi6GkixDu6za8dJ31Z50o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTk8UpYmWnH1rxdNG8ZgSQc6kTOJSgJY9wp2FX58jiSQGjQykzOYVUnlvPPm7RK+iDRfUHFbIJPyazsSgFis2QBi158Tt0sro29/kxLzIh8W98800W+d7GzoZidmF3gFwv6C6CPdwK5n5fww0v8Nu+ez5vmndlGNv3jqN/7FdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CvA2fnC+; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CvA2fnC+"
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-6446c7c5178so1907326d50.1
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401132; x=1768005932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgWUPa6orN5QoP4AMyCwl9k4V9aiIUl9wXZJoJJf0Jo=;
        b=CvA2fnC+97ZdMzsjUzXBbTtr6v22pYe7uHDVQ53j9QD+Eef9W8SyPXujsi7QNR0rtZ
         JJJSAlOWnDuglV08T09NaFx4V5w9NVoett/uMfNPPLRlMnEzHeHX2rBSysQDSarV0ZQA
         s0aUJEvOcBhq4Ii19SLlUJs+y6DhCfm7yQh2d56KjXb7Tv3rbwoyNAFePUDcBVLK+eHq
         W7zNEsTXLd05E4l9L/o2hJdF64VWnEDedDgKZbXa4hc6lmhAIYFGiaeURjf4Rke7smLo
         YjGRzt+SquZd16K/DXJWu2VahH2oepncmfwhX68BYkHsoP0HBjzRCp/HTS6G8/8fGAfx
         BrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401132; x=1768005932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgWUPa6orN5QoP4AMyCwl9k4V9aiIUl9wXZJoJJf0Jo=;
        b=ud/iOq/2NyP+OztDnOA+7lH+GSLZkYO0D717RfZ5OqbawWPyO8vHzrYe89Rrsco0ms
         HtdxPt/2nM4xLJ+SWvKLOZrT25luMhsjMaAGDZqZbagUgPhkd5XqL2DMdnYqQSz3NedX
         XjzWG4TL1RwgSOAoF/AIc1ASV9tvINLKTJGk6v10+h7hF5L/gQGBBw3KloPc8dGRCUJh
         GLc5KBkNFkVpYR1hZspdaoSnGBIpLvr6XiFRcL7LZKSAXGpVKzM30zuoDqitnryXx8SF
         k8G+eToAS7Mxpwuzg5VJrHy+8Z6U4o4/B3qi3x//ShZJLN2YZUQbcwB1E2sWV4AFD41/
         p2Cw==
X-Gm-Message-State: AOJu0YwGRJD5nodXWQSexRLUHRDbKq03+nza8mG8909+aYUO4N5e3jVa
	cx9ePT/QyMCPNiOkjDNU4E9k39CzjCylzHTGvMdeP9jVie/CTGF9zNEhkctG6TPpdUpbutN9j9g
	+w7eWs8Nl2W7qPlARwnnw91axEORcIUCNTBlx0Kzr6T5bqpY/oD5l
X-Gm-Gg: AY/fxX5EJPSK03ci9+9E0DKGG8/KdbyQr5YZiTFX3YQRZ8H5Ii7VMy05ZYs+Ap8FCAG
	IZKLBB7BYuJwzaipREwpGcrJ4LSkcUrI0o+fRzmEmXEQfXps1qjXz99M0HnGPzyRjCWCF1IQ/gr
	ITtCuk7SnN85e3cMMP7m6nx2kKdrTmtuQ8DDRTR5o+6ybeSrnca0xTDI6CZAMTgq4Vrn+0SxrV2
	8hG6unQk1tHT0HCLFNl0hPsBiKUBlJlIiJ5JFLFLm8WUKC7yB/omk+ZLVKgFRoVXwQll5Cdwqrf
	djDAm38YQBuUQ+/s9ncRBCzRuJBWmVtk4Kjyo5uG8p42ucWdIRbt8gbgb96TQmkGJRJKQln4OsO
	abVPYUTH2o50kWe2NTXKsbIEgG58=
X-Google-Smtp-Source: AGHT+IE08Oyk7AKw0dONXxGMI2MnsTwQytJiVnGGfrOyte7cJ8GRAAloVoyv9LI4dr8MqA1SgEpfYp2R/pa3
X-Received: by 2002:a05:690c:e3e8:b0:789:524e:4be1 with SMTP id 00721157ae682-78fb4015871mr306474087b3.2.1767401132579;
        Fri, 02 Jan 2026 16:45:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78fcdc7488csm19124737b3.2.2026.01.02.16.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 73C353402DF;
	Fri,  2 Jan 2026 17:45:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 69390E43D1D; Fri,  2 Jan 2026 17:45:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 00/19] ublk: add support for integrity data
Date: Fri,  2 Jan 2026 17:45:10 -0700
Message-ID: <20260103004529.1582405-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Much work has recently gone into supporting block device integrity data
(sometimes called "metadata") in Linux. Many NVMe devices these days
support metadata transfers and/or automatic protection information
generation and verification. However, ublk devices can't yet advertise
integrity data capabilities. This patch series wires up support for
integrity data in ublk. The ublk feature is referred to as "integrity"
rather than "metadata" to match the block layer's name for it and to
avoid confusion with the existing and unrelated UBLK_IO_F_META.

To advertise support for integrity data, a ublk server fills out the
struct ublk_params's integrity field and sets UBLK_PARAM_TYPE_INTEGRITY.
The struct ublk_param_integrity flags and csum_type fields use the
existing LBMD_PI_* constants from the linux/fs.h UAPI header. The ublk
driver fills out a corresponding struct blk_integrity.

When a request with integrity data is issued to the ublk device, the
ublk driver sets UBLK_IO_F_INTEGRITY in struct ublksrv_io_desc's
op_flags field. This is necessary for a ublk server for which
bi_offload_capable() returns true to distinguish requests with integrity
data from those without.

Integrity data transfers can currently only be performed via the ublk
user copy mechanism. The overhead of zero-copy buffer registration makes
it less appealing for the small transfers typical of integrity data.
Additionally, neither io_uring NVMe passthru nor IORING_RW_ATTR_FLAG_PI
currently allow an io_uring registered buffer for the integrity data.
The ki_pos field of the struct kiocb passed to the user copy
->{read,write}_iter() callback gains a bit UBLKSRV_IO_INTEGRITY_FLAG for
a ublk server to indicate whether to access the request's data or
integrity data.

v2:
- Communicate BIP_CHECK_* flags and expected reftag seed and app tag to
  ublk server
- Add UBLK_F_INTEGRITY feature flag (Ming)
- Don't change the definition of UBLKSRV_IO_BUF_TOTAL_BITS (Ming)
- Drop patches already applied
- Add Reviewed-by tags

Caleb Sander Mateos (16):
  blk-integrity: take const pointer in blk_integrity_rq()
  ublk: move ublk flag check functions earlier
  ublk: set request integrity params in ublksrv_io_desc
  ublk: add ublk_copy_user_bvec() helper
  ublk: split out ublk_user_copy() helper
  ublk: inline ublk_check_and_get_req() into ublk_user_copy()
  ublk: move offset check out of __ublk_check_and_get_req()
  ublk: optimize ublk_user_copy() on daemon task
  selftests: ublk: display UBLK_F_INTEGRITY support
  selftests: ublk: add utility to get block device metadata size
  selftests: ublk: add kublk support for integrity params
  selftests: ublk: implement integrity user copy in kublk
  selftests: ublk: support non-O_DIRECT backing files
  selftests: ublk: add integrity data support to loop target
  selftests: ublk: add integrity params test
  selftests: ublk: add end-to-end integrity test

Stanley Zhang (3):
  ublk: support UBLK_PARAM_TYPE_INTEGRITY in device creation
  ublk: implement integrity user copy
  ublk: support UBLK_F_INTEGRITY

 drivers/block/ublk_drv.c                     | 387 ++++++++++++++-----
 include/linux/blk-integrity.h                |   6 +-
 include/uapi/linux/ublk_cmd.h                |  49 ++-
 tools/testing/selftests/ublk/Makefile        |   6 +-
 tools/testing/selftests/ublk/common.c        |   4 +-
 tools/testing/selftests/ublk/fault_inject.c  |   1 +
 tools/testing/selftests/ublk/file_backed.c   |  61 ++-
 tools/testing/selftests/ublk/kublk.c         |  90 ++++-
 tools/testing/selftests/ublk/kublk.h         |  37 +-
 tools/testing/selftests/ublk/metadata_size.c |  36 ++
 tools/testing/selftests/ublk/null.c          |   1 +
 tools/testing/selftests/ublk/stripe.c        |   6 +-
 tools/testing/selftests/ublk/test_common.sh  |  10 +
 tools/testing/selftests/ublk/test_loop_08.sh | 111 ++++++
 tools/testing/selftests/ublk/test_null_04.sh | 166 ++++++++
 15 files changed, 833 insertions(+), 138 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/metadata_size.c
 create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_04.sh

-- 
2.45.2

