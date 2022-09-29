Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC52C433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 16:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiI2QOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 12:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiI2QOe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 12:14:34 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DF01DB543
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 09:14:27 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id c11so2938054wrp.11
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 09:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zRNiACsJhBNwJLyxdj4fXSeO8OY9w/BNHd9o7EsaQjs=;
        b=07UrhetqbWEIKNr/uqIMbAR/BMkt9WOqPuuruqPue0PdQil37Er+W8cFLs686pfe2n
         aPrblHDzDnxgqWnScG8r02MoJhKLne7exdj3NjkMfRpt/AvwNh0434aY/eHxH79J7HFC
         N6zuz9VblLbsK2gcQxDnbJP70S3t7TR/CMnAKleX1NaJBiu2pFm60bTEpZehqtlxjU2L
         wAv08rhNCzZyttNrc+M9BxAblP3CMYmneOIA5GDk3JtbYfWoe/cf7sxRAVz0ZgxoVXdR
         yx7XCz66GFrjBZpJlNfeOAEyomejxw8QNK3nqGqETiww/lcSQYIYs4TGyG2t77wbm9BZ
         B0YA==
X-Gm-Message-State: ACrzQf3aE6zkd05xIeGOCSFqdQbt6KfDNj6SPEoj5pGD4EEaZdkm6EaD
        UHLt5JTClYPkoANz35a2YKZUL1E7gPg=
X-Google-Smtp-Source: AMsMyM7jLXjhnuLLrBNRhEDkP/c3459iKiT9VPPid2SuOetdwAh5j7XhdUFGfLTh523DISz98fDnXg==
X-Received: by 2002:a5d:6da7:0:b0:226:e081:941a with SMTP id u7-20020a5d6da7000000b00226e081941amr2981557wrs.642.1664468066059;
        Thu, 29 Sep 2022 09:14:26 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s3-20020adff803000000b00228aea99efcsm4009634wrp.14.2022.09.29.09.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 09:14:25 -0700 (PDT)
Message-ID: <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me>
Date:   Thu, 29 Sep 2022 19:14:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> 3. Do you have some performance numbers (we're touching the fast path
>>> here) ?
>>
>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>> preemption disable. This is a very small price to pay for what we gain.
> 
> It does add up, though, and some environments disable stats to skip the
> overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
> assuming you need to account for stats.
> 
> Instead of duplicating the accounting, could you just have the stats file report
> the sum of its hidden devices?

Interesting...

How do you suggest we do that? .collect_stats() callout in fops?
