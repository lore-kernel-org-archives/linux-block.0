Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB7C761A6
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 10:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCVKQz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 06:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCVKQy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 06:16:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4C5B437
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 03:16:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 505CE339B2;
        Wed, 22 Mar 2023 10:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679480212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZOUr56X6oLTAguiKSagJZCZFiRNyzc9eBOo+j7o65JM=;
        b=2JuL4xcNF4GZFaUSvrWQbOkNXVPAdMsmU+GuRYZ6Dk8ZBxCdvc9oknm1eODr1Fb2FSznT9
        Mo3NM/dSevCEmbBPIGcoMdNfyEXMdhvDTtyIisUJUIXwiiuZk1YGr3wifEe7DVYrN4QS8r
        MDlccMztxVi2hSmoXs3Y+HyUmU1x4/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679480212;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZOUr56X6oLTAguiKSagJZCZFiRNyzc9eBOo+j7o65JM=;
        b=PnFDhm8zTI/oWCH2TLAPIeGzb5sb3u5LENFT/Pz9FuqFKdCCO0EHPq/jbqkay08hVdGeMA
        q0y/Z6gkjNhNg5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 419DE138E9;
        Wed, 22 Mar 2023 10:16:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jnrTD5TVGmR7DAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 10:16:52 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/3] Test different queue counts
Date:   Wed, 22 Mar 2023 11:16:45 +0100
Message-Id: <20230322101648.31514-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Setup different queues, e.g. read and poll queues.

There is still the problem that _require_nvme_trtype_is_fabrics also includes
the loop transport which has no support for different queue types.

See also https://lore.kernel.org/linux-nvme/20230322002350.4038048-1-kbusch@meta.com/

changes:
 v2:
   - make most arguements optional for _nvme_connect_subsys
   - move variable decleration at the beging of _nvme_connect_subsy
 v1:
   - initial version

Daniel Wagner (3):
  nvme/rc: Parse optional arguments in _nvme_connect_subsys()
  nvme/rc: Add nr queue parser arguments
  nvme/047: Test different queue counts

 tests/nvme/041     |  7 +++-
 tests/nvme/042     | 10 +++--
 tests/nvme/043     | 10 +++--
 tests/nvme/044     | 23 +++++++----
 tests/nvme/045     |  6 ++-
 tests/nvme/047     | 65 +++++++++++++++++++++++++++++++
 tests/nvme/047.out |  2 +
 tests/nvme/rc      | 96 +++++++++++++++++++++++++++++++++++++++++-----
 8 files changed, 190 insertions(+), 29 deletions(-)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

-- 
2.40.0

