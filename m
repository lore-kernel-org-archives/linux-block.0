Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADAFC43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 15:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiFZPmc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiFZPmb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 11:42:31 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABADFDFDD;
        Sun, 26 Jun 2022 08:42:30 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id r66so6898446pgr.2;
        Sun, 26 Jun 2022 08:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6CzsTVPb9sOdTz2NHINq2vECEmp32n5bp9Bleavk9Gk=;
        b=iKVK87wm1IsGqw0BnBICfV96xr7mc1quS5kNcLHZ4Y+96T5DQ1jN01ymmioQOQK7eW
         HDvF3cYvErBwhB5culrP1hKAzVm5UBskmxFxafv0PzZVfNSIN0jDN4OBR7lrPCq9eXtP
         0Dbcy7QQFidBrUrm15X2BCR/V+cq+HzEs8ItQ1JWf3Lpq9WjMNFTIJtMpMHEi+zhaooo
         9xKeFUhX6vZdjyJVSPXWoJV/BUlmNpgEX+rR6cfa2zqa9HZgB788FTQtip4TPT4z+mPJ
         +GUOy+d4mAnuVEPAf7Z9KlgVKvQ2awaxVf2klbX1AJ5WSLjX4g8KLGzH2pfz8kXJICQ0
         cDcQ==
X-Gm-Message-State: AJIora+v61vvmKe10kRp5okKaKAmI1QZ++g1OZko6o5MU1WS2WphtYbe
        U9h22L0dph5XzUbj9G55Cno=
X-Google-Smtp-Source: AGRyM1uMT+3VhdXiNPrBuiRQrvwxCUuf2Ze27ocZbWEcfEVDIj4qVCJVsUSANf/JutWsQilZWAlg3g==
X-Received: by 2002:a05:6a00:1305:b0:512:eb1e:7921 with SMTP id j5-20020a056a00130500b00512eb1e7921mr10019826pfu.13.1656258150006;
        Sun, 26 Jun 2022 08:42:30 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id p26-20020a634f5a000000b0040dfb0857a0sm188343pgl.78.2022.06.26.08.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 08:42:29 -0700 (PDT)
Message-ID: <a206782a-bd90-58cd-1e83-bb5988edb0f9@acm.org>
Date:   Sun, 26 Jun 2022 08:42:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Content-Language: en-US
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-sparse@vger.kernel.org
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-52-bvanassche@acm.org> <20220624045613.GA4505@lst.de>
 <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
 <20220625092349.GA23530@lst.de>
 <3eed7994-8de2-324d-c373-b6f4289a2734@acm.org>
 <20220626095814.7wtma47w4sph7dha@mail>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220626095814.7wtma47w4sph7dha@mail>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/26/22 02:58, Luc Van Oostenryck wrote:
> On Sat, Jun 25, 2022 at 05:44:54PM -0700, Bart Van Assche wrote:
>> On 6/25/22 02:23, Christoph Hellwig wrote:
>>> Yeah, that is a bit of a mess.  Rasmus, Steven - any good idea how
>>> we can make the trace even macros fit for sparse?  Maybe just drop the
>>> is_signed_type check for __CHECKER__ ?
> 
> I would strongly advise against this:
> -) the macro is sued elsewhere too (for overflow checking)
> -) sparse wouldn't check anymore the same code as the one seen by the
>     compiler
> 
> What about I would add to sparse something to strip away the bitwise/
> recover the underlying type? Something like __unbitwiseof() or
> __underlying_typeof() (some better name is needed)?
> 
> Implementing directly what's needed here, something like __is_signed_type()
> would be possible too but is a bit too specialized and so much less useful.

Another question is how to keep the non-sparse build working. Does
anyone want to comment on the following alternatives or propose another
alternative?

(1) sparse implements __strip_bitwise as a macro.

(in compiler.h)

#ifndef __strip_bitwise
#define __strip_bitwise(type) type
#endif

(in trace_events.h)

#define is_signed_type(type) ((__strip_bitwise(type))(-1) < (__strip_bitwise(type))1)

(2) sparse implements __strip_bitwise as an operator that works on types.

#ifdef __CHECKER__
#define is_signed_type(type) ((__strip_bitwise(type))(-1) < (__strip_bitwise(type))1)
#else
#define is_signed_type(type) (((type)(-1)) < (type)1)
#endif

(1) would work better than (2) for kernel developers who are using a
version of sparse that does not support __strip_bitwise().

Thanks,

Bart.
