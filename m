Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C3FC6FD1C
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 14:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCNO1t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 10:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCNO1r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 10:27:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F2EC3;
        Tue, 14 Mar 2023 07:27:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 761931F895;
        Tue, 14 Mar 2023 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678804064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=R1wW+YnArC6IHU7qwTCVnEU29JD+W5z4FpnswptM4hY=;
        b=eryhgfOvvaYw8USYF2PSt056fJlHaUHN+oyliCoh2ZzqATfy0X0EjhRh8Hn/FG6kbXPP9L
        27kLF4mS/exwNPe0FdbFY61LrT3DogzorndDft/TGe07ZxEZmqjgCp4djiZmyo+SwkQV4D
        Goz/dtdj0KwOPJaY0w+PGgTx77dD8Tw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A70F13A26;
        Tue, 14 Mar 2023 14:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rbnxDGCEEGSPHQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Mar 2023 14:27:44 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org
Subject: [PATCH v2 0/4] xen/blkback: some cleanups
Date:   Tue, 14 Mar 2023 15:27:37 +0100
Message-Id: <20230314142741.24917-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

