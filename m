Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B49EE8010
	for <linux-block@archiver.kernel.org>; Fri,  8 Sep 2023 14:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbjIHOdy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Sep 2023 10:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjIHOdx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Sep 2023 10:33:53 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789381BEE
        for <linux-block@vger.kernel.org>; Fri,  8 Sep 2023 07:33:49 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34bae11c5a6so1801375ab.0
        for <linux-block@vger.kernel.org>; Fri, 08 Sep 2023 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694183629; x=1694788429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gzbe4ajhA+W2yKZqkWGOuIQDgfAVC+vcaZ3Igb5iFuE=;
        b=Kq5++eSMT+Ro5InN3B7xJG5ZcdPmxybTTVfbiLsutTjLOfJZFmH4YK3KbBMdyXCHe/
         rosutb6BTF5tgSZqO3iSVcZt7fw5IkR0DXt730oM2HywuKmWUZwiHrv6bvhjeZb53UpO
         3o+BENClcu5anL7gg3ywlW4RNVphIslWW1ejtS26thDA9DjD4xO/hfhxiG6OyWdoat2Z
         MV1n5i7rnMr8Bum4pZM/hzvPJe8B5pjC2OBWYP6TRctvJKJn0rK5lWwvC7xKtPJd9rD5
         HP1Dj4wTCEue61IgSC/zhbrsLbJqGSlz/vjEJGC8juYhcIiA6UZXW1TxT0NnlQk0daDK
         Nd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694183629; x=1694788429;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gzbe4ajhA+W2yKZqkWGOuIQDgfAVC+vcaZ3Igb5iFuE=;
        b=bcadj4OOkYjGMLKKPpbLyxdIv3ykVktA5mks9/gFjUelSuyrZAIHvwvWVm4KA36K7e
         XUzoz27fwfIC6wFX9SNnN+Fx5rPYEaT8vZUF0SPA2Q2RW/wtDKXMM/VN7K/nh5kPlscD
         fowpVc+F8leEIiTuxo27sTxuCo2rYcVYMKfdGuWS+8lGdQWbrH7VRTygPHRv8tiY/Jn6
         y+jBihnJ9Xsm3Td3oOzYuXJVNUW1D4AwXDdVC2mXLAXaOI8rfkvVWqsfmB8qUuk24aif
         tKEXxSJPIOmAlI7HlsYO2rEgtCrfZ5LQDRVn09NJTZVV/wRvkXA0wvmkaKeBF8cZOTyA
         d5Nw==
X-Gm-Message-State: AOJu0YwKCmZubGsMWJHxkXtqk6i1yLu12yQgajyvrrs8OWqzhrGQMvzg
        9HKpPDyIOQrIBqpQH4yOey7ikU5lMAgsKt4QAtNx7w==
X-Google-Smtp-Source: AGHT+IG8q0PwC/mw5/mDCmRF3LLYGxPFJvfJJohGXmg7fr2eEzATOvCBWaaCCz+e8OetChh5QrNHHA==
X-Received: by 2002:a92:cb4e:0:b0:34f:3b12:799e with SMTP id f14-20020a92cb4e000000b0034f3b12799emr3145023ilq.0.1694183628824;
        Fri, 08 Sep 2023 07:33:48 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c10-20020a02a40a000000b0042b09bde126sm483816jal.165.2023.09.08.07.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 07:33:48 -0700 (PDT)
Message-ID: <ae3d6e46-eb4f-48f6-99b5-bd0f6588ffbf@kernel.dk>
Date:   Fri, 8 Sep 2023 08:33:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Consider inflight IO in io accounting for high
 latency devices
Content-Language: en-US
To:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230907214552.130636-1-gulam.mohamed@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230907214552.130636-1-gulam.mohamed@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/23 3:45 PM, Gulam Mohamed wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ec922c6bccbe..70e5763fb799 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1000,6 +1000,8 @@ static inline void blk_account_io_done(struct request *req, u64 now)
>  
>  static inline void blk_account_io_start(struct request *req)
>  {
> +	bool delta = false;
> +

This is an odd name for this variable...

> @@ -1015,7 +1017,10 @@ static inline void blk_account_io_start(struct request *req)
>  			req->part = req->q->disk->part0;
>  
>  		part_stat_lock();
> -		update_io_ticks(req->part, jiffies, false);
> +		if (req->q->nr_hw_queues == 1) {
> +			delta = !!part_in_flight(req->part);
> +		}

No parens needed here. But that aside, I think this could be a lot
better. You don't really care about the number of requests inflight,
only if there are some. A better helper than part_in_flight() could do
that ala:

static bool part_any_in_flight(struct block_device *part)
{
	int cpu;

	for_each_possible_cpu(cpu) {
		if (part_stat_local_read_cpu(part, in_flight[0], cpu) ||
		    part_stat_local_read_cpu(part, in_flight[1], cpu))
			return true;
	}

	return false;
}

But I do wonder if it's just missed state checking for the request
itself that's missing this, and this is fixing it entirely the wrong way
around.

-- 
Jens Axboe

