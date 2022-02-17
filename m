Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B22C433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 14:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242236AbiBQOzf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 09:55:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242241AbiBQOze (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 09:55:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5602B2E00
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 06:55:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id om7so5781911pjb.5
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 06:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Gtr/RxsviZ5tCz0Bvt9jFmBxJ4FzXAbaGSbJElz/Hlg=;
        b=RP7AQlvkfeyRpEygxSQlTGe6YiucyajrKNZ4j2hs8dxrxbOzhwdAjmuzMhSXrnPt1c
         sny5HzykjZTUwFYcF613btPpzWCTxDY1j5wRZK396jirf7OMFgu649fDpCFyebrafdeG
         RnSHJknmwSjudEtRmuN9INtjpMjAMBfnvhjFILCzmwDxH0liEGGIY5hPQzFOUwOxpnJY
         zy4U1fENYzFqWYZfBVexpReueospH8JHhAGfLUg9sSummfXjccAJxvdS2vlQIMoHXiIe
         FZn/OmNGkZPFj63d+yMQR67slCb6+k0EGJ58QDfqVCieoff++Ce4wWVz/akRdrferrbx
         sWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gtr/RxsviZ5tCz0Bvt9jFmBxJ4FzXAbaGSbJElz/Hlg=;
        b=mBOvSZpELK0mASuZYeyb5FIUByChB6XzNIrG1wcdRQuxikQnpa7yLwbEccT2UORNLS
         VjiKgePZPhhSIjhAAtf0TSefsqBvUtwKwNT1uMk14lRIvJbJIPpID/c1s66iheXRnevz
         /ueaFNeuBUZg8+84btHHpGVo287RO9UUqCX9mt+QoJK9Vv0WPiKhI/LkH8ISfMDyyvNT
         VuUH/PtPrqOYgPCIt+2NE3UUIuYjA3Z/dBEcQpHS/v7YKV1rgHqCZRnkM0gzY00wCoap
         2w6SqwzLA/+vbWouUganGhZWGDQ5ZiKaSwKoJT5HJzGOGszW4aP+d7R9aRX2GV3SoZo5
         5NSA==
X-Gm-Message-State: AOAM530/ZsTnLq4eACbRatFybdCxbbmL4/ljSSWj6GPahJK11P+aSUcI
        9aKFe2T8W0AaLxiisrox7AiHYw==
X-Google-Smtp-Source: ABdhPJxxN4fdtmNfBaNeeot2cudgg/6576pYDbt5buKEIhVRK6sNxrw74mPRD7B40QhIulki0+PgcQ==
X-Received: by 2002:a17:902:daca:b0:14d:7e1b:24af with SMTP id q10-20020a170902daca00b0014d7e1b24afmr3123388plx.167.1645109718763;
        Thu, 17 Feb 2022 06:55:18 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d8sm2040679pjr.29.2022.02.17.06.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 06:55:18 -0800 (PST)
Message-ID: <eb8e2477-d8f6-b032-6177-8ce187de12ab@kernel.dk>
Date:   Thu, 17 Feb 2022 07:55:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] blk: do rq_qos_exit in blk_cleanup_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220216113212.83000-1-jianchao.wan9@gmail.com>
 <Yg392sqFydj9p3My@infradead.org>
 <96deb063-f4ef-fadd-543b-e905495898f6@kernel.dk>
 <Yg5VnRtsrrQX4mFG@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yg5VnRtsrrQX4mFG@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/17/22 7:03 AM, Christoph Hellwig wrote:
> On Thu, Feb 17, 2022 at 06:34:02AM -0700, Jens Axboe wrote:
>> On 2/17/22 12:48 AM, Christoph Hellwig wrote:
>>> On Wed, Feb 16, 2022 at 07:32:12PM +0800, Wang Jianchao (Kuaishou) wrote:
>>>> From: Wang Jianchao <wangjianchao@kuaishou.com>
>>>>
>>>> When __alloc_disk_node() failed, there will not not del_gendisk()
>>>> any more, then resource in rqos policies is leaked. Add rq_qos_exit()
>>>> into blk_cleanup_queue(). rqos is removed from the list, so needn't
>>>> to worry .exit is called twice.
>>>>
>>>> Fixes: commit 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
>>>> Suggested-by: Bart Van Assche <bart.vanassche@wdc.com>
>>>> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
>>>
>>> Ming had a pending patch to move it into disk_release instead, which
>>> I think is the right place.
>>
>> I missed that patch and can't seem to find it, do you have a link?
> 
> [PATCH V2 12/13] block: move rq_qos_exit() into disk_release()
> 
> from Jan 22.  Although it would need a rebase so it can be applied
> without the preceding patches.

Can someone respin that for 5.17 then?

-- 
Jens Axboe

