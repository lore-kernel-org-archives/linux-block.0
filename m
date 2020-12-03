Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CADBC64E8A
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 12:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C8122201
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 12:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbgLCMKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 07:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387983AbgLCMKR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 07:10:17 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58B3C061A4F
        for <linux-block@vger.kernel.org>; Thu,  3 Dec 2020 04:09:36 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r3so1648097wrt.2
        for <linux-block@vger.kernel.org>; Thu, 03 Dec 2020 04:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OCau6oXg+hbo5fJT9AdjUS3+erlq6n4fyJwsTvZG488=;
        b=uiL2W88i7rChbgRLAeb+6raRQpm10s5reG5LChrKJ2jntK0mwXqD6+dTvv8ls+YkXd
         +DXeGMIQygZH1U7TVK+p5a8NDTivjf3EkYFXZkSGBYq195cn/kuUwAcPl2eeRAepqXgs
         ERmrNsJAwB4nwyiCYe7yi9Rc6V8FYl4QpDKjKmQRHwdbJTL1uIS1ygaCPMOkYdX0BhTg
         8M9OKhsDnawIhxwYxBVio7HzhNBmsWSAIxsNEl1PmGzh/HR1RHM76ktTMfToz8GMzKzN
         66dmCnjDh2v6VBek/+PcsyKUF6RQ/msEZCvtz1RJ79TTNtDqoxUQoPfCheKGNDT2iWlA
         0HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OCau6oXg+hbo5fJT9AdjUS3+erlq6n4fyJwsTvZG488=;
        b=AV889DzQF2tzb/Od3Qh9AWQ8iL64U7W6001SoHIwnvH3d1I1hhbjRpjy1UId5MZ3bb
         CpyBIe2+PB9w1l57MRkutOjhl1LU8d8d3Ud6s9MX8fj4ngyXIJPASGGKmXPWmgOsx2Qf
         YqrtUMRgJXtugPTkU5L0+vTxf7GHzejhs9I21luh9TiwTl96xcnI3J0faTUv+bxoZa4h
         llRiYBcRCryJgCXfl3G3IBl/BGI0bV1WhG2MJOkf+PxCKWj6trqDYRNUIBDtSJIUeCqf
         VtpwI47TS3GNIJVQpf9q6SL4lArVbJWP0eRnIttARvOMSKBok2jt4Qhe77ZC+DhQuE/y
         Js8w==
X-Gm-Message-State: AOAM5321mNE8/NvSClmiuyV+adVWo1XqwDTObdJJ7Ex8XghxKrGBMCd1
        ltxZkBETIeN6SU1/8ufYiY5UwHNqeD9Wlw==
X-Google-Smtp-Source: ABdhPJwC6WxUgn3RISx1+sadw/1e6iqShf3xCvHf0BGMwYZF1xkkvtgMsVbrNkHfW8bmveRytolaKg==
X-Received: by 2002:adf:ea47:: with SMTP id j7mr3378241wrn.126.1606997375089;
        Thu, 03 Dec 2020 04:09:35 -0800 (PST)
Received: from [192.168.1.59] (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id u23sm1255994wmc.32.2020.12.03.04.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 04:09:34 -0800 (PST)
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <cover.1606699505.git.asml.silence@gmail.com>
 <beee275f48a98e42f073ee63221e9610fc9470b5.1606699505.git.asml.silence@gmail.com>
 <20201203064931.GB629758@T590>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 1/3] blk-mq: use right tag offset after wait
Message-ID: <0997fd49-5d8c-375f-14be-d2d19b3cd8ee@gmail.com>
Date:   Thu, 3 Dec 2020 12:06:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201203064931.GB629758@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/12/2020 06:49, Ming Lei wrote:
> On Mon, Nov 30, 2020 at 01:36:25AM +0000, Pavel Begunkov wrote:
>> blk_mq_get_tag() selects tag_offset in the beginning and doesn't update
>> it even though the tag set it may have changed hw queue during waiting.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>  block/blk-mq-tag.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 9c92053e704d..dbbf11edf9a6 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -101,10 +101,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>>  			return BLK_MQ_NO_TAG;
>>  		}
>>  		bt = tags->breserved_tags;
>> -		tag_offset = 0;
>>  	} else {
>>  		bt = tags->bitmap_tags;
>> -		tag_offset = tags->nr_reserved_tags;
>>  	}
>>  
>>  	tag = __blk_mq_get_tag(data, bt);
>> @@ -167,6 +165,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>>  	sbitmap_finish_wait(bt, ws, &wait);
>>  
>>  found_tag:
>> +	if (data->flags & BLK_MQ_REQ_RESERVED)
>> +		tag_offset = 0;
>> +	else
>> +		tag_offset = tags->nr_reserved_tags;
>> +
> 
> So far, the tag offset is tag-set wide, and 'tag_offset' is same for all tags,
> looks no need to add the extra check.

Thanks for clearing that. I still think that's a good thing to do as more
apparent to me and shouldn't be slower -- it unconditionally stores offset
on-stack, even for no-wait path (gcc 9.2). With it's optimised more like

if (!(data->flags & BLK_MQ_REQ_RESERVED))
	tag += tags->nr_reserved_tags;

I like assembly a bit more, but not like that matters much.

-- 
Pavel Begunkov
