Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A44AC4338F
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 21:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5236360EB9
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 21:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhHIVY3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 17:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhHIVY2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 17:24:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BCDC0613D3
        for <linux-block@vger.kernel.org>; Mon,  9 Aug 2021 14:24:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so2035369pjb.3
        for <linux-block@vger.kernel.org>; Mon, 09 Aug 2021 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OyG4sh0wZAAWr4TpNXR7PYUy98X4grR2BRtprjaq/ng=;
        b=wBtUeaUay3Kbl/Q5xZ9y+W4HUmLrTZBC1a8kseW9h6BBcCkdAsOZFB1uopMN+6RzY0
         3gTn3l8FKkggS3gtH4WTR7QcFXYslnemtKIkR70dv512Sl9avzMlQlrTRRWR8z5N0HBF
         Gh9bTEPq0EyG0rK9czgQ71iqBSKdUtxKcPF9LrhYiXcjrpu0wgpFMoUhP68q2yb6QnlW
         HHOwhMVTG5Vs7VzipjOScUfluwQ3fspk7tCTSW9zR6VMcCfmuAMaqobGRj1LsL2n77Tz
         KlKJRS3eacjJS6V1gWdXNBSeFoIFKz9D9+9H4VAIZe5E53PdHLetxVIf/dylTZOCJnEC
         LEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OyG4sh0wZAAWr4TpNXR7PYUy98X4grR2BRtprjaq/ng=;
        b=qmVoR9fCuZAcr5VcZXoqtpFqIOTJsIQSzzBRPvI4jLADAccvFv/Eka1R3Ijy9q0UCv
         Mh0XX2C/yogCfeAOF/xEzDKnJow4f+on/8WSbH3oKX4KGd5lmYpb0AgixINm+zyx7oCA
         BEVxSNZIbLQchlQdoaWAl3qGGQXv7UjJCM/irmAtZYrIGPOet2DKnDkpL2rlKLaU9jOx
         8ixkMbkaqRtSAeaFgXo81Zza6kEGFQGb94SegMRPWIQRS7tnfcufQvksy6XMrvBUkh8H
         Xn+9IYIPnmWPv4SjP8B4RNRtwUkRT9t65rku8m828hOdIu/CbZf5+0jkkUZPRZ26CDCD
         zJ8w==
X-Gm-Message-State: AOAM531S4L7kUgYV9U6PiecejMftLijWj6GcjHIHXlM7y5V+Tb+Xht62
        t3b51ZKLvkrRbOgM298GEMZgWA==
X-Google-Smtp-Source: ABdhPJz/TCAeS4NFs9JO4ZAXe73KSV/gng93g6PkjAV/jH4S+0vbS7C/hl2rb5pxgxe1fqT/Ya8ciQ==
X-Received: by 2002:a17:90a:c213:: with SMTP id e19mr6832551pjt.58.1628544247361;
        Mon, 09 Aug 2021 14:24:07 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id m16sm439885pjz.30.2021.08.09.14.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 14:24:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/4] Enable bio recycling for polled IO
Date:   Mon,  9 Aug 2021 15:23:57 -0600
Message-Id: <20210809212401.19807-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This is v2 of this patchset. The main change from v1 is that we're no
longer passing the cache pointer in struct kiocb, and the primary reason
for that is to avoid growing it by 8 bytes. That would take it over one
cacheline, and that is a noticeable slowdown for hot users of kiocb. Hence
this was re-architected to store it in the per-task io_uring structure
instead. Only real downside of that imho is that we need calls to get it,
and that it's obviously then io_uring specific rather than being able to
have multiple users of this. The latter I don't consider a big problem, as
nobody else supports async polled IO anyway.

The tldr; here is that we get about a 10% bump in polled performance with
this patchset, as we can recycle bio structures essentially for free.
Outside of that, explanations in each patch. I've also got an iomap patch,
but trying to keep this single user until there's agreement on the
direction.

Against for-5.15/io_uring, and can also be found in my
io_uring-bio-cache.2 branch.

 block/bio.c              | 126 +++++++++++++++++++++++++++++++++++----
 fs/block_dev.c           |  30 ++++++++--
 fs/io_uring.c            |  52 ++++++++++++++++
 include/linux/bio.h      |  24 ++++++--
 include/linux/fs.h       |   2 +
 include/linux/io_uring.h |   7 +++
 6 files changed, 221 insertions(+), 20 deletions(-)

-- 
Jens Axboe


