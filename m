Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB8BC00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 22:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiHBWdR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiHBWdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 18:33:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9E9B41
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 15:33:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t2so14743228ply.2
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ivNoPYAMihvHSeX0TaEOQ/Sh3rskAq57Anpm0Krug8k=;
        b=25zW4On1a1nEw1cxQN7ZsVB47RTI06osXxZPAssV5zDIAmDHRIER0zyhff6J5304lx
         Exh50gGleccbsvt6kaTidxkXFDL4w53a5VQj3/zDMIO8gx8dntaaRC2l0g4uzc2+y5mm
         Gjo3W9FELsRPNXw6Qr/59TpD82FHAqWLLBFootGXaGIu0hhfiWB2Zh51bsac8YIEJBJe
         AOfqls2leYVZfdr9Sx9/7mM4L+rYgiVhIdrQOtnal/5y9bxiWwVN9S77/bzZjULBQrPT
         eL+9ABKDKV8ANGGFZlOzRa6W2ou2OCspUzl5bRpSs3I/EvHsCI6/xFK89XYn8Z0zbR1B
         DtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ivNoPYAMihvHSeX0TaEOQ/Sh3rskAq57Anpm0Krug8k=;
        b=o0eU5OPDOzMsXHK8oI0cz6KdNbIU07FqDGXsOfOGxxho4UEYeoENTVmKon7RBmcWnJ
         d9fqkOnmW7ywXoUJXMIaUIAHJXT7601TUCuK27YWT+SsXYwMiOR292CrcVRCyNstWA56
         IyEEeNJeRaqNBme7V8zgeT1RNE0GmL0nK8HkUiKdgjqiu6StJlKZ0H25B1iXkqNS47tI
         19ecN56OKMYAR9FZ7HuHd4iZ0VE+MJgxoVxUSiqYRyWxq75jwhgrpc+pZbFeRKnb8vvG
         f7ALs5A7WrwwwF64fmULQgndwZ5beE2ax1SQZ/uX/Fao7LPbpZ0P/+2363ZHuBZ1pFNF
         caoA==
X-Gm-Message-State: ACgBeo14852dt6+IK3KUe39sb1ewtrSbhuokNTdR0ROgtr7P0tq+UIXJ
        cD3KnoM7KEAOxaJQRcDNUNz5lg==
X-Google-Smtp-Source: AA6agR7I7winywWHtwTdTZetb/yI5eLZqdu8UsnW1BIKrA+IBcrx70VOWc9++zZ0uQvgbMW+Q6M8rw==
X-Received: by 2002:a17:90b:4a8f:b0:1f5:ee3:a6a1 with SMTP id lp15-20020a17090b4a8f00b001f50ee3a6a1mr1704169pjb.149.1659479594934;
        Tue, 02 Aug 2022 15:33:14 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l190-20020a6225c7000000b0052d98fbf8f3sm4419346pfl.56.2022.08.02.15.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:33:14 -0700 (PDT)
Message-ID: <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk>
Date:   Tue, 2 Aug 2022 16:33:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com>
 <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk>
 <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/22 4:27 PM, Linus Torvalds wrote:
> On Tue, Aug 2, 2022 at 3:24 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I take it this is only happening on clang, which is why I haven't seen
>> it as I don't compile with clang.
> 
> It happens both with clang-14.0 and with gcc-12.1.1.

gcc-12.1 is what I use, fwiw.

> And Keith says that the issue was apparently know about and fixed over
> two weeks ago.
> 
> So *somebody* knew about it, and fixed it, but apparently the people
> involved didn't bother informing upstream.
> 
> Regardless of what happened, it's not even remotely acceptable.

Agree, nobody told me about it, and that would've been nice to know.

-- 
Jens Axboe

