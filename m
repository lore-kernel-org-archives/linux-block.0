Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52511C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 20:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1042C213A2
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 20:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CO6sahIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfB0UUL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:20:11 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:44404 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfB0UUL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 15:20:11 -0500
Received: by mail-pg1-f179.google.com with SMTP id j3so8471826pgm.11
        for <linux-block@vger.kernel.org>; Wed, 27 Feb 2019 12:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ITI0+MMIzJKzxzvDKQ16aikOdKSQ2OSVMr6uRxjPaq4=;
        b=CO6sahIA46tbPrfx6KCHmgwtEEq0DAQPFpVurgDHpV5lRSm9K4LfcHhQ1pgfVnx+gj
         J4LxGNN/d4Zx6MCICFMyMXaDa+4+HCzwqHjria4x3IAe2B0N/t4RNE7Gc5fp4/w9MrK5
         JFCMBnfVXXqR0c53ecqn9tpfYZV08xJl7ajt0K8ZNxLVuQRISRqsnJKT24xFCsThTcJS
         gMoILL8sWTF9NGNDxGfd1g2Vb1kZQaxiuTebQeUYKjPJdDp+T+35uHENd9RHqt3vEFRg
         fRpZ89xtSZoebIE3Dr+nmkuzCglRGqNwK15vdYzc9c1zIcAvLKtxY7uhQXwrnVW66lc5
         4LGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ITI0+MMIzJKzxzvDKQ16aikOdKSQ2OSVMr6uRxjPaq4=;
        b=hZ0cFt5oJgfnrppsFUbro8af5i6Nb0t0UVQITgR26WObmJB8Gm+czbFR4dQ3oDgrli
         1a3houruEDP5M7ULW307kGOVAzZaj+jb0xa7mNfCqGO0n3uXlM3f5ZAt3Npslrl/FIIq
         RPhun1znwP+IrvUMBKR1fx3bE1wqeO8LGi5mfHhjlF118wyxki4r9Ll8Z0QfpKCu6f+K
         R8Zm8y7U12Op4sLASbgKTvEn37TJ6VZeOE8tFa8Cygg6BY8gDqaLygPPioGEVLuvNE8O
         A/oxYS2K/wxvvjvxkL/Y7LnZ86jOTZCMDFBGWFAQdOj4veGUH0UxF/0VJjCYj37AMlEk
         Hb1g==
X-Gm-Message-State: AHQUAuaCvHFzO/P19Y/Sn0SfnUeHBVV4hswfeLh3gPZQJAKcYjsPcyXD
        /tFJtIRrsfk3X/B8KpYU9xRn6Q==
X-Google-Smtp-Source: AHgI3IanJsQamdB4IyX8PmIeU34tx3OtrHpOzunFqgWxROIKrDXQJa4WIhadMQFcPgOhR0iI95qVWQ==
X-Received: by 2002:a63:83:: with SMTP id 125mr4733021pga.403.1551298810545;
        Wed, 27 Feb 2019 12:20:10 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d23sm22945959pfn.180.2019.02.27.12.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 12:20:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@ZenIV.linux.org.uk
Subject: [PATCHSET] Re-introduce iov/bio no page referencing
Date:   Wed, 27 Feb 2019 13:20:04 -0700
Message-Id: <20190227202006.18844-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The io_uring branch had a patch that enabled us to NOT get/put page
references on pages that we have registered from the application.
This patch assumed that it was safe to never do this for any ITER_BVEC,
but that turned out to be problematic for the splice direct case where
we stuff those pages into a pipe and unconditionally release them when
the pipe buffer is released.

This was fixed by always grabbing an extra page reference before doing
IO, and let the caller release that reference. However, this causes a
performance regressions since we're now doing an atomic inc/dec per
IO needlessly.

Instead of assuming that any ITER_BVEC caller knows not to put these
page references, have the caller explicitly flag it. This shifts the
iter types up a bit, so we can add a bit similar to the read/write bit
for managing this information.

Patch 2 then re-introduces the BIO_NO_PAGE_REF, which is now limited by
both ITER_BVEC _and_ the caller flagged it as safe.

Patches are on top of my io_uring branch.

-- 
Jens Axboe


