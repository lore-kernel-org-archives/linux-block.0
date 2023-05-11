Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A29C77B7F
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 14:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbjEKOKH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 10:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238309AbjEKOKB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 10:10:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8372D9EFF;
        Thu, 11 May 2023 07:09:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1878721D0D;
        Thu, 11 May 2023 14:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683814198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xFwaA+wIKlaI/1MZziCKqYmigbddYHG0ysQJeHat2NQ=;
        b=Sc+NC2aajHFAzbYmOO6fTlXPzxkBWDfBIr78JPthJ7YBvYDDptO4TWrhTeyigv0ZhClQQM
        4KPMpny33kNgQTIPpTIO+FrPQraIS3ujxstls5Q618ad/ryaLXR5Rb98fEErOpcUNqUwRt
        aMDH7H1LB28pvcOxavfoOw6WQc29z3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683814198;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xFwaA+wIKlaI/1MZziCKqYmigbddYHG0ysQJeHat2NQ=;
        b=bcI47lEChW3XoQxlvf3fHUXkBiP0YKG+Fj85MP1oyiZEix7tEYVIWecIRYskiIT+wPBK17
        NjevSfIfTAXgKCCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB5F0134B2;
        Thu, 11 May 2023 14:09:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7d3pJDX3XGQ/PwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:09:57 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 00/11] nvme testsuite runtime optimization
Date:   Thu, 11 May 2023 16:09:42 +0200
Message-Id: <20230511140953.17609-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've updated the series with the comments from the last round.  

changes
v4:
  - renamed test
  - updated commit messages
  - fixed whitespace damage
  - fixed ShellCheck reports
  - dropped 'limit number of random jobs'
  - fio runtime 'invinity' changed to 1d
  - fixed typo and updated documentation
  - added tags

v3:
  - 'nvme/rc' instead of 'nvme-rc' subject prefi	x
  - fixed spaces vs tabs indention
  - nvme/014, nvme/015 dropped -1 in #block calculation
  - common/xfs: use 'tail -1' instead 'awk'
  - common/xfs: no need for printf for integer division
  - nvme/035 limit disk size via nvme_img_size
  - set defaults to previous values: nvme_img_size=1G, nvme_num_iter=1000
  - nvme/032, nvme/040 let fio figure out image size
    set timeout to infinity
    cleanup fio
  - add documentation for nvme_tr_type, nvme_img_size and nvme_num_iter
  - limited nproc to 32 for num jobs for random fio job
  - drop job size limit calculation
  - drop nvme_num_iter from nvme/002
  - limit xfs fio job size inside _xfs_run_fio_verify_io()
  - added reviewed tags
  - https://lore.kernel.org/linux-nvme/20230503080258.14525-1-dwagner@suse.de/

v2:
  - made image size configurable via nvme_img_size env
  - make number of iteration configurable via nvme_num_iter
  - do not hard code test values
  - calculate job size
  - use runtime for fio background jobs
   - https://lore.kernel.org/linux-nvme/20230421060505.10132-1-dwagner@suse.de/

v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20230419085643.25714-1-dwagner@suse.de/

Daniel Wagner (11):
  nvme/rc: Auto convert test device size info
  nvme{014/015}: Do not hard code device size for dd test
  common/xfs: Make size argument optional for _xfs_run_fio_verify_io
  common/xfs: Limit fio size job to fit into xfs fs
  nvme{032,040}: Use runtime fio background jobs
  Documentation: Add info on nvme_trtype
  nvme: Make test image size configurable
  nvme: Add minimal test image size requirement
  nvme{045,047}: Calculate IO size for random fio jobs
  nvme{002,030}: Move discovery generation counter code to rc
  nvme{016,017}: Make the number iterations configurable

 Documentation/running-tests.md |   12 +
 common/rc                      |   30 +-
 common/xfs                     |   17 +-
 tests/nvme/002                 |    4 +-
 tests/nvme/002.out             | 3004 --------------------------------
 tests/nvme/004                 |    2 +-
 tests/nvme/005                 |    2 +-
 tests/nvme/006                 |    2 +-
 tests/nvme/007                 |    2 +-
 tests/nvme/008                 |    2 +-
 tests/nvme/009                 |    2 +-
 tests/nvme/010                 |    5 +-
 tests/nvme/011                 |    5 +-
 tests/nvme/012                 |    5 +-
 tests/nvme/013                 |    5 +-
 tests/nvme/014                 |   12 +-
 tests/nvme/015                 |   12 +-
 tests/nvme/016                 |    2 +-
 tests/nvme/017                 |    4 +-
 tests/nvme/018                 |    2 +-
 tests/nvme/019                 |    2 +-
 tests/nvme/020                 |    2 +-
 tests/nvme/021                 |    2 +-
 tests/nvme/022                 |    2 +-
 tests/nvme/023                 |    2 +-
 tests/nvme/024                 |    2 +-
 tests/nvme/025                 |    2 +-
 tests/nvme/026                 |    2 +-
 tests/nvme/027                 |    2 +-
 tests/nvme/028                 |    2 +-
 tests/nvme/029                 |    2 +-
 tests/nvme/030                 |   22 +-
 tests/nvme/031                 |    2 +-
 tests/nvme/032                 |    4 +-
 tests/nvme/034                 |    2 +-
 tests/nvme/035                 |    4 +-
 tests/nvme/040                 |   11 +-
 tests/nvme/041                 |    2 +-
 tests/nvme/042                 |    2 +-
 tests/nvme/043                 |    2 +-
 tests/nvme/044                 |    2 +-
 tests/nvme/045                 |    6 +-
 tests/nvme/047                 |    8 +-
 tests/nvme/048                 |    2 +-
 tests/nvme/rc                  |   40 +
 45 files changed, 183 insertions(+), 3079 deletions(-)

-- 
2.40.0

