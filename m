Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956AFC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C44161053
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhJMQ4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbhJMQ4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:56:23 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D7FC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:19 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n7so529566iod.0
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsdOKA8abZlWjUQi+XSxDsDxn/yeJdaC9Rvb2XuYVfQ=;
        b=gdWflAPvZr7STBI3QGmUjSIJdVA9oQrJsaeF2PV4QcO3nr+61pK/IyRQP29uY7Kpcw
         PBYTJpulg3YYTSm1nQ7FX6YleF6w8E3Tyr0TDdWNFzawI7BI07f82PQMXyCGcevQxMJF
         gcw3MrgT8sr8+wTtdSqEFFFXj497JL2SRrO1wacb5YlXcvg0GyJJwdAyalUuc48zRkND
         P9KvrZ/NSQqu3fwrtOE9GWh/Rku7QVKjQgv7Sdp92xM+w07nISdQx0MxiwHTXLUCdIhW
         Tk8AOzLFLfp7ISBkcWSfYa1eXGHkqUNgHRhj/OyYHvl+LkRhthl0ZnLrFEOzcmql4sfX
         vTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsdOKA8abZlWjUQi+XSxDsDxn/yeJdaC9Rvb2XuYVfQ=;
        b=P/cWbyLR3emzh9GZpqwroyvCrDMqiMrgrQZ9PferUzchDvdEYBOrUiavLtrUeW+RKn
         JsCyIYNOF0Ul45wI+gvv3uCkKVsws0keLoFZMMFfaby5kYuN3vKxk2T159qmkB3vzNLq
         iU4Cx4Hp/ZlL7OSc8bZrI6iP2Fauoxo72hIrB9q39wO+OFgJjhj/N4cmMOWAKepY2XVb
         rj6Q2MKoSkFnNsdx1IfoefgJPSNW8SGypBZaVZyBH04FnVpbXCoy9Hmy0tbg4hfP17pS
         Gski00c8uBxi8h3ezg2Z/h3DWt6WOvS/t+8L5kdBclc3681f+3qWzUdHSzR39z3GDJpQ
         JUxw==
X-Gm-Message-State: AOAM5322goXtXFuEJtWJXatQpeV4tPqSuPtWQyWRlpDdd99F7k54fZQk
        CxVIp4b7nBDxUfYPC4ZUpmFs/EBSxwe9aA==
X-Google-Smtp-Source: ABdhPJxy08Ku/Xqw0Gb74x5oWY825aZdEZ0h8ssBC4lGlyosPxCBhoji/AH9YP9cW9fy1tRyEBOIgw==
X-Received: by 2002:a5d:9ad9:: with SMTP id x25mr296257ion.59.1634144059075;
        Wed, 13 Oct 2021 09:54:19 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r7sm65023ior.25.2021.10.13.09.54.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:54:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET v2 0/9] Batched completions
Date:   Wed, 13 Oct 2021 10:54:07 -0600
Message-Id: <20211013165416.985696-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We now do decent batching of allocations for submit, but we still
complete requests individually. This costs a lot of CPU cycles.

This patchset adds support for collecting requests for completion,
and then completing them as a batch. This includes things like freeing
a batch of tags.

A few rough edges in this patchset, but sending it out for comments
so I can whip it into an upstreamable thing. As per patch 8, the
wins here are pretty massive - 8-10% improvement in the peak IOPS.

Changes since v1:
- Rename ib -> iob for the batch
- Add rq_list helpers
- Change array -> tags_array naming
- Drop nvme disposition patch
- Rework the batched completion on the nvme side to be a lot cleaner
- Add DEFINE_IO_BATCH helper
- Move batch into blkdev.h instead of in fs.h

-- 
Jens Axboe


