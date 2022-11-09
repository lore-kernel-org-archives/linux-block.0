Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821F2C433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 13:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKINfI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 08:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKINfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 08:35:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642582AC6A
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 05:35:06 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n12so46582295eja.11
        for <linux-block@vger.kernel.org>; Wed, 09 Nov 2022 05:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gtOl1+w9+H/kDpYw0VENqPv5aJ8skI+vP8Y3fHG6JhY=;
        b=m3xksJLf0b3ZNRrGKim/LnCvOPAM7mztwM9sBrnvlkQ/JNHs0iof1K+DXpqiv6kQqv
         Cbn/baGxs0r/3h72mEOEwPOmeWnMJHbrynlqVSdkLBwig0vEJLJb9RPjua8pSFhZRAAi
         ZKQdjhMu4nSSMUcMqZ27zjkSLMBLm2YMM4VyE1E03RDglqtSNluJKUNnWUzwIJ+hBiDr
         0F3Q7wVaF7GM+ut94pMWKwHGsHjdq7wXls1n+094e9y+E5JGfbIObB90o6FNg1o9t7gm
         AtqSlSwKrUy6zQAQ4whkQb9nRylPlPMZry5qDr/HGVHwhF9dhMYuTQKLpyCUkWcvqj0u
         J+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtOl1+w9+H/kDpYw0VENqPv5aJ8skI+vP8Y3fHG6JhY=;
        b=x+vHM+GpNt/ssoP6ZzD7oqKZvNUZW7Bw4aU13CgVOA/A32OTU5koRkhDx7/3kwmyK7
         1i3zT7KMdVVY/E8GF6U27+Nm8oORprec1QIqmzy7QV/LWz6zRfESKFpByCAWQSQOX9pr
         ehL5jTDCtFXHCCShISDc2AE6G2tLCGAT/O3Jk9hT7UplwIMUo9Vk0ZXZaIqvSCJC88a5
         T1z6V+vYRV6w96jnQs6XqyX/It84Qno0rYFRHqJoFdjzw/U1rjUIp7xrPAFZLypcncO3
         nHqnEmeQG0HvcJRSKWbfOOKy0Al2vxClHFhVwq997+qKI7udZHay+rh08uUk2MFOa7vE
         Rwvw==
X-Gm-Message-State: ACrzQf0prKdvx2/Tg4Z9FBD6kXnBEGtikH41AycioE4lo7Lltakdmadi
        pqZitoPmZ92sPdTpoJhJ/c9+nQ==
X-Google-Smtp-Source: AMsMyM6wyvAwUO1KLGRtkWxtnHORrvQJPnlfEaGAXuBUObnH2kCMbIz/Dl2mKD6wQHt3o4of/6mkdg==
X-Received: by 2002:a17:906:474b:b0:78d:cea0:e87a with SMTP id j11-20020a170906474b00b0078dcea0e87amr1144404ejs.178.1668000904938;
        Wed, 09 Nov 2022 05:35:04 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id lx8-20020a170906af0800b00782fbb7f5f7sm5867463ejb.113.2022.11.09.05.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 05:35:04 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/3] Miscellaneous DRBD updates for 6.2
Date:   Wed,  9 Nov 2022 14:34:50 +0100
Message-Id: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here are some various updates for DRBD.
The first two are related to the handling of discards in DRBD, and the
third is a resend of [0].

[0] https://lore.kernel.org/all/20221024142424.25877-1-christoph.boehmwalder@linbit.com/

Christoph Böhmwalder (2):
  drbd: use blk_queue_max_discard_sectors helper
  drbd: Store op in drbd_peer_request

Philipp Reisner (1):
  drbd: disable discard support if granularity > max

 drivers/block/drbd/drbd_int.h      |  8 ++-
 drivers/block/drbd/drbd_nl.c       | 23 +++++++--
 drivers/block/drbd/drbd_receiver.c | 81 +++++++++++++++++-------------
 drivers/block/drbd/drbd_worker.c   |  4 +-
 4 files changed, 71 insertions(+), 45 deletions(-)

-- 
2.38.1

