Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A63C2BB40
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 19:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8A0221EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 19:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbgLNTFg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Dec 2020 14:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387448AbgLNTFb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Dec 2020 14:05:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F721C0613D3
        for <linux-block@vger.kernel.org>; Mon, 14 Dec 2020 11:04:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q18so9998397wrn.1
        for <linux-block@vger.kernel.org>; Mon, 14 Dec 2020 11:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ymm5n7lNdN7U8kiqoUS1EaBSzulH/Y/2UDWMGRAxbuU=;
        b=KKHnSmtF1pJqEU6ifjBDen2X+gZ8J5HtoA24GtgVlOuGHbNy0xuBY3A4Xpo3QE1OYX
         z/M7Uncyj59itHTNgb/QninSbS1AmvQJNvtwr0EsHKRSKpn0PzT+jpVczVak3Gn2zTSV
         uYMSW7qztDQAjVclwRvbjJvA3WD+W816fD3EJdaq6yWw8wLtr/FJwrAwMT6RPEYHW0E2
         5PK4aEM8xhhVKBlKOCvvOvxTyXA03A9zVn9oo+zV4JPS0AglIx50Yxtkoy1JrVYnhqxC
         BliLmVUlD3a+Izugskz47UO8lQNbwCHeZTxPrg0ZIvCBCxGP+QFkpwEBnD5K3qQyIMKf
         eqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ymm5n7lNdN7U8kiqoUS1EaBSzulH/Y/2UDWMGRAxbuU=;
        b=qX77M9zJe9K+119B4SQomRnBtiyI6PCubwG4vw10kAnn2JsAoTrzHYYlodVVtdigar
         Zxd1deFQBLBYyk/djLHVWWE8A4ZXBipmJStdLe8Ij6fePSffIDiuvoukL3zU6FYkKTpr
         3J0jU8udTsqTTjJixYuQgZK6V5AjMYTmVyPC6YRr8a0MA6lbpTcWf0ZJOQBLlpkeN+Gi
         7OnOLlP4X0+fTUs8V3C1fUcW4zX4ODNciTodro7YnEQPPRylmCiuEd3/VUJTasi4CQND
         Brx9MGvypICBOAbPvqEb9vWORZ/yP/gYIKVbDo2kQI5yOuGJSJVx7S4emjd2deRbhQXA
         wvPw==
X-Gm-Message-State: AOAM532PX7yCOx/s6vFRH3gC7Wdq52jcC3soVK4AQJRNdFE1HXHlYEkD
        kFYTxw3Qv65/2rKlqLL1m/I=
X-Google-Smtp-Source: ABdhPJzn3qGb3mQf+u4IHZVyUvSgNSHjNDxvzqmMoeN0cc9A2hJjhLWCYE9HyuRwVRc2mA+GM09/5Q==
X-Received: by 2002:a5d:6682:: with SMTP id l2mr30404936wru.213.1607972689899;
        Mon, 14 Dec 2020 11:04:49 -0800 (PST)
Received: from [192.168.8.128] ([85.255.232.163])
        by smtp.gmail.com with ESMTPSA id h9sm31857822wre.24.2020.12.14.11.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 11:04:49 -0800 (PST)
To:     Keith Busch <kbusch@kernel.org>
Cc:     Andres Freund <andres@anarazel.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
 <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
 <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
 <20201211011940.ouc4k3am5gg2ithp@alap3.anarazel.de>
 <de0b46d2-d053-a7a8-23e7-fc954807c70d@gmail.com>
 <20201211033719.GA6414@redsun51.ssa.fujisawa.hgst.com>
 <2b26eaca-d143-6951-3bed-ce29df4dd07d@gmail.com>
 <20201213181927.GA3909519@dhcp-10-100-145-180.wdc.com>
 <55ec2183-2b3a-7660-a7fa-3f063872845e@gmail.com>
 <20201214182310.GA22725@redsun51.ssa.fujisawa.hgst.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <1859cc60-eaa2-9a3a-6d99-6363de449332@gmail.com>
Date:   Mon, 14 Dec 2020 19:01:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201214182310.GA22725@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/12/2020 18:23, Keith Busch wrote:
> On Mon, Dec 14, 2020 at 05:58:56PM +0000, Pavel Begunkov wrote:
>> On 13/12/2020 18:19, Keith Busch wrote:
>>> On Fri, Dec 11, 2020 at 12:38:43PM +0000, Pavel Begunkov wrote:
>>>> On 11/12/2020 03:37, Keith Busch wrote:
>>>>> It sounds like the statistic is using the wrong criteria. It ought to
>>>>> use the average time for the next available completion for any request
>>>>> rather than the average latency of a specific IO. It might work at high
>>>>> depth if the hybrid poll knew the hctx's depth when calculating the
>>>>> sleep time, but that information doesn't appear to be readily available.
>>>>
>>>> It polls (and so sleeps) from submission of a request to its completion,
>>>> not from request to request. 
>>>
>>> Right, but the polling thread is responsible for completing all
>>> requests, not just the most recent cookie. If the sleep timer uses the
>>> round trip of a single request when you have a high queue depth, there
>>> are likely to be many completions in the pipeline that aren't getting
>>> polled on time. This feeds back to the mean latency, pushing the sleep
>>> timer further out.
>>
>> It rather polls for a particular request and completes others by the way,
>> and that's the problem. Completion-to-completion would make much more
>> sense if we'd have a separate from waiters poll task.
>>
>> Or if the semantics would be not "poll for a request", but poll a file.
>> And since io_uring IMHO that actually makes more sense even for
>> non-hybrid polling.
> 
> The existing block layer polling semantics doesn't poll for a specific
> request. Please see the blk_mq_ops driver API for the 'poll' function.
> It takes a hardware context, which does not indicate a specific request.
> See also the blk_poll() function, which doesn't consider any specific
> request in order to break out of the polling loop.

Yeah, thanks for pointing out, it's just the users do it that way --
block layer dio and somewhat true for io_uring, and also hybrid part is
per request based (and sleeps once per request), that stands out.
If would go with coml-to-compl it should be changed. And not to forget
that subm-to-compl sometimes is more desirable.

-- 
Pavel Begunkov
