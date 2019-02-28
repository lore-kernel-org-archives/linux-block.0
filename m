Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B82C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D3A218B0
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MUI41/U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfB1Vgq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:36:46 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:53517 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfB1Vgq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 16:36:46 -0500
Received: by mail-it1-f177.google.com with SMTP id v2so17040156ith.3
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 13:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=l8dGsG1FqhROVLj9iqabjaLk2ROz/sFXexoMAbeIzAc=;
        b=MUI41/U+6UiP2wEuD19dFOD9mX/ZfaEJQl68OgeyOZ5njOuiV6q/wjYpvNPGWKWh0t
         ybc5DOOZG6K+WwIkaq3gJn5b0I72gkNu2s6tYeVuUiHW3RP96v9dkl+020K6oT74lZOx
         /Rx70PpmWpxMgyRdFBZ/UjnK2Kdnjpbba+xBkT9wgvIM3Ph6xIxSIpUxcot8P9XQLp0P
         kgQK9k4BReXirgaRaaNIGdKoPA7zF9cpqTv6iKZsvdmw/ARikDMNlCIYyOAcF86lb8oK
         w0ADWDlpHKi9hjgRommv6pNYofBM/ZQeFYZsZ8dWzMmOydeSrcpCwz/3SezQECTfJVES
         9Ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l8dGsG1FqhROVLj9iqabjaLk2ROz/sFXexoMAbeIzAc=;
        b=iGq+e8FL4qQHrvOqH9GOmZLhqpH5pPFNetfPTdDsF2kmvVSjsnARcwG+Tx/d2XMl63
         cuI0RfDXUnSid81t5vETi0PE7ODxOHuF/nHKzOGQPvpPtL9kzzR8g+5SuVP1JSV1FyL/
         6bkh/+lTdU6VUhGCwrEeb9kFgaqRDlNHGW4Bl5mHz603SGukSA6fytwX5yLOnDxGW5YS
         Ompey8o4lV8R9cnR2O/XoUPMGDy1cvXofM3uGDz1nLd0DR6duYXLRVqUZYSFAtQKZeMI
         oYDhvUYY2GugO3BMDmZ4myEkX5DQV8IDTuHB7XiRLrC5f1hrpoa0uQPUESwq8ynsGp4S
         Qbhg==
X-Gm-Message-State: APjAAAWGYsNzdGyiTR+XwOUuo8EBZ6aK5+fJzAe8kxzzlhhsC2fsC/MY
        QULzhgb/7OkGSDvtUmG7HvBmCA==
X-Google-Smtp-Source: AHgI3IZybekGHFqrBh2t7TCg1tZ079VUQMy2P9/no+mW9dpAfCrAHMc2I/BmWodQgeX1Cbspi4jTJg==
X-Received: by 2002:a24:738e:: with SMTP id y136mr1179038itb.147.1551389805870;
        Thu, 28 Feb 2019 13:36:45 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m79sm1376311itm.25.2019.02.28.13.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:36:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@ZenIV.linux.org.uk
Subject: [PATCHSET v2 0/2] Re-introduce iov/bio no page referencing
Date:   Thu, 28 Feb 2019 14:36:40 -0700
Message-Id: <20190228213642.306-1-axboe@kernel.dk>
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

Since v1:

- Add comment on the bit usages of iter->type
- Move ITER_BVEC_FLAG_NO_REF at the start of the enum
- Remove superfluous 'const' in iov_iter_bvec_no_ref()

-- 
Jens Axboe


