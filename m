Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3BDCA9EB5
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 08:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9896D214AE
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 08:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfJUIiK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:38:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:44638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbfJUIiJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 04:38:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1866B0BD;
        Mon, 21 Oct 2019 08:38:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6075D1E4AA0; Mon, 21 Oct 2019 10:38:08 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] bdev: Refresh bdev size for disks without partitioning
Date:   Mon, 21 Oct 2019 10:37:58 +0200
Message-Id: <20191021083132.5351-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I've been debugging for quite a long time strange issues with encrypted DVDs
not being readable on Linux (bko#194965). In the end I've tracked down the
problem to the fact that block device size is not updated when the media is
inserted in case the DVD device is already open. This is IMO a bug in block
device code as the size gets properly update in case the device has partition
scanning enabled.  The following series fixes the problem by refreshing disk
size on each open even for devices with partition scanning disabled.

								Honza
