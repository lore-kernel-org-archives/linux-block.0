Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D32C4332F
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 22:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiKVW6d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 17:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKVW6c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 17:58:32 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA134240BC
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 14:58:31 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f9so11083950pgf.7
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 14:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cqm6rTul+MJv80b6M87o/8Ay245ctqmeFHSL1Z9I7sQ=;
        b=BCJxV4DuNh6EFfNxnHaKlqFDu3UGKJ8DanfEU96mHAWWmhvzd123mMrICyzQd+fWXc
         6Yxol3S1BV3r38vqC0WrlK3JrPXsiTMp1p8xu22lfuq4d+epoVXM/5hLEw0YEw/H76sg
         XtWR3BvtE2KlzfNCmKlGFVA1+XeCO+fnoGBTs4tR+A7xpn/xdTFOzCEpDQFoj6x8o4gZ
         z8+1pabJr5c7zg1/B0831tbIWOTV6YEDSpRWj+fcdFpCHU4LNbf54DWwHWJOQNoN2Tg2
         JIZTzThf6NA4AJcBEao1GjX377DR2FuB68OhdwNDxpN+FipoiKcWKjzBUOs2X+oeCrej
         c9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cqm6rTul+MJv80b6M87o/8Ay245ctqmeFHSL1Z9I7sQ=;
        b=pJ4A+smN0pMlvqBliP3uFbL6ZFzq8rwUV5VhAGiIZGMGWtThq85+7DKgxPRhEsbLo4
         tRH+4WYJ/S+Dzo62PIBKDgbLPMstqDoa2aE6khzLopzotKxp61kBC+fS34sJ5pf2hOzq
         bi9+Hyy4CQBCZFncCeE5cwXsSxwIrYF7sU2z+1zbpRpdG7YJGfaTln0S80TOpwWEBrZe
         qKCJICMrEdbqt9mEd70qkVBgRXAhUjjLeszzIaUdqHf0E5kGdedPrs+Yz3+/1u8vuhMs
         mL1DDvy5TIj05/iJfc07gRFVJwA82KzUNBK+DSJ3g02jD08TvDvelIXmIIxLdUjC/h3S
         DG+Q==
X-Gm-Message-State: ANoB5pm8Oc+xsr/fcFyi1OyQhR+gMhDOZ2ODA1Thb534DahAqohJ2+BV
        aKYC8dzq2PxYMCVPTa5A1LbXVWtXCYonb2bB
X-Google-Smtp-Source: AA0mqf6L4gCqJFfL8TKckYqVL4UdbA4AvJsl85PbnuRckuOUybQn47sT013q6YHr5DJpuY1UeIOQjQ==
X-Received: by 2002:a63:d117:0:b0:447:ed69:761 with SMTP id k23-20020a63d117000000b00447ed690761mr5042406pgg.181.1669157911225;
        Tue, 22 Nov 2022 14:58:31 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x11-20020aa79acb000000b00561d79f1064sm11247066pfp.57.2022.11.22.14.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:58:30 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <20221122072753.426077-1-hch@lst.de>
References: <20221122072753.426077-1-hch@lst.de>
Subject: Re: [PATCH] blk-mq: fix queue reference leak on blk_mq_alloc_disk_for_queue failure
Message-Id: <166915791036.141259.14121218872007132527.b4-ty@kernel.dk>
Date:   Tue, 22 Nov 2022 15:58:30 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Nov 2022 08:27:53 +0100, Christoph Hellwig wrote:
> Drop the disk reference just acquired when __alloc_disk_node failed.
> 
> 

Applied, thanks!

[1/1] blk-mq: fix queue reference leak on blk_mq_alloc_disk_for_queue failure
      commit: 22c17e279a1b03bad7987e4a4192b289b890f293

Best regards,
-- 
Jens Axboe


