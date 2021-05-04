Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94753C433B4
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 00:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA9961244
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 00:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhEDAdC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 20:33:02 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:36663 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhEDAdB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 May 2021 20:33:01 -0400
Received: by mail-pg1-f175.google.com with SMTP id c21so904654pgg.3
        for <linux-block@vger.kernel.org>; Mon, 03 May 2021 17:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IHv+UvXamHSoFZjnPZ2YUdrp9AWySR30qYrdTwwJyYU=;
        b=CKjWL488fYtsCbY56eAx5PbJdfo8183UYq8+NONLx0fPECB8ksmm1iJffyas3sznmx
         lM0ASr55gudTiW0FfDcvg+DORsamokG1mKzU0wIknXiFcXyGC6AAlo3itrGb6KXXtX1C
         e9fFU3Wbu8AT2bQwfFJXQwFNsKG/L2LOOzazgVk2xN6k2aNgb/eqWDgSqE1c4LKkvIxA
         qqY4n050cPOqKslz33MSR2oIEb9lwC2se5HxiPeRparGzFU/nu2d3DKasLvkcwhDCAV9
         oYEfpt8v6NyMwPVoWpj2bJUsa6yuM9Wg5tQfUKCwNEcI53Ze2nhkHPB4C6XbjnS1hNXE
         664g==
X-Gm-Message-State: AOAM530+i3wi353yWHMBWo62IWSYSAINSo2GpyUwvjDbJi5fiwWID3Se
        4j2UuqUhwqATddr4GvGfkdu7BeXaZfw=
X-Google-Smtp-Source: ABdhPJw1mpvQ4tcVtz6VkCDdk3zKw5qd8NkSI12m9t1PLMBGtiocXRoVUGBoXBzI4G91ghzUTw8t3Q==
X-Received: by 2002:a05:6a00:1513:b029:28e:d34b:9cdf with SMTP id q19-20020a056a001513b029028ed34b9cdfmr1681080pfu.67.1620088327274;
        Mon, 03 May 2021 17:32:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6b81:314d:2541:7829? ([2601:647:4000:d7:6b81:314d:2541:7829])
        by smtp.gmail.com with ESMTPSA id o4sm10456235pjg.2.2021.05.03.17.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 17:32:06 -0700 (PDT)
Subject: Re: [PATCH] null_blk: poll queue support
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
 <725ea863-c754-addf-f143-71d7e2f273de@acm.org>
 <5e0c7e2f-3fe4-7537-98f5-b9c6de8e5c8f@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1bcdc63d-dc1e-c863-07e1-1d957b936a1a@acm.org>
Date:   Mon, 3 May 2021 17:32:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <5e0c7e2f-3fe4-7537-98f5-b9c6de8e5c8f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/3/21 10:42 AM, Jens Axboe wrote:
> On 5/3/21 9:47 AM, Bart Van Assche wrote:
>> On 4/17/21 8:29 AM, Jens Axboe wrote:
>>> There's currently no way to experiment with polled IO with null_blk,
>>> which seems like an oversight. This patch adds support for polled IO.
>>> We keep a list of issued IOs on submit, and then process that list
>>> when mq_ops->poll() is invoked.
>>>
>>> A new parameter is added, poll_queues. It defaults to 1 like the
>>> submit queues, meaning we'll have 1 poll queue available.
>>
>> Has anyone run blktests against blk-for-next since this patch got
>> queued? The following appears in the kernel log if I run blktests:
> 
> Do you know what parameters the module was loaded with? I'll drop this
> one from the 5.13 queue for now.

Hi Jens,

The call trace was reported about 35 seconds after the message
indicating the start of the test so I assume that the null_blk driver
was loaded by the following shell code from tests/block/010:

	if ! _init_null_blk queue_mode=2 submit_queues=16 nr_devices=32 shared_tags=1; then
		return 1
	fi

Bart.


