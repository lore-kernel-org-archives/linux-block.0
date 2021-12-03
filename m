Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CC7C433FE
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 13:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381145AbhLCNiO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381025AbhLCNiH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 08:38:07 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA9C061757
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 05:34:42 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id m15so3014970pgu.11
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 05:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Jw+1DAkEpMPquyy06OpnL80g0kP8AF6oi7t4fzPGrM=;
        b=L40QUGP+WuRlQNC85VC536NTQGpCq8l6b5iQfMvTFbzoiJhecLqqlDR78BWNKEWRpB
         ytbTeaFjxIWjLA6AiDZtFDujW3ZA8yp6wPly4m+wCMxmDagNu8+dOBCUctioCUWaTgnX
         wXECgUu5c2zH1UXDlfYjq5RGY6+xEE2rgArC9kXor8KKfbMCQ4bO+IcMBW/nYhs+00Az
         Z1OSYjtU6F8z/AIE/xTK4NQEg8qoP1TRg7gdTGIAJhMyouDVDbgEAtJ13+bWwDBzvczw
         fPB0UHa8vq09QnvBhJ9GrCCgqmJbpvavEC1mClFS1n2264K88mcwJIplZ/EPlB+nQrXP
         fpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Jw+1DAkEpMPquyy06OpnL80g0kP8AF6oi7t4fzPGrM=;
        b=mprxLeb7tyr+Ir1VpkQxTa4mX0mRAqCnTdCP+Zgy8ffjAki++6kuuBMEu6eCGkKdZL
         y1rFT8GYwEzfRwVsayvD+CyPj/Zx93rcXpe1KLgEqluPZwh1owUALdXv3VyKnouxGVea
         bavoMEza5Zvl3uKSAn0d/SmMwNAUXy7Lpx7lIRxv1PoHemv5w/S0fKjkwA/YL0liRuOI
         uC9eof43flfFwpDb8YekuwKiplaSc2tijOsLlQtOY8ug3ElKtMLRXnu/dweBPwUb+0aN
         M44DCmrM2BDfwPfXIGDZ8/1t6b055n3yKgAz8O1RRFNWzADbYMMNN9LU4UD18MrcwAzR
         qwiQ==
X-Gm-Message-State: AOAM530WsAID/Vi6tpDTZhQx50OKTgbFfv/aqXuoMgeVPtLccKmHEQ6t
        e07Srhm5B0yxMUVqEWfovQQDU5FQTSSJUeOw
X-Google-Smtp-Source: ABdhPJy0b1pn574F65BbUvvYUGrn7KOMvMD4CEOrTWzvIB929yMLeT60FzJf+ufpAlo+InrjY08eew==
X-Received: by 2002:a05:6a00:16c6:b0:4a8:261d:6013 with SMTP id l6-20020a056a0016c600b004a8261d6013mr18874970pfc.82.1638538482260;
        Fri, 03 Dec 2021 05:34:42 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j7sm3362607pfu.164.2021.12.03.05.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 05:34:41 -0800 (PST)
Subject: Re: [GIT PULL] Floppy patches for 5.17
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
References: <045df549-6805-0a02-a634-81aca7d98db5@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2272e5d7-aacf-46b4-9008-27776381c92b@kernel.dk>
Date:   Fri, 3 Dec 2021 06:34:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <045df549-6805-0a02-a634-81aca7d98db5@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 12:42 AM, Denis Efremov wrote:
> Hi Jens,
> 
> The following changes since commit 2bfdbe8b7ebd17b5331071071a910fbabc64b436:
> 
>   null_blk: allow zero poll queues (2021-12-02 19:57:47 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/evdenis/linux-floppy tags/floppy-for-5.17
> 
> for you to fetch changes up to 9fae059d4cd88229661b3eccb0409f723129e5bd:
> 
>   floppy: Add max size check for user space request (2021-12-03 09:54:34 +0300)
> 
> Please, pull

Pulled, thanks.

-- 
Jens Axboe

