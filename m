Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE7CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 15:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D2161074
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 15:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhJSPf0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhJSPfS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 11:35:18 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFABC061765
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 08:33:03 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e144so20860711iof.3
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MmeReyIXSPXhd0pVPUVaPeEPQD0oj4wRLQuG+9PYgH4=;
        b=fn38KoKdI3V+FAJ2n/0LxCritdjCHB7RBSJJ5jI1fLHshxK/iIB6ifxRKjjof/o7+u
         naMBj0PMTVB8J06tcCeEJPKV3kAyT+r6A2zVBjHvOK2niurrfOb0bMDLtzAOLy9vUBH7
         045rF/quTS1OzBEcRk1PpvKb6DRQg9o0FO4doPbDMEShVvzl2G8pvIu5dC9K8NlkrdBR
         CeTxiTz0utpPcavZFV/CiH7zYMrzTSO9W9YZjOa+NnNHq8qZpRn1PXRb+5OntKYTdbHB
         a8ZKeTTd5FmTXsRogp9KECP7H8xHJAc4Ohx1gdtJncrNjr3TiqkZdEfchRjXO/Bi/NLs
         qvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MmeReyIXSPXhd0pVPUVaPeEPQD0oj4wRLQuG+9PYgH4=;
        b=dThf9LL4w+ewRNl/rr+ATSgS6iDPjvVI0vth4Zzwal+8AnNWmYdDkiwNuX16+GbSFp
         mjaBeiWhvISmlEJaSTQHHyI+p87DsZ/I3RrZa9qAxwuXYzRZjiLzMbvU2ZieVlrFXWU5
         hepI20GjdxPy6QoKp9F4/OePvQhciBxZUok0VKDRB/4X1Ap9QhF/GXwh0QmeHqM8mciV
         +rr+hJYNLmTb4aM/1WyuX5Lu2UZ3YC05cUvbouAN6gOPcmEAX/RXDwGAbX8oseIohk3K
         dMzeu7ragPqzYdf5uCLFZ6CgYNtgEaQ9toAEchXLgsOxUgmDZnNBLo9YdAqLejbrY0ao
         TeyA==
X-Gm-Message-State: AOAM533RJMW5RRJm5ztxBKYqykW5JwpqcjN7T3aX88xxqxsCGClonYF2
        Ex6OSP+RC/C5vQgz6/7o2V9AzLJILGCIkg==
X-Google-Smtp-Source: ABdhPJw9thfvnOz4qgfwqCqNVGHYnQtt6lCDAxxacpsTItC8BvksKa6MIh/H9C4pFf/tzDf7vTVDNw==
X-Received: by 2002:a05:6602:2d53:: with SMTP id d19mr19375096iow.141.1634657583211;
        Tue, 19 Oct 2021 08:33:03 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t12sm8409555ilp.43.2021.10.19.08.33.02
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:33:02 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/4] Last round of alloc side optimizations
Date:   Tue, 19 Oct 2021 09:32:56 -0600
Message-Id: <20211019153300.623322-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We're doing pretty well on this front now, but there are still a few
tweaks we can make to improve it a bit. Here are 4 minor patches that
do just that.

-- 
Jens Axboe


