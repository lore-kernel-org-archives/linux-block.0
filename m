Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525BAC4332F
	for <linux-block@archiver.kernel.org>; Fri, 16 Dec 2022 14:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiLPO6a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Dec 2022 09:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiLPO61 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Dec 2022 09:58:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4445A5EDE5;
        Fri, 16 Dec 2022 06:58:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB59920626;
        Fri, 16 Dec 2022 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671202699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=R1wW+YnArC6IHU7qwTCVnEU29JD+W5z4FpnswptM4hY=;
        b=RPWPVOBsskz04N7Bs80MzKbVK0TW+qYkqcq6zmrJVIdNMS00iR9E+umskIYVfJqSUpv6dU
        wc5ZrjMr711EUmfDiF8BVthyWgjAL+Lpn+wIQYt1aHQAUdrQRrjX5A7Vx0Wkes0Spfr1yV
        eS7zR6RrBgnO0ts3KKylu/zSwXbFDBo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACA72138FD;
        Fri, 16 Dec 2022 14:58:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mnOrKIuHnGOkeAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 16 Dec 2022 14:58:19 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org
Subject: [PATCH 0/4] xen/blkback: some cleanups
Date:   Fri, 16 Dec 2022 15:58:12 +0100
Message-Id: <20221216145816.27374-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some small cleanup patches I had lying around for some time now.

Juergen Gross (4):
  xen/blkback: fix white space code style issues
  xen/blkback: remove stale prototype
  xen/blkback: simplify free_persistent_gnts() interface
  xen/blkback: move blkif_get_x86_*_req() into blkback.c

 drivers/block/xen-blkback/blkback.c | 126 +++++++++++++++++++++++++---
 drivers/block/xen-blkback/common.h  | 103 +----------------------
 2 files changed, 118 insertions(+), 111 deletions(-)

-- 
2.35.3

