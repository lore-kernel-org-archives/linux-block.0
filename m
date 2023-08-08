Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1469C001DB
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 18:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjHHSLP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjHHSKp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 14:10:45 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AF51BAFB
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 10:13:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-790dcf48546so37823939f.0
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 10:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691514793; x=1692119593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFSFCcy2YzyX7yU8OcfMkexJd8fRtqvgyyADBsq68No=;
        b=OI8unf6Stoi7II4i36n65HgUa/mkQ78GMZ6ONqj2imI57TeN4tQ5sCIbCsS4wWUU3M
         lR404n2Yfguw49iKF6LuF5+RjBG5ucbLQ4XSYQThHbFcz3rjBezzWt33wCXXKivafN9g
         AAfNmZQVvGVxjiNwVmI+BhYTlalYcgHvmQOFa8hFttjSuK32SXd+127Un+nMcxukRlrg
         z/kzn+5R8ch5ltPO6jE+gzvYcFS7UN3c48bgIj1+BLjwQqcgKZBQCnD0x/eoZ9FsFThh
         UUxhzYmHssb3KwmJXh2bgqWVFok61aH30xScnfK3a2kYYlGqimfaxNhg+e/R2L5Snxus
         7+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514793; x=1692119593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFSFCcy2YzyX7yU8OcfMkexJd8fRtqvgyyADBsq68No=;
        b=eTtME9HSpUdB8SrJ5OzH7uBzqaT4HZawUCF5HTpkekdNIJwCf/89pgjIzEkRbrL55d
         ao/X/uE7EsIjuiqkX2r3PMLjcn2T0RvWpMybXs52y7eCrpFFPODqfYyMmojyKqF2aXQR
         ky5kUSikTtiKppImCxcM5+cBuOrR2PpthZQ67Q6EZJqlmKDTL7bGGhKafzwNqQOq797J
         ne/ICwhqzkdvmotPDhEW3mgvNd/jX1YwnwA+NRYL2OENZF694yQDfPuwq9+Ms9cIVD3j
         K7oVZ+uXjs83n43t2En6S8yYICjuObrtwPVXjtF5FqhgE1/9y6RS16yo42GtXDEquMp/
         dhQw==
X-Gm-Message-State: AOJu0Yx1hVrtpVQ370ZljD5G4BjcJEPneVtuk2b29d1hqI2Gwhp3vMkS
        dRQCTgF+9MgKUiNivO+E0qbne/dmXl9IUDR3O3w=
X-Google-Smtp-Source: AGHT+IFNfCoKahM+duqo9C6f1BuiAgc0i+iu1he2RHATM24InsvTZIyEpwZyt0WbU6oa6ZnCbVNgyw==
X-Received: by 2002:a05:6602:29c7:b0:780:d6ef:160 with SMTP id z7-20020a05660229c700b00780d6ef0160mr380220ioq.1.1691514793193;
        Tue, 08 Aug 2023 10:13:13 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r25-20020a02c859000000b0042afec5be53sm3222955jao.153.2023.08.08.10.13.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 10:13:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCH 0/2] Block nowait fix
Date:   Tue,  8 Aug 2023 11:13:08 -0600
Message-Id: <20230808171310.112878-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Patch 1 is just something I came across while debugging an issue,
killing old and unused code.

Patch 2 fixes an issue with IOCB_HIPRI -> REQ_POLLED, where we always
set REQ_NOWAIT as well. We should not be combining these two flags, they
are separate properties and it's up to the caller to do the right thing
and set one or both as they see fit.

-- 
Jens Axboe


