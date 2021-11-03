Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6E2C433FE
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 12:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7F061101
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 12:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhKCMDK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 08:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhKCMDK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 08:03:10 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15E9C061203
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 05:00:33 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b203so2399968iof.1
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=cDei1keWsvl4PYK3ISz0TTskfmJQPyTanC8QtP8c2IM=;
        b=we1aIeYSg+m4v2LTpkEaLME2qgBx8Itr2kFLT04/aFMaj3H+yN4jGnKM54ZxZmoPyN
         MK4D2V3Jmn5r0BaGcHaUgO4+85f6UBYB+TAipO29YJq386QPvr0j11FMSccvn9vr3dY9
         moB/4ZBhQe70hlnJOCR6FS2M/lenAn7vAidXDmmEIlGW34OgvLFr+tvAf+ibt6MWYISi
         nSchkdZQctFQNtoTrTORICb7SMzAxK4sg1gquesdS0wgMjDsuRuXBQ9DHzXQPwPCNnr2
         0XaE4H8+x9o/tiKNFPaa9hrsHGTaNa6s5XxK38wcraTTzdR+exknT//QVJz9IGU/yiJ1
         OxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=cDei1keWsvl4PYK3ISz0TTskfmJQPyTanC8QtP8c2IM=;
        b=SqEaTab+P0NIwQX1HrnEnuJXa07HgL905tyJDukClJYR1wu0xWh5i9hjrZwMitxhH6
         4UAgrmG1U3VEGoEC4imjJkXgMTRmCMQH0IixC3l0bX0qQ1z1b8Uyw31xspC9dnz02Gyz
         0Qnq3cuWXSWg8AWaK7E+NkjRROEw9DoCYI+MkEM6pNV+/JMePDAV62cyn+fRTLpENLkC
         q8rsFAtgaVQR+rwtqoebwjMCLSIgY4Fp1B/L/kewDZJEHz4JLLl1Db7H478yYI0ll1h/
         ZaECBBh9Pc1q1XpjGYJIdvMpk3lSWgxzHtU/XfU2u8g9mqJdkiVqPi/hBVFr3PoVJ9yo
         FnHw==
X-Gm-Message-State: AOAM531R8Bz/FgumU3IPWKoRfWgOI/FZUiHHa+FOFuiMlOPoPcAOLRi4
        LrJkNy6oTPvIIgZk87UQpNgzaQ==
X-Google-Smtp-Source: ABdhPJy+u/6YTvU0aq4oLcJFO/i8gutUloaF0ii+Z5JVatTb1s+jELaU9oDz9FbgYRj/b9L6xTMzFw==
X-Received: by 2002:a05:6602:14c9:: with SMTP id b9mr249851iow.196.1635940833141;
        Wed, 03 Nov 2021 05:00:33 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l9sm1174074ilh.21.2021.11.03.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 05:00:32 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org
In-Reply-To: <20211103064917.67383-1-colyli@suse.de>
References: <20211103064917.67383-1-colyli@suse.de>
Subject: Re: [PATCH] bcache: fix use-after-free problem in bcache_device_free()
Message-Id: <163594083246.585712.11771708105907257182.b4-ty@kernel.dk>
Date:   Wed, 03 Nov 2021 06:00:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 3 Nov 2021 14:49:17 +0800, Coly Li wrote:
> In bcache_device_free(), pointer disk is referenced still in
> ida_simple_remove() after blk_cleanup_disk() gets called on this
> pointer. This may cause a potential panic by use-after-free on the
> disk pointer.
> 
> This patch fixes the problem by calling blk_cleanup_disk() after
> ida_simple_remove().
> 
> [...]

Applied, thanks!

[1/1] bcache: fix use-after-free problem in bcache_device_free()
      commit: 8468f45091d2866affed6f6a7aecc20779139173

Best regards,
-- 
Jens Axboe


