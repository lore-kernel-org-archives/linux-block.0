Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B8CC433EF
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 14:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DDE061165
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 14:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhKIOfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 09:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbhKIOfu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 09:35:50 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4B9C061764
        for <linux-block@vger.kernel.org>; Tue,  9 Nov 2021 06:33:04 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id f9so22703427ioo.11
        for <linux-block@vger.kernel.org>; Tue, 09 Nov 2021 06:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uOBJA2ZhwFTMkPwJxRorYWacoYK2jCfb9lxYBUDXVFY=;
        b=qn5rz2eC1lExA3/qbjvLrrnQecvAinUUO/CyHzhzjIfP2ZbTNVriPqo0wfu40mLgES
         yBA+B2nCfzxmj6jJ7PHNOSxTnKBu1mPNeOu3ZjNg3/kKLIfEu/0pkBxtcJXDYlq5ZuTA
         +f9UnocMA6YnXQmo/40G88hELNMR1bkUMWOQxraguhNEmrb9HvDAQVJMUP1/YXx5iwaS
         06ix26Mrik/ACdTSfD33tyRjnpe0aXihnDhRqU1gX4mwo5P6Mjo+OwgRsEjtabFK90O8
         pBnA4VpJKH5Dzn8A2YrKIkr67FO9OQSUB8azOCcTF8L+UiQVtnPB1WQmfsjvlHZWtAD0
         rmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uOBJA2ZhwFTMkPwJxRorYWacoYK2jCfb9lxYBUDXVFY=;
        b=MS4DoSLDcMpldwcQTQI5S555ktAek5vra/0FpyauuPA9lM3ACsp9xvPTdySDqM2VcI
         4inGvOKDiSgPkqOvWGLrn82IbXQYMSczMbAivwgg0OFgOBd7X2JfcHgLCupssZu6YxcT
         0Ll5U/Ps8Z8kiJ1cmInohL1aHDPtW5Bko9AbXEfPTzNyEK1/VEU8UNZ2XiU9QFNe5i9k
         VV1cV58BR/PfBJpnUSf5obhXhrI9/lAcvNSTk3txM2KZT+mYg1EV0Sm6VlxA3mhZ3ZN5
         bj68QhZtHd+Aruczyq6Ip8rWM4B27fnrDHLCDRmhBjeeQZbU4+7xN8QFEmYI+xr5wnbo
         M9kg==
X-Gm-Message-State: AOAM533ASaX8ahMdsXmGRqQKUqNtVZRZ6iOs0KaAhdGupC1vrfZ2h9b3
        WPHojei1eSl+HMIkyqUYBy5lQVVB+JYtDd7b
X-Google-Smtp-Source: ABdhPJyjV9YsVZNNDwhpdSfjTqD1io00DdMCooZRHZ9uAx29uAOGNiC0qmEtUW8Xuxp4cSujENOuFg==
X-Received: by 2002:a02:ab8f:: with SMTP id t15mr5937698jan.147.1636468384359;
        Tue, 09 Nov 2021 06:33:04 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r3sm1306780iob.0.2021.11.09.06.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 06:33:03 -0800 (PST)
Subject: Re: [PATCH 0/2] block: Fix stale page cache of discard or zero out
 ioctl
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de540f73-a512-0ac4-c822-d84ab931957d@kernel.dk>
Date:   Tue, 9 Nov 2021 07:33:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/21 3:47 AM, Shin'ichiro Kawasaki wrote:
> When BLKDISCARD or BLKZEROOUT ioctl race with data read, stale page cache is
> left. This patch series have two fox patches for the stale page cache. Same
> fix approach was used as blkdev_fallocate() [1].
> 
> [1] https://marc.info/?l=linux-block&m=163236463716836
> 
> Shin'ichiro Kawasaki (2):
>   block: Hold invalidate_lock in BLKDISCARD ioctl
>   block: Hold invalidate_lock in BLKZEROOUT ioctl
> 
>  block/ioctl.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 

Do you want to do a v2 with BLKRESETZONE added as well? I can do these
separately. but a bit awkward right now as my main block 5.16 branch
doesn't yet have the bdev size changes. I'll queue this up post flushing
out the remaining block bits for 5.16, if v2 with BLKRESETZONE happens
before that I'll just use that one.

-- 
Jens Axboe

