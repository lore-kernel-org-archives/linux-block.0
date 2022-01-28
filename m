Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76CFC433EF
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 04:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345961AbiA1ER6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 23:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236875AbiA1ER5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 23:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643343476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=uy/j0iorjzfngas6HgsLamkI2lubo9i9STfyB6Rfz1M=;
        b=VWFAkvJX7xYBJK+BhMCzlmXZqBAZB52oDmR/vcMPThE39R/Qgi5J+h+x0L+URMdD5Q0u1L
        qFytl1PJHuJF8n/BzJSFCnb8FUrIsPPKbvVfza2nQZH+TzznNLW7o+sROUVf+wNR9TurQL
        2fpb5jErKv4GE3S7bHCpxnH5X4RigEA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-22fd8P3rNR2fwCWct86sNg-1; Thu, 27 Jan 2022 23:17:55 -0500
X-MC-Unique: 22fd8P3rNR2fwCWct86sNg-1
Received: by mail-qk1-f198.google.com with SMTP id d11-20020a37680b000000b0047d87e46f4aso3957468qkc.11
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 20:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uy/j0iorjzfngas6HgsLamkI2lubo9i9STfyB6Rfz1M=;
        b=0CX0Q/QFENAAGO9JbBk5FzsjVZvYoeJFYqIMOnV7Qa9MSf/AIFuM6CAw/BA1A7Iiir
         4prC6hlBhge1ysoU5R21igp6u5tlSfYyawmTD2+7rNUg/dc/dIS67wV2qid0zPGZJEFs
         PNgcCt3ERoT5Mg1iFgvvC6Ex5QuFnQ7qAvBNllH85JWnnRWkyAkb+GAo72h+cxlZK8RV
         1NM4bLziCdwVB9Mapd8N1dYaaS5XS65ymIb2kUqjgD5Vsg4I6pwMoNJv/zcNCjGhN2aN
         v3HaTvTYKGoj1YepUVEWk1cOPBbpblkrCujU2P9CniC8SV9SHgcKg4NeKqDsHQEICbhf
         5uRw==
X-Gm-Message-State: AOAM530wA4mOvAaITvkO5qXONC0NG1Wf95H/sVQjN7QVTEDM/mX689jI
        FAigJtxDHXvYp31Rs963e3Dqgd02tS0N/G7SnPSQnqsk5speeSKLmGpWzm/aeH+uOXtqowM9xtn
        M9XwZmIpZCtvhXm29D/2A6A==
X-Received: by 2002:a05:620a:2592:: with SMTP id x18mr4773407qko.578.1643343474604;
        Thu, 27 Jan 2022 20:17:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXEdqRD3HFVOXHNPzlLjyGkH9sxVfcjKK9cncI7nKb2QMVaYaptnIK4czeECKsxp2jSGQLqQ==
X-Received: by 2002:a05:620a:2592:: with SMTP id x18mr4773404qko.578.1643343474405;
        Thu, 27 Jan 2022 20:17:54 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id x16sm2599343qko.17.2022.01.27.20.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 20:17:54 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 0/3] block/dm: fix bio-based DM IO accounting
Date:   Thu, 27 Jan 2022 23:17:50 -0500
Message-Id: <20220128041753.32195-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Just over 3 years ago, with commit a1e1cb72d9649 ("dm: fix redundant
IO accounting for bios that need splitting") I focused too narrowly on
fixing the reported potential for redundant accounting for IO totals.
Which, at least mentally for me, papered over how inaccurate all other
bio-based DM's IO accounting is for bios that get split.

This set fixes things up properly by allowing DM to start IO
accounting _after_ IO is submitted and a split may have occurred.  The
proper start_time is still established (prior to submission), it is
passed in to a new bio_start_io_acct_time().  This eliminates the need
for any DM hack to rewind block core's accounting that was started
before any potential bio split.

All said: If you'd provide your Acked-by(s) I'm happy to send this set
to Linus for v5.17-rc (and shepherd the changes into stable@ kernels).

Or you're welcome to pickup this set to send along (I'd obviously
still do any stable@ backports). NOTE: the 3rd patch references the
linux-dm.git commit id for the 1st patch.. so that'll require tweaking
no matter who sends the changes to Linus.

Please advise, thanks.
Mike

v3: fix patch 3 to call bio_start_io_acct_time
v2: made block changes suggested by Christoph

Mike Snitzer (3):
  block: add bio_start_io_acct_time() to control start_time
  dm: revert partial fix for redundant bio-based IO accounting
  dm: properly fix redundant bio-based IO accounting

 block/blk-core.c       | 25 +++++++++++++++++++------
 drivers/md/dm.c        | 20 +++-----------------
 include/linux/blkdev.h |  1 +
 3 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.15.0

