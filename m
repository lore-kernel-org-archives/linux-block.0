Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6320EECAAD3
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 14:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiIAOL5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 10:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiIAOL4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 10:11:56 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F35B5FF69
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 07:11:56 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r141so14652955iod.4
        for <linux-block@vger.kernel.org>; Thu, 01 Sep 2022 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SfrvPUeDfSxsB+ZYct4Y42o1R68SAbwKiDdGA0lYRRs=;
        b=z2iEwOE80S0iG313rO+YNUbFY2tCEJHk3q0I/NYmABlyEEIw0uxCMd1J7K4kkpuxBy
         VlVT9TlzPcv3jpBqqDHf6Nvamb+BMWwbv7xTtMNjBiFhrGI+ugH7lXwBmT8hiQfHM7pm
         h9523/uw3V0aAKQ15xjN+kwoecOcTw8Z6eKAyLKlhuhv5cQKWaZE8XQsYN4svZ+vL9oM
         BYg5JZUiXGum2Bmh1OJXvDixzRfb+a+8PbZRVdciFC8lDJn0CEzv7GnaW+9wgGX/o+Yq
         +fBrwHWWnCJ/BH4uMz/dD7R+mVnWsJ7Ydgu1oP9rXBdjBUjZSmbKMqMhDoc0ascJZqFa
         4RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SfrvPUeDfSxsB+ZYct4Y42o1R68SAbwKiDdGA0lYRRs=;
        b=djzlqwQPImXgITU/IOJ2gzbDEbaTV6nXFcW5G7Tnm8wAMdoRy31O8nNYRI1fb2H3pO
         SmIHLF1nCOluQX/BxI3ZKi96OWJe3aD4FIxt6XnVM647/TL0u9+EnPklD1E/HhzQzYO1
         sXqWXmrRZO3l9SFRCpy078l31PfEwWcGCuJfkDW6QCY8iCtb0o+Va1g720ey9oDTXUYn
         T5gYmKds0fEcLxjNKsHGeob7etg/KvDQ4Eoc3b6CRGV0AmvPSDMV73bsiQm1mKc+ZTU6
         oquR7xLRy25/3X/tdzeM8K8owzg7iQUgqcosuWl9QjWc7gerHVn/fxIkfPH01xxJFp6U
         yRQw==
X-Gm-Message-State: ACgBeo2WSjR9EUz2cyEDQ06Ac2zIZWm1vg+vDjXexSx1bb+BzsizmHe+
        vOVXQQPhf8N1ll3z/OJlK/PS9Q==
X-Google-Smtp-Source: AA6agR4ABVcTUn7sukr/ebvuT1Cz3/kWBYqX1W4p7pAaTobOVZY+FrD/Gmw5BomPJooa/AUJlosY8g==
X-Received: by 2002:a05:6602:26d5:b0:68a:db5d:2923 with SMTP id g21-20020a05660226d500b0068adb5d2923mr14861253ioo.175.1662041515212;
        Thu, 01 Sep 2022 07:11:55 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i37-20020a056638382500b00339ef592279sm8017661jav.127.2022.09.01.07.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 07:11:48 -0700 (PDT)
Message-ID: <acb80792-99e8-1e89-2972-3878154c1677@kernel.dk>
Date:   Thu, 1 Sep 2022 08:11:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [GIT PULL] nvme fixes for Linux 6.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YxBfb38kb18Im/QB@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YxBfb38kb18Im/QB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/22 1:29 AM, Christoph Hellwig wrote:
> The following changes since commit 645b5ed871f408c9826a61276b97ea14048d439c:
> 
>   Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.0 (2022-08-24 13:58:37 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-01

Pulled, thanks.

-- 
Jens Axboe


