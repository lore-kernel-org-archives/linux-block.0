Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7FCC61DA4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 16:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBPQRA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 11:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPQQ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 11:16:59 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552845264
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 08:16:55 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id g14so917316ild.8
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 08:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NiHnpNhZP7BIDUTVtGU23j1cQmK5RDYI1duz3OgctY=;
        b=Y/CXA+g/EXskLmDruYLuYFsVoEretHSkp2p5oh1Hcl/Ls7rIN2vkDnP8kkjzWjRqtA
         M3wOn+HRlTrjkstnFEtvOklb8B2Zp26mqxUWyj3QHXBIedVP+YvFkT44RRVt6qBuxMou
         W7JhyIDKv4JswBF4HKo1MpMoMev/8E04tPS/pDF+GDiyFqZzUfhd67nKvf4LZyia4V5H
         8hpX+5pXiWKlm4pEy+U4X2svO4dSkz3V8ifBK/jPjfLvSsdUiMrNotr2aWVpS08bpCbg
         QLnmOfOTXBMMhergFEdmjRl8J0srxgjE/HChj4zQZXrzG1izgSvlbShyqGjxP5PfO3JB
         ungw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NiHnpNhZP7BIDUTVtGU23j1cQmK5RDYI1duz3OgctY=;
        b=bFZXHUpOKzSo9c1NZVachpOwbLIoir0G0EmlJDiRMpD8J7iNn6403DYOB8jE+GBQZ6
         rSmYy/RUC9yOqwwEPkLf4LsU1y9Vnj98BdFWICdWOfy61/Az0IWVeyHj9932m5gBNUk4
         /Mhr1n2J3nyJOSnujmg4zHtgkXGCaAa/U8YUgNdzGkyxOCukEwqxCAwuSpJWfLwZ9rZY
         WZB9zZUI/tFu345mxH2KvKPsHeBv2r3LZfjcMeCvt4A5kZwnZwyCPs0OQUP4Jsk4eTwH
         S3mvZOxk8rk9VNtBxTi0qcU+DKeTGXgQacQ4uCfTEMjn/ILgIaCalIBPhwicyC6wVvUu
         pSAA==
X-Gm-Message-State: AO0yUKUWwo8DOHH857xpDhnuZQ9hT+BROktZF5UqMPsv0tiUzJqKdtIa
        wSDdER6qeA49f5aEj+c4dTjrdw==
X-Google-Smtp-Source: AK7set/ZPT7bRG6m1ScviXOPT189h+FyLgYwCq/Tc08eaupOTCQpi/OlYawBCa/NtWMNrTW1EJOfFg==
X-Received: by 2002:a92:d98f:0:b0:314:1121:dd85 with SMTP id r15-20020a92d98f000000b003141121dd85mr4135516iln.1.1676564214656;
        Thu, 16 Feb 2023 08:16:54 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i15-20020a056e02152f00b0031537da6ba3sm521124ilu.87.2023.02.16.08.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 08:16:54 -0800 (PST)
Message-ID: <ebc08e60-4be3-e517-90c9-09a9a5ccd7a1@kernel.dk>
Date:   Thu, 16 Feb 2023 09:16:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/4] brd: return 0/-error from brd_insert_page()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20230216151918.319585-1-axboe@kernel.dk>
 <20230216151918.319585-2-axboe@kernel.dk> <Y+5UYrUgp9lg8zRD@infradead.org>
 <e4fb52d3-25da-4796-2f79-d9630b7168d6@kernel.dk>
 <Y+5WgmTEbGP5oz8P@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+5WgmTEbGP5oz8P@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/16/23 9:14 AM, Christoph Hellwig wrote:
> On Thu, Feb 16, 2023 at 09:12:33AM -0700, Jens Axboe wrote:
>> On 2/16/23 9:05 AM, Christoph Hellwig wrote:
>>> Looks good:
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>>> Cc: stable@vger.kernel.org # 5.10+
>>>
>>> But why is this a stable candidate?
>>
>> Only because the other patches depend on it.
> 
> But none of those is stable material either as I can tell.  It's
> a fairly simple and nice to have enhancement, but not really a
> grave bug or regression fix.

It causes a big perf regression when swapping between IO backends,
and even caused confusion for that initial reporter. So while it's
not a very important crash fix, I do think shoving into stable is
prudent.

-- 
Jens Axboe


