Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A97C25B06
	for <linux-block@archiver.kernel.org>; Thu,  4 Aug 2022 16:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiHDQSE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiHDQSD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Aug 2022 12:18:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE61A81D
        for <linux-block@vger.kernel.org>; Thu,  4 Aug 2022 09:18:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d16so270601pll.11
        for <linux-block@vger.kernel.org>; Thu, 04 Aug 2022 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CoYaedw+lAJX94EUMIqZNcixB4zlifv7m7f02NP8udU=;
        b=1tdGe1QZsuD/5c0Y+OIBaog3p5SfDXhzqTMQxQoywmPz3bnf0v1P5rqBIy34GVYh8q
         rWQEoPYreFCRtSzdD6ZKFJ8Sw1r99OuhPrQM9z96rcSCQWQoZ8+WTB3ST4nQmGiHngNW
         +djSylA7HAlqkakgXyNz25AWEYiyP1LnAT7OjHSHG8Rd++oiWfkrPY77MUsrstsX/1l2
         7Y0yVJrseVjp/qbL5Iq2ip7Pg3oVMOf5yPVBaCtGU8YG9t7E5MinPz2HCkbLmWNlXkXK
         6/nxr1FD9Me2V0BAT67x1k1k/4teJ5iVinjZ2Ci6eSYDqd2DChJ6jpaLquuHLT5LtoEt
         T6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CoYaedw+lAJX94EUMIqZNcixB4zlifv7m7f02NP8udU=;
        b=dbMosOM/BC0/SknnQY5wqUxxL06PAjDcwAVRUfWdwgx/xo3DYypsXMbiDeLR6CPe4d
         5ngMrJRkMV7zPYRz/1bVGfKouINPM3K/x85kK0c+uC0cVjmIwN4RoFCyE+9Q9TPxhUCV
         M/rfrt8P/iUoYW9lGsHcne6/vW/shi6WKkskhMuNfXnqLPo8A7FpgX/Z747PuR5szktw
         p4euLAwr0NmsbEquh1DcDQ2o/SnC6sF8YTcajKeQG0tKySpxaHZp6Wzr44DVmSxGTuRS
         18bsUCzkHAO3CmPNTAaL2DxIXFmQfKne0WQ7tL7IO/da1dE1TEO91ndt8RIo2LiN8avm
         czVg==
X-Gm-Message-State: ACgBeo1qjOTAS2XaxBFrx+UA7jFev3zgOoVTY29p5R8UsFXWVQ0Sh1Li
        vm2O4fNxSWhRFkI3QcPr2ovnag==
X-Google-Smtp-Source: AA6agR6xKDJ05PHUxroFDJ0Ib0IZ+CY0dZu6jmD/5zExLoSQ5H5+qY8ciJNvg1AjV1dip5s7gwZjdg==
X-Received: by 2002:a17:90a:d783:b0:1f4:e30b:ece with SMTP id z3-20020a17090ad78300b001f4e30b0ecemr2918019pju.165.1659629881743;
        Thu, 04 Aug 2022 09:18:01 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d138-20020a621d90000000b0052d82ce65a9sm1194474pfd.143.2022.08.04.09.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 09:18:01 -0700 (PDT)
Message-ID: <69b3bb50-e07f-cd7d-ff10-01856dd50053@kernel.dk>
Date:   Thu, 4 Aug 2022 10:17:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk>
 <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
 <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk>
 <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
 <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk>
 <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
 <c1b1b619-9142-9818-0536-ce4b97d3e979@kernel.dk>
 <3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk>
 <CAHk-=whx-CA1QpFc_6587OmiJHb5+OYDR9aRQQh6=06oJWZG8Q@mail.gmail.com>
 <CAKwvOdkpNRvD0kDe-j8N0Gkq+1Fdhd6=z-9ROm3gc12Sf0k-Kg@mail.gmail.com>
 <552201a1-2248-b16e-1118-54373531a158@kernel.dk>
 <CAKwvOdm3RE14sNrKX9OS-2YrSjEgmq2VqZwXjRQ+yTUXR1FzNQ@mail.gmail.com>
 <65d2a122-ef68-a6bc-44e8-bb21ad7b9255@kernel.dk>
 <CAKwvOdmD10yK0r1H-M2PcnZgy3M0aA9gdkY0BErDOQ+KpBRxVQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAKwvOdmD10yK0r1H-M2PcnZgy3M0aA9gdkY0BErDOQ+KpBRxVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/22 12:06 PM, Nick Desaulniers wrote:
>> ld: warning: arch/x86/boot/compressed/efi_thunk_64.o: missing .note.GNU-stack section implies executable stack
>> ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> 
> Right, arch/x86/boot/compressed (and arch/x86/boot/) discard/reset
> KBUILD_AFLAGS (via the := assignment operator).
> 
> So arch/x86/boot/Makefile and arch/x86/boot/compressed/Makefile also
> will need changes similar to the one you did below.
> 
> Finally, if those parts of the code actually expect the stack to be
> executable (probably depends on some inline asm), I suspect we might
> get some kind of fault at runtime (though I don't know how the kernel
> handles segment permissions or even uses ELF segments).  Point being
> that -Wa,--noexecstack is somewhat a promise that we wont try to
> execute data on the stack as if it were code.  -Wa,--execstack is
> useful if we need to be able to do so, but we should be careful to
> limit that to individual translation units if they really truly need
> that.  The linker warning is more so about the current ambiguity since
> if the implicit default changes in the future, that could break code.
> Better for us to be explicit here, and disable executable stack unless
> strictly necessary and only as necessary IMO.  Personally, I think the
> current implicit default is wrong, but pragmatically I recognize that
> people have been used to the status quo for years, and changing it
> could break existing codebases.
> 
> If you send the below diff with the two other additions I suggest to
> the x86 ML, the x86 maintainers might be able to comment if they're
> familiar with any possible cases where the stack is expected to be
> executable.

I'd be happy for you to take this over, I'm really just the reporter
here...

-- 
Jens Axboe

