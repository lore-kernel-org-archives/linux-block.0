Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2496DC433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045BF20776
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qN783EXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgF2TYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732364AbgF2TYU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 15:24:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D9C061755
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 12:24:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so8752068pgn.7
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cq4UBXrTLYgIRJ0xWriZuGDCaPMlM6gW39AR31lPx+0=;
        b=qN783EXLt/MMGHppJnWa45eRyBY90VpDa/sxDCh6Qfyln2FvfhLb/Aii/lkheS+wBO
         Dqci6cjnv9nhRE6bbGvMjC/GbYZAh0TgxX6Du8RfFaAVuv/Eaw01dKrfhsHKw2+SwIRi
         6Iwyw0N0mHdxoithK1HCM5sR4N7Q79cYXxEyudbdtFj2cy/0CUcTS2JEcPccJlfrnbgl
         qmgxFlxnMTpLWR/bM+h9VPtP/5jNSNyKpKciRwsfA3XghNHjx42xVgzxO2tAMig9gpqK
         BqFKBtse+wms9cd4bzXq2GrIexpBGRv1Vq1cXyNmVkupKdt7P92Iaa8UgybvflDuXaR/
         mzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cq4UBXrTLYgIRJ0xWriZuGDCaPMlM6gW39AR31lPx+0=;
        b=mgSwkBhWe7DDStjVzn6t28qfBz6P/Aamd3abYh1kYKvdtBRfHdxxTJiljvGqCK2c7M
         xzT9kAAnKjufUMXEC1nURuLWVZcZpfvNg9dN2/OZIz6QJMn08vx55aSwNTqLvA8ZoQOJ
         7EIIKCpBBPv/5x8Fvi0ZdH7Bf1IeuOiwc5rM8Tjm4LLW2P/7bnmlbC4VsUfVZls3/sUA
         CizrUEfFpDJMxNmUFhtWCB3C2m97QmxjrzaSe9nIZQ1qv/AC9+S+PQ3ImBtj2Zn4P4TV
         qjEDWU2u1sa8hS/blyZLjYd7vz73EN6R31ErI4yX6kgPma7h/Sb7hx7oOSiRqmOVKqef
         Ek6A==
X-Gm-Message-State: AOAM5311rk0OUg47gH+4r3+B7XmDDQwNrqtlHxUwiXOlrHnOVin26azW
        tzR4OiC0+7pK/PLPWPE1zQzt9w==
X-Google-Smtp-Source: ABdhPJx4OJYni9g/6pDj1+j2oU99gNHg3yf+BPH8XUo8SFw9ku6pHRQv5hCjMHYThvJhpTZtsYU14A==
X-Received: by 2002:aa7:8298:: with SMTP id s24mr16435624pfm.21.1593458659993;
        Mon, 29 Jun 2020 12:24:19 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id mw5sm307050pjb.27.2020.06.29.12.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 12:24:19 -0700 (PDT)
Subject: Re: [PATCH] block/keyslot-manager: use kvfree_sensitive()
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>
References: <20200616155654.191263-1-ebiggers@kernel.org>
 <20200629165159.GB20492@sol.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf08a91c-bd40-fd1d-3d03-c2ba822df1c2@kernel.dk>
Date:   Mon, 29 Jun 2020 13:24:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629165159.GB20492@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/20 10:51 AM, Eric Biggers wrote:
> On Tue, Jun 16, 2020 at 08:56:54AM -0700, Eric Biggers wrote:
>> From: Eric Biggers <ebiggers@google.com>
>>
>> Make blk_ksm_destroy() use the kvfree_sensitive() function (which was
>> introduced in v5.8-rc1) instead of open-coding it.
>>
>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>> ---
>>  block/keyslot-manager.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
>> index c2ef41b3147b..35abcb1ec051 100644
>> --- a/block/keyslot-manager.c
>> +++ b/block/keyslot-manager.c
>> @@ -374,8 +374,7 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
>>  	if (!ksm)
>>  		return;
>>  	kvfree(ksm->slot_hashtable);
>> -	memzero_explicit(ksm->slots, sizeof(ksm->slots[0]) * ksm->num_slots);
>> -	kvfree(ksm->slots);
>> +	kvfree_sensitive(ksm->slots, sizeof(ksm->slots[0]) * ksm->num_slots);
>>  	memzero_explicit(ksm, sizeof(*ksm));
>>  }
>>  EXPORT_SYMBOL_GPL(blk_ksm_destroy);
>> -- 
> 
> Ping?

Applied, thanks.

-- 
Jens Axboe

