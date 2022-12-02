Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C49C4332F
	for <linux-block@archiver.kernel.org>; Fri,  2 Dec 2022 00:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiLBA6x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiLBA6x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 19:58:53 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB5273407
        for <linux-block@vger.kernel.org>; Thu,  1 Dec 2022 16:58:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso5244423pjb.1
        for <linux-block@vger.kernel.org>; Thu, 01 Dec 2022 16:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3+ONzpAtXlifkW6XWzzPleBiUtoMQaIHTVrV3OgNP4=;
        b=H3GkGIBo8XgqkK5DkeHABIGwit48vACrV9sP+ulWzbjHLxzYOQN3hE03P9S2tOP7AY
         7dpsG3WSV3lq7/hfTLkWUGaHqQq4hXPzO6VALO/cEm4sIciNa1hl5OywZjXJjFWTt+6u
         VPjphHPKnYsdDbJ6KlZy/SmRBuMLa5aUwOzfmUmhP1zfy7pCnU5AntfcUa2w1pmv4Qha
         YH+yr/QJSBhHC8M33t0TMvyGqeisYEWXp0D/XovewUrgTp6zVqWGh9DwMkf9OOl862lF
         5CMSm3pGn7rnlSqYWoefs0QuB02rGll2gU2CB+didToOa9T7NojCo6ZN++AItUMnl49e
         SRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3+ONzpAtXlifkW6XWzzPleBiUtoMQaIHTVrV3OgNP4=;
        b=zkeEwRrIA9unhq+8+j/oKhx6EF/ApOM47DVJmjw4XUPWutNMX1X5WcV25aJkHfQLxA
         vyu8SUTGenoMqWmv9jA0sXAspqYCayHHyP7dtQR2gsum+cq98PKmNZU/k+SwTDrexiPc
         y6Vot+FxYlztn+GEi8UXr7nVQduKGNindYz97blPUGHEKk/FIB8CxDUG5b2MFqw3dT++
         ec0OarSqB3NE8LboX9b97xwvAqxSf2CLQ875YulhmFyMEttE0apPZqgkvTjYTyAOPbm4
         rV/ObgaW5oMFfe4ePWbtnwMjeV7oXpUdFuFMzt/7tOGudUrV2W/n/BDPAZkfmWcQKXpM
         1+Pw==
X-Gm-Message-State: ANoB5pnakTCGg59QaKoUZmEJCnkVxLnZWPW9DzF4AywCFHUNmObSPRjp
        l4rvex3+x1pcSWY6XxRsxZzdQg==
X-Google-Smtp-Source: AA0mqf7y6YtI3WuzJyh/YaeQl8mQ9WJF44L69Hgz8h8YPZoMqb1wU28XCTcKCF1e96tnuiuTXPNGYA==
X-Received: by 2002:a17:902:ea82:b0:189:9bb4:70 with SMTP id x2-20020a170902ea8200b001899bb40070mr16451154plb.108.1669942729324;
        Thu, 01 Dec 2022 16:58:49 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id oj4-20020a17090b4d8400b00217cdc4b0a5sm5451177pjb.16.2022.12.01.16.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 16:58:48 -0800 (PST)
Message-ID: <e6a984e9-f597-d987-2eef-9c3dd8ae7f0e@kernel.dk>
Date:   Thu, 1 Dec 2022 17:58:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] sbitmap: don't consume nr for inactive waitqueue to
 avoid lost wakeups
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>,
        Kemeng Shi <shikemeng@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang@huawei.com
References: <20221201045408.21908-1-shikemeng@huawei.com>
 <20221201045408.21908-2-shikemeng@huawei.com>
 <81e3f861-f163-c17c-49d4-2408f16c3350@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <81e3f861-f163-c17c-49d4-2408f16c3350@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/22 12:21?AM, Kemeng Shi wrote:
> 
> 
> on 12/1/2022 12:54 PM, Kemeng Shi wrote:
>> If we decremented queue without waiters, we should not decremente freed
>> bits number "nr", or all "nr" could be consumed in a empty queue and no
>> wakeup will be called.
>> Currently, for case "wait_cnt > 0", "nr" will not be decremented if we
>> decremented queue without watiers and retry is returned to avoid lost
>> wakeups. However for case "wait_cnt == 0", "nr" will be decremented
>> unconditionally and maybe decremented to zero. Although retry is
>> returned by active state of queue, it's not actually executed for "nr"
>> is zero.
>>
>> Fix this by only decrementing "nr" for active queue when "wait_cnt ==
>> 0". After this fix, "nr" will always be non-zero when we decremented
>> inactive queue for case "wait_cnt == 0", so the need to retry could
>> be returned by "nr" and active state of waitqueue returned for the same
>> purpose is not needed.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
>> ---
>>  lib/sbitmap.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 7280ae8ca88c..e40759bcf821 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -604,7 +604,6 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>>  	struct sbq_wait_state *ws;
>>  	unsigned int wake_batch;
>>  	int wait_cnt, cur, sub;
>> -	bool ret;
>>  
>>  	if (*nr <= 0)
>>  		return false;
>> @@ -632,15 +631,15 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>>  	if (wait_cnt > 0)
>>  		return !waitqueue_active(&ws->wait);
>>  
>> -	*nr -= sub;
>> -
>>  	/*
>>  	 * When wait_cnt == 0, we have to be particularly careful as we are
>>  	 * responsible to reset wait_cnt regardless whether we've actually
>> -	 * woken up anybody. But in case we didn't wakeup anybody, we still
>> -	 * need to retry.
>> +	 * woken up anybody. But in case we didn't wakeup anybody, we should
>> +	 * not consume nr and need to retry to avoid lost wakeups.
>>  	 */
>> -	ret = !waitqueue_active(&ws->wait);
> There is a warnning reported by checkpatch.pl which is
> "WARNING:waitqueue_active without comment" but I don't know why.

Most likely because waitqueue_active() could be racy, so a comment is
warranted on why it's safe rather than using wq_has_sleeper().

-- 
Jens Axboe
