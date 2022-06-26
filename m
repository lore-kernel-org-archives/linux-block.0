Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0905C43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 14:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiFZOQM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 10:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiFZOQM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 10:16:12 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EAD101FA
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 07:16:11 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso327710wms.1
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 07:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6zCJCSVlAUXRaGnISCtHsz/5Pjr48JRZxmR0ns3GnNg=;
        b=LHUm4foAu3UR7Yx8Fl8AGeCqSs/TPCoezb0fisl9UZLar3VlQCmIdqZ9ICHItE7FXG
         hmcss5ToH5+MPaC0BQWbcIj+2BlkG1Fnrs7MkBBuSQWurNnQQmEQyovkKEBGAKEddCqn
         6dwQ3JgqMoIBv+5AmvmrywTlaKv5kGG1ImiBrNTYhG7RPkBQh3bef5L6XZ8eVIa5X4u6
         TnAh4t9qArCnm1AeFKJfBKmaVrFQJwdA9lBxwoV1qjI94B+XH/0pnQC8TwXpcIqzUEDD
         yqC8mQFF87Dph7r4OAwik7p8iUWSIrDBwOWZ3A1y8yKYOtWz2wWcyK9HqH0+9BBS/+Eb
         P6dQ==
X-Gm-Message-State: AJIora869l7LdTza4lIRrELg2b4Yuh9cpOPHAiJl9vU3SlYdOQ5JNbWi
        NVD4j59F+LkKoaQPVA+YgTc=
X-Google-Smtp-Source: AGRyM1sspwWvVudAHE6sLY9L60sphjiPlvm76BAMYyUot88IugqA5kzn6bsXWcWV02k874t3pUk54A==
X-Received: by 2002:a7b:cb03:0:b0:39e:e826:ce6d with SMTP id u3-20020a7bcb03000000b0039ee826ce6dmr14601812wmj.102.1656252969976;
        Sun, 26 Jun 2022 07:16:09 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z5-20020adfe545000000b0021b81855c1csm9515775wrm.27.2022.06.26.07.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 07:16:09 -0700 (PDT)
Message-ID: <1a253c74-9dd7-60f3-33f4-037d92c179ea@grimberg.me>
Date:   Sun, 26 Jun 2022 17:16:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] kmemleak observed from blktests on latest
 linux-block/for-next
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
 <YqavC8hwLXwPVnor@T590>
 <CAHj4cs8y5HHYjr0FtWm1AmkEY=ZqOL4OmgzrWBEhbRpu5V8dWA@mail.gmail.com>
 <YqdIWcgnEylFuSci@T590>
 <CAHj4cs-66nWX_8HvN4_j8QmrTKA9tXNrdfejPagaDNOzNTGs_A@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs-66nWX_8HvN4_j8QmrTKA9tXNrdfejPagaDNOzNTGs_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Hi Ming
>>>
>>> The kmemleak also can be reproduced on 5.19.0-rc2, pls try to enable
>>> nvme_core multipath and retest.
>>>
>>> # cat /sys/module/nvme_core/parameters/multipath
>>> Y
>>>
>>
>> OK, I can understand the reason now since rqos is only removed for blk-mq queue,
>> then rqos allocated for bio queue is leaked, see disk_release_mq().
>>
>> The following patch should fix it:
> 
> Hi Ming
> The kmemleak was fixed by this change, feel free to add
> 
> Tested-by: Yi Zhang <yi.zhang@redhat.com>

I just tripped on this myself...
You can add,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
