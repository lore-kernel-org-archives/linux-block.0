Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84134D3B8
	for <linux-block@vger.kernel.org>; Sat,  1 Nov 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003897; cv=none; b=aOiz6R8WMcg3gv+EWnn4RU1jGT5rTqoJfPVlR9rGgwrULqYsZ16RqbQdXlm6vliUHG/HyLwnEcdNKV66y2vUB5BwFK8SOAmQlLF9c7Gt/Kap8gUDDVcRJrGc+DHCjNWn6Hd/EGjB9qud4saZ57Gyh087H6BK4aZaydgnfRwjEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003897; c=relaxed/simple;
	bh=0d0fRk9nfS99Pfrd5w5RC8rsLRW8lWf/cfsOjt/xFFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kG9puuFiRrf8bu0/1ZKSNcLGvJumWXiWSCwU+W9pM8PE1Zs69ojN57VouFUUogVZhxbLN+w9wMFGyERGd/OZ8MOQiBDmg6KLn5Y28H/bCtsqfKRKnhvVdXWQNcLTyJbhAcTjgfjVliGD+wmkSsWy1tJm2JP2ipPCtNjibrQQmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEjtnKIy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEjtnKIy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762003894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bbUZHYnAW1tmqeRV2XUXle4kBpvIhyRur3vVRSBVno8=;
	b=fEjtnKIyzyXs3UQkvbNYcYvfgN1g89TrjvN1TMX+l3h2pRkkiuHsl+s8JF9AUerwWXB2kA
	NZ5ZCVszjlhFT8PiirhFUzdVmGG1UE/d7Wiz7drNv7VJ4V9G2zdotcfPPQ5uEhdA7sVsi4
	IykOM7qa0JCLAePrVugNvC4uSVXgIrs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453--KwgTjQtPmuW834iZhW4cg-1; Sat,
 01 Nov 2025 09:31:32 -0400
X-MC-Unique: -KwgTjQtPmuW834iZhW4cg-1
X-Mimecast-MFC-AGG-ID: -KwgTjQtPmuW834iZhW4cg_1762003891
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70F5718002C0;
	Sat,  1 Nov 2025 13:31:31 +0000 (UTC)
Received: from localhost (unknown [10.72.120.13])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4EBC21800576;
	Sat,  1 Nov 2025 13:31:29 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/5] ublk: NUMA-aware memory allocation
Date: Sat,  1 Nov 2025 21:31:15 +0800
Message-ID: <20251101133123.670052-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Jens,

The 1st two patches implement ublk driver NUMA aware memory allocation.

The last two patches implement it for ublk selftest utility.

`taskset -c 0-31 ~/git/fio/t/io_uring -p0 -n16 -r 40 /dev/ublkb0` shows
5%~10% IOPS improvement on one AMD zen4 dual socket machine when creating
ublk/null with 16 queues and AUTO_BUF_REG(zero copy).

V4:
	- fix build failure because __counted_by() doesn't support nested fields
	- fix commit log on patch "ublk: implement NUMA-aware memory allocation"

V3:
	- don't use DECLARE_FLEX_ARRAY()
	- annotate flexible array by __counted_by()

V2:
	- use a flexible array member for queues field, save one indirection
	  for retrieving ublk queue
	- rename __queues into queues 
	- remove the queue_size field from struct ublk_device
	- Move queue allocation and deallocation into ublk_init_queue() and
	ublk_deinit_queue() 
	- use flexible array for ublk_queue.ios
	- convert ublk_thread_set_sched_affinity() to use pthread_setaffinity_np()


Ming Lei (5):
  ublk: reorder tag_set initialization before queue allocation
  ublk: implement NUMA-aware memory allocation
  ublk: use struct_size() for allocation
  selftests: ublk: set CPU affinity before thread initialization
  selftests: ublk: make ublk_thread thread-local variable

 drivers/block/ublk_drv.c             | 98 +++++++++++++++++-----------
 tools/testing/selftests/ublk/kublk.c | 70 ++++++++++++--------
 tools/testing/selftests/ublk/kublk.h |  9 +--
 3 files changed, 105 insertions(+), 72 deletions(-)

-- 
2.47.0

