Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126FC433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 19:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiKNTNk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Nov 2022 14:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbiKNTNj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2022 14:13:39 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9544021B5
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 11:13:36 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id m15so6238719ilq.2
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 11:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWoUo8dmGgVm8bdHXsx3SaIM8PPKLWFRvVphT7R1JZk=;
        b=2R2YVPVVF+58UpTRevTkArlSKla7wWVDcdoaqxkQQSILevAUH0zaG/QCy0yaVUAC5R
         vOy9tcW5TVTIjaXn6GCtn2MQcVkZN7COfMWi5iMXFt95kZ1gVnOwWtJZAdXoQ5DYdJ9t
         +7q/wvyDUY/cKHw5qw5rSU5c9ZL6GFqllf37t6DFM3134wuL8sQwuzjdwJjyGLOYz3aU
         WG9pNxTQW+ZtZwXkP93mMcj6Oh334u4xZZeEPX5dtOy9j7XAPn/S3HQ/fKnZI6YOajzX
         g5CCZxix9qjnwlqv4FNyACeHXITWqR3j8MajzNwgToB9zMC71h9wbIe21NDVECH7Hp4l
         51dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWoUo8dmGgVm8bdHXsx3SaIM8PPKLWFRvVphT7R1JZk=;
        b=j3BfLUYZzG3hG+l+ZtQK0zESXj+jWqT/ghJXNHsEHYecem/8WyhkYOWAeO2b6Ikp/f
         Esa5BHPtjgRIXaiWhbD8SsL+BO+o1m8W9vQ19k4iFJzVvCJXvMOh5Hnelxi8tbOzqP9M
         lVoGQZAz3RFZytAMeQ+xc4C1q8TO0qSJUDYWBTB/4EGSoIBxfxfDLk1lWw+2PRaeObVH
         qoxmErWT2NJdAWM9f/Nq1sk991fYrw+FpD6UxAMzJZ2EYvPrIik1ZehSULFBPIRMA0Bn
         Koe5qxflJM/RIHkvW/DEr3Hx/XT+YSw+igcJNzj+eY1ADnbW0RamwR/sLPobrQgB8Mpj
         ScPw==
X-Gm-Message-State: ANoB5plz7kj0HIuTi5D7kDPhiwRMGFnkwO1RjFnuSU9kw2Zi1rasitHf
        kmD97t1AWlcFZWDHDhubgbkT4g==
X-Google-Smtp-Source: AA0mqf5ydQO6C5Sls6HIBpDtP51IkcN+8+IypW+Nx65ZS3sZ6NiGmxyVhmqNizJosIMfanolvf8ftA==
X-Received: by 2002:a92:c0ca:0:b0:2ff:dfa7:f306 with SMTP id t10-20020a92c0ca000000b002ffdfa7f306mr6627669ilf.9.1668453216189;
        Mon, 14 Nov 2022 11:13:36 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j18-20020a056e02015200b0030005ae9241sm4106641ilr.43.2022.11.14.11.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:13:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     hannes@cmpxchg.org, Chris Mason <clm@fb.com>, tj@kernel.org,
        riel@surriel.com, hch@infradead.org, linux-block@vger.kernel.org
In-Reply-To: <20221114181930.2093706-1-clm@fb.com>
References: <20221114181930.2093706-1-clm@fb.com>
Subject: Re: [PATCH] blk-cgroup: properly pin the parent in blkcg_css_online
Message-Id: <166845321457.38124.12926398545778302638.b4-ty@kernel.dk>
Date:   Mon, 14 Nov 2022 12:13:34 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 14 Nov 2022 10:19:30 -0800, Chris Mason wrote:
> blkcg_css_online is supposed to pin the blkcg of the parent, but
> 397c9f46ee4d refactored things and along the way, changed it to pin the
> css instead.  This results in extra pins, and we end up leaking blkcgs
> and cgroups.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: properly pin the parent in blkcg_css_online
      commit: d7dbd43f4a828fa1d9a8614d5b0ac40aee6375fe

Best regards,
-- 
Jens Axboe


