Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E03C433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 02:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D114D64E2E
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 02:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhCACtg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Feb 2021 21:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhCACtf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 21:49:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14AC061788
        for <linux-block@vger.kernel.org>; Sun, 28 Feb 2021 18:48:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d13-20020a17090abf8db02900c0590648b1so1665906pjs.1
        for <linux-block@vger.kernel.org>; Sun, 28 Feb 2021 18:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q9qU7QjFpSHW9lmhTijMTqPQwYa37aE6elgjX/DKe2E=;
        b=tXxM9SRvtVZ+Cxh0QNLS3Xlys8AYOcYWwjzbJ/zaDOWJb6DmMWSBhz6LGgBXQAYhjk
         lNmzPVWoj+YixYDdY0QGXs6gAQvYTHlJMXBKu9l0La8yOHoX/d0l32iD2/r7RHiZnDe1
         Hi/80a5rqNkr6lv+KuGThTevJ8k9n+QGGKhckioug78T29B4yqIyg84EGByW6hk2ld7k
         SPXJLfOR+WzkvC9DdBUFZ4QmQeK7TgjTzCYiypyL6AZBFj59i744I1LsL2fwn6Wkw9EL
         pwTmyVzAr8YWR/Z3gbXz3Hh1vvMy70L0NaNuBHJcADag7iM3ykgEOyfH4bg09NTLOqDn
         18CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q9qU7QjFpSHW9lmhTijMTqPQwYa37aE6elgjX/DKe2E=;
        b=L/ptcsn8UmfReOnFpCwJsH2RGzqkFQeloWNzPxKb/nmbA1ZhPOECx2dmEia31zbnCA
         Xggnzd3jaz6ijKHarlzTgDCZHsXDT8puy//sp9Z9PBMa8r/vDR7SPo1iROb/PEJaTBbh
         vkxj9FXPftSmjlCd9NHIeCpQjau/UdKqo4+vUlEGETBeOS+wXlBabSrOA8hgave+f1Fb
         PqeElyDVK95WAze1i/wgd/9a4uv+UUHIq3HlxO198X0lGjjZHgdOiYrWCjjmnsVHegRc
         6S/kyEHcxUc8youQA7+ZFBYYV1xV0aQM4qi8fZSCxWz3arnhuX7AdSIbo0cQFFVjVMZp
         G04w==
X-Gm-Message-State: AOAM5337UCsmBG9n1oEUPgoB1NB8Jx8HGA5eK1jvr6Po4BMEB3jDnfd6
        oTbg7hEbVGO5mJ7OIAPz/VJoXl8X4lqT3Q==
X-Google-Smtp-Source: ABdhPJzMBZOLeTD2XWgoJPKlHabv4X7KWL9Ow/lsBTB/rWcUTD6x5YYUctFTAB2Dts8Ku+oCulUTgg==
X-Received: by 2002:a17:902:bd0a:b029:e0:612:ad38 with SMTP id p10-20020a170902bd0ab02900e00612ad38mr14152952pls.30.1614566933901;
        Sun, 28 Feb 2021 18:48:53 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 192sm12829095pfx.193.2021.02.28.18.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 18:48:53 -0800 (PST)
Subject: Re: [GIT PULL] Followup block fixes for this merge window
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4fb0811b-af58-60db-1c27-ef367876c491@kernel.dk>
 <BL0PR04MB651426DD935C27ABF775B8B9E79A9@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ab5e1da5-05a4-6bb6-80b8-68364bd2ea1a@kernel.dk>
Date:   Sun, 28 Feb 2021 19:48:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BL0PR04MB651426DD935C27ABF775B8B9E79A9@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/21 6:49 PM, Damien Le Moal wrote:
> On 2021/02/28 4:55, Jens Axboe wrote:
>> Hi Linus,
>>
>> A few stragglers (and one due to me missing it originally), and fixes
>> for changes in this merge window mostly. In particular:
>>
>> - blktrace cleanups (Chaitanya, Greg)
>>
>> - Kill dead blk_pm_* functions (Bart)
>>
>> - Fixes for the bio alloc changes (Christoph)
>>
>> - Fix for the partition changes (Christoph, Ming)
>>
>> - Fix for turning off iopoll with polled IO inflight (Jeffle)
>>
>> - nbd disconnect fix (Josef)
>>
>> - loop fsync error fix (Mauricio)
>>
>> - kyber update depth fix (Yang)
>>
>> - max_sectors alignment fix (Mikulas)
>>
>> - Add bio_max_segs helper (Matthew)
> 
> Hi Jens,
> 
> I think you forgot to add the patch for reverting commit 0fe37724f8e7 ("block:
> fix bd_size_lock use"). Or will that got into another PR ?

Yes, please re-send it and it'll make -rc2.

-- 
Jens Axboe

