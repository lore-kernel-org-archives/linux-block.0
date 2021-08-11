Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472D3C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 20:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255C26101E
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 20:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHKUWu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 16:22:50 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:47100 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKUWs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 16:22:48 -0400
Received: by mail-pl1-f179.google.com with SMTP id k2so4192044plk.13
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 13:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ZBdfJlOLYYsKQza1rY6EcHDJTUofwwG9wOg0b16VCg=;
        b=n+/6nEO1xP6XjCgWONl8uWtC4pyFoA48QwPP8OaVSAVdcKBLVMNBSOc9bJ4wYqgiNo
         M8m86jMWXKCPDa0LdwYJcvpolQ3AGZxElVAmtb4Jj40KXj8v8aS+jJKbG2E+QmEmqJP1
         MYzplfE52RmlyHWQwnQw2t9DDAWV64aTcArTaG8KGXcBBg3kxQ6nNIbzqwbOqhVmEAlC
         AzjMajIbtwO3qELMagRI2XEoyLk06dvCXngG2KI7fSVMTrUODqd+HXTDxvK0SfVkKA0S
         LmFTnNzX6Ymo0H5aSJ4jSdDXqcdHMdmk15oIniarBRLYc3FMv1KCZGRW8gH4s2cAlvgx
         dTDg==
X-Gm-Message-State: AOAM531ymWx6aKG6Ds03qwtA7gK0OxoXdpyUxrA5GFdPB3zmYv8DmbuB
        vSLzy5lgjRO1/V41ixtdgb7C9LYpwfGgHQ8s
X-Google-Smtp-Source: ABdhPJyYxTgc77CjHG6+Widkr936CxTsR87gSP0qde2NCfQTqERD5QdMqqv4a3rRaai5/mFC5JqjEA==
X-Received: by 2002:a63:1456:: with SMTP id 22mr461801pgu.257.1628713342280;
        Wed, 11 Aug 2021 13:22:22 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:85f2:bb0e:80b9:d6f6])
        by smtp.gmail.com with ESMTPSA id 22sm342716pgn.88.2021.08.11.13.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 13:22:21 -0700 (PDT)
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
 <YRQhlPBqAlkJdowG@mtj.duckdns.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
Date:   Wed, 11 Aug 2021 13:22:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRQhlPBqAlkJdowG@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/21 12:14 PM, Tejun Heo wrote:
> On Wed, Aug 11, 2021 at 11:49:10AM -0700, Bart Van Assche wrote:
>> You write that this isn't the right way to collect per cgroup stats. What is
>> the "right way"? Has this been documented somewhere?
> 
> Well, there's nothing specific to mq-deadline or any other elevator or
> controller about the stats that your patch collected and showed. That
> seems like a pretty straight forward sign that it likely doens't
> belong there.

Do you perhaps want these statistics to be reported via read-only cgroup 
attributes of a new cgroup policy that is independent of any particular 
I/O scheduler?

Thanks,

Bart.
