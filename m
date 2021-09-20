Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E71C433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 11:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF5A60E08
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 11:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhITLmG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhITLmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 07:42:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D1C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 04:40:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w29so28731517wra.8
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SCpMMU+AylYNSMGXi/253/pNji1oh6d5az7brxnQL9E=;
        b=XXYn6fU7zTb9D9aIxeCKL806MkiHEQffUEDQODylVE00igKyWq/Lzhw2OFSVE9qvE+
         mLCsKM11qKhlHCkvwEtonxuC9QPYy4yUs3N4XuPu/4VfFIJgIbTLIMplsSj2ZXFjEyAY
         ezLO7OMn2QDPbv5eQt6PwOK/PTAehXmQrFzt17EeWjohlv1W6vn7OjrIKsPB55xeMg9M
         D28+6ycLdQJJ1eUl1ARVMLKa1Kw2UaO6jB72QPRFthlneZSuDzYllbK7QEygLaVQ7SEv
         GJRZ8qOQuAjzFEIlS4qCECajXg8FetM61c5hU38kzkcItV/kwbAf9hOIynKINiba9wCG
         B1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SCpMMU+AylYNSMGXi/253/pNji1oh6d5az7brxnQL9E=;
        b=Tp/i/dD20kC3y9MQoMj6hNqzQorAHFpUCvx3261zNQe7wpeCKj4vfgMwyjo+58KX9L
         SMnyzjO3qz0WQmZl9b8gQ+rgwNrN1atq+6azeiG7bbTbNAd6fKJgXMvCUGq90KDAcDtq
         u3nHgt4/A+ymPRVADj8ktuesoEq7kp1sIRCEddSYHutHhtJnqKTnn9UH/Uq/XD0K31Zl
         d+LoHXPkAv0IGbpjAz36B0ndqOyO1xCq/Si30h8fVe0UO8FRjV3YQ7QlO4oqJ+UHvFHo
         +R4XrhiOTb3qhwAghpa1GILcwtMd7/ZDzJglFPVlhmdw01cOqsJFw6atI+FZY8V4miV9
         XtGw==
X-Gm-Message-State: AOAM531maZerkEsqnUuQ5hA2OGQcUwc2GnQKrwqdtbaxV9boHEQ9LKX0
        +6htKzoqk+QT7j0HxR5qyl6XKaSedYs=
X-Google-Smtp-Source: ABdhPJy/Tpea4qr+C5CUFTg5jrPtVxEv2kKxVTWL9le2jsBS2DkccbLb7RhhDnsNqmUfauarQZwW7w==
X-Received: by 2002:a1c:210a:: with SMTP id h10mr3103254wmh.117.1632138037818;
        Mon, 20 Sep 2021 04:40:37 -0700 (PDT)
Received: from [192.168.8.197] ([148.252.128.31])
        by smtp.gmail.com with ESMTPSA id o19sm6872883wrg.60.2021.09.20.04.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 04:40:37 -0700 (PDT)
Subject: Re: [PATCH] null_blk: poll queue support
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
 <1a63be84-3024-722b-232b-90f606a2addd@gmail.com>
 <1002cd58-63b6-453a-93c0-774928690e5f@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <19eecc0f-c7d7-ef4d-3a79-74a57753a3a1@gmail.com>
Date:   Mon, 20 Sep 2021 12:40:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1002cd58-63b6-453a-93c0-774928690e5f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/16/21 2:57 AM, Jens Axboe wrote:
> On 9/14/21 3:38 PM, Pavel Begunkov wrote:
>> On 4/17/21 4:29 PM, Jens Axboe wrote:
>>> There's currently no way to experiment with polled IO with null_blk,
>>> which seems like an oversight. This patch adds support for polled IO.
>>> We keep a list of issued IOs on submit, and then process that list
>>> when mq_ops->poll() is invoked.
>>
>> That would be pretty useful to have.
>>
>> to fold in:
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index 5914fed8fa56..eb5cfe189e90 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1508,7 +1508,7 @@ static int null_poll(struct blk_mq_hw_ctx *hctx)
>>  		cmd = blk_mq_rq_to_pdu(req);
>>  		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
>>  						blk_rq_sectors(req));
>> -		nullb_complete_cmd(cmd);
>> +		end_cmd(cmd);
>>  		nr++;
>>  	}
> 
> Let's try again with that...

I'm not so sure it fixes the problem Bart mentioned, but at least it
doesn't crash for me right away (timer mode) and io_uring tests complete
well.

-- 
Pavel Begunkov
