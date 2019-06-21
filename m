Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6005CC48BE0
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 09:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D0621530
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 09:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="GNLUMzSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFUJMK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:12:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38096 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfFUJMJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 05:12:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so4515791lfa.5
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2019 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=723zdSxWmoIrgdl5a9Vt9oyfiq9xWUVExK76ZlKKCm0=;
        b=GNLUMzSRQRmkYgy9HO+y6XgqaWAZIWNFVi9h69iWiliFFjd9IFHmqVG76eQ4YHiOXn
         /+WpPrRrgqs+Q4/nRaDJUuYJ5iYYybvpYZRhZkoxB4NW6FRbfJllLFSG6yH4O+FtoTrL
         vipl5QyBxeB9tn8ZT7ciGgPGYFWj4Cv97DYEktPOREq0mukGacs6qdtgVSKrI8m9O+Ie
         ZVogQ0rB4hMzCPst7UYN5PboCgVC5NL74msG2oJJC1t+Fr4yMI1RghX/o+g0j5elqWwI
         ZSNPebq1fPPvXyym+LyJOAF1PfVldlI56S6slBqYLZgdVLqDah3A2biq1kw9I0VgzZiY
         t6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=723zdSxWmoIrgdl5a9Vt9oyfiq9xWUVExK76ZlKKCm0=;
        b=Xk/1ryY/6LZHxUU7erwyneRd9ARpGvZB+EJuaE6ZXwk54wwjuhcCfZKfIEvPFr3+Mq
         xM2hgeXItOvxk2lElM9xRLm/30OO4yQ8gbJeXphw13SoqU8p3FaJ+9bhMDnI+Ly4Zno4
         2VEy/SaAwcq1VtWIJtk5+++bMnZcgXQYHTQ+Qb7xXjgknqRC/VGj0wSNXJ8Pzejt5u3a
         c3PuNOgR3IW8T1EMSYuRefoU5TadnYH1jcKVO/5ct2IlnmVDJb0KaXZGgPPAfO+HbUuO
         powOJrbUoOUQ590Bk4ljbgVAE7g39DqzYhN1Jt6JvwD8EEjCfl/1KOhADFHfgCdMu2L6
         APdw==
X-Gm-Message-State: APjAAAUtexFKJuoEyoR8WkRUi7eHdBjxvaup+S8qVCqzT9kQPqBoE5Nw
        KrElQoo7XDLQUSERJMOn6UHXnw==
X-Google-Smtp-Source: APXvYqzI16rVPuwHp28e4FF+f2uPEhf7qLRQa3YMIi0B/32uwA4eiEFweuEIRbWyoQXAZqvXJsPNMw==
X-Received: by 2002:ac2:528e:: with SMTP id q14mr38367414lfm.17.1561108327647;
        Fri, 21 Jun 2019 02:12:07 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id z26sm303178ljz.64.2019.06.21.02.12.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:12:06 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 0/2] lightnvm updates for 5.3
Date:   Fri, 21 Jun 2019 11:11:58 +0200
Message-Id: <20190621091200.23168-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

A couple of patches for the 5.3 window. Geert fixed an uninitialized
pointer bug, and Heiner fixed up a bug when merging bio pages in pblk.

Thank you,
Matias

Geert Uytterhoeven (1):
  lightnvm: fix uninitialized pointer in nvm_remove_tgt()

Heiner Litz (1):
  lightnvm: pblk: fix freeing of merged pages

 drivers/lightnvm/core.c      |  2 +-
 drivers/lightnvm/pblk-core.c | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.19.1

