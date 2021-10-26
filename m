Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FFFC433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 22:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45BA6109D
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 22:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbhJZWDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 18:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbhJZWDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 18:03:22 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2F3C061745
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 15:00:57 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id w10so771301ilc.13
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 15:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=yaCb0u7kHGCkaTa52y1zZ37iQuNRyZWxVB8xcOMfBL0=;
        b=znQj4CxLFrfRLotnrL7NrFjxFc5hIT+jpYYUUKtsxtUv8ndD8HI7UlgkpUpwOmGMo8
         leg9M4M742eCheZiZbLnFQlThSOgBU5ZUordW6tLqRYHy3f2dPGb7nRkvme4ML29wC/k
         Plvhi7nAYunGGqHWnAw7LClZbTirOL8gtXehQQQ6bQopja4wwkd9Tqmdc3gByWdI6XqR
         FQpfa8MoW9NFW0RqwAyYT98p7oYcWUPbMSAMrkQis/8n4YLbM9uyjzoLTP/ShsZydmMx
         OgKIj8zxGm2u5cdaFmEbcBUvRAFbT4TkIC+CvUhViTmoZrdcaSvdUkXnAp149MlD/Zn/
         4LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=yaCb0u7kHGCkaTa52y1zZ37iQuNRyZWxVB8xcOMfBL0=;
        b=FcUlQKfFTFOBsmeLoKt1hnLBF/muV79tHkNvFdQHfTsNBkv+cTKc7OGnApjGL78wyv
         AoCfTIck6Tbm3C54dnLyrQYyu+4pxjpLMV9WBsILhwTSBWv0fYi3vBZvgHQRaiA6y+iv
         3AbX1/HtY3hLGcUAFG5TXoCXSRrd9wtdwX4LJJuWxj0BwEFM8GC2GHzxTQ42W0k5WTR/
         AlOFdN/Rv2UOzNfumlJXCLuk2thIaZuIJpw3M+9zKHTXlqzFg+OpLG0rZjuBELzn4Zk3
         ZeHZporScErlaeA6tkLDq+8yj+rkYfyt524KOwo6Eqy91DGtElxconKigFeJbSIHstR6
         loFw==
X-Gm-Message-State: AOAM532tA05CmCp2bxMKsq9pq1nBBbr71073NewOUCGbiKlICZow3QzM
        1Yu2w6ZEpEtRbyCRkxl22q/yAKeysg4IUg==
X-Google-Smtp-Source: ABdhPJygmCTN0DIW6AoMGzHLBKa0OoR3NljfrKfxn31V1ZWufs7FbfUO9CwVl7o2VLvUPwx3C6NCnQ==
X-Received: by 2002:a05:6e02:188e:: with SMTP id o14mr10658855ilu.114.1635285656867;
        Tue, 26 Oct 2021 15:00:56 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d10sm2191871iog.25.2021.10.26.15.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:00:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
In-Reply-To: <20211026165127.4151055-1-naohiro.aota@wdc.com>
References: <20211026165127.4151055-1-naohiro.aota@wdc.com>
Subject: Re: [PATCH v2] block: schedule queue restart after BLK_STS_ZONE_RESOURCE
Message-Id: <163528565626.259196.4840508461738349119.b4-ty@kernel.dk>
Date:   Tue, 26 Oct 2021 16:00:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 27 Oct 2021 01:51:27 +0900, Naohiro Aota wrote:
> When dispatching a zone append write request to a SCSI zoned block device,
> if the target zone of the request is already locked, the device driver will
> return BLK_STS_ZONE_RESOURCE and the request will be pushed back to the
> hctx dipatch queue. The queue will be marked as RESTART in
> dd_finish_request() and restarted in __blk_mq_free_request(). However, this
> restart applies to the hctx of the completed request. If the requeued
> request is on a different hctx, dispatch will no be retried until another
> request is submitted or the next periodic queue run triggers, leading to up
> to 30 seconds latency for the requeued request.
> 
> [...]

Applied, thanks!

[1/1] block: schedule queue restart after BLK_STS_ZONE_RESOURCE
      commit: 9586e67b911c95ba158fcc247b230e9c2d718623

Best regards,
-- 
Jens Axboe


