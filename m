Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F669ECAAA1
	for <linux-block@archiver.kernel.org>; Sat,  3 Sep 2022 02:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiICCC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 22:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiICCC0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 22:02:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2457C8754;
        Fri,  2 Sep 2022 19:02:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id l3so3460305plb.10;
        Fri, 02 Sep 2022 19:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0r8NdBT69RFwnbmp10XxWtUK9Y1Ejmq1k4v6A4hzneo=;
        b=GhQjQLoIoAvqMoQdOANmkoeHLSE0pfXQtORW3OTALIpdmNgRKWcTj481ookqkXtJll
         N5BX0QDe8XZOZXxEGdZIWkkjfkXWCIvNvPWumc656iaJBhspBURL6EfMDRb6oB67dLHI
         8GqLsOJHDlgwyJiTM3YdK8/grJv8GDu/H5zvS3G4KbRPwGHSTTTkXbwakL8OoPDBdtEA
         0As0hbx8ITZTzkb3d2CXPSxTu7HEIpqR8tT9Chq4MlErDkn6jjsed0MmMAMZfexgF2V8
         sB+mKnoctKtxw8ce81j1VQruXQHPXvTkYo2mb7q6+C4P+dxpkVCnYxWFreHTd+wttLPG
         E2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0r8NdBT69RFwnbmp10XxWtUK9Y1Ejmq1k4v6A4hzneo=;
        b=iwmrETAm1FSgL2BpbBGzgC8UmVywgIzBz6GwZSc0hA9mLazHVxhJ8eBCzBNdh+s/aE
         slNlYKnP2yKg54suTT/sBeYR/f+X6bPO2oPUDxV/D3N4MWcz+4Kf8J2+XciKTQO96JaT
         W+30UJhh5rRlsaOsFgRByV3oyXpQyh3i6jP1QQ0b+lndbodAPWYATnV7kXkhdSJWU13k
         jn3hwKQBacnTagYZaEIstjGe5ZR3l79IO89Ks09gsfnpnrck3d9R1OYsbixZIH4XHhyX
         AcBHSnC97BL7thvLDYij9SjQ2+yRNwUO6mjQDk7sVHVJCH5ixEBC2VU3qCk4tq8gOZ6V
         Kgog==
X-Gm-Message-State: ACgBeo1Xc0Q6gyECPzvzACsze73EJcMtFZJQCxF8Ie5lTUWzblm5T91E
        fUUbqIBJ2yzs1bo0MA7tuLo=
X-Google-Smtp-Source: AA6agR5umDytfLJWGJ31jQHzA1SX7xHEXon07O/CUD2fTkmCYxtzjkRskWzMLHTeROQFqXiAFfWPtQ==
X-Received: by 2002:a17:90b:4f44:b0:1f5:1310:9e7f with SMTP id pj4-20020a17090b4f4400b001f513109e7fmr7787676pjb.235.1662170545075;
        Fri, 02 Sep 2022 19:02:25 -0700 (PDT)
Received: from [192.168.43.80] (subs09b-223-255-225-224.three.co.id. [223.255.225.224])
        by smtp.gmail.com with ESMTPSA id u195-20020a6279cc000000b00537eb00850asm2584816pfc.130.2022.09.02.19.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 19:02:24 -0700 (PDT)
Message-ID: <103bba65-cc98-fd83-515a-de7dfa719e5a@gmail.com>
Date:   Sat, 3 Sep 2022 09:02:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V4 1/1] Documentation: document ublk
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
References: <20220902152302.757375-1-ming.lei@redhat.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220902152302.757375-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/2/22 22:23, Ming Lei wrote:
> Add documentation for ublk subsystem. It was supposed to be documented when
> merging the driver, but missing at that time.
> 

LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
