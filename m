Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE08C43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 00:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiFZAo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jun 2022 20:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiFZAo6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jun 2022 20:44:58 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB7214007
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 17:44:57 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id l2so4892216pjf.1
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 17:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=+3dALfFkGsSuaeuAPJOfM2MmZmY7AEbcVCeXtSaR3/g=;
        b=VqhIIj4ZKemFMFRpdBoAlZJ2KTxvVLp3szoJtR7czpkkSH45Y7JP1Ye11oKJxezTQ9
         k1LFBD4Kc7X6M7v/S6Wfejb41lFrWbm2EhgyRQ4A//Vv5fxsbTn9dGk3Te2VOLc2zRl0
         BeCeLMVxBZNv7+cydUjiM8ney4WZGWCA1e5NdJYWwx4Wi3mUmGHgChyJYFxybGXfjhGl
         K0fZOmwXuDdEEQyJ4vI0WNPCgL7bMlN/Y+nyNQIXl83a4sEt4wS3b/m6IX9WJXaU71+p
         TyzyjY8KqU4XfLKSJ/w/Thiq3j4R12fnQ/FmRytCDDAG8aMArAJUQFVrYirM7AIbWpFK
         BIcw==
X-Gm-Message-State: AJIora+tKK7oDYBenY68WLZ5ITBKLfFPGgCrFbvQfQlvRR8U311r0+MQ
        Cb3NqDEeczNeKzM84DIgE0A=
X-Google-Smtp-Source: AGRyM1skoMbA7PlCuK7AtXnN69R91b42jhH+5BFVJj9iEcxA/2OThBulisvDbMc+13iU7+DtXzFdrA==
X-Received: by 2002:a17:903:11cd:b0:167:8a0f:8d44 with SMTP id q13-20020a17090311cd00b001678a0f8d44mr6763178plh.72.1656204297086;
        Sat, 25 Jun 2022 17:44:57 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090a318900b001e88c4bb3dcsm6335067pjb.25.2022.06.25.17.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 17:44:56 -0700 (PDT)
Message-ID: <3eed7994-8de2-324d-c373-b6f4289a2734@acm.org>
Date:   Sat, 25 Jun 2022 17:44:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-52-bvanassche@acm.org> <20220624045613.GA4505@lst.de>
 <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
 <20220625092349.GA23530@lst.de>
Content-Language: en-US
In-Reply-To: <20220625092349.GA23530@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/25/22 02:23, Christoph Hellwig wrote:
> On Fri, Jun 24, 2022 at 12:57:56PM -0700, Bart Van Assche wrote:
>> BTW, I discovered the code in the tracing infrastructure
>> that makes sparse unhappy:
>>
>> #define is_signed_type(type) (((type)(-1)) < (type)1)
>>
>> Sparse reports four warnings for that expression if 'type' is a bitwise
>> type. Two of these warnings can be suppressed by changing 'type' into
>> '__force type'. I have not yet found a way to suppress all the sparse
>> warnings triggered by the is_signed_type() macro for bitwise types.
> 
> Yeah, that is a bit of a mess.  Rasmus, Steven - any good idea how
> we can make the trace even macros fit for sparse?  Maybe just drop the
> is_signed_type check for __CHECKER__ ?

How about the patch below?


Subject: [PATCH] tracing: Suppress sparse warnings triggered by
  is_signed_type()

Using a __bitwise type in a tracing __field() definition triggers four
sparse warnings in stage 4 of expanding the TRACE_EVENT() macro. These
warnings are triggered by the is_signed_type() macro implementation.
Since there is no known way of checking signedness of a bitwise type
without triggering sparse warnings, disable signedness checking when
verifying code with sparse.

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  include/linux/trace_events.h | 12 ++++++++++++
  1 file changed, 12 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e6e95a9f07a5..f7b2a5467361 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -814,7 +814,19 @@ extern int trace_add_event_call(struct trace_event_call *call);
  extern int trace_remove_event_call(struct trace_event_call *call);
  extern int trace_event_get_offsets(struct trace_event_call *call);

+/*
+ * There is no known way to check signedness of __bitwise types without
+ * triggering a sparse warning. Hence the #ifdef __CHECKER__.
+ *
+ * There is another definition of is_signed_type() in <linux/overflow.h>.
+ * Hence undefine is_signed_type() before redefining it.
+ */
+#undef is_signed_type
+#ifdef __CHECKER__
+#define is_signed_type(type)	0
+#else
  #define is_signed_type(type)	(((type)(-1)) < (type)1)
+#endif

  int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
  int trace_set_clr_event(const char *system, const char *event, int set);
