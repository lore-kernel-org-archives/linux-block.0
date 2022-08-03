Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D13C19F2C
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 17:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiHCRpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiHCRpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 13:45:19 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B5B38AB
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 10:45:17 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id v185so13419356ioe.11
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cCa6whmId6dF3acTHi27XWGZTH5tqgXRKV00ptgBDiM=;
        b=NCFYUx2CramenoYYkbecLhpPuYA3L6JwEZw4o20j+7WcSZxW7xAqhPnxVDATAb8Snn
         vlO6GAsBFLVu/pHKBR6rqG/NjsQEL5IkIClkupuI3U4r5rhshRWh+Rb6gUvGn1L6shVK
         0s8+FVskFI1czDchWHPnsP6UJfAPb+NpAgoeJQmscqFbi5r/BWZgWntUxd1c+oFSmMa7
         AOiJoRm2QU+PSK18IFf0QXGzAgLEPh2UOWmnT3H/qTxWZ8ow3nMMTkO5mz9IJzh3nHaA
         aKPBNKtsYrxBxw5W9I6JEO5aNGFtPydS9Q94qdd1XtvgotVutwf1uoAK8LY5Qxc+CuFI
         yYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cCa6whmId6dF3acTHi27XWGZTH5tqgXRKV00ptgBDiM=;
        b=JEjhvPjj2DoWE2N40vkh/95qWL0cQPcaaU/ASmiInjcQAUUv5w4/qg1qLCsT75jCey
         FyeP/O1BFg3dtnToiJenFHXStCxrja/vZP9eKF9AgMegHBJEX7YxIEiCXo5Cjj9pET8R
         +YKHxP5MjckrZ+fUf+1nMEnSSQti9yaA7h0divwHF9ZIzh9B+rfFD25I90ja0lbb0LNI
         yX/wnr0S0EwAj6+297j2T9blGopPwVcAJpUca324PjETBDFCHAWc/owxMUMecRl2ne41
         vOKyXDRH5ODM7zkFC5+Io2nWRP0QqNkRILk22U9gMJHYN1t6ZVMnsfiUCRVadKv1JfRU
         iK2g==
X-Gm-Message-State: AJIora/wUhnSexh+5WRuGWtG0X3kuP9FqaZsGKEtyo+VCmHTGTjsnlOW
        AVJkdbimqGejnajUi/73PvXHRA==
X-Google-Smtp-Source: AGRyM1s409bWsgpV+qWa19IaLv1KZR1cXa2Lf/XICsDZX+RwPZEvvleicFQ0e1KEJk7jxJVpDi2tDg==
X-Received: by 2002:a05:6638:d15:b0:341:5ea1:5716 with SMTP id q21-20020a0566380d1500b003415ea15716mr11018085jaj.158.1659548717183;
        Wed, 03 Aug 2022 10:45:17 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x39-20020a0294aa000000b0033f11276715sm8088078jah.132.2022.08.03.10.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:45:16 -0700 (PDT)
Message-ID: <65d2a122-ef68-a6bc-44e8-bb21ad7b9255@kernel.dk>
Date:   Wed, 3 Aug 2022 11:45:15 -0600
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
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
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
 <552201a1-2248-b16e-1118-54373531a158@kernel.dk>
 <CAKwvOdm3RE14sNrKX9OS-2YrSjEgmq2VqZwXjRQ+yTUXR1FzNQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAKwvOdm3RE14sNrKX9OS-2YrSjEgmq2VqZwXjRQ+yTUXR1FzNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/22 11:38 AM, Nick Desaulniers wrote:
> On Wed, Aug 3, 2022 at 9:53 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/3/22 10:51 AM, Nick Desaulniers wrote:
>>> On Wed, Aug 3, 2022 at 9:26 AM Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>>
>>>> On Wed, Aug 3, 2022 at 8:16 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>> On the topic of warnings, on my new build box I get a lot of these:
>>>>>
>>>>> ld: warning: arch/x86/lib/putuser.o: missing .note.GNU-stack section implies executable stack
>>>>> ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>>>>>
>>>>> which ends up polluting the output quite a bit.
>>>>>
>>>>> axboe@r7525 ~> ld --version
>>>>> GNU ld (GNU Binutils for Debian) 2.38.90.20220713
>>>>
>>>> Ok, I have binutils 2.37, so it may be new to 2.38.
>>>>
>>>> Some googling around seems to imply that we'd need to so something like this
>>>>
>>>>    .section .note.GNU-stack,"",%progbits
>>>>
>>>> in all our *.S files.
>>>>
>>>> We do have some signs of that in our tooling, because apparently it
>>>> has hit user-space, but I wonder what has triggered the need on the
>>>> kernel side for you.
>>>>
>>>> I'd hate to add that pointless line to every asm file, but maybe we
>>>> could so something like this
>>>>
>>>>    #ifdef __ASSEMBLY_
>>>>    #ifdef OUTPUT_PROGBITS
>>>>       .section .note.GNU-stack,"",%progbits
>>>>       #undef OUTPUT_PROGBITS
>>>>    #endif
>>>>    #endif
>>>>
>>>> and then change our 'AS' command line to do '-DOUTPUT_PROGBITS' in our
>>>> makefiles.
>>>>
>>>> *Most* asm files should include <linux/linkage.h> just for all the
>>>> macros that declare variables externally, so that might catch the bulk
>>>> of it.
>>>>
>>>> Somebody who knows the rules better than I would be a good idea.
>>>
>>> $ as --help | grep exec
>>>   --execstack             require executable stack for this object
>>>   --noexecstack           don't require executable stack for this object
>>>   --statistics            print various measured statistics from execution
>>>
>>> Does adding `--noexecstack` to KBUILD_ASFLAGS for these architectures
>>> help, rather than modifying every assembler source?
>>
>> I can try whatever here, but a quick grep doesn't find anything for
>> KBUILD_ASFLAGS or anything close to it. What am I missing?
> 
> Sorry, I'm running between many meetings today...so suggestions aren't
> tested and may not be fully coherent...
> 
> KBUILD_AFLAGS += -Wa,--noexecstack
> 
> There's also as-option Make macro in case older binutils doesn't
> support that flag outright.
> 
> tools/perf/Makefile.config also uses noexecstack as a linker flag.
> That might be an option, too.  It is the linker producing the
> warnings, not the assembler, but the assembler flag is probably the
> way to go to fix the warnings since it sounds like these are assembler
> sources exclusively causing the issue.

I ran with the below and it silences the linker warning mentioned. I do
also see the below with my build (which aren't new with the option added
obviously, but not visible since I don't get the other noise):

axboe@r7525 ~/gi/linux-block (test)> time make -j256 -s                      1.886s
ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
ld: warning: vmlinux has a LOAD segment with RWX permissions
ld: warning: arch/x86/boot/compressed/efi_thunk_64.o: missing .note.GNU-stack section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
ld: warning: arch/x86/boot/compressed/vmlinux has a LOAD segment with RWX permissions
ld: warning: arch/x86/boot/pmjump.o: missing .note.GNU-stack section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
ld: warning: arch/x86/boot/setup.elf has a LOAD segment with RWX permissions


diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 7854685c5f25..51824528a026 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -123,6 +123,7 @@ else
         CHECKFLAGS += -D__x86_64__
 
         KBUILD_AFLAGS += -m64
+        KBUILD_AFLAGS += -Wa,--noexecstack
         KBUILD_CFLAGS += -m64
 
         # Align jump targets to 1 byte, not the default 16 bytes:

-- 
Jens Axboe

