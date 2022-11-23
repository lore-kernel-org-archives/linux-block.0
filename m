Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A089C433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 13:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbiKWN7W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 08:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbiKWN6x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 08:58:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815DD56566
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 05:53:06 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 4so16725566pli.0
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 05:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9CmsBIWPbQRo+TQhWjPbgMCBvMUGNV8/tiPp8eu33A=;
        b=yxrVfZ0wWyZdqelxuvxh/YdZ1nBYHWUwk6oxwPvk304duX4I9vWxogIpb/cfsEI9zH
         dCIdvO8YnEFqAOJLXg0N1SOM+SnEXBRVhIqLMx6Rmzku19LfNnyUCTa50K3hCFIWIEZE
         QCIawit9/k4dg2LsuT7kqRWAf/POAws9KaYOSg7DCNAVEGu/Z3vM96SDxTj18uQqUftz
         xDWV+lHziX73nHBXddpuF6QFG72Rtye6ddy8nUvhCS4ZgcFGtWTDqqwqdSgFX8dE5AWa
         va+hedob9txWrBhyl10U3on6RwBARyMaZp4UVjeiyJrHl/BrYkb4SBTWFiKj3C9lmBUo
         Xo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9CmsBIWPbQRo+TQhWjPbgMCBvMUGNV8/tiPp8eu33A=;
        b=TqIU8r4q5CcKxkm5R4+V1etsmbgXjNPu2illOFHy9jDZ9rCmeNM7gfwWlspaT8v/cU
         YW+5wHm1ulsUyqTlmYAcAEmMgHihQHBqfnSwhg3v4BsBIkx/BEgnRAtkPeabo6NognxQ
         Q/jvv7BlNJt1YPz6vQzMT5/mNVX1OSi1+fSBdI87FK/mfMVdqznP2Wjy40l64FUd2Jf+
         Q3Xz2rouP2wbC/gRE5SXic8Oocf+ZhyzS2rSo+AA/Ptv2lH3OA3JbHA0UHn1WRHn+PN1
         ST4Ailx01/21pggxOeJA40n+/lYwMh5Apazx6aAB7N2bLHQWOajKb8KNv/84DzNRphoY
         0KPQ==
X-Gm-Message-State: ANoB5plz0SnbB9cdZnoaRAGOkOOuOnoppeV3BbmooW+kjcStgZ6bIxU0
        +dL3wp1zz7IU+NvuSA2YkLMSA36TYKv4sETO
X-Google-Smtp-Source: AA0mqf5sVEtPanjRBHYnlAf9OAv84TFp0ljtU0HTcjdOSxHLvWkAQFzNWw/gOjyRff/Sv+CxIY6HSw==
X-Received: by 2002:a17:902:f68a:b0:189:b07:10fd with SMTP id l10-20020a170902f68a00b001890b0710fdmr8726256plg.151.1669211585735;
        Wed, 23 Nov 2022 05:53:05 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c3-20020a170903234300b0018862bb3976sm2222618plh.308.2022.11.23.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:53:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-block@vger.kernel.org, hch@lst.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <cover.1669126766.git.nickyc975@zju.edu.cn>
References: <cover.1669126766.git.nickyc975@zju.edu.cn>
Subject: Re: [PATCH 0/4] random improvments and cleanups for elevator.c
Message-Id: <166921158474.84780.6332237082581853166.b4-ty@kernel.dk>
Date:   Wed, 23 Nov 2022 06:53:04 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Nov 2022 22:21:22 +0800, Jinlong Chen wrote:
> This series updates some function documents (patch 1 and 3), removes an
> outdated comment (patch 4), and adds a warning message (patch 2) in
> elevator.c.
> 
> Jinlong Chen (4):
>   elevator: update the document of elevator_switch
>   elevator: printk a warning if switching to a new io scheduler fails
>   elevator: update the document of elevator_match
>   elevator: remove an outdated comment in elevator_change
> 
> [...]

Applied, thanks!

[1/4] elevator: update the document of elevator_switch
      commit: ac1171bd2c7a3a32dfbdd3c347919fee32b745a1
[2/4] elevator: printk a warning if switching to a new io scheduler fails
      commit: e0cca8bc9cd8d6176921cb3f5f466d3ccfbc6b99
[3/4] elevator: update the document of elevator_match
      commit: f69b5e8f356e4e57e94b806ca1dcb9771933bb9c
[4/4] elevator: remove an outdated comment in elevator_change
      commit: 4284354758d67cf77ab2a4494e28d4c05fb83074

Best regards,
-- 
Jens Axboe


