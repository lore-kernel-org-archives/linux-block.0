Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EDAC6FA82
	for <linux-block@archiver.kernel.org>; Tue, 13 Sep 2022 21:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIMVIH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Sep 2022 17:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIMVIG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2022 17:08:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2396746D
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 14:08:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e18so4107714wmq.3
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=KQ08ovo8cE2Cv1PTDXttRfjzaZjAKihe6Dg0kiDovOA=;
        b=aHqn0FHX9oo4y08omSuZovGZFwyCbIeoGW7tiOEb2USEW8jiiGo6ae46gani0m5HMu
         WwIuDUwVTrNg12sf7XReMAxhjNxkPLTGukxoqr2zRDUU4tUhGAZQbMacXe9u9e2CTg6D
         PDxeaL2XX2ROxwsFBySW0sfts7LSccsuZ2dhCBxGmeBlGxqN+WmhmHkqCN4Y6/dhRGrv
         w2R+mFlD89UKWuc2L82bbIZFcN0ulYeKCJCGMOwcKV1ipOIlpZu2AsdgfQN1f3WrxB0l
         5auBPR6FLaKIfyaxqbZJzMwN2LkeOZBelRW5SrXoG3YZgPmOam5RYtrye1fS82mGfVG1
         lshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KQ08ovo8cE2Cv1PTDXttRfjzaZjAKihe6Dg0kiDovOA=;
        b=RLFDJ4SqmGW/mRjzhQ5cjF1xzKd9O7fwy2RT3AYU/ud+N6g36Uk1jrYTWwiet5UWbJ
         WJowJ/MfStwQ/rnPHaHOP840oEsf8nGAQBv7SIbodNwe+ufM4MAGFpLXEHsOxFSA6ERv
         0iqFZm/ZC8tyEeVPYCWfXwrg57j7uaqJtMWrberssMo0sLoFxOFtjEbdKacbZGVy9wTm
         7gKSFNgHaUq/lAuNhIoVHFzz51f/nFlpeJxhXtfaWZJujtBU6lOpIIOJPhQ+UCch8vrL
         P6cjVtIp2lLgbCihoerhYuOqruyChAjUOAlznAoWd1xloXwQkDs+4ci3gFhfNv79mIqR
         r0qw==
X-Gm-Message-State: ACgBeo3OjrU4LLfMRIsHEq3dcbCZUZJH9uwMt5Mm/v1cDIHFF2mlWoty
        IUl0+nr0oXEcx9yjx4hJPvmpko0LFmO4O9lX
X-Google-Smtp-Source: AA6agR7td6AyMAmbtsMgm0hU6//DSjUrwx6r9FRn+QEq5hJ8kvDeWVTZbB4eeNzN9hNu51mNtx602w==
X-Received: by 2002:a05:600c:2f88:b0:3a5:4014:4b47 with SMTP id t8-20020a05600c2f8800b003a540144b47mr831467wmn.96.1663103284103;
        Tue, 13 Sep 2022 14:08:04 -0700 (PDT)
Received: from [127.0.0.1] ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id bo23-20020a056000069700b0022a3517d3besm12854497wrb.5.2022.09.13.14.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 14:08:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, kernel-team@fb.com,
        Stefan Roesch <shr@fb.com>
Cc:     io-uring@vger.kernel.org
In-Reply-To: <20220912165325.2858746-1-shr@fb.com>
References: <20220912165325.2858746-1-shr@fb.com>
Subject: Re: [PATCH v1] block: blk_queue_enter() / __bio_queue_enter() must return -EAGAIN for nowait
Message-Id: <166310328309.12918.13628547136691339777.b4-ty@kernel.dk>
Date:   Tue, 13 Sep 2022 15:08:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-95855
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 12 Sep 2022 09:53:25 -0700, Stefan Roesch wrote:
> Today blk_queue_enter() and __bio_queue_enter() return -EBUSY for the
> nowait code path. This is not correct: they should return -EAGAIN
> instead.
> 
> This problem was detected by fio. The following command exposed the
> above problem:
> 
> [...]

Applied, thanks!

[1/1] block: blk_queue_enter() / __bio_queue_enter() must return -EAGAIN for nowait
      commit: 56f99b8d06ef1ed1c9730948f9f05ac2b930a20b

Best regards,
-- 
Jens Axboe


