Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53168C25B4E
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 18:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjAXS1i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 13:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjAXS1g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 13:27:36 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879F14DBE9
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 10:27:35 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id g68so11854693pgc.11
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 10:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uuCaVekZfkeqai5+tH1XcWnNEAthexu4ES7NdxZb1w=;
        b=0CQWYnWDevNhrRMRt79Csp8uujkrtXG9LJvL4xcplkj5RuqhEHNNH+h2PR4eHxahWD
         ckiol8pJr5N95Y4z0SOk+dQhSE+fsrOAJ424qkp6vWsxCkxyBkiqrRfBJxQHy+rBELuw
         KdN2BCRcFEhjJpwTHINv5Z8Dj+EZ+rDa/rVQNUCuB7WW/UIkY6hFZ9K6L1RXtutRLwPC
         Q0yEVv2n3Pe1LFGvSQFcUVQIFACknflCPc5bPu1OwCNUtbqOHJ7GnwTyFd1igb0ETedz
         aMyLM8njl7hVa7Bk91wqhA0GJ4/mUlAaFV/MCSTIF/w1Jp45kB9riYrXwex/FhZi+T7A
         RS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uuCaVekZfkeqai5+tH1XcWnNEAthexu4ES7NdxZb1w=;
        b=EulCrfygniARnGpbIWFf76yVS+yRMvX9zdm0Y54N7B6SCnFRqlXQhidXUmDHWFNK66
         CvqieJUPu67mrHs598JVBKITjgSunWG+9qwstuQJr79BPnx76ppL/LWnqH3V0B9n3P17
         LH3K9GocnZyLn2yC4XEP1zq6dTD0oexkKByZTGc38UM2l0wwHX8r2eoebF+z9GcROj+V
         OV8/zQSrBZ+3HsLpPdyH5JWdGfkcwN7hCdY5POlVRkNHa5QDdo+YD4EuItoZw0hLKuWD
         8q9YXBZRAhiN+rlhCkOTSYOrrX4l9hXU6WflUtG113E9v7LrcDUoX1Q2XcrGVm6jyJJo
         q2sg==
X-Gm-Message-State: AFqh2kpEioC8FwiOJO2Fn4zGhDYEDWdPR+kc5PSTIk+XUwjP2s97JqTk
        E+E1pehdqGbA3YiYviFpe0amKA==
X-Google-Smtp-Source: AMrXdXttIr5KYxH5dqKuhEcvWg6vVguxQirpQYJnlHgIYD5FvkqQheaGLMPMeFvcN7pfdlzMyU8/Jg==
X-Received: by 2002:aa7:9ad9:0:b0:582:4a5e:b1ec with SMTP id x25-20020aa79ad9000000b005824a5eb1ecmr6677607pfp.2.1674584854965;
        Tue, 24 Jan 2023 10:27:34 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a7-20020a62d407000000b0058c8bf500bcsm1909451pfh.72.2023.01.24.10.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 10:27:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-s390@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20230123075356.60847-1-hch@lst.de>
References: <20230123075356.60847-1-hch@lst.de>
Subject: Re: [PATCH] s390/dcssblk:: don't call bio_split_to_limits
Message-Id: <167458485388.330803.7271674092697042392.b4-ty@kernel.dk>
Date:   Tue, 24 Jan 2023 11:27:33 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 23 Jan 2023 08:53:56 +0100, Christoph Hellwig wrote:
> s390 iterates over the bio using bio_for_each_segment and doesn't need
> any bio splitting.
> 
> 

Applied, thanks!

[1/1] s390/dcssblk:: don't call bio_split_to_limits
      commit: a2aea8f56f9ee995aeabeb633b708024a3be5281

Best regards,
-- 
Jens Axboe



