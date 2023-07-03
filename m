Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB6DEB64DD
	for <linux-block@archiver.kernel.org>; Mon,  3 Jul 2023 09:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjGCJQ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jul 2023 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGCJQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jul 2023 05:16:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF712E;
        Mon,  3 Jul 2023 02:16:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98DC8218F3;
        Mon,  3 Jul 2023 09:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688375814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oYXq0IbhQpypu2rSTUhyLrl9oNXw4wveppQQDzCPsJc=;
        b=ppm0jnDaJ9ZJmrsT8J0xJ+6lI8FGY1B0GZwY2sd/7X3ub8pT+3Ln5YJxiwe2uwEReNc+9O
        DOv8vUOhvSN5K6CDjc/DAEXg3d1ZuIXL9RzZF6ti3+Sh4uBx6gOna6b5Na2PiHl/6J275M
        ygd4LnrXraG9nqC5ckI9VXsTn2Ux8EQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688375814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oYXq0IbhQpypu2rSTUhyLrl9oNXw4wveppQQDzCPsJc=;
        b=xH1+Lm2YfLnJMPcD2TgOu6M06QcJXqPt77dG6iYvcRcqQUCcL4Kn39+10O/+Lk3/HHxvC7
        5CbbwFHl2iY758BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8704613276;
        Mon,  3 Jul 2023 09:16:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PEjrIAaSomSCDgAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 03 Jul 2023 09:16:54 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 0/3] More fixes for FC enabling
Date:   Mon,  3 Jul 2023 11:16:44 +0200
Message-ID: <20230703091647.800-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've rebased the series on the current HEAD and moved the def_hostnqn bits from
the second patch to the third. This should make it more consistent in commit
history.

Also retested and found a bug in the context matching code in libnvme which I
post a fix too.

changes:
v3:
  - rebased
  - moved def_hostnqn bits from second patch to third
  
v2:
  - https://lore.kernel.org/linux-nvme/20230628151623.11340-1-dwagner@suse.de/ 
  - nvme/048:
    - untaggle waiting for state change and queue count check
    - make all variables local
    - compare numbers not strings
  - nvme/rc:
    - rename _nvme_cli_supports_context to _have_nvme_cli_context
    - only add --context for fc
    - reordered setup/cleanup
  - nvme/{041,042,043,044,045,048}:
    - move all changes related to this patch
v1:
  - https://lore.kernel.org/linux-nvme/20230620132703.20648-1-dwagner@suse.de/

Daniel Wagner (3):
  nvme/048: Check for queue count check directly
  nvme/rc: Avoid triggering host nvme-cli autoconnect
  nvme/{041,042,043,044,045,048}: Use default hostnqn and hostid

 tests/nvme/041 |  8 ++---
 tests/nvme/042 |  8 ++---
 tests/nvme/043 |  8 ++---
 tests/nvme/044 |  8 ++---
 tests/nvme/045 |  8 ++---
 tests/nvme/048 | 32 +++++++++++++-------
 tests/nvme/rc  | 81 +++++++++++++++++++++++++++++++++++++++-----------
 7 files changed, 96 insertions(+), 57 deletions(-)

-- 
2.41.0

