Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD84C4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 12:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJRMMm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJRMMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 08:12:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C840481EA
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 05:12:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so13825079pjb.2
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 05:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjiYBWHAsq5BSDUVPoLM00mOuS8zKk9l4sbhEAwUt/s=;
        b=KDo/UelbHK2Lq3B03+qlsYL3E/uP3B71Vws5tjN8etK7bErlH8XeDOs5zjwAGFpxsp
         bYgtskekf3N1VvG1er141LbEZx2WMVTCzfPAqRmjltHe/uiRK3JbHsroBif0/VNf14Ze
         aRxWj0hL35j9duPy69YkHXbYa/LTAb9Q83fpryYXrhnmMtgbypkeTADtV8ON9lS6JDOS
         b5FU5C9ryOyahKqE4pwoIKAHIifV6qSynkBTXe6SfT7s6Ye1xxRvBU//AVm+4dGsc58U
         7HBlimP6InVqXVD1yQVrLFk5XSjhUzZKPC7KVUkivRpQ+2xkRDTBQWzMQdIEthZ9t1zs
         rfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjiYBWHAsq5BSDUVPoLM00mOuS8zKk9l4sbhEAwUt/s=;
        b=15Cgo8KuHLz62FbkwcBXRfXMrzaXJqYJg1lEQRFpm9FRBBU9HVwL2u+ckDy24GdjJy
         XblE8vjL/420ifzH/lBLJYmaqQPU7YRgbReoT5l52aVDAaZEsr8HTU2cLgTQyOWH/p5G
         u+ltyMhGoqwV52/ImWogRpV1Gjujkx9ggL1mVgIZxq8PRUy8Qo74IkLVqefNBOEHpSxp
         KC/snhua//OqFcGGBPtDY12s+KoYXx9kEeyevd8rItuw3AkrF97MBXFHbKudJbjkNKmu
         tWlYC6P55O/QTGZatk7VlMbIjycpt02NSGDUcJtt05Mm118dyzeydpn1zgaxfUZigoh9
         Ykfg==
X-Gm-Message-State: ACrzQf0j4hDruOI6nkGL+j9+ZfaLH69lAebrh5QbCcGQXkkJ5/BAUlC6
        HbPRLYLk29FkZRMwV0PxiAm3sg==
X-Google-Smtp-Source: AMsMyM4xhlW1FInjHG7+slvf4Tq0ZfnKswtvVR3OyCmT0DQ4kBYHxlUxg53izEyT2IjoFZqGdCN9sA==
X-Received: by 2002:a17:90b:1c87:b0:20a:e485:4e21 with SMTP id oo7-20020a17090b1c8700b0020ae4854e21mr3254817pjb.194.1666095158783;
        Tue, 18 Oct 2022 05:12:38 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0017f48a9e2d6sm8580160pla.292.2022.10.18.05.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:12:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>, ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        corbet@lwn.net, joseph.qi@linux.alibaba.com
In-Reply-To: <20221018045346.99706-1-ZiyangZhang@linux.alibaba.com>
References: <20221018045346.99706-1-ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH 0/1] Documentation: document ublk user recovery
Message-Id: <166609515777.5284.5366131175827495577.b4-ty@kernel.dk>
Date:   Tue, 18 Oct 2022 05:12:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 18 Oct 2022 12:53:45 +0800, ZiyangZhang wrote:
> User recovery feature of ublk has been merged. Add documentation for
> it.
> 
> ZiyangZhang (1):
>   Documentation: document ublk user recovery feature
> 
>  Documentation/block/ublk.rst | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> [...]

Applied, thanks!

[1/1] Documentation: document ublk user recovery feature
      commit: e0539ae012ba5d618eb19665ff990b87b960c643

Best regards,
-- 
Jens Axboe


