Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EBFCDB474
	for <linux-block@archiver.kernel.org>; Tue, 17 Oct 2023 14:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbjJQOXk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344079AbjJQOXj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 10:23:39 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6232100
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 07:23:37 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a6643ba679so3375139f.1
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697552617; x=1698157417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUK3i88RgtZNO3OWoEbzGm6ivEKChVWTjmfRDA7FSEM=;
        b=dgMgDcE/tfir5k65/E27bJlM5hLQsYMldLy2aKiOQ11us1CpxT7+9gudr68BH+KD21
         C6RCcn6qHNCYVh8p6N9AZCZ1WhasQly/lSO0ppFRAZ2rgIMC+YO1IkFgP07X7c6ZS8xE
         7G80qvzzaxTnO9WVF7/J/eisbT3/JsoJHcVNVZ1/A7SjHnxIKvp8T0eiQIVZrbt+6lLk
         Ym2xUYTFkoY0RI+E8Npskll/R8+ETCD/PFU/7/2NFzd+XcKXaUzc1fp9/nHd/8Q8RBaY
         fRfFHuU9BLqZrxXBRA+YubKXypaBpoLKxS0VnoGZEbPjX/4bRXhK18CR2WKnj/icdoAH
         kZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697552617; x=1698157417;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUK3i88RgtZNO3OWoEbzGm6ivEKChVWTjmfRDA7FSEM=;
        b=QRLj65CUN70uopm2lFYt+s7ZbNqPotpv+s5IywmNPNy0C2wa7n4HZv1rx2/X49eCTe
         Me4fJasMZI5W6Q1qSn4zMHrAhbVA4BTIuHOskPg9ih3BxbRUaZ/dG7b1oYyA6rrIULFj
         x83q8WBv/SrPFs4ux0RzF49D5/H01G/1kjZp7eqdabbT66syWI3P1h88rCtwL9oXk3u0
         htMnToYmxIldnQebtTjlO6arV0oBCCiEK2cm8Kmi51N0p6fEF/KxZKsZlWPmU0cZwIZR
         IedXSxeN3WnD8Is4xeYdsF/djmIw3BaV/GlGaqvzsM1Vn3TNQVnpjjVqmcgKmffmMIY8
         aWZw==
X-Gm-Message-State: AOJu0YzFLfoQ5iudHwxdUerBcf9Z4HGGBk43rQpvEEX7rvP4W23+Wq7L
        WPwGJSvPREhNWo3y4tgm+f9m9g==
X-Google-Smtp-Source: AGHT+IH3zMO3MDHns/1alETuHnmUTqTezjlwH1M/l3k0cyFRHWz8AuUgV50XGV3b3lNQ60KZ9InsJw==
X-Received: by 2002:a05:6e02:2145:b0:34f:7ba2:50e8 with SMTP id d5-20020a056e02214500b0034f7ba250e8mr3042389ilv.2.1697552617128;
        Tue, 17 Oct 2023 07:23:37 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s15-20020a02c50f000000b0045b4a059a57sm536368jam.44.2023.10.17.07.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 07:23:36 -0700 (PDT)
Message-ID: <8f239910-af73-4363-abca-d35c5d6d3216@kernel.dk>
Date:   Tue, 17 Oct 2023 08:23:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Consider inflight IO in io accounting for high latency
 devices
Content-Language: en-US
To:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231013195559.1306345-1-gulam.mohamed@oracle.com>
 <35e3e173-8018-42d8-a6e8-7ba994ff6b17@acm.org>
 <CO1PR10MB4563B1B650C89FA32B60AE1298D7A@CO1PR10MB4563.namprd10.prod.outlook.com>
 <d10c329b-85c9-4bc2-be00-f156c48639e5@acm.org>
 <CO1PR10MB4563AA8AE670E9EDBF3AF32B98D6A@CO1PR10MB4563.namprd10.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CO1PR10MB4563AA8AE670E9EDBF3AF32B98D6A@CO1PR10MB4563.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/16/23 10:13 PM, Gulam Mohamed wrote:
> Hi Bart,
> 
> Thanks for the review. I agree, for low latency devices if they have
> single hardware queue, this patch will have significant impact. Can
> you please let me know about what kind of low latency devices will
> have a single queue (just for my knowledge)? Also I would be grateful
> if you have any suggestions to fix this issue?

I mentioned this last time, I'll do it again - please follow normal
mailing list etiquette. Don't top post, and don't do those
unreadable/unquotable "see replies inline".

As I told you last time as well, the problem with the approach is
exactly as Bart says - it's expensive. Because it's expensive, you limit
the fix to single queue devices and then hope that this is fine because
of some ill perceived notion that single queue devices must be slow, and
hence this isn't a big problem. But this both misses the fact that you
could very well have single queue devices that are much faster than the
one you used to test with. Those do exist.

This doesn't even address the fact that presumably this problem isn't
specific to single queue devices at all. You may only care about those,
but as a fix, it's lacking as it doesn't apply to devices across the
board.

-- 
Jens Axboe

