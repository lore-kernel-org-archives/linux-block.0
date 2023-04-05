Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863BC76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 15:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbjDEPrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbjDEPrb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 11:47:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE2B5FFC
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 08:47:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E89A22314;
        Wed,  5 Apr 2023 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680709595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=icT/mqr4pMZQJFZc1I7CnseD2mZL4uOS9LIN9x1wVVg=;
        b=WYiSiLOelii2EKxYp+E8jBPI6OOFrs8/pWG0zAHMpo+mD4K1mCOhYaG4x5EybJ556xz5cL
        M6NEpY3IrWtdS7re65XCu6gAVDzOLh9Co3K+rgsoaMt7vZd1JanjTZrgHcKc1ifOMJMrb6
        TER+3p/h8J5QUIHFa6RR4Ko1BDnooQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680709595;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=icT/mqr4pMZQJFZc1I7CnseD2mZL4uOS9LIN9x1wVVg=;
        b=ZUaaFqCYUULstj9anNQ9j7381Jqao9SCxDRznlYfKCjJHoyTauCr5BfyPw5vEI9lDA4KJ5
        Mecgv6rwQ2QtEKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3CBC13A10;
        Wed,  5 Apr 2023 15:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O7aAO9qXLWTTNgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 05 Apr 2023 15:46:34 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v5 0/4] test queue count changes on reconnect
Date:   Wed,  5 Apr 2023 17:46:26 +0200
Message-Id: <20230405154630.16298-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The target is allowed to change the number of i/o queues. test if the
host is able to reconnect in this scenario.

I was able to test this successfully with tcp and rdma. fc still fails due to
the race condition in the target code.

Next attempt to get this series upstream :)

This version is based on my previous posted nvme/047 patches [1]

[1] https://lore.kernel.org/linux-nvme/20230329090202.8351-1-dwagner@suse.de/

v5:
 - moved generic parts to nvme/rc
 - renamed test to 048
 - rebased ontop of nvme/047
v4:
 - do not remove ports instead depend on host removing
   controllers, see
   https://lore.kernel.org/linux-nvme/20220927143157.3659-1-dwagner@suse.de/
 - https://lore.kernel.org/linux-nvme/20220927143719.4214-1-dwagner@suse.de/
v3:
 - Added comment why at least 2 CPUs are needed for the test
 - Fixed shell quoting in _set_nvmet_attr_qid_max
 - https://lore.kernel.org/linux-nvme/20220913065758.134668-1-dwagner@suse.de/
v2:
 - detect if attr_qid_max is available
 - https://lore.kernel.org/linux-block/20220831153506.28234-1-dwagner@suse.de/
v1:
 - https://lore.kernel.org/linux-block/20220831120900.13129-1-dwagner@suse.de/


Daniel Wagner (4):
  nvme/rc: Add setter for attr_qid_max
  nvme/rc: Add nvmet attribute feature detection function
  nvme/rc: Add helper to wait for nvme ctrl state
  nvme/048: test queue count changes on reconnect

 tests/nvme/048     | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/048.out |  3 ++
 tests/nvme/rc      | 58 +++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100755 tests/nvme/048
 create mode 100644 tests/nvme/048.out

-- 
2.40.0

