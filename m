Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C899FC433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 04:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiC2Evc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 00:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiC2Evb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 00:51:31 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5A7DF4B
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 21:49:48 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id o13so13829687pgc.12
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 21:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=bUMeuEEAFQSSjo+N5vaN4Ddn9irns9qEGOPq3Qwm1/Y=;
        b=oMGBIN2vZ/4ZKqrCF0T4xP+1lD3sHZLdMomLujpJolg2v8Etv0eDPU1WA1XDdcorm/
         gWjFc+mRNH4tajUczduop860l2oofnhWmkiJXydEceZUWRV/PpnXNbpwc7uLb9KWl9G5
         Kk3/CgqYhohuo850w0Jfhq1OKUV3ZUdxcNZ1dHZjMEYV5TXYtHWEGEjuxd17/NfSeX4M
         X0SQtKdpyoCQdqzQFww49Z7z2jz0OPVgmG74QCEOISGaRw1p5Axi3xsEqIzAY0BDzniW
         gLSuehQ1eckWWOwUdKr067H7IeDxdsYJ4BJQpi4B3cAu5sW8ayz2oDemnp0k/iTZ5l1b
         47/g==
X-Gm-Message-State: AOAM532Tz+m/VKnzBqQC8aQAU23zbwe/VzdJimoXADveJiSj4KEP9sSF
        ayA5qIkTmo/aVScNcwdz+t5B2w6JOpk=
X-Google-Smtp-Source: ABdhPJxYL02ucMdyli2l6bcorLqvFhTtOGyqdYN+LyzJbN8hr67WLVOgLrNjMvF2cj8EFBhiGgUXag==
X-Received: by 2002:a05:6a00:18a4:b0:4fa:ee98:87bb with SMTP id x36-20020a056a0018a400b004faee9887bbmr24338709pfh.2.1648529387909;
        Mon, 28 Mar 2022 21:49:47 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id p13-20020a056a000b4d00b004faecee6e89sm17231591pfo.208.2022.03.28.21.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 21:49:46 -0700 (PDT)
Message-ID: <3d4b4c68-0c9d-b4bb-3ce1-14ee5417ba19@acm.org>
Date:   Mon, 28 Mar 2022 21:49:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prioritize high-priority
 requests
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210927220328.1410161-1-bvanassche@acm.org>
 <20210927220328.1410161-5-bvanassche@acm.org>
 <Yj22kLrsw+z7sj7R@pengutronix.de>
 <180dc22b-4fee-93c2-9813-1b4f109b5dc7@acm.org>
 <20220326085755.GB27264@pengutronix.de>
 <844fdda0-37d2-4335-d755-1348482201a9@acm.org>
In-Reply-To: <844fdda0-37d2-4335-d755-1348482201a9@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/22 19:20, Bart Van Assche wrote:
> Thanks, this helps a lot. can_queue = 1 as I was suspecting. In a quick
> test I noticed that I/O is about 10x slower for queue depth 1 and the
> v5.17 mq-deadline scheduler. I will take a closer look at this tomorrow.

(replying to my own email)

Please take a look at the two new tests in
https://github.com/osandov/blktests/pull/87. The results of that test for
kernel v5.13 show that enabling an I/O scheduler speeds up the I/O workload
except when using BFQ (times are in centiseconds):

# cat /home/bart/software/blktests/results/nodev/block/032.full
bfq: 465 vs 452: pass
kyber: 243 vs 452: pass
mq-deadline: 230 vs 452: pass

The results for kernel v5.16 shows that enabling an I/O scheduler slows down
the I/O workload up to 2.2x:

# cat /home/bart/software/blktests/results/nodev/block/032.full
bfq: 920 vs 419: fail
kyber: 732 vs 419: fail
mq-deadline: 751 vs 419: fail

In other words, this is not an mq-deadline issue.

Bart.
