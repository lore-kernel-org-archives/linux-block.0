Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8127FC433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Dec 2021 15:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358919AbhLBPZV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 10:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358906AbhLBPZV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Dec 2021 10:25:21 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99566C06174A
        for <linux-block@vger.kernel.org>; Thu,  2 Dec 2021 07:21:58 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id m9so35784684iop.0
        for <linux-block@vger.kernel.org>; Thu, 02 Dec 2021 07:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=YG5KWXu86cvGteHf/Ij/qXbUrRxzayxkFNKiuCLk1PM=;
        b=3zk+eKaZCjieQvsVvtE2svtPTqz+fqzb4hSK/MrJ8VtRxLZLwUsEdD0y9IkKYdhiCh
         ClUQCY1JQ7e3eIg8d1Dwae2c261ZB1riTa3+txaFD1Zd4b4D6bmq1RP79aIF+CyrFuig
         lqpTDXLFKKP3u2UFjuoHwrsLBL65ptsqdLTUyoJ9+v+5ShGlAYAtAp1QuCXiI/tS1YNT
         lFhPAfN6SYgOqYuly7LZogNyOobszQ6VuvrVzWYezKRh2orNfbQisTz5w1fox2B5gxDd
         EBeBPrGWdbOzJuI8yOXVUo91K6u2J2t0djlTOBycPKb04I/xXobKbwK2XGyegp5hT09n
         sqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=YG5KWXu86cvGteHf/Ij/qXbUrRxzayxkFNKiuCLk1PM=;
        b=bgVtcRD5hn3INwDXIRVfquGAjG46X6E3ho1zXZXm5ArCwFnYmsIHtTH8guzpV27DOC
         9fp0BKQt3yk4fFUcFnc1U716VP+71f/FT+8Us206Bwe7AyVlF++eRfIVpEu/yt0sUde/
         OugbUwX0/w7w4skItXjXKPn3KSfqKB+ZDqLnItaVG/DMMmPONNVSja/8Tcc5g5X9tVcE
         f/IjGdaxDk7rTyvclyMbnfMKC8drgL58S/e/NGJNEvJ5kTstUJzhVAqMRNxvDV5cG/fD
         pSPQimkjncBYFjP0GbO+IyWeljObmesEUAg7cr0mE3wrU1XM1hTUXpbeXMU9XU22K32d
         ac2A==
X-Gm-Message-State: AOAM532x1/1Y9Gcg+lOquZUQvCSqb4bWHDox+MhOgT2TPJYJ5rDTJ9T4
        Ox86R3FA5kqZY2r5D5Lmf8yKj4Ck9XnKdshc
X-Google-Smtp-Source: ABdhPJy169Qein4bvI4xq/8CTKEvivRvVu466f60TGyKLSHaX4eNmZFY8x4D2ugQeS94jTg4m9Yh7g==
X-Received: by 2002:a05:6638:2684:: with SMTP id o4mr19988326jat.70.1638458517787;
        Thu, 02 Dec 2021 07:21:57 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a15sm38727ilj.35.2021.12.02.07.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 07:21:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20211202090716.3292244-1-ming.lei@redhat.com>
References: <20211202090716.3292244-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: check q->poll_stat in queue_poll_stat_show
Message-Id: <163845851733.578704.6397888995573392515.b4-ty@kernel.dk>
Date:   Thu, 02 Dec 2021 08:21:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2 Dec 2021 17:07:16 +0800, Ming Lei wrote:
> Without checking q->poll_stat in queue_poll_stat_show(), kernel panic
> may be caused if q->poll_stat isn't allocated.
> 
> 

Applied, thanks!

[1/1] blk-mq: check q->poll_stat in queue_poll_stat_show
      commit: 18d78171c061889a9a43152f60d6a27a10fc7656

Best regards,
-- 
Jens Axboe


