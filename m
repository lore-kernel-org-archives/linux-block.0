Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0B4C7F
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 04:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429047; cv=none; b=OC61mNC7cyUnFAQ2SWniPlJs6yMfnWpJkJnGx0SPzGPnmPPPoVlKBiVKw1/A2oBFatoxChm56llInBDahS1TaMyD5i7bsNNbULI7ygndFaTvFZ1KD1TITT9V8jKRBswTknUQl/mBtiKrzVoZ1B7URABqFWXZrtNiePxe9UFkr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429047; c=relaxed/simple;
	bh=z1AsIHKa5gmomoRjYMiEGDW8gsmr4v1NRckW8CJvH0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcqV82IYPW878HuHiBby0ptxGIgruRR+UUTd0xXhr0I+mNmtfGVXvTAeFzcKAESt8onJLwDUpfAb8wchxj6n1MZry2+rWewetXowL0AslWPtNYIlsgic7Fbu8H1PysB2suhKcFtTymMrPXziR4kWb/lYoFEQNS0e1joQ3UELhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feQ6Z4DH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feQ6Z4DH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751429042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cPnZjBORITivRIzwgR9xC5bX4Zso0jMPRPPsnjMXCNU=;
	b=feQ6Z4DHBd12u3hckYToPDI2JolC+l+owG3OPg8F0Qp+hOug+nUbX49IU/H2oz7DpAZBCH
	7hd5mkE+ewc297gZKPbwUxp2H2Xtrrb8BmTLYYzmHTlv++YHiEz7c4CDaBkbNuKv/3RjH5
	fmapgyZAiqKF4Ku950KgMOSGwXWRo4A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-d1wbdiNhOMifzYcefoT1XA-1; Wed,
 02 Jul 2025 00:03:59 -0400
X-MC-Unique: d1wbdiNhOMifzYcefoT1XA-1
X-Mimecast-MFC-AGG-ID: d1wbdiNhOMifzYcefoT1XA_1751429037
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A744180028B;
	Wed,  2 Jul 2025 04:03:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3272E30001B1;
	Wed,  2 Jul 2025 04:03:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 00/16] ublk: cleanup for supporting batch IO command
Date: Wed,  2 Jul 2025 12:03:24 +0800
Message-ID: <20250702040344.1544077-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Jens,

The 1st 9 patches cleans ublk driver, and prepare for supporting
batch IO command which needs per-io lock.

The others are selftest cleanup, and prepare for supporting arbitrary
task context & ublk queue combination, which will be allowed with
batch IO feature.

ublk Batch IO feature introduction:

	- use per-queue multshot uring_cmd for fetching incoming io commands,
	and io command tag is saved to provided buffer

	- use per-queue uring_cmd for completing io command result, and io tag
	& result are filled in uring_cmd buffer

	- this way improves communication efficiency, also:

		- allows each queue to be handled in any pthread contexts, and each
		pthread context can handle any number of queues, and driver
		doesn't care ublk server context any more

		- help to apply blk-mq batch optimization in future

		- help to support io polling in future

	- github:

		https://github.com/ming1/linux/commits/ublk2-cmd-batch.v3/

Ming Lei (16):
  ublk: move fake timeout logic into __ublk_complete_rq()
  ublk: look up ublk task via its pid in timeout handler
  ublk: let ublk_fill_io_cmd() cover more things
  ublk: avoid to pass `struct ublksrv_io_cmd *` to
    ublk_commit_and_fetch()
  ublk: move auto buffer register handling into one dedicated helper
  ublk: store auto buffer register data into `struct ublk_io`
  ublk: add helper ublk_check_fetch_buf()
  ublk: remove ublk_commit_and_fetch()
  ublk: pass 'const struct ublk_io *' to ublk_[un]map_io()
  selftests: ublk: remove `tag` parameter of ->tgt_io_done()
  selftests: ublk: pass 'ublk_thread *' to ->queue_io() and
    ->tgt_io_done()
  selftests: ublk: pass 'ublk_thread *' to more common helpers
  selftests: ublk: remove ublk queue self-defined flags
  selftests: ublk: improve flags naming
  selftests: ublk: add helper ublk_handle_uring_cmd() for handle ublk
    command
  selftests: ublk: add utils.h

 drivers/block/ublk_drv.c                    | 249 +++++++++++---------
 tools/testing/selftests/ublk/fault_inject.c |  15 +-
 tools/testing/selftests/ublk/file_backed.c  |  32 +--
 tools/testing/selftests/ublk/kublk.c        | 140 ++++++-----
 tools/testing/selftests/ublk/kublk.h        | 135 ++++-------
 tools/testing/selftests/ublk/null.c         |  32 +--
 tools/testing/selftests/ublk/stripe.c       |  33 +--
 tools/testing/selftests/ublk/utils.h        |  70 ++++++
 8 files changed, 385 insertions(+), 321 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/utils.h

-- 
2.47.0

