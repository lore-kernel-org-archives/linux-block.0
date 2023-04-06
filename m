Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A314C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 08:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjDFIa6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjDFIa5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 04:30:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C286A7A
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 01:30:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4C6721FB8;
        Thu,  6 Apr 2023 08:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680769854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=l9RjLCGA+9Gi+v/GAwuEsXri/jmmvtA42minBTKTu98=;
        b=DNnXfHBzagX8KTOVoAA0CDzwmIE76AeEdeK06qSvv/WYIOwd3iDY5nCvEEwMdFE24x7tDG
        /bqO69Tk5EfNb4CNwnztdtVdm9564t2Xfdg0ZqstQf07X5pwNprxk3QTbyrcdnKBucqaeU
        B+LNLa0Tq7P+q0sEawYJcbpLaZC230s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680769854;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=l9RjLCGA+9Gi+v/GAwuEsXri/jmmvtA42minBTKTu98=;
        b=q2whHGiQt3BC+IMBSVp1JjC1Boo2CR9AdLklJtfwVTAKR4xk7lPVcuSpoG8D4QL2pKwNU2
        f7NBlXYLVdVstLDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92056133E5;
        Thu,  6 Apr 2023 08:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TYmfIz6DLmTLZAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 08:30:54 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v6 0/2] test queue count changes on reconnect
Date:   Thu,  6 Apr 2023 10:30:48 +0200
Message-Id: <20230406083050.19246-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The target is allowed to change the number of i/o queues. Test if the
host is able to reconnect in this scenario.

I've incorperated Chaitanya's feedback and also optimized the runtime for the
good and the bad case (rdma started to fail today, something to fix). Before it
run for rougly 25 seconds when everytying was okay.

  # nvme_trtype=rdma ./check nvme/048
  nvme/048 (Test queue count changes on reconnect)             [failed]
      runtime  6.488s  ...  6.404s
      --- tests/nvme/048.out      2023-04-06 09:38:29.574194562 +0200
      +++ /home/wagi/work/blktests/results/nodev/nvme/048.out.bad 2023-04-06 10:09:47.692036702 +0200
      @@ -1,3 +1,11 @@
       Running nvme/048
      -NQN:blktests-subsystem-1 disconnected 1 controller(s)
      +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
      +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
      +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
      +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
      +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
      ...
      (Run 'diff -u tests/nvme/048.out /home/wagi/work/blktests/results/nodev/nvme/048.out.bad' to see the entire diff)
  # nvme_trtype=tcp ./check nvme/048
  nvme/048 (Test queue count changes on reconnect)             [passed]
      runtime  6.350s  ...  6.227s
  
This version is based on my previous posted nvme/047 patches [1]

[1] https://lore.kernel.org/linux-nvme/20230329090202.8351-1-dwagner@suse.de/

v6:
 - moved generic rc bits back into test case
 - added checks to fail early
 - added timeout values parser for connect call
 - reduced timeouts (runtime reduction for good and bad case)
 - fixed shellcheck warnings
v5:
 - moved generic parts to nvme/rc
 - renamed test to 048
 - rebased ontop of nvme/047
 - https://lore.kernel.org/linux-nvme/20230405154630.16298-1-dwagner@suse.de/
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

Daniel Wagner (2):
  nvme/rc: Add timeout argument parsing to _nvme_connect_subsys()
  nvme/048: test queue count changes on reconnect

 tests/nvme/048     | 125 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/048.out |   3 ++
 tests/nvme/rc      |  24 +++++++++
 3 files changed, 152 insertions(+)
 create mode 100755 tests/nvme/048
 create mode 100644 tests/nvme/048.out

-- 
2.40.0

