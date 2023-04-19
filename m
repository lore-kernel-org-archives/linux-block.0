Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0153C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 08:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjDSIsE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjDSIsE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 04:48:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443481A4;
        Wed, 19 Apr 2023 01:48:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6E752193C;
        Wed, 19 Apr 2023 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681894081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p1s5jMDrUBxZBZWTGeFE0HAki3ixSROArH88l+ErhWQ=;
        b=lZzuFhPiUoGy/vSbK76tTDOCZMiJnkr7I0qcrjCNKrXyhkiibQ1QLTw98PNuD00YABQuqs
        ZFPYTdmmzDHttjckDGbqHWDgbmyuuSSGGAmnuG5oIPTezou1zWb5/x8ojZCOysTxvQMjLZ
        fsiYzRbXhUF/EEruw2UeMukvxk1fj4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681894081;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p1s5jMDrUBxZBZWTGeFE0HAki3ixSROArH88l+ErhWQ=;
        b=utW/gvW2BNoWXYLubrP/Yy7rWTOR5SkGkMjk3RtjlAsI2frWzssb8EjbRaLmCpmFG0VaDv
        QphJLNKY8zuO3rAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D89FA1390E;
        Wed, 19 Apr 2023 08:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tjrTNMGqP2SydQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 08:48:01 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/2] nvme_trtype=fc fixes
Date:   Wed, 19 Apr 2023 10:47:55 +0200
Message-Id: <20230419084757.24846-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the attempt to get the fc transport running for blktest I found a couple of
issues in the current cleanup code path for fc. With these fixes and the kernel
patches and configuration from

  https://lore.kernel.org/linux-nvme/20230418130159.11075-1-dwagner@suse.de/

it starts to work nicely, incl finding some bugs in fc I think.

Daniel Wagner (2):
  nvme-rc: Cleanup fc ports in reverse order
  nvme-rc: Cleanup fc resource before module unloading

 tests/nvme/rc | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.40.0

