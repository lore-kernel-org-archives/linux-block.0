Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7BCC43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 19:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiGRTNO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiGRTNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 15:13:10 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF592FFCC
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 12:13:09 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id u20so10082685iob.8
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=caIZTiJWjBkjSEjSsh8aaqF1qw6NJcsEk6g0gae8NU4=;
        b=CRel0K8PmEU6sSlvH3fXWe2x2mX2tTzmRL7Uvw+t18Aha/B7PE770ZzFli2nMYyJ0g
         g/aEjeual0db/Z91qkF0SlDS8DgIzI5wl6AI/vvCIfyr8/oG20EMH/rkkl+U2YkSKv/C
         nwf8HqiBJywa9upzoIZw3Nq9YawALLbtsVyGQilzIHsv/wYWadmnmwgK2yzXB4lSCW66
         /JS7MOFJJAQRsVW4HgpmRjVJ4KeJQnLBg1T41K1DQl9ySs8jCIEfL8eAGqKHe6zFDCqm
         Jcf5mOc+JNbnoqcP567kBoT45l28CeKqBt9uSkfOBEWZhHEiDNd+Enh1lMCYhQt8BsvQ
         Cvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=caIZTiJWjBkjSEjSsh8aaqF1qw6NJcsEk6g0gae8NU4=;
        b=wvZFhDInkczJNkbSA8UB5jFP9upy1SXUN1ibG/suRBxcMzqMmqVhCFe77ziO1r4ME9
         QTnZpAt5XURiXwrLSC9lqgS0W5a/rgk0ex+wJtyX+wCouVYZ8SHdbbbdBY2Acr4giyb6
         vUaZ4eMJEaoaY1diTCLCu+QRMfq1HuzJsJ65NrWqeOwt8ntpWX76h/Ve5M++ymHMXVTi
         BupKArBG1wPi9fAX/M7wHGMKSGN0+vtOfdshwq7hWs2Ro/KLMw8WmRglVznMkNk9WpMl
         brWNn4c+n/m5ax6oJjNZUd8v44cY+yVexck5+QTljWBaINvXlFtOBr/QXoClK3q0i1Sv
         BREw==
X-Gm-Message-State: AJIora/qxKaXhHa9uf9+oL7wBvR+UnlqbQVvZdsm+xEAhOzN6mygxIGL
        c2AVE2W48/LzTroXh/2X4RVpnheIapUmdw==
X-Google-Smtp-Source: AGRyM1tMgNoc9aUxVQUxuNqIXOQNVxqVEvxKxUTwRHVxahWjeUYcxW5AkLdhC1yDy3AVWWSImoBzhw==
X-Received: by 2002:a02:c8c9:0:b0:33f:3647:e751 with SMTP id q9-20020a02c8c9000000b0033f3647e751mr14571350jao.225.1658171588963;
        Mon, 18 Jul 2022 12:13:08 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r11-20020a922a0b000000b002dce032d817sm2234493ile.81.2022.07.18.12.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:13:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
In-Reply-To: <20220718063013.335531-1-hch@lst.de>
References: <20220718063013.335531-1-hch@lst.de>
Subject: Re: [PATCH] ublk: remove UBLK_IO_F_INTEGRITY
Message-Id: <165817158840.144438.13704138062708633441.b4-ty@kernel.dk>
Date:   Mon, 18 Jul 2022 13:13:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Jul 2022 08:30:13 +0200, Christoph Hellwig wrote:
> The ublk protocol has no mechanism to actually transfer the integrity
> metadata, so don't define this flag, which requires that an integrity
> payload is attached to a bio.
> 
> 

Applied, thanks!

[1/1] ublk: remove UBLK_IO_F_INTEGRITY
      commit: d276a22314c2bad9136c5e0b09eb3c8a560e1161

Best regards,
-- 
Jens Axboe


