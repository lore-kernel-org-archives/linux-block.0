Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3404499AB
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632955; cv=none; b=RM4XVxlgY4uNPhhHYjRsHtFh78iHSPs3YLz28EAPrrDBfTAO40oUKc0iQFMdxMEtFxz/B9bhQhtr0I0D28C2Be2idmbaq0CmpL4fAcGrdBslHzdnQhbMVBzGX8JygbMzosTcv4iPj2xMFfxVGGjdN9TV+bWfqdGLrAatKLEgubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632955; c=relaxed/simple;
	bh=VryNCqDkwS+/q7VYxBCQNgJwWOuMJMLYdqMhdaWsx0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qS76edlAhdYdkHhHWqOdBs37X5tmWB6AlUh+LxdWNMdNvJag1vN9XpyVVZB1cU8G2UXNpJZRu8ffolbM8mbb5iTDN0ecGovziNld++JPt2XpWY7Da4uRXzJwjizVYkw4A1hq0XAOWZRsxgd8ZvZz4G/gUX8JAZTGYsbcbxSW7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=u/3M8cD9; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="u/3M8cD9"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7Yj0jgtzlhH04;
	Thu,  9 Jul 2026 21:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632949; x=1786224950; bh=HEkye
	3boB2c402e0J9urodn6qOL1Qf7apbZ397JCq2o=; b=u/3M8cD9/8IYimaQxnBV+
	UzYK6jESd5Wwn/XNDrADKPXchgRLXZhS4YZDY0s8ZYfjcLROhv9i/1aQvQMblA+P
	5bth/CIRDUDK6apBGSyrYQo6qP8BEuWMysQntXmcTrEyYM39CL+umrGlcv7OaYAd
	B9hF6yVJyrwDrRqMGayGko1n2dH6jUOAgIJ8fayfqpgG7Oojdx5iClFll5IxG6k1
	ebw6OZtH5alxHW+tJ5/jlFf+4S4rwriLrQfV+1ucsamGB8uIJNIunv8K44Tjwms7
	5w/Rufdvvl06Oo3F7IFM5wCKBvmEfPmvhdNonXXRub1b+ySlP+QGpgUnXeam/ck6
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id loyh8NckAZCb; Thu,  9 Jul 2026 21:35:49 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7Yc0C9bzlfdCs;
	Thu,  9 Jul 2026 21:35:47 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	=?UTF-8?q?Cc=20=3A=20Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/12] drbd: Enable lock context analysis
Date: Thu,  9 Jul 2026 14:35:21 -0700
Message-ID: <cover.1783632330.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series enables compile-time lock context analysis for DRBD. Th=
e goal
of this series is to allow the compiler to statically verify that locks a=
re
acquired and released correctly, helping to prevent deadlocks and race
conditions. This version addresses feedback received on the v1 series, im=
proves
the annotations, and refactors some conditional locking paths to use the =
modern
cleanup.h guard infrastructure.

Changes since v1:
- Extracted the DRBD patches from a larger series. See also
  "[PATCH 00/27] Enable lock context analysis in drivers/block/"
  (https://lore.kernel.org/all/cover.1781042470.git.bvanassche@acm.org/).
- Fixed the indentation of the arguments of
  drbd_nl_put_dump_connections_result().
- Combined the two drbd_req_state() patches into a single patch.

Please consider these patches for the next merge window.

Thanks,

Bart.

Bart Van Assche (12):
  drbd: Remove "extern" from function declarations
  drbd: Retain one _get_ldev_if_state() implementation
  drbd: Remove the get_ldev_if_state() macro
  drbd: Remove the 'local' lock context
  drbd: Simplify the bitmap locking functions.
  drbd: Move two declarations
  drbd: Pass 'resource' directly to complete_conflicting_writes()
  drbd: Split drbd_nl_get_connections_dumpit()
  drbd: Make a mutex_unlock() call unconditional
  drbd: Rework locking in drbd_req_state()
  drbd: Annotate drbd_bm_{lock,unlock}()
  drbd: Enable lock context analysis

 drivers/block/drbd/Makefile            |   3 +
 drivers/block/drbd/drbd_bitmap.c       |  43 +-
 drivers/block/drbd/drbd_config.h       |   2 +-
 drivers/block/drbd/drbd_int.h          | 594 +++++++++++++------------
 drivers/block/drbd/drbd_interval.h     |  11 +-
 drivers/block/drbd/drbd_main.c         |  41 +-
 drivers/block/drbd/drbd_nl.c           | 117 ++---
 drivers/block/drbd/drbd_receiver.c     |  27 +-
 drivers/block/drbd/drbd_req.c          |  10 +-
 drivers/block/drbd/drbd_req.h          |  24 +-
 drivers/block/drbd/drbd_state.c        |  49 +-
 drivers/block/drbd/drbd_state.h        |  35 +-
 drivers/block/drbd/drbd_state_change.h |  32 +-
 drivers/block/drbd/drbd_worker.c       |   6 +-
 14 files changed, 508 insertions(+), 486 deletions(-)

