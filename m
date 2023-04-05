Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8709CC7619A
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 16:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjDEQqh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjDEQqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 12:46:36 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B34440C9
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 09:46:33 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-75d1e0ff8ecso1103939f.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680713193; x=1683305193;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzDRh3J+8SvEaXn0A+6OwXdLsL1cECKaJ2d44EZkMv8=;
        b=cvI9QcotuV/WktpPWLiG9q4P4hb+fv6+L6fSPKWafHE+/Rha1cywCFPBTcxcs7VOfF
         N2ouY2O52fIxorXrYcHLYhkSGr5sQ1qOJw8wE+22T7X5px1V2h0oDQtykbM00fv+er7Y
         ciNCEt6vEUY3Ost7gBNPDhWIpDUWZrJ2f7UQ7gmXcxcDWUzSvUWcTaAn4zEZf7xmmHQ5
         JuyZih1ualPwJ4GOudcl4LRQ/+nICcjsA1Ne1W9BLHY1ePAq4HJQMeWlv1hV5wlFfj9j
         9HONukPaW9BEyzUlrOr7RjHnP0crt4tssSxH+GSgSZEv3keTR95daTnBl1Zq72l143Gf
         cA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680713193; x=1683305193;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzDRh3J+8SvEaXn0A+6OwXdLsL1cECKaJ2d44EZkMv8=;
        b=KZ7e+3BO7TAlSK7b33F6VMuWhIHHro/L3GUXoGj0GlTaKtMU0NIMdYnPqXHMS8xxW0
         ppBettiSSgbq6Gt42XWHC234vPL3ZdtXbqkXb6XXiPN+Bfk1YYOBF1r6LzdwJ25WGkOM
         lRJ+t+BZohY5vq48UsgaBN1fP7h2Pa2Qz6+096IDeKUlmB4lxScvep/kKZdynD7I7ZTk
         pS4UwEvc3g7ilookh6uDc/GAfcD60anjy0V1GbkLfc/0V1e28bCOBQKaV+Ef9ijxLLXY
         PNgJv5qBPA2kH7zLBlHUVsWKsbwvRVNeJuZDpSqm/NogT+BLQZ41RExMFeZmBmlIY6CK
         rjaQ==
X-Gm-Message-State: AAQBX9eaI9hYLHCIfHi+OZuZAWvyIavvnd6ErPb03XEDdWJ25N/4DbaC
        SYj3FFFqey/7EpOYLMx6sTosdw==
X-Google-Smtp-Source: AKy350Zpwf9mFVQTQK0zdVakkitvp5e+RlJjveBB+ifhwqXu+VbfbTE1RvfDJdPOPfDc5Uo0oYEAHQ==
X-Received: by 2002:a92:7d04:0:b0:313:fb1b:2f86 with SMTP id y4-20020a927d04000000b00313fb1b2f86mr1403917ilc.0.1680713192956;
        Wed, 05 Apr 2023 09:46:32 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 19-20020a921813000000b00326ca02f30dsm800189ily.65.2023.04.05.09.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:46:32 -0700 (PDT)
Message-ID: <aae10acf-7567-48e9-37b5-12db6a69719e@kernel.dk>
Date:   Wed, 5 Apr 2023 10:46:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: kernel BUG in find_lock_entries
Content-Language: en-US
To:     "Dae R. Jeong" <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZC1S_f9nworAQpm_@dragonet>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZC1S_f9nworAQpm_@dragonet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/23 4:52 AM, Dae R. Jeong wrote:
> Hi,
> 
> We observed an issue "kernel BUG in find_lock_entries". This was
> observed a few months ago.
> 
> Unfortunately, we have not found a reproducer for the crash yet. We
> will inform you if we have any update on this crash.
> 
> Detailed crash information is attached below.
> 
> Best regards,
> Dae R. Jeong
> 
> -----
> - Kernel version:
> 6.0-rc7

This is pretty old. Does it trigger on a current kernel?

-- 
Jens Axboe


