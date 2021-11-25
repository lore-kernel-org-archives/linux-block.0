Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BFEC433EF
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 16:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbhKYQTV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244227AbhKYQRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 11:17:21 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C891C0619D8
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 08:02:47 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id a11so6017894ilj.6
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 08:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=0qAsEjnbb+VBv+AENbl+pjNbqQq05jQJQ3B0sc5CN1o=;
        b=xoIVEah/yh6mbI/sTwuQBY2+5aG7QjEShDVHENIHR6HMi2eWgKaYjeuFYemOjMYwFn
         y/sdFbjOLN96YrH9DUbfuONrnJXfRJuJSGOZXquDQXbWXHGtcdo7SVfwo7einHnKcX7Y
         /OkK0gJqmVtl85aPQbFH7x/pzIvs/D5ry+1/KbFBm+If/pugrl4M5l0UHfum5G8MZFs3
         0bXMOV7BFM4j7Ay4trnMhdbqXM9OztUG57C6pGSKZxjmVbpZz7bhvd7yNreBam1ZV7tu
         dRI8XEMnmpCIbkjikuapV38wB1KVPG7IFPeC6Ck2478/keOqm0PAybExAQvRjmdROth1
         ZowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=0qAsEjnbb+VBv+AENbl+pjNbqQq05jQJQ3B0sc5CN1o=;
        b=ShYUyjo89N7Jp3ls/7Ph0tyqWMMn7cHcosvfk7IHVWxSg4XzKti0x9Cafuz8nsUs8T
         hCHer+kJhTz4WpbWzWV1cZc0e2XZ6O145S4rOqJb3wdVuJFaiTpoPgHuNoJM/0FG+1CB
         wXvi/F+m3GrSqIW2ewlQPnlyVnE4TAURyfMiBMxg2HFSIvzBXhB5to71QQTrzw79P1yJ
         PiBSzFsixqlHD9cm/Fc2H8Km8dIOF0LMbLgQH/wWNLAAea3m14Rycf+wK/kCWVHBZT/b
         rbBI8LyODWfnObnE5UgFEu9i5VNtJ2irvyUcPqy4q4hrxdg8cFIRjYKJOC7vJmOtYkU2
         b0LA==
X-Gm-Message-State: AOAM533ilkV+4IWGOzdLHxUvXXL8t5ypZY5SDmxf4HpPKZxe03DXhhxJ
        9/+muGe4/yRqkpZoDA8DLyxixQ==
X-Google-Smtp-Source: ABdhPJyixIBxXmOozDydsBZA2OLvJCu4BqZVnzvh5NVkni2M5UbdJ7H0NHuxx7ZbmashZSux8a1gEw==
X-Received: by 2002:a05:6e02:1945:: with SMTP id x5mr15135285ilu.287.1637856166608;
        Thu, 25 Nov 2021 08:02:46 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 11sm1737108ilt.63.2021.11.25.08.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 08:02:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, tglx@linutronix.de,
        Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20211025070658.1565848-1-bigeasy@linutronix.de>
References: <20211025070658.1565848-1-bigeasy@linutronix.de>
Subject: Re: [PATCH v3 0/2] blk-mq: Allow to complete requests directly
Message-Id: <163785616389.524013.4459386805250526075.b4-ty@kernel.dk>
Date:   Thu, 25 Nov 2021 09:02:43 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 25 Oct 2021 09:06:56 +0200, Sebastian Andrzej Siewior wrote:
> v2…v3:
>  - Align arguments with the begin of the function name
>    (blk_mq_complete_request_direct).
> 
> v1…v2:
>  - Drop the SCSI patch for now.
>  - Make blk_mq_complete_request_direct() call the completion handler
>    directly instead going through struct chain (Jens and hch might had
>    the same in mind).
> 
> [...]

Applied, thanks!

[1/2] blk-mq: Add blk_mq_complete_request_direct()
      commit: f783a8cc7d0701bcfb1ee0989a2227250c847178
[2/2] mmc: core: Use blk_mq_complete_request_direct().
      commit: a5d6aee0c81f86fc83950567b8b6988bf8ca6ff1

Best regards,
-- 
Jens Axboe


