Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1204AC6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 09:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjC2JC6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjC2JCx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 05:02:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918FE4694
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 02:02:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69643219CD;
        Wed, 29 Mar 2023 09:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680080524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hstRHPtrpOcBlDp6LFA5+2lp7rWbV1Gd9Ha/HQ48ZkE=;
        b=gqvQ8h3hheao6ZnLNIfd3R/CEtQWEajlUXrKx/d+uo5WacjhxYTA8zTgYWNBqe1pVtT1lD
        GyiHh/YCcyF78Y2uymbYpIRDStTIf5ACHD/6LL6nHtx4osYQEzTnJggh7Ic8AYjvEmiVUe
        7wUzoymV9oPWHTi5x4VOsXVz1dRLzS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680080524;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hstRHPtrpOcBlDp6LFA5+2lp7rWbV1Gd9Ha/HQ48ZkE=;
        b=VuB1TsVIb0+xkHqgyxuBrY7uOB39g3nC3jfFW16iIuzUTrtEw6Sr2vU3eRb8q+780xCls8
        dufmKkqDnVPGC8Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CAD1138FF;
        Wed, 29 Mar 2023 09:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xqmWFoz+I2RRdgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 29 Mar 2023 09:02:04 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 0/4] Test different queue types
Date:   Wed, 29 Mar 2023 11:01:58 +0200
Message-Id: <20230329090202.8351-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Setup different queues, e.g. read and poll queues.

As discussed I introduced a _require_nvme_trtype() function to limit the test to
tcp and rdma. I've upated the existing _require_nvme_type_is_*() checks to
explicit transport checks.

Test run against current nvme-6.4 but it still needs patch #3 from [1] to
survive.

[1] https://lore.kernel.org/linux-nvme/20230322002350.4038048-1-kbusch@meta.com/

changes:
 v3:
   - added _require_nvme_trtype() 
   - updated test requirement checks
   - replaced double shift instructions with 'shift 2'
   - updated license type
   - added FAIL checks
 v2:
   - make most arguements optional for _nvme_connect_subsys
   - move variable decleration at the beging of _nvme_connect_subsy
 v1:
   - initial version

Daniel Wagner (4):
  nvme/rc: Parse optional arguments in _nvme_connect_subsys()
  nvme/rc: Add nr queue parser arguments to _nvme_connect_subsys()
  nvme/rc: Add parametric transport required check
  nvme/047: Test different queue types for fabrics transports

 tests/nvme/041     |   7 ++-
 tests/nvme/042     |  10 +++--
 tests/nvme/043     |  10 +++--
 tests/nvme/044     |  23 ++++++----
 tests/nvme/045     |   6 ++-
 tests/nvme/047     |  66 +++++++++++++++++++++++++++++
 tests/nvme/047.out |   2 +
 tests/nvme/rc      | 103 +++++++++++++++++++++++++++++++++++++++------
 8 files changed, 194 insertions(+), 33 deletions(-)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

-- 
2.40.0

