Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07F1C433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 01:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39FD611C6
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 01:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhIPB6h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 21:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhIPB6h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 21:58:37 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70710C061574
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 18:57:17 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id j18so5947709ioj.8
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 18:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mbZDMGQjWpQ+gxbToWOCapJIyG5E9b9I4gWLDQXaSQA=;
        b=JhUmQ4qpr71CUyqIum+7DaxlPLov7NxANsSmoi6jPs2721+yQpvfZpWePAE92uampN
         VOz/vnQnFTPThIaRq0BupUgGLTBvR9sKazT0ZGvnvkWxAmHIga3dtZXp0BRQ2MQEp4nD
         rEX8uNA657MLpGN/Lg0QmY6mGT52twQP7tPTbNCdz0UdGJ58M+NxuJQRQT5kvtMnPwpE
         No2ENhHzIYw4aKrtgRrzQqTsriGR/i16KXh4g2TXQfRxrwypLOpMyW1YrMUBiZqQo1lO
         Z4Rkjomudq4vw8vmAUt/Akaj6BCxMShUH1YoFgpOE7jUIoa42E2qf8gYLwV2DojZjBwQ
         FH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mbZDMGQjWpQ+gxbToWOCapJIyG5E9b9I4gWLDQXaSQA=;
        b=2ONQ/qajeUTTV2+EsES/TQTsFeKqavriatrRze/+PLTtf3X34ZAz4dxCVeHXR6fAyN
         N3rnAN+XU1ZhNCwxB4mQ4tuvrR4qCZGHHjS61SaflJaYvrlwIq2VUjnQuTFeZ/oU4WJ7
         bJ+LcmNeQd4bKsytNFMqJN+rPxqm/NKJ7NZG4YNXWAdy3YT30umPAoWSWHdyGrcVhRXz
         CvOZGSG+ATbNG3vuNyau69gyM4ZaI1psVwEUP9cL8muDTFekK3GsjxEvh6tIVoTG9M7r
         10wiqtI2gzH/R+OsSDlbAYWqRa6wTNZ2hy+ZiGctILKapd2itLnatba6oPdUAAb3xo8d
         7vdw==
X-Gm-Message-State: AOAM533p+/GrmyqGQOmkQgyLQ63q1oTbp8fzKfRzzpkX8BR3Hhoq3Br1
        VOGRyZbCv3G/0zYQpCFMXXH0Skz69/wsZg==
X-Google-Smtp-Source: ABdhPJzccFBO/elMLEvUj3TYgjS8IjeqV+Kzd/3EObDYV4dExu3FvWjSFe71Id0jzFvrJW3BzgEL3Q==
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr2443793iop.166.1631757436676;
        Wed, 15 Sep 2021 18:57:16 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i14sm950663ilc.51.2021.09.15.18.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 18:57:16 -0700 (PDT)
Subject: Re: [PATCH] null_blk: poll queue support
To:     Pavel Begunkov <asml.silence@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
 <1a63be84-3024-722b-232b-90f606a2addd@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1002cd58-63b6-453a-93c0-774928690e5f@kernel.dk>
Date:   Wed, 15 Sep 2021 19:57:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1a63be84-3024-722b-232b-90f606a2addd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/14/21 3:38 PM, Pavel Begunkov wrote:
> On 4/17/21 4:29 PM, Jens Axboe wrote:
>> There's currently no way to experiment with polled IO with null_blk,
>> which seems like an oversight. This patch adds support for polled IO.
>> We keep a list of issued IOs on submit, and then process that list
>> when mq_ops->poll() is invoked.
> 
> That would be pretty useful to have.
> 
> to fold in:
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 5914fed8fa56..eb5cfe189e90 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1508,7 +1508,7 @@ static int null_poll(struct blk_mq_hw_ctx *hctx)
>  		cmd = blk_mq_rq_to_pdu(req);
>  		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
>  						blk_rq_sectors(req));
> -		nullb_complete_cmd(cmd);
> +		end_cmd(cmd);
>  		nr++;
>  	}

Let's try again with that...

-- 
Jens Axboe

