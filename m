Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E868C433EF
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 09:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D67060F8F
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 09:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhJIJo5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhJIJo4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 05:44:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1264CC061570
        for <linux-block@vger.kernel.org>; Sat,  9 Oct 2021 02:43:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 133so5582390pgb.1
        for <linux-block@vger.kernel.org>; Sat, 09 Oct 2021 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qcraft-ai.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ah1u3rGdryLKEZSr8qONi3KYTW8xXaP8VYmQu7I06zs=;
        b=DM+sQEd8R0s55VvykaEo09ijuTVbj4g51xu3oGt31muxER76bFZvdt+Y9B2EiudfAS
         W35WtFxxcerQllaI3kx41V3dFhjlA6dtnUsn0hgnzvwty2jXX2Ukq/9Kwg0dw/yZGf+W
         V4IX2C2Z0UtNGARJuxSYC65EIJxjGxWjk8aN2ZR0bhGl5pdIY/TnHZtsyH1faNrHyVtj
         FI0rKJgfUZfE+uwVewm+uCcnIa9le2NSeuecm1+ZB+E1EjrZy9VuAc9Lb47AtljC2L04
         1EKBSpou/AV10HVD4fHOXWXVzFFMaiC5eJcRxnc25cmAak+IHzX91mc+toR1FbX2suWi
         a9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ah1u3rGdryLKEZSr8qONi3KYTW8xXaP8VYmQu7I06zs=;
        b=yLlbymKbXSJSO4ZapgKELAaQhZqTJDDrI938K1yk5CAccnogXzu06ahibj1OMYg/m9
         tFROqqs8zR/4LnRNHjgoBWt0t7dOlK3+HqFhWJR3GFtcn9s2fIu/yPUHSwkqmFRX0I7v
         z01iw+54F8zDByyzJ6V8E7CYDFFSn7tha1R1PK7Txws6bBh2GPeo9RQAHfWd+mRaW++o
         4qVm37OQCQ0jmuPSWQnzTtAlEQDpuY+61SFlFGeEJjjCCvKXtntNQw6M8AlPXgpl0Aqi
         QOKBS2wYrxeph7/sae8A9ZH+5bN//V3a5MZWCbePcfotdRxsIi091R+2wuBYvuOdOA0m
         Q1Fg==
X-Gm-Message-State: AOAM533aaFOonAzn5ZWELmGvWNUYZeWUqxOkBfMMW1CepiQiMS7b3bGm
        e/6/UfrDsAULcFGJckaJzoipoA==
X-Google-Smtp-Source: ABdhPJzSyygY4RYse7dpTLIIt5yYljy7F+9kivN6hBaigSHsPbcD170Gl/o5s87wJkO4eJeQu2kFfQ==
X-Received: by 2002:aa7:8f12:0:b0:44c:833f:9dad with SMTP id x18-20020aa78f12000000b0044c833f9dadmr14614319pfr.35.1633772579535;
        Sat, 09 Oct 2021 02:42:59 -0700 (PDT)
Received: from [172.18.2.138] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id s7sm2007535pgc.60.2021.10.09.02.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 02:42:59 -0700 (PDT)
Subject: Re: [PATCH] block: fix syzbot report UAF in bdev_free_inode()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zqiang <qiang.zhang1211@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk
References: <20211009065951.11567-1-qiang.zhang1211@gmail.com>
 <ad09fde9-9655-fc28-4298-4b43d57cd76c@i-love.sakura.ne.jp>
From:   zhangqiang <zhangqiang@qcraft.ai>
Message-ID: <d1cf5746-360a-9cb1-a69f-020480994352@qcraft.ai>
Date:   Sat, 9 Oct 2021 17:42:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ad09fde9-9655-fc28-4298-4b43d57cd76c@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2021/10/9 下午5:34, Tetsuo Handa wrote:
> On 2021/10/09 15:59, Zqiang wrote:
>> The xa_insert() may be return error in __alloc_disk_node(), and the disk
>> object will be release, however there are two operations that will release
>> it, kfree(disk) and iput(disk->part0->bd_inode), the iput operations
>> will call call_rcu(), because the rcu callback executed is an asynchronous
>> actionthe, so when free disk object in rcu callback, the disk object haven
>> been released. solve it through a unified release action.
>>
>> Reported-by: syzbot+8281086e8a6fbfbd952a@syzkaller.appspotmail.com
>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> Thanks. But my patch is ready for 5.15.
>
> https://lore.kernel.org/all/e6dd13c5-8db0-4392-6e78-a42ee5d2a1c4@i-love.sakura.ne.jp/T/#u


Thanks, there is a problem with my patch, your path is more suitable

