Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAA6C19F28
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 16:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbiHCQxp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiHCQxp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 12:53:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5279EAE49
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 09:53:44 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r70so13318181iod.10
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xhlaoyM1TQw3fGeI9lR+8PTOEyKHtRm9oJiFvGxfTUA=;
        b=lKrCGNn4F1+MkTeeVNzSRlbLO3fKvkIbP4jfYEGCyftmMA4+s39HBl5g2vrdP/+gj+
         B2N6aUtw4xbNiNumzpgbVcqYIpFDhiNc83HcKd4v+IJYXR1AkGfoEIawSw6vd2x8LpQZ
         Ikgx76K2a/v2MU2V1YmbnhekWL2kAzxBHgHu3X/cCCdv+DItSIs+G6cdSEbRpe1luQXF
         5H7zReAU/yTcWSxXhyn95x5IEXWjY8HQYOUHRfsEAeDx/bJmIAI93hEfMYLJUMg6e8qM
         tFKZb6H2ENnfUQQccPmRXZ7j6lU2zTOb4fQalBRKEGtU7TzU199WeovIvoJJeD8JnwgL
         5e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xhlaoyM1TQw3fGeI9lR+8PTOEyKHtRm9oJiFvGxfTUA=;
        b=lqTnJUiOPf/8ao6I5rlkTfsTdDJDeuxMDwPgLknoAZlTNLw5RzYaB5uUzYAEG84PIg
         p2W6rh+kimQ+S1HFAFSb+UgvASJHQ4KUEt4mciOOElabtgtW8H2/hsDgOxQW87PebTT0
         IUf2XHKtnWp9mXS7tj3FytmOmVawYU7MldfryA1TwDQ/L8Py9KVEo0EUuZ9eKV9+94ye
         4Ub3I8dmjqDdLC9g5icuP0LQQBXRDMZbus/rvOfruGZgPqsiM7woejQRzN/KCLxIhyYC
         IGWBsClcWGY0OtdbO2Jb38P4pZfIanM7QDf0vOAaloScV7xVoo41hlZQKTNnWhyT9Xpj
         VVtA==
X-Gm-Message-State: AJIora+/KeT7ErtPTPSSvdhj+LqAqFlBY3mvww2poZqfl83joYzD9sMU
        766d1teqQhFBq8Fj0UtSB7goww==
X-Google-Smtp-Source: AGRyM1uria7FNt42yVHkQ/eSHteL5k+pkHGhg25zsoBO7b0RmY9OGTQmZx3zszk2/EtGLqx7mSR+Ow==
X-Received: by 2002:a02:238b:0:b0:33f:4ccb:3139 with SMTP id u133-20020a02238b000000b0033f4ccb3139mr10960060jau.20.1659545623677;
        Wed, 03 Aug 2022 09:53:43 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y19-20020a02bb13000000b00342711481c5sm4602312jan.111.2022.08.03.09.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 09:53:43 -0700 (PDT)
Message-ID: <552201a1-2248-b16e-1118-54373531a158@kernel.dk>
Date:   Wed, 3 Aug 2022 10:53:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
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
 <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk>
 <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
 <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk>
 <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
 <c1b1b619-9142-9818-0536-ce4b97d3e979@kernel.dk>
 <3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk>
 <CAHk-=whx-CA1QpFc_6587OmiJHb5+OYDR9aRQQh6=06oJWZG8Q@mail.gmail.com>
 <CAKwvOdkpNRvD0kDe-j8N0Gkq+1Fdhd6=z-9ROm3gc12Sf0k-Kg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAKwvOdkpNRvD0kDe-j8N0Gkq+1Fdhd6=z-9ROm3gc12Sf0k-Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/22 10:51 AM, Nick Desaulniers wrote:
> On Wed, Aug 3, 2022 at 9:26 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Wed, Aug 3, 2022 at 8:16 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On the topic of warnings, on my new build box I get a lot of these:
>>>
>>> ld: warning: arch/x86/lib/putuser.o: missing .note.GNU-stack section implies executable stack
>>> ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>>>
>>> which ends up polluting the output quite a bit.
>>>
>>> axboe@r7525 ~> ld --version
>>> GNU ld (GNU Binutils for Debian) 2.38.90.20220713
>>
>> Ok, I have binutils 2.37, so it may be new to 2.38.
>>
>> Some googling around seems to imply that we'd need to so something like this
>>
>>    .section .note.GNU-stack,"",%progbits
>>
>> in all our *.S files.
>>
>> We do have some signs of that in our tooling, because apparently it
>> has hit user-space, but I wonder what has triggered the need on the
>> kernel side for you.
>>
>> I'd hate to add that pointless line to every asm file, but maybe we
>> could so something like this
>>
>>    #ifdef __ASSEMBLY_
>>    #ifdef OUTPUT_PROGBITS
>>       .section .note.GNU-stack,"",%progbits
>>       #undef OUTPUT_PROGBITS
>>    #endif
>>    #endif
>>
>> and then change our 'AS' command line to do '-DOUTPUT_PROGBITS' in our
>> makefiles.
>>
>> *Most* asm files should include <linux/linkage.h> just for all the
>> macros that declare variables externally, so that might catch the bulk
>> of it.
>>
>> Somebody who knows the rules better than I would be a good idea.
> 
> $ as --help | grep exec
>   --execstack             require executable stack for this object
>   --noexecstack           don't require executable stack for this object
>   --statistics            print various measured statistics from execution
> 
> Does adding `--noexecstack` to KBUILD_ASFLAGS for these architectures
> help, rather than modifying every assembler source?

I can try whatever here, but a quick grep doesn't find anything for
KBUILD_ASFLAGS or anything close to it. What am I missing?

-- 
Jens Axboe

