Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0774C6FD1D
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 19:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCQTob (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCQTo1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 15:44:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D469319C54
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 12:44:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q14so3767113pff.10
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679082265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8lKPbpLU+chXYXEC1Z4Ckd3t5BR5yXaSbXWEnS6P9M=;
        b=qrGvPbZVywlf3hSmh6XLLhT02WKUR8q1JkH46+OKDAWEldQPRJvAaRo5S2IXtRS+Ll
         J9r/Xxpn0r+y5sXjuJpXu5nGTRfZ4sA+BcvzeMzGKmF9VAIppQb9ur9W5nw4ichknz4k
         GbVMQG/Nj+lH/+jofeLShfoXw6hXJtkYNF5JF9bDYYWvhsVjPnpnrZVbAyeZ+m8Uo/rW
         j6Zw9mXjsqUPcASKox6a95B+Z/KVtEhl3Swjj4u9BJ7LLSsxdUEQ13OEA7BFbAx82BPw
         9RE/V3V7fCUEjwPNixgVIdA+tKchjBn0L/qz6JwNwKHA4tAzlOmufmHPx3GWZsvRcoby
         a+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679082265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8lKPbpLU+chXYXEC1Z4Ckd3t5BR5yXaSbXWEnS6P9M=;
        b=LscOyEbV52dkKoR+t4wm4nYRUjsWnLR54MgIpQuYjTSWt3dbe8M4jN80UEcrXM9h7z
         tde0K8cnT/xPGKhvkGWJGqo8m3Na58BrZ1RKP2SHzjLbK7S7p0UZvIPtZo/EQUoS16qv
         kc1saO5HygGR6LPdBk2Yk4hgPf6WB8DstpaBdhyJVjk0ui8qgS2tZbcSCWr86OqEu4GC
         REt17p45bh4HJb80DIiXbxK8ei0monN0mXPWfOkbQsk2rkr95zlIPXy6yu8D3pocJ/bE
         bePm5ZApN3zsWHAkoFrSXx3DCB8tcMysxuHOKOmolAUtaTPWwzJg87Y2eOIP8kruct5r
         z3GQ==
X-Gm-Message-State: AO0yUKVbZ7WWsznnGvmHMXpyRahCCXS37maat3U0pN2Ahe5HjHAWWSK1
        GspMzM3IL6J/9SQ28JFbQGDIHw==
X-Google-Smtp-Source: AK7set8JBs+bLZQ54Eqj/erf1PfB0MmniZhIm38M38Xz2ZBzX5DdW8G/tmm5Dmqgc+T/qcg9nncIAQ==
X-Received: by 2002:a05:6a00:e0e:b0:626:62f:38d8 with SMTP id bq14-20020a056a000e0e00b00626062f38d8mr5980804pfb.3.1679082265068;
        Fri, 17 Mar 2023 12:44:25 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t14-20020a6549ce000000b005038291e5cbsm1826565pgs.35.2023.03.17.12.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 12:44:24 -0700 (PDT)
Message-ID: <93d41a6d-47f3-962b-dd71-5bb0ab9c6e4e@kernel.dk>
Date:   Fri, 17 Mar 2023 13:44:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/23 12:35?PM, Linus Torvalds wrote:
> On Fri, Mar 17, 2023 at 10:16?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> - blk-mq SRCU fix for BLK_MQ_F_BLOCKING devices (Christ)
> 
> Christ indeed.
> 
> But I think you meant "Chris".

Oops yes indeed, good catch. Though I'd love to think that if we did
have a resurrection of that nature, blk-mq would be high on the list of
things to hack on.

>> Side note - when doing the usual allmodconfig builds with gcc-12 and
>> clang before sending them out, for the latter I see this warning being
>> spewed with clang-15:
>>
>> drivers/media/i2c/m5mols/m5mols.o: warning: objtool: m5mols_set_fmt() falls through to next function m5mols_get_frame_desc()
>>
>> Obviously not related to my changes, but mentioning it in case it has
>> been missed as I know you love squeaky clean builds :-). Doesn't happen
>> with clang-14.
> 
> Hmm. I have clang-15 too, but I do the allmodconfig builds with gcc,
> and only my own "normal config" builds with clang.

I just do both to avoid anything odd, it's just a few min each.

> So I don't see this particular issue and my builds are still squeaky clean.
> 
> That said, when I explicitly try that allmodconfig thing with clang, I
> can see it too. And the reason seems to be something we've seen
> before: UBSAN functions being considered non-return by clang, so clang
> generates code like this:
> 
>    ....
> .LBB24_3:
>         callq   __sanitizer_cov_trace_pc@PLT
>         movl    $2, %esi
>         movq    $.L__unnamed_3, %rdi
>         callq   __ubsan_handle_out_of_bounds
> .Lfunc_end24:
>         .size   m5mols_set_fmt, .Lfunc_end24-m5mols_set_fmt
> 
> ie the last thing in that m5mols_set_fmt() function is a call to
> __ubsan_handle_out_of_bounds, and then it "falls through" to the next
> function.
> 
> And yes, I absolutely *detest* how clang does that. Not only does it
> cause objtool sanity checking issues, it fundamentally means that we
> can never treat UBSAN warnings as warnings. They are always fatal.
> 
> This is a *huge* clang mis-feature, and I forget what we decided last
> that we saw it.

Gotcha, thanks for digging into that. I must admit I didn't look any
further at it, but figured it was worth reporting...

-- 
Jens Axboe

