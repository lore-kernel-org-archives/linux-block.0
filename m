Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0501C7EE22
	for <linux-block@archiver.kernel.org>; Sun,  7 May 2023 11:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjEGLnR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 May 2023 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjEGLnQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 May 2023 07:43:16 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95B13289
        for <linux-block@vger.kernel.org>; Sun,  7 May 2023 04:43:14 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ba21644874cso187652276.0
        for <linux-block@vger.kernel.org>; Sun, 07 May 2023 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683459794; x=1686051794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/KgkHs9lVvBm3xpb5mpBL1jon6g+T6CYo/zJAttVKI=;
        b=X+S1hIRGux8FkzjG1b6iz6Wrftbum7bA4vvigJOyjZ6R67A/op0wFLouauDdw3Spbq
         IRCi6Q6CVIyXRLOtBfM8NHKC7ullVNGgmSL8/uCCITIKrYUtXQgeEGq6ijZZC29hWrWE
         c/SnXgUmorJm3ymr1YgbnPK2vOHEaFrBCEfctfPCx3BtCvTmu7iQA8InOaQRaS1IBP/8
         A28tpcPbAqrbzzskUie389+fEgOA5NDA2Q7ooljoKuX2i9/GlFtlaC4vZone/MsT069i
         M6SmOAk/Brvm32NcFe4lwnizGWJajFdpRgV6Y/cQPFoWSVmEsnDPcK51Rre20+Weg/us
         kkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683459794; x=1686051794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/KgkHs9lVvBm3xpb5mpBL1jon6g+T6CYo/zJAttVKI=;
        b=hXjTU26IUt1rpQ0Wd3V9gTM6bUEVPAztWvHdixqyCH3bkfPnRP4KYgUegNS1WzN55K
         IK0GJKYryKxGxnRtcGMxzAKsDgiq3Mbg/4sH7gJ1WZ0Y4h6hHwxkSW48tIPVyGtmMOlA
         WOFPG+0xqk22W/eyUNh2+L5izffanny8vYFJr1XoPz7K7RbYvAsa+hdAfiuJqGaBr5mr
         m6R+qMQSTWKMgsFXno2QyqVdLqEYw4Bl8qfqnE+I9X5FEmZ9T/P71+kmT0fLzvakXjP8
         2Yqa3fQdL3pCiayHiDX0fQ2t7xLIkPj0JK1uUNc49gfy2X7bqKWA4TWlIS9A8oudVjgx
         ipww==
X-Gm-Message-State: AC+VfDz8lAyOlDtmjD5avtrsOqz59YqxkFInhJz8eNOoFjrhljWZMKC7
        xzxriEd4klff92r2CtbQNEk+Ew==
X-Google-Smtp-Source: ACHHUZ6eN2R5iv72lVClZy2r8Jl7KPPR4R0d0mK8ZhY+OVDGabIxojEOhbqMCpi3LJZVFh+JGHl77g==
X-Received: by 2002:a25:aac3:0:b0:b9e:76b4:df36 with SMTP id t61-20020a25aac3000000b00b9e76b4df36mr6977968ybi.5.1683459794046;
        Sun, 07 May 2023 04:43:14 -0700 (PDT)
Received: from [172.20.2.186] ([12.153.103.3])
        by smtp.gmail.com with ESMTPSA id r15-20020a255d0f000000b00b9f4343547csm1630950ybb.41.2023.05.07.04.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 04:43:13 -0700 (PDT)
Message-ID: <92f0bb80-0dce-b679-4b51-ad3f0d466abf@kernel.dk>
Date:   Sun, 7 May 2023 05:43:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Documentation/block: request: delete the unused FIXME
 comment
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20230507045012.15172-1-rdunlap@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230507045012.15172-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/6/23 10:50?PM, Randy Dunlap wrote:
> This FIXME comment looks like it could be a local file contents
> attempt, but this file is short and does not needs its own contents
> block, so drop it completely.

I had a quick look at that file (which I didn't even remember existed),
and let's just burn it down. It's way out dated at this point, should
just be removed.

-- 
Jens Axboe

