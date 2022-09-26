Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49FFC6FA90
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 15:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiIZPy3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiIZPxV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 11:53:21 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BE180BCA
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 07:40:57 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h194so5389564iof.4
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 07:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tk/+gqpQ1KXTISitaamlovnrYdNLaPJtPsu2SpLlw/s=;
        b=qc9goE6U37XX17RWcd919/FtI5JV3QyR1TUDkZCT3e0mXsJUCkXe72GQKroTkKKVTr
         04x3VHTYC24DZh4KzOXUqLhpJ0yzO6uUM8vPJzd+Siq7qLuUbfWLJ4w52nATHUJ9Aptv
         k16DeHFJUMwYOaYzs75/aKo9ILiEa+vBmj46SJRNWFLwOHEbh9XhiImkvRGHW3s1sgxB
         X3net6+IAkk3EHqNvVyHnSB0S4vJdbsiHMcI5aGx01a3CiLuci7x1mMQgxQiEJ9u1TUn
         /VIgLlExn7T1Q2uzU3JvBdydODlyOWQ45b0sC15SmCPjldP9Abc7QzyecvShscAMFIdA
         N3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tk/+gqpQ1KXTISitaamlovnrYdNLaPJtPsu2SpLlw/s=;
        b=EWLp8O4e8+UlMKBHH+MCl2pzscaiwx5e4DUKGgiOiSTbMTDkd+HM8ZVcQVkvDMq2T8
         q/gDc9d1teDYeLjrXP/g9F69eM1r8FtB7Ofq3nPvVUMOQqoNdltbehPDDx+GkxhGiYSQ
         I7bb9ms3qvCo6PNaJ2UTJq+5a75B+PgtAf5ERMhEA3NQbXDMbL3WHAeTrbZodHrjmD+d
         dkbHsbDQdAw30MzVEeleUBW0rqOJvwuqumicGT5sVXo1TsqmGOIpyfljFyFzYws/D4r9
         T5vO/F43LccwGuIfalSo1dLZlRaqOpEWgMhsRKwm9oCFNDrdEkRyTaJTsfvAjMTw0TTo
         Q6Rw==
X-Gm-Message-State: ACrzQf2/3emqBTNOVQkURppkqCrfU74ABZsyiLhMvaBgpNEdrOueDWP+
        eskCwIaNm7GvUD4AtrEGjagJT60C9/ct6w==
X-Google-Smtp-Source: AMsMyM4KkyccGm+yn6M5855hb+VMVxKe/IKxI6Y06N3md8NepP8+d946YaCEyFoHfioyeFmvSzszrw==
X-Received: by 2002:a05:6602:168b:b0:6a2:c6d1:d4e4 with SMTP id s11-20020a056602168b00b006a2c6d1d4e4mr9861426iow.190.1664203256828;
        Mon, 26 Sep 2022 07:40:56 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l5-20020a023905000000b00342cb39de68sm6900499jaa.130.2022.09.26.07.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:40:56 -0700 (PDT)
Message-ID: <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
Date:   Mon, 26 Sep 2022 08:40:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Cc:     linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        gost.dev@samsung.com
References: <20220925185348.120964-1-p.raghav@samsung.com>
 <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YzG5RgmWSsH6rX08@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/22 8:37 AM, Christoph Hellwig wrote:
> On Sun, Sep 25, 2022 at 08:53:46PM +0200, Pankaj Raghav wrote:
>> Modify blk_mq_plug() to allow plugging only for read operations in zoned
>> block devices as there are alternative IO paths in the linux block
>> layer which can end up doing a write via driver private requests in
>> sequential write zones.
> 
> We should be able to plug for all operations that are not
> REQ_OP_ZONE_APPEND just fine.

Agree, I think we just want to make this about someone doing a series
of appends. If you mix-and-match with passthrough you will have a bad
time anyway.

-- 
Jens Axboe


