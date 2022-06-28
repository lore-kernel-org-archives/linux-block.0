Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE47C43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 12:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345804AbiF1M3s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 08:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345802AbiF1M3r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 08:29:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372592DA9A
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 05:29:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l2so11265172pjf.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pr2zoFiTpkXzREMQfcijXKJTIDFAzV0VhNSAPpthVqQ=;
        b=ifpubo96w6hYYBA5bS4pC0BgGcTHbWsX1lMI8OvWIc4nRdQ+Hx1DFZJ6h2jvylEDSv
         GLC5tKYdjBY7NzdsRz+mSm+BCF5m5esF93Nfo/+fgWlCpoYgpyhfrRJxvBVgNhj6ZPKS
         PcpCqR3tPmiN139ZYFyDz34AhhGuPROq8LcILehKKF39f/DF8W57JOTi9WpjvDTq7D3i
         Jt+bcL8sd68l7GtahWhZ20eF+vyVtVgQrWq4H6ng2rUruulLKxjq4uHVT7AwwCKO3Arv
         bxvNGlZ0LB21oJ/A11zQswh9QFHmY4qVbzayuNZgLAIHIlt2PLG5zZ3sjZ0l2lOF27gW
         qMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pr2zoFiTpkXzREMQfcijXKJTIDFAzV0VhNSAPpthVqQ=;
        b=asMHf3a9J7ZuAfPEaObTFuxtYHmnm3vdHtq7I6sEtrPn3yoOBsy+5fEqKc1kySAJQW
         um5ta+V8RUu8GbLRROiNJqL5IIBKIAUQhG/Y3QOlS3TUsZI0yuXpGJU7BAn1yXiJU55q
         r2EqTwC1wSETMgfEE7DaZ7IgXqC0xDe4kRso4VCffmgQOEIz5BbFTRLOXr+RAhmP0EoI
         AyoKJdc8fZ42CyjORIVM9XPv3Bi/meArqwHhdJXN6N2G8Cn/z6C4dNvRImid1k+ozgsJ
         7zs0prG9U3US+ykhEhgkLUqbu9Q9kx4CJFjGyP4Tb8BVBxGYcHqBZ3VUfANPDVL+ab2+
         7n1w==
X-Gm-Message-State: AJIora+P8lEsiAarBvcaQd/7VKHsKwAaqEs6oJUbjEUsgINbFmKs0Nxy
        bX9Tx0SYWq0kwlcV70dNnOlGfQ==
X-Google-Smtp-Source: AGRyM1s3PsYtz9bnCpb08r1y8xQ4WeVyG72BF/0afktbEPpoTwa9RGJHVMgCdUI4626iicGrFkuzdQ==
X-Received: by 2002:a17:902:c950:b0:16a:6b0c:a2e with SMTP id i16-20020a170902c95000b0016a6b0c0a2emr4612887pla.36.1656419385615;
        Tue, 28 Jun 2022 05:29:45 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b0016a4f3ca2b5sm9175371plo.277.2022.06.28.05.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:29:45 -0700 (PDT)
Message-ID: <bb56a578-741a-6eb4-a66f-3c774d0a24da@kernel.dk>
Date:   Tue, 28 Jun 2022 06:29:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: fully tear down the queue in del_gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <67dd8d1c-658c-8833-9630-79ade736b348@kernel.dk>
 <20220620060948.GA10485@lst.de>
 <1e3f054e-eec6-be87-7039-e2b4260addc2@kernel.dk>
 <20220628051139.GA22701@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220628051139.GA22701@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/22 11:11 PM, Christoph Hellwig wrote:
> On Mon, Jun 20, 2022 at 05:16:03AM -0600, Jens Axboe wrote:
>> On 6/20/22 12:09 AM, Christoph Hellwig wrote:
>>> On Sun, Jun 19, 2022 at 04:21:39PM -0600, Jens Axboe wrote:
>>>> On 6/19/22 12:05 AM, Christoph Hellwig wrote:
>>>>> Note that while intended or 5.20, this series is generated against the
>>>>> block-5.19 branch as that contains fixes in this area that haven't
>>>>> made it to the for-5.10/block branch yet.
>>>>
>>>> Side note - I rebased on -rc3 anyway because of the series that went
>>>> into -rc2, so we should be fine there.
>>>
>>> It depends on elevator/debugfs teardown series that has not made it
>>> into -rc3.
>>
>> Guess we'll rebase for -rc4 again...
> 
> As you'd done that, can you consider this series now?

It doesn't apply cleanly. I'll check if it's something minor...

-- 
Jens Axboe

