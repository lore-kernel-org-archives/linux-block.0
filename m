Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402B0C47086
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234E661417
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhEYV0j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 17:26:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36430 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhEYV0j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 17:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621977909; x=1653513909;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/0Fs2t/8Lct+NB2zQOgVL64FvfANBQSa/F9el7DrQpI=;
  b=hfpq35XNvQ74CNj2BrGviw7kmQc6y4jggSCEkTKnjkqZUyYfB55vT9aD
   vwfqkdqMRpcukHzib28vbPpxAIOh11xp3/HlNJg09yMCMhVgmy+zdAg1z
   29sI3ahUXNDvZvlrHYNupdI8tbSLYKMcuEq6ZK/1mjOI+YWlbub2oIdGB
   rW5VDrwlMjJntirSAewvMEyPIoCBc7cP9aEQ5YlGAmiM6rJqsolfPhOOQ
   BLoOD4gyHRgZuk0sjXIg3d93Yc/KkM20ZAtRa/Bmlc9gCG+Ifvmo84k0V
   +tjCNPNQMuRLJ5ajoFlnJ/jc4xeBUBz1+vf3Hikl7DuKYc9NbOp84Q5/q
   A==;
IronPort-SDR: +K1J4ZWh1T94S7Ab8U6qBpa0IKvnlC2vF9+fkKcEia6yzkI603NMiAqoJtWEjDvuf13Oadjclm
 skwQq+rCd3qG+XXHh2knUyPyNrHBBt8oI19OybaBsfcFfEtAJLHhouNwbUnZZAJ7I/GJkueJWo
 LSarhnrOlkdDuU7I0SoK/pkeinFuoMvGSwVWx/qQblbtZNgO1cJaAPgXERuF3FqJI4BmQdJvXR
 N0t5gEDV7xEtK6XSNn4nomE9N/kCp+RlH7ZrN1EhbFvy9qW1TExgvhIYcls8K/AJSaEZ5pwgh1
 ahY=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; 
   d="scan'208";a="168717521"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 05:25:09 +0800
IronPort-SDR: OxATa0SMAN5fewINGwCGYfT5JgEkva7M/i8CEZaOS8SfWwYb9DhmeW+bldd4rj6wH1rxA8P0Q+
 dAsI6lffzNDtPpPyR5KU2puoGux/CwfEESyTfCc/a4ZJDxC38Z9UtDxrjUgnnLcrWqVjr3kFVx
 5hje+MxwvXqoc7mOyI28LTlvJqOeM12ErB0nWBrVKBqhPWqu2DFh8AXPAYrRq6FiMoL2XWufxp
 Br+FqWZk+7LZsLuH9wqSG9Zk7bl3ZGTUgXgW1ikra15YThN7kuC6Zoqm2PrXx2DXftjZpwgKNG
 rxYGLM+GAhUXEFAAi1wIMtLH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 14:04:36 -0700
IronPort-SDR: 3WNVVCsgoR+ULzKivcrpIeAvbOp+kxOVyC48DtAIJxBDV5vcEXViErn5CAUrjJQMKqfidv6Nmn
 lW4Bg5t3O66RzOS5xKoyVViesIm8tMGdOlCpsqFHGufkP5rGYHsGX7RlmFhbYMsT2IfulamBmL
 mB7wkTHfZUs7VDnI13816sg/w+4Zx8k7tQhufvjmRMMR8poDM1pV7kBtqNnBEUJba7UsoT9Rz3
 1LtKYOjwWvvRvRLBKX62ZoFKG0/THsY8cfbQ9toC+X1FKFXWKX+1V5m47kED3THFGonbQhIKBI
 scs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 May 2021 14:25:08 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 04/11] dm: Fix dm_accept_partial_bio()
Date:   Wed, 26 May 2021 06:24:54 +0900
Message-Id: <20210525212501.226888-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525212501.226888-1-damien.lemoal@wdc.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix dm_accept_partial_bio() to actually check that zone management
commands are not passed as explained in the function documentation
comment. Also, since a zone append operation cannot be split, add
REQ_OP_ZONE_APPEND as a forbidden command.

White lines are added around the group of BUG_ON() calls to make the
code more legible.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ca2aedd8ee7d..11af20080639 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1237,8 +1237,8 @@ static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 
 /*
  * A target may call dm_accept_partial_bio only from the map routine.  It is
- * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_RESET,
- * REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH.
+ * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_* zone management
+ * operations and REQ_OP_ZONE_APPEND (zone append writes).
  *
  * dm_accept_partial_bio informs the dm that the target only wants to process
  * additional n_sectors sectors of the bio and the rest of the data should be
@@ -1268,9 +1268,13 @@ void dm_accept_partial_bio(struct bio *bio, unsigned n_sectors)
 {
 	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
 	unsigned bi_size = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+
 	BUG_ON(bio->bi_opf & REQ_PREFLUSH);
+	BUG_ON(op_is_zone_mgmt(bio_op(bio)));
+	BUG_ON(bio_op(bio) == REQ_OP_ZONE_APPEND);
 	BUG_ON(bi_size > *tio->len_ptr);
 	BUG_ON(n_sectors > bi_size);
+
 	*tio->len_ptr -= bi_size - n_sectors;
 	bio->bi_iter.bi_size = n_sectors << SECTOR_SHIFT;
 }
-- 
2.31.1

