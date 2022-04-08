Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D49C433F5
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 12:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiDHMgN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiDHMgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 08:36:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9850A342025
        for <linux-block@vger.kernel.org>; Fri,  8 Apr 2022 05:34:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso11794673pju.1
        for <linux-block@vger.kernel.org>; Fri, 08 Apr 2022 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UtCrT7/OSpWOMAYO1geobq/EXsQPSfaZpg6dw1dccJA=;
        b=gPKeOsWZLKcITHew9VoVHySrY5DJP0Xoq5SL8mWQSl66apSzBVnvBRZ/oK+qhP6JKp
         tVcm2JW5DrWNtD8mif4Q1M9xG37iHT+EaQAueKg+4A/cCvT2Ui39w0MV+2DvT8n84nmw
         dKeRPqqEozhwSOi3cAcEOm21BRXqsPCZLm/2LHc/3hLxU6BbiTY8pyO2ZIpk0CUqxVqr
         7g8mFp1soYukAAbGdorkfOb9lCBvxmxJp/3S+qanUCY6Q8NqCW6IkSnk0XCtBbtIBLdP
         MJsJH3t95rv2kewA7PAOHgXl053lje1moRmLQHsXqdRVAHesPP1HtyDvHsheGCrs8WEy
         tnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UtCrT7/OSpWOMAYO1geobq/EXsQPSfaZpg6dw1dccJA=;
        b=2h1QAXSiqqkKAmxn2UBIvMSN684Y0Hs2CkmacjwDvFJs/wQQSTD0WwBIvxxdc9oOAW
         tCsEhu9raTLIkmpJ5u77XBoJgvaanezJwPRLUzjQP4SiaRtrU3lui5TjkQAjbif3fbfC
         jgD3jRBUVrAN/iRFRwWkbPP/+U02DHzAQ1DyXZBw1hcxMGr3WSQiQSmX+AW7+MmXgFTn
         5yZmw1q28PHhimmEjpJQH1XlyM/HJWMElU7oMyf9//laiXGFrkxftIHKcnBnsSMCDKK3
         Fvy3yaljHZ/0VOBRYf0yIxtlsnahWZ3UNsOIIhIOAwOsUqrH0HSvd6jJB8BG5H37oRXi
         qAjQ==
X-Gm-Message-State: AOAM533FGIXK6hWFkY2H5jjzXsCbVrKIH3z+cLecsHZH2wjhIY3MBp60
        dLhrMWKFP0P95TuHd3cE60RmDunzgOl/WA==
X-Google-Smtp-Source: ABdhPJx/pXWT+ts25J0AmcdjjobsCtLNqf+Qxas8597jmmWX3smB+JCJmjVD1xbCjKpi1LxBs/Sy8w==
X-Received: by 2002:a17:902:9009:b0:156:8b7b:8e4 with SMTP id a9-20020a170902900900b001568b7b08e4mr18757641plp.100.1649421246902;
        Fri, 08 Apr 2022 05:34:06 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id co7-20020a17090afe8700b001caa0af5f8csm11818487pjb.37.2022.04.08.05.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 05:34:06 -0700 (PDT)
Message-ID: <25390602-cfa0-dba3-bfbc-a35ed6b44bcf@kernel.dk>
Date:   Fri, 8 Apr 2022 06:34:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] cdrom: do not print info list when there is no cdrom
 device
Content-Language: en-US
To:     Enze Li <lienze@kylinos.cn>, phil@philpotter.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20220408084221.1681592-1-lienze@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220408084221.1681592-1-lienze@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/22 2:42 AM, Enze Li wrote:
> There is no need to print a list of cdrom entries with blank info when
> no cdrom device exists.  With this patch applied, we get:
> 
> ================================================
> $ cat /proc/sys/dev/cdrom/info
> CD-ROM information, Id:cdrom.c 3.20 2003/12/17
> 
> No device found.
> 
> ================================================

And what did we get before?

Will this potentially break applications that parse it?

-- 
Jens Axboe

