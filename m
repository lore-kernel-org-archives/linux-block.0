Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF29C433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 21:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244384AbiDAVC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiDAVC0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 17:02:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506F41B2543
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 14:00:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso2188788wml.5
        for <linux-block@vger.kernel.org>; Fri, 01 Apr 2022 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Nfe9G6FAXY/E/AbmQAdSvRU9IORQQkMBI1TaVXtl0I=;
        b=ehFx1CZeNauNPlFJDPhsoGXqJb3EGKznWsNWXmYtJm2Na6JRkBguhTA52xhCey8Ejx
         CUvRZmh9SWpsgjDc3W0Y/ZBS79AbiCQvaq+2UHKJuudI3ZnZstW5wGzAI+qPtEe5XD07
         drxVG8g1aUPzVzzSPdP6+Ve+glSHGap368kgnS5tW3VYzFiF3PG555f4nfT1Tu91P2jx
         vs9p24XHMfSd7lAUvzqqOFK9Zh6WCBNciTwnR6sZvTv2xVHwJrXS/96HvBN/ku8Nknkw
         iRriKxEMXLdWFKmnL5Nc9QVS5bCTovfNobAt5dVkY9epn/pEzxZUGlD2n3GLA4BS5vp/
         ZZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Nfe9G6FAXY/E/AbmQAdSvRU9IORQQkMBI1TaVXtl0I=;
        b=kv9fdxg2vkVgfJXpQe7bXMKa9DmQ399yax+MQc/so6Ro0SZI88ICNRvkhn/yiQUPdk
         HMsKMn6vwHFgcyChq1KByfbdYkA14bhPw3vVhqNCpMUAdUPnIpDgy0aQGGMj1FnXpZBQ
         zWnzgFmKYxlIpe+xajvZYdSC0kOsU1MIT5r0pSML04U7dmgW2L3WMoCWbWW1tsFVsOJG
         vYvicOzm2Niqlz2Y2BeLD0LHqbrz/jjzK08grpn3TVO8HNt9tCDSKTuC7rCjTEmk44ME
         t1+CoZbr5zsfH7SDk8urLIFlQUvuIXxSpK2DIDEkJJh65FJtb7Ggo+WtL3tBCe6uFn4y
         yKdQ==
X-Gm-Message-State: AOAM531fjYvXM+PxRUPmhJPAtsAYqSL0zbQOphofhOgkC0idwzP/oPoC
        RsvDdGH98HTrmXHAnUqQ3hbFqg==
X-Google-Smtp-Source: ABdhPJylXTtpK692bqz4KfNgI5xyVNjcHc+ugaJ2/3bPUryjXJPVzLcLU12s/iWShAy+/1hfqoWlbw==
X-Received: by 2002:a05:600c:5106:b0:38e:38f8:858 with SMTP id o6-20020a05600c510600b0038e38f80858mr10027515wms.109.1648846834887;
        Fri, 01 Apr 2022 14:00:34 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm3479405wrz.29.2022.04.01.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 14:00:34 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     lienze@kylinos.cn
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] cdrom: remove unused variable
Date:   Fri,  1 Apr 2022 22:00:33 +0100
Message-Id: <20220401210033.2078426-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401032623.293666-1-lienze@kylinos.cn>
References: <20220401032623.293666-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The clang static analyzer reports the following warning,
>
> File: drivers/cdrom/cdrom.c
> Warning: line 1380, column 7
> 	 Although the value stored to 'status' is used in enclosing
> 	 expression, the value is never actually read from 'status'
> 
> Remove the unused variable to eliminate the warning.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  drivers/cdrom/cdrom.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

Looks good to me, thanks for the patch, will send on for inclusion in
5.18.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
