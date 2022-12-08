Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7604DC4332F
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 16:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiLHQSx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiLHQSr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 11:18:47 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F349AE4E7
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 08:18:42 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id m15so1211911ilq.2
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctZSmVwq25g3/U7jp9KaoppQJYFYzMgA0WsTkJEN6m8=;
        b=qTmufAa8AHrzWjRZ8+GYLPVMM/Ls4JV1J/f+IPlnahk5mdpjylg/JfLQMsICmEKIqh
         ydCSgBmCkCu/sRHs5rRIqkMOjRDHoB02U6X9+ePrYsNGPEUPFTphBzgZEZwhk0AOd3Ew
         lDg26VlfuOW2W97+Rqppk4Wud5v2KCVXgx+/Hkg/1zDNJelx1cr9mbo5uF0ddVXuSoBU
         TdN76YaYXaCJZ8WP4vBuJ5UaiKAX/6QU6jNd+XcKcE7hatVe2JfBjpIUqtwQDKsBdwiu
         8QlSEA0D6hMqlbRn7p1E1jXdBcxBND9syoYc78MwtdjjCT9rdOSDO50pw3g0LO0F6TAi
         2Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctZSmVwq25g3/U7jp9KaoppQJYFYzMgA0WsTkJEN6m8=;
        b=fu9w2l/Hd0U6XJ75bCy1EneTai6TIAjYOVmdKLj+2oXI9/XA25qK4700VGGVJTqyqt
         vn4vkzV/EptN6qv7jQtP/dKf6zxcbkcbqs0RB1T8SQ71Yx9uKb+YsyZpGYKax55ZMhgB
         9We3kwwT8Vz5SKNRJ1SrqqBvcNja32dAGSgGvMImgwYwXmA+ZZtLo9XLNrA6EyOusGgR
         zxWx2F685EjYbajfKKolB5Ol8CrU3F5IK6z2IH8uL1ZFjiiP2S3UFWqvXcmUgkvSfMnT
         +RyMTXo8tB9TFiJqOf2hfdHCqTh5ipckFpKb0WeAwuUVP5wTD7doPQCQA4pvnxdMajZN
         lFbA==
X-Gm-Message-State: ANoB5pnG4yoirMNVF6pif0KjV5BUJcxB9Vg+U0Quy3zRHo0ZM4UUTz2e
        572sVwri7SjlS/AGyNH6KC9bNw==
X-Google-Smtp-Source: AA0mqf5bxhLp30WdMBhWMGOrtZWnNZspHKH9tf9BbcEhMNjasWPACoezdxUQTGpX2Gsj5NFl7OEcDg==
X-Received: by 2002:a05:6e02:f43:b0:303:814:dc0d with SMTP id y3-20020a056e020f4300b003030814dc0dmr26457795ilj.131.1670516322135;
        Thu, 08 Dec 2022 08:18:42 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u6-20020a92d1c6000000b003036d1ee5cbsm897082ilg.41.2022.12.08.08.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 08:18:41 -0800 (PST)
Message-ID: <ffce679f-0062-f514-1504-c92c63d74850@kernel.dk>
Date:   Thu, 8 Dec 2022 09:18:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4] sed-opal: allow using IOC_OPAL_SAVE for locking too
Content-Language: en-US
To:     luca.boccassi@gmail.com, linux-block@vger.kernel.org
Cc:     jonathan.derrick@linux.dev
References: <20221202003610.100024-1-luca.boccassi@gmail.com>
 <20221206092913.4625-1-luca.boccassi@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221206092913.4625-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/22 2:29 AM, luca.boccassi@gmail.com wrote:
> v4: add reviewed-by tags, no other changes

Never resend just for that, normal patch tooling picks that up
automatically hence it's just pointless noise.

-- 
Jens Axboe


