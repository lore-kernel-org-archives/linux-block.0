Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966B5ECAAA1
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 13:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJ1NzU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 09:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJ1NzM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 09:55:12 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922145072
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 06:55:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id o13so2961996ilc.7
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tj6XPZgUzW8NJ94b23+3IuXwJoGOQr4AlpD0AF0r/6w=;
        b=Xlu1uPNMpYPUg0+TCziv/31NEm7rrpAH9J9cxIJ0HL4Ks3WBfICWa1sJYzimYnSruR
         MSHyU607tb/52sAo0Dlw5AN7oYNOwz1iPvMJjPNTPrxrDx9v0Cx3kCrdJrCM1p1wE9E/
         ox2mCg65fPbX6FrTZEwrmGkusuDTJSOgqZIUbvSpgmv+i/VWSqD4qUB8g4YbGUK7AtmS
         9ZDDk60XjREUnCoImKiS0YLPcXmv9CT3eaVKWpDre9DZrrb7KwcNMavUFRBOgCnqeFqB
         Pl61KwVnz141j7ZUqdwhFhQsRFqZvRtcgTmqnZ9xA2o5/DbVYm3M21fga+iYK080DQQ6
         NP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tj6XPZgUzW8NJ94b23+3IuXwJoGOQr4AlpD0AF0r/6w=;
        b=dUH/CoEntpRknwD+56m7vWrkeuPGnGPcs1z6bwPflZT88FhTLG1rkkxqN9SgZ96+At
         ZDvSyD64/VxO+jw/ge/EjBjOOqlGkG5+cYFL46RKw6wu7SlhO9/dPQ7MKjshkaaRrcLl
         uQS7uCQkz3vD1Pmf/LjBv8fE/iLgaqXxFUwol5TyMEo3adcrmuJPpcm6vS/GOjUa+1er
         NhWCoPZW4pSfSt6mvxe27mP6vlNhGgAWgP6U9/tCBYdXT9IlxjLXWPTzOh98Lpv+DL8t
         PviOV6/ntfP0K+R+ZIseMbCmgPnPGPuIVm+w6FTngfZUXU27y1LZoOrHQsA7arfVEwQN
         GNvA==
X-Gm-Message-State: ACrzQf0/4uRDVb1q2Joo3/hHW+7IG3cNRool65GJVUhjNlWUfoS0z21B
        bjzs7LVGsWdC1saHSL4vMzRmrnx86D6IN9Yx
X-Google-Smtp-Source: AMsMyM4xFQNkAsTtD+ONkVrsD9AIwgTvJR5bGZF0QsaRtxvMxMiYp3OH0bt/EAjWQOe7H1sGReFw/w==
X-Received: by 2002:a05:6e02:1605:b0:2fc:405a:d04d with SMTP id t5-20020a056e02160500b002fc405ad04dmr34107225ilu.320.1666965305346;
        Fri, 28 Oct 2022 06:55:05 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y16-20020a92d210000000b002f9f44625fbsm1616544ily.52.2022.10.28.06.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 06:55:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        bvanassche@acm.org, linux-kernel@vger.kernel.org, hch@lst.de
In-Reply-To: <1666780513-121650-1-git-send-email-john.garry@huawei.com>
References: <1666780513-121650-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH v2] blk-mq: Properly init requests from blk_mq_alloc_request_hctx()
Message-Id: <166696530392.41700.5029897700030243844.b4-ty@kernel.dk>
Date:   Fri, 28 Oct 2022 07:55:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 26 Oct 2022 18:35:13 +0800, John Garry wrote:
> Function blk_mq_alloc_request_hctx() is missing zeroing/init of rq->bio,
> biotail, __sector, and __data_len members, which blk_mq_alloc_request()
> has, so duplicate what we do in blk_mq_alloc_request().
> 
> 

Applied, thanks!

[1/1] blk-mq: Properly init requests from blk_mq_alloc_request_hctx()
      commit: e3c5a78cdb6237bfb9641b63cccf366325229eec

Best regards,
-- 
Jens Axboe


