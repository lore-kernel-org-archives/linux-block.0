Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D36C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8578660D07
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhJLSTu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhJLSTs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:19:48 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AB3C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:46 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id x1so20773844iof.7
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBMjxG6b6zbCc0I0rbwDh4XQ2KAVvZ2zeMD15jDUwQ0=;
        b=ftzhg2QOj+wr/jfE00AocnHh+ODBSCH8emIMJXAuJpOGa1t9XLZqHLst3AC8lcAPH1
         ja4eRsS/f8tZ3ELnKYy0Pu3CfADAffHsC5jeRA66OfxFTsFWBYiHGrZgS1mWJdk3KtsC
         0NiI7AN2Clz3C/m4185Kpzb7ZEi1PEMuyLneJsjlUmCw5PVwN/K7sMgnqQoCnCGosnkB
         xEz0l+gRcIE1Co/ZrkdMRX73oxTpK9lZ7mlyJL6vWgi3/SIS796qsvgvKc60DLjm4n9t
         xwCkRMpILVbu2N5cOWxK6cCM2j+ogDSLEGFnejOrW4PGOPdlFGxmMM4HjCO1uAax+ogY
         b+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBMjxG6b6zbCc0I0rbwDh4XQ2KAVvZ2zeMD15jDUwQ0=;
        b=W1CD3IM1d0ari9MmOG5uTjE0zFEDiHSvik8kpmyMPFp7xpmyWb7xywe7G/Rbr4TSd8
         LYPnjvSo21BBPjwjpzRJY/ksmOJIdq6wh0hJ+FpY0gACpDBKGXDa/bQQr+HbSetU/62t
         agD3yeKcWZNI9xn4BZhp+6vBzXKp8RDqjWbQ6Hh7COxbpB1xjwGq8dukqYst3TMHS5ok
         oDeUkVibhEm5vPIseEosi0psJMK3Jc7NzD52pDuMCkfp4iqxyIzZl+NLb4tcmpsWroTd
         3XXlNa0Yobi4UAPQcOt1oFGoj+U7+dMdH6NU2OlQbbLnjxpUj4fx04uyCWZk0JE2pFXM
         moug==
X-Gm-Message-State: AOAM530TkSff+QM5MW9+2voCUWmzG6CWE5+doE9Dgk7hGrKSIzPeQ6jq
        jfuoEWA+26W2OkCfQRszuQgFjie9xBBjAw==
X-Google-Smtp-Source: ABdhPJx9EfybPODUMfUTsMUsm4dtJF6/pmaFjaD2JbS3lGL+tjFYZlwL8EyMENsx9+9HiS5S2Wqetg==
X-Received: by 2002:a05:6638:344c:: with SMTP id q12mr14046988jav.16.1634062665021;
        Tue, 12 Oct 2021 11:17:45 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm2242476ioh.23.2021.10.12.11.17.44
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:17:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/9] Batched completions
Date:   Tue, 12 Oct 2021 12:17:33 -0600
Message-Id: <20211012181742.672391-1-axboe@kernel.dk>
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

-- 
Jens Axboe


