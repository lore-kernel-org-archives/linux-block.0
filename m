Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4364C3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 16:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjAQQ4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 11:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjAQQ4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 11:56:46 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ACA442FC
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 08:56:44 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id a3so9728674ilp.6
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 08:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gKb8xJoYl6ZJqTS0ZBbwa7NM5feNsZQ4ab5wEkrYrnA=;
        b=nmkwpIYVV4COrWMjAbiKd/bsMPS/czQLuIGdvISyBvXbRQ4Xy4d7ibCVtEGEOkS1Hi
         yNpiCVOAfR0HomNKwf4HP7VLmH8Dmnww+qf6lZUx2IZ3ldq3G2f1qV9NM6UAl0sL7L38
         rTkLNmuA2lT/OYVLpipq+Qr/kvhLg4Xr+99N+FFX3EAVy55RNNm+rzDXNGIPIg27GVRH
         0iVxNdpdVRbNUVT75M0CflxadC8S1kDXWuz8HomJDjn7OaqU5rhAh3uk9eijZmRadyoQ
         V4ldoOpwmitUxuylfgNyxhhXJ7hayWZKh+wmI6r/hFXTLbLbc3K3p5DKN5VGSfwwpy8w
         JXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKb8xJoYl6ZJqTS0ZBbwa7NM5feNsZQ4ab5wEkrYrnA=;
        b=o2kqxTRQtcLMNiNhN2W5MqsUC7HMs75IkcgGnu7Sv2gwtQvrzyQI7gEEIkzYQ3AYgl
         fGByJsAg/vRDcFF+nsvacoH7AfRxcNZa+54mq57zQ6HOyUHltiH1AHbdMIHucwcgGZA3
         kJp07qdQQvUEFj5Uc4VnT3vPQX5jUxwPMOZkRefHJtMyLEJ08/XifbWj2lxhpvjBxO9A
         lw2ndfKlyQ9Rmtqy8y2NpAcz18IZLoaaILZwedzDNxSoPAqgsXnsxNmUYSMPYOj3Pm2O
         8aPqwfocgkXbnJ2XJsOcUjtzMHGPS5PdtQRO/DOMXwmYlaAfcPT6uff2hLNxk70DCEY/
         mj5w==
X-Gm-Message-State: AFqh2kqsSbPotR73Ng5EMDFsN/qpg18TCP6MFbqclConvybfuWCbdUvW
        Cdww3lnINjyEKsoR4Xn5lajGzX1E1/4YlTOw
X-Google-Smtp-Source: AMrXdXvCZ/wV7Q84305D4Qv2msOFoKVH9adbWiKPObiDop7SUeQAUKGb93dDRDZI9NteSDrA9vCzxg==
X-Received: by 2002:a05:6e02:be7:b0:30e:f0e7:dddb with SMTP id d7-20020a056e020be700b0030ef0e7dddbmr651137ilu.1.1673974603735;
        Tue, 17 Jan 2023 08:56:43 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l1-20020a92d941000000b0030ef5881a51sm2602388ilq.34.2023.01.17.08.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 08:56:43 -0800 (PST)
Message-ID: <8a0c0416-2994-ebb9-42ba-66262da35ff2@kernel.dk>
Date:   Tue, 17 Jan 2023 09:56:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH for-next] block: fix hctx checks for batch allocation
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
References: <80d4511011d7d4751b4cf6375c4e38f237d935e3.1673955390.git.asml.silence@gmail.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <80d4511011d7d4751b4cf6375c4e38f237d935e3.1673955390.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/23 4:42?AM, Pavel Begunkov wrote:
> When there are no read queues read requests will be assigned a
> default queue on allocation. However, blk_mq_get_cached_request() is not
> prepared for that and will fail all attempts to grab read requests from
> the cache. Worst case it doubles the number of requests allocated,
> roughly half of which will be returned by blk_mq_free_plug_rqs().
> 
> It only affects batched allocations and so is io_uring specific.
> For reference, QD8 t/io_uring benchmark improves by 20-35%.

This does make a big difference for me. Usual peak test (24 drives), and
I get 63-65M IOPS with IRQ based IO. With the patch:

polled=0, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=64.79M, BW=31.64GiB/s, IOS/call=32/31
IOPS=73.45M, BW=35.86GiB/s, IOS/call=32/32
IOPS=73.70M, BW=35.99GiB/s, IOS/call=31/31
IOPS=74.57M, BW=36.41GiB/s, IOS/call=31/31
IOPS=75.18M, BW=36.71GiB/s, IOS/call=31/31
IOPS=74.33M, BW=36.29GiB/s, IOS/call=32/32
IOPS=74.53M, BW=36.39GiB/s, IOS/call=32/32
IOPS=74.61M, BW=36.43GiB/s, IOS/call=32/32

which is 15-19% better.

> It might be a good idea to always use HCTX_TYPE_DEFAULT, so the cache
> always can accomodate combined write with read reqs.

I think it makes sense to do so, particularly now that we have support
for not just polled IO.

-- 
Jens Axboe

