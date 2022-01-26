Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6340DC2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 13:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbiAZNs7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiAZNs7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 08:48:59 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3651C06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 05:48:58 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d3so19903924ilr.10
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 05:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=CyqmzxPGCoANQA0kOVDAK6ju2RW+nvX6I43oXbMXgUw=;
        b=lun5tjg2WIq7PC3FBHi1dBQyxh16BBDdlifzhnh+6rwcdQVtgmhkqlyKc3SPHlMeXn
         qAaMvzXf+ItRubd2XwpJ0CLV2Rckyph4reP4Jh0BpPGIaheVphnQpXiOZSCmOU3HeyqO
         bw4bg4EwxtLkf3n5US90A47tptrQE2CEHQFolnNoGJKevehA6feUrRjJSsEH0ez0ceFB
         ldN0H0ZDSpUFCvKy76gjhAnb3HXtp2yeq4/QLAtpk8oM0ueJFSkt4oo8fmZlBbD4++Op
         WZSqe3tD7iyRG6LokGyVIxTdZcm1ciFU9pKLMYkaF0sWog0UgGcdk3rpnUmJkSDT8vWF
         nB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=CyqmzxPGCoANQA0kOVDAK6ju2RW+nvX6I43oXbMXgUw=;
        b=o9Re3FI3o5P1SyRDrjAlFPuVr6psfGttOQinFryplbOnMnlN5euHucrBbZHV3ws96e
         xFs7jbttMbgU4+kmCrDIWVqSfnUPhfDWu6z3utIDdjrIAuPSfCUXgkRcakkWwbxnSQgZ
         QucbhosXt1CClbwSZWd98ZOptykta0TY44dg4XQ6bxZjXmGFukTftcFkMtz+/RTjaauA
         CxKbMF5M6WlKwE+0O4kcGnlOAD+axFt6kM0jhV4aa6yKgualWuWyAkmN/qsyxkTzQKBQ
         /679MGqW2o/D9sJJ2g0g8eT660MJXBQCfanwkdO+c/vHMlHDtshRS4Is65v4c4nHr/lW
         9YjA==
X-Gm-Message-State: AOAM530iZOK6XY2jRPRbF8AZzie84vrNzyd0TJjedi8g2T+ZOVhbgd1r
        15Yxq1+DBye2w8Ev+YHh0ZDtIeu5UDH9Jw==
X-Google-Smtp-Source: ABdhPJxKpLQrRSGVLtg08ymaTRbs6gKlvK+FtDXdrgFfXgfiKV0UOKpU8QBqVNolIQomCukOatmwYQ==
X-Received: by 2002:a05:6e02:1c48:: with SMTP id d8mr14066465ilg.297.1643204937905;
        Wed, 26 Jan 2022 05:48:57 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f22sm10041108iob.34.2022.01.26.05.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:48:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220124093913.742411-2-hch@lst.de>
References: <20220124093913.742411-1-hch@lst.de> <20220124093913.742411-2-hch@lst.de>
Subject: Re: [PATCH 1/3] block: move disk_{block,unblock,flush}_events to blk.h
Message-Id: <164320493537.125747.12080346441619848293.b4-ty@kernel.dk>
Date:   Wed, 26 Jan 2022 06:48:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Jan 2022 10:39:11 +0100, Christoph Hellwig wrote:
> No need to have these declarations in a public header.
> 
> 

Applied, thanks!

[1/3] block: move disk_{block,unblock,flush}_events to blk.h
      commit: cb42c8ab3115f70501cf4657fa09c465f1d13284
[2/3] block: move blk_drop_partitions to blk.h
      commit: a3498e7ccf139ba19bacaded7cdc8ed098f5f907
[3/3] block: remove genhd.h
      commit: eac3b89477ca8274e27ddefe9a1f9da4d0c5dd4a

Best regards,
-- 
Jens Axboe


