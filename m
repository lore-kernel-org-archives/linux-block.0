Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2DFC433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Nov 2022 22:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiKOWqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Nov 2022 17:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiKOWqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 17:46:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729FC1E3E6;
        Tue, 15 Nov 2022 14:46:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 225CB209D5;
        Tue, 15 Nov 2022 22:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668552363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lXHqxpkurBmpumd+Q+NIofh19DXjIJGUvD54QuP9Lv8=;
        b=MCmboMBl4oZrDliTyU5M4t0N5fuCsD1fnsn8CxoCFMAM3VHfW5HrVi5KJEfCXVhhJI0ED7
        o13k9Yc49Orls4mO1T7PrzBzmt4dhGDXa+RIHdNVk97XPTMuGK3b5MGmhqnN/ERCfZ6P+7
        poXULDHRWcrgutZwGjG65WK7DyqJyHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668552363;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lXHqxpkurBmpumd+Q+NIofh19DXjIJGUvD54QuP9Lv8=;
        b=K+fnSF+3dmB2nDetdto5ZOF/N5DrUo/XkQoUFpGNO7/VprRl32Hr68bQBgaMJm/G8ua1x1
        QMaogM4zgrmORcAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B37A13273;
        Tue, 15 Nov 2022 22:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KBDXC6oWdGPVSwAAMHmgww
        (envelope-from <krisman@suse.de>); Tue, 15 Nov 2022 22:46:02 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     axboe@kernel.dk
Cc:     mingo@redhat.com, peterz@infradead.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        liusong@linux.alibaba.com, chaitanyak@nvidia.com,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 0/3] sbitmap: Fix two issues in the per-bitmap wakeup counter code
Date:   Tue, 15 Nov 2022 17:45:50 -0500
Message-Id: <20221115224553.23594-1-krisman@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jan reported two issues in the original thread.

The first is that wake_index was not updated after returning from
sbq_wake_ptr which meant we'd have to empty the wq before moving to the
next one.  Patch 1/3 in this series reorders the code to avoid this
condition, increasing fairness of queue selection and preventing
starvation.  I sent this patch already on the other thread and Jan
reviewed it, but since it is a small one, and a dependency for the
other, I'm resending it a along this series.

The second issue is trickier.  When the selected queue is emptied after
the waitqueue_active check and before wake_up_nr, there is no waiters to
be awaken in that queue, even if other queues might have it.  This
causes us to loose one too many wakeups, and there might not be enough
requests in flight to wake up every queued request.

The proposed fix, is to walk through every queue after doing the atomic
update, such that we ensure any waiters already queued are candidates
for awakening, and that we awake at least 1 waiter in any of the queues.
The patch is a bit more complex than the suggestion since it avoids
partial updates to wake_index, which measurably hurt performance
unnecessarily.

It survived the same tests done on the original patch.

btw, I'm still missing the latency and utilisation reports.  I haven't
forgotten about it, but I didn't have a chance to collect them
yet. Sorry.  I will follow up with them for completeness, even if the
original patch is already queued.

Gabriel Krisman Bertazi (3):
  sbitmap: Advance the queue index before waking up a queue
  wait: Return number of exclusive waiters awaken
  sbitmap: Try each queue to wake up at least one waiter

 include/linux/wait.h |  2 +-
 kernel/sched/wait.c  | 18 +++++++++++-------
 lib/sbitmap.c        | 36 +++++++++++++++++++-----------------
 3 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.35.3

