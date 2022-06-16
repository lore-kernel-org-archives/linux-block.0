Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E134C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 20:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiFPUq3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFPUq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 16:46:29 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69905C767
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 13:46:28 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r3so1715579ilt.8
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=/0rB6HZjPnWmFv43FFehMNWzQXlNuJCpLS0IY+hPtrs=;
        b=BY4R2vq9s6mdywVzLP4cKHc9ALejY4NrCwmOcEfawsPULCkzkEUDfK9z4c6m59qxN8
         Q+7p4a7fh0VtSYoO5AzeIPBWWGwBQJTaubBZolnE35BFn25/Vn6/01zmc4tRU6XbGc+X
         5d+/B891TrjOWExrTM18CVsdhg4wAiWFqkJBHM/krvj2KceyS2gJrP7dfzRKLVHHpHAS
         jaQFNQYG9leIb5BslYSpyRFKQORS8J97NAloUjpx7bsc6619l+0h/hb5asqA1shJ9d7V
         25TyLA8/pPtYwsx1Z7Trno/g86Vyf7krDtgDx0r88+kGq3QehAm1mBzQ9iewdKkKjf6x
         +ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=/0rB6HZjPnWmFv43FFehMNWzQXlNuJCpLS0IY+hPtrs=;
        b=KOuWOm3LieQIA+0Kn2CEd8bqClQcOsjE1ICIHEtmyF4WNihM56xVQM4baiwaSuphDi
         5OcH94Ksb84fhrk3sd3ezYSY9DLHsLalixdr3Hpb9k2T/LmWFe81qQszWWu49EZ9PiNw
         8b3k60tsQpMjV6IY3KEx7Yeo9ruLZlzHldBDSp8DoankpPYRqRNgGLYBytBSqWCQSZOS
         MBZgV4OPUAx8hEaLiDxk9W8yz68A9LUZiia3/PyjUt4w7og+/52Ew0NpetaDE60OfEQO
         FyXlLkoog3zr/aa6IfzmFhNMnaMxRZOLJiIKJiWsGhoo5BRCUoXVhEqITo2GG488RsNF
         eZHA==
X-Gm-Message-State: AJIora/pWAq6ofi6GXoCAWJUF1DPZgnaXshSBFQz/2FrM0wDPOqXZg5K
        DV9HLn5sy38bCiAwfSRQzpd6YYzP3XmGLg==
X-Google-Smtp-Source: AGRyM1uIQGPeJg+EFmsogZa3pGgG0vfEcXA0uhlttEwOMQsqlvoVAKl9wBZayd4F7O75dM5KiigeOA==
X-Received: by 2002:a92:7c06:0:b0:2d6:605d:8164 with SMTP id x6-20020a927c06000000b002d6605d8164mr3692256ilc.179.1655412388003;
        Thu, 16 Jun 2022 13:46:28 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s62-20020a6b2c41000000b0065dc93eae5dsm1647971ios.7.2022.06.16.13.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:46:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220615225549.1054905-1-bvanassche@acm.org>
References: <20220615225549.1054905-1-bvanassche@acm.org>
Subject: Re: [PATCH v3 0/3] Three small block layer patches
Message-Id: <165541238738.250893.3019134669903309639.b4-ty@kernel.dk>
Date:   Thu, 16 Jun 2022 14:46:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 15 Jun 2022 15:55:46 -0700, Bart Van Assche wrote:
> These three patches are what I came up with while reading block layer code in
> preparation of the patch series for improving zoned write performance.
> 
> Please consider this patch series for kernel v5.20.
> 
> Thanks,
> 
> [...]

Applied, thanks!

[1/3] blk-iocost: Simplify ioc_rqos_done()
      (no commit info)
[2/3] block: Rename a blk_mq_map_queue() argument
      (no commit info)
[3/3] block: Make blk_mq_get_sq_hctx() select the proper hardware queue type
      (no commit info)

Best regards,
-- 
Jens Axboe


