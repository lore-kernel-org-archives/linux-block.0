Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5271C43444
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8872E20870
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 08:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfANIsR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:48:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:48724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfANIsR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 03:48:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F1AAAF1B;
        Mon, 14 Jan 2019 08:48:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 77B7D1E157A; Mon, 14 Jan 2019 09:48:15 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Josef Bacik <jbacik@fb.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] blkdev: Fix livelock when loop device updates capacity
Date:   Mon, 14 Jan 2019 09:48:08 +0100
Message-Id: <20190114084811.14455-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

this series fixes a long standing issue with loop device which can change block
device size under a mounted filesystem which causes infinite loop inside buffer
head code. See patch 2/2 for details about the problem.

Note that generally it is dangerous to resize the loop device when filesystem
is mounted on top of it. However there are some valid use cases for this (such
as growing the loop device and then increasing the filesystem size) so we
cannot just restrict the functionality to exclusive owners of the device.

								Honza
