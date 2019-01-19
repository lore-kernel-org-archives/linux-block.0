Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15288C61CE8
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDDD2084C
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 18:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKN/6PGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfASSFK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:05:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36869 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfASSFK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 13:05:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id t33so18792626qtt.4
        for <linux-block@vger.kernel.org>; Sat, 19 Jan 2019 10:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=g96HLR62Z1wD7qmSoZM/UnDZmhZ+xYmrHF0WPxiKWkM=;
        b=TKN/6PGgmjF7rDnxnK8BPaoeDIw1yGMY7VXx+1rfsxVd7gszBPHKtdSqQAD4tKtNI3
         wwlGUkJ9EFY1USm3674Vbrlwa5nZwT58SClN8EpeZQNFtnzE7HtEApT7EhVob0ZJR5lo
         D9D/JlD0fKOkEz5KLJFFpzmedyaxX5Qk4B9vKFLUY2F4/29Ri2+zETpxcYYNXp0azXVE
         KpE00ccWLr7XcTVPTXJRsLq1HkOFDOgL8+tadfiySkCIYUFv7YasVSF5bsL4anDdaYmm
         7MnQucCEIt20jzPqEgq9m6uAbDBt7YLLSYJZiKn1SPzmaHJKCYzRKUnr0Q4iPIBGa9Kn
         /yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=g96HLR62Z1wD7qmSoZM/UnDZmhZ+xYmrHF0WPxiKWkM=;
        b=L24fed//bXmjOoggKfbGCYoPiVSAWKMMBbFLbs9iHF60z1EhfLhCu1TJhz+34ZJ+ab
         U0W1280hTvV7pLWXYjzb0H2YesVWDM4e8sXiASWgaEKsJRAMD3H2VcWkMyci/JIQAHGu
         uKROecAvWUVgnBWyi8NfV8GJOTjwisxy5GMGdeyD2P4nmgr7c+KV2DNhGqmYYm1GgasH
         e4rn94Llijl2/jOP0OcLrsaz3M+RXacFEPjRRaT19ppEFrZ7PKRUBDPcT+9s4VHI+u/g
         WTxV8YzEt0niwFhAPLRsWg8AmqexW0M8EIZnDQvU8KcuzPZyrp68AEFjZDvI+VcK7lWW
         Ownw==
X-Gm-Message-State: AJcUukeJ1Y1JSioB3bQ39BPtlW2xtehBrGZYgKh7bwaMhGOd4Qp5XMht
        Wtzr/X17rSJBmznY5tReJME=
X-Google-Smtp-Source: ALg8bN7Wpu20ypQqoQKf5O/TG07QX08bnSGGwX06cSSNIkfreFkN2ZvNGmvoX+/aPxWCKaSs+vsRyQ==
X-Received: by 2002:a0c:c348:: with SMTP id j8mr20282090qvi.201.1547921109288;
        Sat, 19 Jan 2019 10:05:09 -0800 (PST)
Received: from localhost (pool-68-160-176-113.bstnma.fios.verizon.net. [68.160.176.113])
        by smtp.gmail.com with ESMTPSA id g189sm44447854qkb.3.2019.01.19.10.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 10:05:07 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     NeilBrown <neilb@suse.com>, Ming Lei <ming.lei@redhat.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH 0/4] dm: fix various issues with bio splitting code
Date:   Sat, 19 Jan 2019 13:05:02 -0500
Message-Id: <20190119180506.1300-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

These mostly stable@ patches will be sent to Linus for 5.0-rc4
inclusion (would've sent today for 5.0-rc3 but I don't yet have
linux-next coverage).

Just wanted to give a heads up because some of the problems fixed
could bite other users of the bio_split()+generic_make_request()
recursive pattern.  We should probably factor out some helpers that
all users could share (e.g. so they don't forget to set
BIO_QUEUE_ENTERED or call trace_block_split(), etc).

Thanks,
Mike

Mike Snitzer (4):
  dm: fix clone_bio() to trigger blk_recount_segments()
  dm: fix redundant IO accounting for bios that need splitting
  dm: fix missing bio_split() pattern code in __split_and_process_bio()
  dm: fix dm_wq_work() to only use __split_and_process_bio() if appropriate

 drivers/md/dm.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

-- 
2.15.0

