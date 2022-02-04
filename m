Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F240AC433F5
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 13:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358699AbiBDNc3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiBDNc3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Feb 2022 08:32:29 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D22C061714
        for <linux-block@vger.kernel.org>; Fri,  4 Feb 2022 05:32:29 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id h125so5053917pgc.3
        for <linux-block@vger.kernel.org>; Fri, 04 Feb 2022 05:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UbGuJT+82u/r5OVFIMOVDfayUzP0EGS/g4aR/lRMEDU=;
        b=tb319ZxJaT2G2jEsLg001lXCi1v5OjI0tcX3tYb96s6yhPSV74Av/Fmqv0P0FhrD7G
         s2KWFILCJ5Oe0/99QkM+8m8DWTGV1SDpUTKkSEDRGLnXb7mFRWlTwa9OyG+pZVFThbUg
         rYfdGtniBA03bJjxGVdaQl6ucJZuNbaP7KhiG9fD1L61EpDe3plJ3LfLi9tciIE5Iv7a
         mVRSxtjXq27G3q1MSzQc7EMJ3TBmmwQDnV0PsyF6L/Pih5jw/Bz24fS+cxAnAe5pbEeD
         2zG+kzzIf0gF2GH7cIe7EgjqwptmQB9eylyoXBg9MZBZ+fmNMejHy8r7jHrrx4IhOgwi
         HcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UbGuJT+82u/r5OVFIMOVDfayUzP0EGS/g4aR/lRMEDU=;
        b=20mNAPQs6NthuA/ILLK+STgcVv/rAx5zvgPW50Z76JdnPuNrCq3wE9xybwKmkchDvC
         E3BY0BjwtUZgcgR1E4qpi1KeN4Ik6SX5jmuYcTmIph+h7NfULn2kzuWvfHSM740QdEil
         2ncr0R8yNbQnKDWCY+cLK7KbAta80lYKPw1JEsmL65F+0QMVQIUcsYrRgwOgpYN6wKNP
         IG39Kfnkm9XqJVIYHB/A2EKHPGzYX3ELJmRG9aij+lhCTRvX4Sev3Q0z5t6IJUmkCrP6
         A4sn+Ft1ebH0uj49WXqLlsM9B8qKADZTn2TZoy+uDyhnx3BTFUHKoH8vIyCmhK6OAOA0
         mRZw==
X-Gm-Message-State: AOAM531EYOJVWCQ7de2dDWu5pyPi3FZXFklFXUCpKtgZwVEilW6g/qjD
        7Du3P2PPDvlMyPGxa4SN2wocDw==
X-Google-Smtp-Source: ABdhPJwqTE9JG+YJdZ4CiM388CYHQbBhyS5L72K7Y633EUO/ynw8J+ru2L9V+JSjCIgU1JgykhkwhQ==
X-Received: by 2002:a63:f711:: with SMTP id x17mr2395738pgh.274.1643981548461;
        Fri, 04 Feb 2022 05:32:28 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o5sm2727140pfk.172.2022.02.04.05.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 05:32:28 -0800 (PST)
Subject: Re: Partial direct-io loop regression in 5.17-rc
To:     Milan Broz <gmazyland@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Kozina <okozina@redhat.com>
References: <feb7e4b4-1a6f-71a7-0cdd-fda547408bea@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <08e1dbde-b27c-fd99-294c-8e4715b92576@kernel.dk>
Date:   Fri, 4 Feb 2022 06:32:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <feb7e4b4-1a6f-71a7-0cdd-fda547408bea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/22 2:22 AM, Milan Broz wrote:
> Hi Jens,
> 
> It seems that there is a regression in direct-io over loop for partial
> direct-io reads (or perhaps even for other situations).
> 
> If I run this code (loop over 6M file, dd direct-io read with 4M blocks)
> 
> IMG=tst.img
> LOOP=/dev/loop66
> 
> truncate -s 6M $IMG
> losetup $LOOP $IMG
> dd if=$LOOP of=/dev/null bs=4M iflag=direct
> losetup -d $LOOP
> 
> 
> on older kernel (<=5.16) it reads the whole file
>    6291456 bytes (6.3 MB, 6.0 MiB) copied, 0.201591 s, 31.2 MB/s
> 
> 
> while on 5.17-rc (tested on today/s Linus' git) it reads only the full blocks:
>    4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.201904 s, 20.8 MB/s
> 
> No error reported, exit code is 0.

Can you try:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.17&id=3e1f941dd9f33776b3df4e30f741fe445ff773f3

-- 
Jens Axboe

