Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B4C48BD1
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41D861351
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhFIPpH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbhFIPo1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 11:44:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647D2C061574
        for <linux-block@vger.kernel.org>; Wed,  9 Jun 2021 08:42:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q25so18680821pfh.7
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CUyegkg0RflLGjCgW8eHZLxyCNKKbQVGdJ9HzLVtxbY=;
        b=l8fVWqITBh1EQRTwsBgt6yru1HwzWuP0XAfNfHSl0Lf2Ojtq4pxSAnIwlDe6D76dQY
         jVMlYnCpSls/D298cIoOJ4rqiMRoXzWZX3SPldRrYaNtTiSgTuIvxvwW+V2iBcCiwqHh
         uglm9c0AfyIjY+f5Q6fat5/8gXFOvK6BAn0U1kwYPt1zUgb/6NhbKrCosijU9TS4E65R
         FM3nN4EhDQhi29xCJGsNGufLTmzp1s1ghEANVa6lrpFyUukRBF3kK1GhaizyqMnWwA64
         FwTWp/du0jsZ8eAD7zx3JEN//ej6z7Y0zTKKnVncb4SpD2PyC+9Z5VNHBkoko8Ll2gtL
         Unaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CUyegkg0RflLGjCgW8eHZLxyCNKKbQVGdJ9HzLVtxbY=;
        b=IYRxjab6OdEeJgiy3bMPP+UEiIHbdK323A9SItS9NVoTInQUun+YVX5eDNV2qcepX8
         59JU/0EbRw2N4WyZPxobohSpnf/564RP7noxHYbmmzcSCUKauIL75V67/fvRKZkqSYbb
         rP15/PCOBtr6nwNGeE3X+jWstryG+CxxUbccNo7B0034gOOwqtdQgiMSDYB9y3a9dH0z
         EChQ8wRLWG6C8fK7fBgZ70ijdhKvJOGogLD9ok4eg+HEKYbQ2ScCEWQ0lSPopobnsQ8E
         arassnQsXMlxkyLOjkzlBABTmUgblApH06IaOfABh0YcEbrhpmez1R0ULR8X3oQ1Od7j
         6GEg==
X-Gm-Message-State: AOAM530/I8poxTA1jFZgemRIWtbq4NDj8vk59biLoO2lyG7YN1RivSpH
        vXw+nAgEGYqAS0tAXbVaOGQulMEAWKHvPA==
X-Google-Smtp-Source: ABdhPJx5HZzzQsKXO2zeM69xEzWa/54x/rFWdegLhmb0ikfu4mxkAuffMvkzDRh4P9jpif+FUcCUCA==
X-Received: by 2002:a65:4689:: with SMTP id h9mr286351pgr.347.1623253338371;
        Wed, 09 Jun 2021 08:42:18 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id ep6sm5309263pjb.24.2021.06.09.08.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:42:17 -0700 (PDT)
Subject: Re: [PATCH 1/1] aoe: remove unnecessary oom message
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Justin Sanders <justin@coraid.com>,
        linux-block <linux-block@vger.kernel.org>
References: <20210609121125.13883-1-thunder.leizhen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2c906010-5a6f-cd0a-310a-e3d38f0c3563@kernel.dk>
Date:   Wed, 9 Jun 2021 09:42:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210609121125.13883-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 6:11 AM, Zhen Lei wrote:
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message

Applied, thanks.

-- 
Jens Axboe

