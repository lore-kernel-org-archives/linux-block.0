Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17DAC05052
	for <linux-block@archiver.kernel.org>; Fri, 18 Aug 2023 09:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348065AbjHRJ6a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbjHRJ6Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2023 05:58:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720E730D6;
        Fri, 18 Aug 2023 02:58:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 416CB1F893;
        Fri, 18 Aug 2023 09:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692352657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=F+4pE3eEurIa+crq3qA6W7/bubTCplnACoCcJD+xN5k=;
        b=wKfiyMH8jk6H5Z5GyN+6VVe2FgI13BNyUBKp0WOPxRpPWgucE56XNo6ujn3uIMCWAbP0Fh
        14Hl6p+NpL5f6nTxjg2xJpBnbzLk3uEJ571+CZYc6Dt9/rHxotZ0naBzlX8yKZer1MiwfT
        E89p7ZHSJdXcssDi2pFNbMxaLeKO6z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692352657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=F+4pE3eEurIa+crq3qA6W7/bubTCplnACoCcJD+xN5k=;
        b=8/vmGOZLHG3qT9Pt4zNDFnf4wIeAsryWZ9/qw7W8uGvVfR+rdlrCTCwpy0js48t63KsCQs
        Bwa/Xb7TiAv2hfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34036138F0;
        Fri, 18 Aug 2023 09:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rRyiDJFA32SfNgAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 18 Aug 2023 09:57:37 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 0/1] Introduce nvmet target setup/cleanup helpers
Date:   Fri, 18 Aug 2023 11:57:43 +0200
Message-ID: <20230818095744.24619-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce helpers to setup nvmet targets. This is spin off from the refactoring
patches and the allowed_host patches [1].

Sagi suggested to record all resources allocated by nvmet_target_setup and then
later clean them up in nvmet_target_cleanup. I opted to figure out in
nvmet_target_cleanup what was allocated via the newly introdcuded _get_nvmet_ports
helper. The reason being, Hannes told me offline that he would like to add ANA
tests which will add some more ports to the subsystem. I hope with this
the code is more future proof.

BTW, while looking at this I saw that the passthru code is using the awkward
return value port when calling nvmet_passthru_target_setup. It seems some
more refactoring is in order...

[1] https://lore.kernel.org/linux-nvme/5h333eqhtw252sjw6axjewlb5bbb5ze7awekczxe3kie2lnhw6@manyer42khct/

Daniel Wagner (1):
  nvme: Introduce nvmet_target_{setup/cleanup} common code

 tests/nvme/003 | 14 ++-------
 tests/nvme/004 | 21 ++-----------
 tests/nvme/005 | 20 ++----------
 tests/nvme/006 | 19 ++----------
 tests/nvme/007 | 14 ++-------
 tests/nvme/008 | 21 ++-----------
 tests/nvme/009 | 16 ++--------
 tests/nvme/010 | 21 ++-----------
 tests/nvme/011 | 16 ++--------
 tests/nvme/012 | 21 ++-----------
 tests/nvme/013 | 16 ++--------
 tests/nvme/014 | 21 ++-----------
 tests/nvme/015 | 16 ++--------
 tests/nvme/018 | 16 ++--------
 tests/nvme/019 | 21 ++-----------
 tests/nvme/020 | 16 ++--------
 tests/nvme/021 | 16 ++--------
 tests/nvme/022 | 16 ++--------
 tests/nvme/023 | 21 ++-----------
 tests/nvme/024 | 16 ++--------
 tests/nvme/025 | 16 ++--------
 tests/nvme/026 | 16 ++--------
 tests/nvme/027 | 17 ++---------
 tests/nvme/028 | 17 ++---------
 tests/nvme/029 | 21 ++-----------
 tests/nvme/040 | 19 ++----------
 tests/nvme/041 | 18 ++---------
 tests/nvme/042 | 17 ++---------
 tests/nvme/043 | 17 ++---------
 tests/nvme/044 | 19 ++----------
 tests/nvme/045 | 18 ++---------
 tests/nvme/047 | 21 ++-----------
 tests/nvme/048 | 17 ++---------
 tests/nvme/rc  | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
 34 files changed, 154 insertions(+), 519 deletions(-)

-- 
2.41.0

