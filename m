Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27865C7619A
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjC3W7B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC3W7B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 18:59:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CD5D33C
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:59:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id iw3so19577847plb.6
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680217139; x=1682809139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhbe3l11Ig1Sx84Y1PVwLkM/ARWENrz36B2XEf7BLm0=;
        b=50Oi+UsoGnUN1U0T/lKsAUkYSz6o4Tr6W+IpyDNmCoJ7JOwf8di/75DWHXwIYOYVH1
         aIpPZiy/Rd+a6HAZ4JgoRqn6HIffh5PEKhUmulEO4topV6c6zz9RgtYqh1FAQ4x3Rrra
         8JGtcOEYP6/7eJhjj41YCvi2LUu3ik+dBN/bEVP6vz19aF/KpM+c7hFQNfA5EHBS/2Xx
         CygQcUNfnLEtO8SU2uyuo4vi1lqgUEeR7l67h1S0PZnttSHWngeGdYtVN2OqY3QpE7U4
         X8+SbQpCAsZb02TwRWXgxWfQac7MYm+0k9isgysT2RJ2RhfNLtKZemV5Hy22Yw3QDGwJ
         gssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680217139; x=1682809139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhbe3l11Ig1Sx84Y1PVwLkM/ARWENrz36B2XEf7BLm0=;
        b=RQBxAQrsoc4VWvrinP9OAwBY6ei8DOZx6X/eza0kVZdIxIQUMU4F0B+LFDVxSw+cCn
         aBa4h+6nwyGcc188r3ut1Ngmr/uDmhyGMFzYvgxEOCCtLPsqoN5X9A2EdwZ9SO4VAcA/
         S7cLXeGZf0RqZ4c+rG+2B1TUJohYg80PqTfh5BqxhmWcbgkJzt7TksB2ZzxgN3kJLweZ
         VoP6MWP2j5eWFt4cgmvIpDQVAk4uJP4PLg0hUqCZe618yyP8u3mxBjwxosJayvWZRliW
         +X+zUtQNAAhoHuXls5bpj5Bh1AAwE7DOExr0litKQvRHor2KSByxif9/BiNUYULEfAaP
         nE7A==
X-Gm-Message-State: AAQBX9cEasndm0nh6P+oYuCz5hqET/toca+EJNrkQkAs3FaJYU84w4Sm
        BBUHWuKhVmq1Kfx5s9f4A0+gLQ==
X-Google-Smtp-Source: AKy350Y8LiBKopcX1AUJ5EJ/pWubG3ffn7x5UnHMHTiWudXpJTjBfT2Vg5NDE8cyNsD9NQru16C8HQ==
X-Received: by 2002:a17:903:685:b0:197:8e8e:f15 with SMTP id ki5-20020a170903068500b001978e8e0f15mr21054900plb.6.1680217139462;
        Thu, 30 Mar 2023 15:58:59 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w21-20020a170902d71500b0019abd4ddbf2sm222365ply.179.2023.03.30.15.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 15:58:59 -0700 (PDT)
Message-ID: <7762317f-9875-317b-c2be-0e6bdf91e2f0@kernel.dk>
Date:   Thu, 30 Mar 2023 16:58:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/9] null_blk: check for valid submit_queue value
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, ming.lei@redhat.com,
        bvanassche@acm.org, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com
References: <20230330055203.43064-1-kch@nvidia.com>
 <20230330055203.43064-3-kch@nvidia.com>
 <3e67b995-d2fd-7518-2a55-3279bc10d950@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3e67b995-d2fd-7518-2a55-3279bc10d950@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 3:22?AM, Damien Le Moal wrote:
> On 3/30/23 14:51, Chaitanya Kulkarni wrote:
>> Right now we don't check for valid module parameter value for
>> submit_queue, that allows user to set negative values.
>>
>> Add a callback null_set_submit_queues() to error out when submit_queue
>> value is < 1 before module is loaded.
>>
>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>> ---
>>  drivers/block/null_blk/main.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index cf6937f4cfa1..9e3df92d0b98 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -100,8 +100,18 @@ static int g_no_sched;
>>  module_param_named(no_sched, g_no_sched, int, 0444);
>>  MODULE_PARM_DESC(no_sched, "No io scheduler");
>>  
>> +static int null_set_submit_queues(const char *s, const struct kernel_param *kp)
>> +{
>> +	return null_param_store_int(s, kp->arg, 1, INT_MAX);
>> +}
>> +
>> +static const struct kernel_param_ops null_submit_queues_param_ops = {
>> +	.set	= null_set_submit_queues,
>> +	.get	= param_get_int,
>> +};
>> +
>>  static int g_submit_queues = 1;
>> -module_param_named(submit_queues, g_submit_queues, int, 0444);
>> +device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues, 0444);
>>  MODULE_PARM_DESC(submit_queues, "Number of submission queues");
>>  
>>  static int g_poll_queues = 1;
> 
> I would do this:
> 
> +#define NULL_PARAM(_name, _min, _max)                                  \
> +static int null_param_##_name##_set(const char *s,                     \
> +                                   const struct kernel_param *kp)      \
> +{                                                                      \
> +       return null_param_store_int(s, kp->arg, _min, _max);            \
> +}                                                                      \
> +                                                                       \
> +static const struct kernel_param_ops null_##_name##_param_ops = {      \
> +       .set    = null_param_##_name##_set,                             \
> +       .get    = param_get_int,                                        \
> +}
> +
> 
> And then have:
> 
> +NULL_PARAM(submit_queues, 1, INT_MAX);
> +NULL_PARAM(poll_queues, 1, num_online_cpus());
> +NULL_PARAM(queue_mode, NULL_Q_BIO, NULL_Q_MQ);
> +NULL_PARAM(gb, 1, INT_MAX);
> +NULL_PARAM(bs, 512, 4096);
> +NULL_PARAM(max_sectors, 1, INT_MAX);
> +NULL_PARAM(irqmode, NULL_IRQ_NONE, NULL_IRQ_TIMER);
> +NULL_PARAM(hw_qdepth, 1, INT_MAX);
> 
> That can be done in a single patch and is overall a lot less code.

Agree, let's please try and reduce the number of patches in a series
when it's not really useful to split things up.

-- 
Jens Axboe

