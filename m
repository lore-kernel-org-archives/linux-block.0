Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5879DE95A8F
	for <linux-block@archiver.kernel.org>; Sun,  8 Oct 2023 04:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjJHEjE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Oct 2023 00:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJHEjD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Oct 2023 00:39:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D603C2
        for <linux-block@vger.kernel.org>; Sat,  7 Oct 2023 21:39:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c5db4925f9so26201565ad.1
        for <linux-block@vger.kernel.org>; Sat, 07 Oct 2023 21:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696739942; x=1697344742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IsMeRH0QRNKYNVq9/tm9ZJNkwgPtdPqq26qQy2Ffdo=;
        b=F9s7W/G+sPpue8jJqBH1jFSVLuNAseaUrfet8y9O3J3WBxRqzQqo+OrgVnfaGL5ia7
         BUWNRyVcqsNSKtpCe7u+tdIZznhm16FLSVXBm8g4oIxePNlBCS5y8FoxVx7U9+O7kC+X
         xcOfZMo4KiqCobf0w7rUY2tYiOvBJvV3lIEyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696739942; x=1697344742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IsMeRH0QRNKYNVq9/tm9ZJNkwgPtdPqq26qQy2Ffdo=;
        b=a8xtHgrqERwJ62uvSF/8j7ArSiZ/xMUM+1zO8Q0V6aYP1tgRZJNWxjIWxB6X8cFu3E
         Q7frySbJbF1WOvAwQHWPzCf+XKftyEe7anhM9Lp7yo6ogqaq9WVsvuYbdGMu3HS/ShRj
         6bbetjW1DVB1Bd0jIXLnomhJmu9ieLS9DLA3D8eN/IOfnmryru/W7aH/piCHxHPsif4e
         d6L3yty7bg4AxnfS7qWWKjqLWRIhExMFk8tfzWiDvqFQJJwreGaqHogUHVs5u8+nyTlz
         5HaJ1mdP3BAvVqkt+A53iAJr7fNzpNWlnF7aa24MU/blrf+tqjBd6T07GuBIiKQNCfV9
         rDCw==
X-Gm-Message-State: AOJu0Yx6DMzN/xWSiCLNLKeoPZvKtdfVQNAFMpuPifRFJT2sKPzCwdWB
        7PH8yMdmtB4xSiBIzb5p2PyEdA==
X-Google-Smtp-Source: AGHT+IF/FgciWLEkO+rHo0i3RaI4sgAv8QYL/KWMB1vlhmp8wyjNfPRAim7iW2undRDY1Stzw+4xAw==
X-Received: by 2002:a17:902:e84c:b0:1bc:4f04:17f4 with SMTP id t12-20020a170902e84c00b001bc4f0417f4mr12703406plg.30.1696739941503;
        Sat, 07 Oct 2023 21:39:01 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5275:a34e:f50f:5f52])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001bdb0483e65sm6727218plg.265.2023.10.07.21.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 21:39:00 -0700 (PDT)
Date:   Sun, 8 Oct 2023 13:38:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yj.chiang@mediatek.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] zram: use copy_page for full page copy
Message-ID: <20231008043855.GA2738554@google.com>
References: <20231007070554.8657-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007070554.8657-1-mark-pk.tsai@mediatek.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/10/07 15:05), Mark-PK Tsai wrote:
> 
> Some architectures, such as arm, have implemented
> optimized copy_page for full page copying.
> 
> Replace the full page memcpy with copy_page to
> take advantage of the optimization.
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
