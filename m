Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D63C61DA4
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 12:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCFMBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 07:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCFMBn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 07:01:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA09127D43
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 04:01:40 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 587BE21F28;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678104099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b+WDDC0GPt/fYktKxXWLJixr1Un3fBCnrFe06J6Iy0Y=;
        b=bmuiLBNJQ2mOl4klcvaTt5veZ7A+ajUC7jhmQeYtKKvAoCVrRn/zIp+BbrpjVd7YKnEU/s
        bRcbsMBbWkcTMs/EXMO7J46nq3gzick7+ZXjRmqsdxOG39QMVZPK2UPdZuapz8Mp2iMGj7
        aGYJ7JUlUXpX631b8LKGggb52Aojwh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678104099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b+WDDC0GPt/fYktKxXWLJixr1Un3fBCnrFe06J6Iy0Y=;
        b=uVKqUUT4FEQxIk5q8A6ftvMDItnby12pWvGxE4H1UZJ8BgLCGxogiepYgq8nIGUdVqgshj
        3BqaLHZNaKo6sQBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 418162C145;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 304F051BE387; Mon,  6 Mar 2023 13:01:39 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/5] brd: Allow to change block sizes
Date:   Mon,  6 Mar 2023 13:01:22 +0100
Message-Id: <20230306120127.21375-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

meat to the bone: with this patchset one can change the physical and
logical block size of the 'brd' ramdisk driver.
Default is 512 (for both); one can easily increase the physical block
size to 16k and the logical block size to 4k.
Increasing the logcial block size beyond 4k gives some 'interesting'
crashes.
It should also be possible to use the resulting ram disk as a backend
for nvme target, thereby exercising the NVMe stack for larger block
sizes, too.

Happy hacking!

Hannes Reinecke (5):
  brd: convert to folios
  brd: abstract page_size conventions
  brd: make sector size configurable
  brd: limit maximal block size to 32M
  brd: make logical sector size configurable

 drivers/block/brd.c | 244 ++++++++++++++++++++++++--------------------
 1 file changed, 136 insertions(+), 108 deletions(-)

-- 
2.35.3

