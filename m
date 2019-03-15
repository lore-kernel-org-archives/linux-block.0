Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF805C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761EB218AC
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ih6BAd/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCOO7n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:59:43 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:42527 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfCOO7n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 10:59:43 -0400
Received: by mail-pf1-f169.google.com with SMTP id r15so3772104pfn.9
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Jz8JXKvrR91levwR+AKGQT+kkplKyy8RqUuN+K+6buE=;
        b=ih6BAd/5HS/Lv53w4/SUY6Mis0BV94tqSfnEwcCsOFs/r0qTCskYnGQFr5OJ6C09em
         ZqkZoE2aTG+eC2P5Zx4QNMdqtYz7Vc4ni+HTNqDIEfO8HHWhywCk2FNCFUmi/kvaIPKi
         NrJj0PXSaBmBP093n4Asxx2fiueY2ez6l2/Qg5fziJlRRluvTaBiugOg0K2LzS86UXU0
         9VoEixXGK959jm/bLaJXe3gHMxWDbvokdMFcjy/O+5GrhjOUfZVbMeaD6/F51F1yuxFe
         jBfx4k3XTkZw49WzuT2KO1LcrQC84UlmIEeBlWdjeCK6IZDrJnckzH2lp64mt8HSiuy+
         0Zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jz8JXKvrR91levwR+AKGQT+kkplKyy8RqUuN+K+6buE=;
        b=TzbA/tb4I+uquMM/m581unVTU0C6nzdzjgKQKhpPumWckAhoPcSeDFqpFWQBn5sZgN
         jaJQ3aw8KwH1wOxQCAYhsM0y+IWvl3nBt62nSYkv+o/UjKO8SAJt48KJ6oMH3QjePLjm
         lHQJZVd9lp/bzKdaGqvYlDd2eDKf5KATSe0pVkJB128F3NlUx8UKpMPXRhuDmec8zmB8
         AMmMcfV3F0lTJuR1xAr6MyhGEJUrwymCVQ3GkVS++dN4LP1VUY/I+UOZaXiJySkkiNUt
         SqbKyS9xxlx8CjS9eg2pKrHUQ8AJGTZtOS5UwCkATtaNNXpD/DtK0XX9g2WbG3jl0gLS
         Gi9w==
X-Gm-Message-State: APjAAAU/61q3f4OBUp3g9047PfBW+Zgbsj7bexp0/+/Jb0iidMSccjuA
        bxWDhXfSU51CFvA/Sbv81SJZgQ==
X-Google-Smtp-Source: APXvYqzxzSg0PM7fwgGnYcvC6PUjceYx6lJfWxaAHg+mekLyIhWGmoGPYvBOJeskRSMHOdb5Nwn7jg==
X-Received: by 2002:a65:60c7:: with SMTP id r7mr3954476pgv.37.1552661982324;
        Fri, 15 Mar 2019 07:59:42 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f28sm4287179pfh.178.2019.03.15.07.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 07:59:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk
Subject: [PATCHSET 0/3] io_uring improvements
Date:   Fri, 15 Mar 2019 08:59:35 -0600
Message-Id: <20190315145938.21516-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is on top of the just posted "PATCHSET v2 0/7] io_uring fixes"
series.

This re-introduces the ability to NOT have to touch page reference
counts for our fixed buffers. Instead of assuming that's always
safe to do with a BVEC iter, we add an explicit flag for that. This
shifts the iter types a bit, but otherwise shouldn't cause any
changes.

The final patch re-adds the "we hit cache" flag. I left this out of
the initial series due to concerns over informing userspace about
this, with all the mincore etc discussions.

 block/bio.c                   | 43 +++++++++++++++++++----------------
 fs/block_dev.c                | 12 ++++++----
 fs/io_uring.c                 |  9 +++++++-
 fs/iomap.c                    | 12 ++++++----
 include/linux/blk_types.h     |  1 +
 include/linux/uio.h           | 24 +++++++++++++++----
 include/uapi/linux/io_uring.h |  5 ++++
 7 files changed, 71 insertions(+), 35 deletions(-)

-- 
Jens Axboe


