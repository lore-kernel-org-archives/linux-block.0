Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C6FC5479D
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 00:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjAJAiH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 19:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjAJAiG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 19:38:06 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3561015
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 16:38:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so14667290pjj.2
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 16:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdnD0Z4aZnwFCrphznvK3m0v1xd8xN1FxzDDqS4u268=;
        b=OVEIFhPfjW/eQdM/sXnBuoHdXxGkgJsKpfDVm+QPf/f5TYtvbzFDD9HRsXq2Wkpbr5
         x1+3rvin9NohjnTZkDFFrz3jL1EG/hb0r+VBrPfY4KtFpvJxoMAT6DGHR0mcMegauVlj
         ZnI/T87SDy92N3Sd1yYCRngs0Y088zoeW6IBgHx9Ww6I5TVhkcHqm8lU5npXaa/iX161
         iFjkAcBcLCSLU/btNf6qSx1qb4nyk0N+ZcUqfPwiYHLOXaMNRK0fyJiBfN1t7cG6QOdT
         B8qOIbL93bmDD6Ta0OqmAE+ykeUlnFZD93MGYgQbJvA4oIu2sRoi31Zb3Uv3vC4weRg+
         h3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdnD0Z4aZnwFCrphznvK3m0v1xd8xN1FxzDDqS4u268=;
        b=ba3N9u23u9omc1R2OecrhHjc7w1ibsHZosXJqg6HSPjvPT0t4wv2FfOEkZnVrq4jbN
         EMBbxhKPoIjXvV/skH89xtfDjWwq0Qf7L+gaUOmxroN4XM2N6BJWdfQ7jiT10szid1sB
         u8MAO8pa8vC7frDm78qdChyEkrUcbyaVkkHzVhDMQ+zOfF0szqxizZmwpvrYM2AbzsgM
         9Z/PTN2bV4m8D5R2VWwDS1RZeKfGClb9I/1QDCTeFoBadfB46/sLeFo8Mz+p1VQmvE8m
         jGPktbunTSBgvAqv5CDn5gt2AboXITcll4tpMlArH4PgcHla2RncuAlADyHwJs/Epcdf
         7KLg==
X-Gm-Message-State: AFqh2kr0PQIo/O+voG32XxNHRQ239eCz1yAD5J+ls8cmiRx9N3OYpI8y
        D56/qiR5+POC6p1i2ta4AzF6WvfAVDhHS/1E
X-Google-Smtp-Source: AMrXdXukhaYOIb1yNBqoBOhxsmCoNfSDosdPJLPQYIh7scx08aU9zVzQ6T1hIIBtkAtDNUN9la9JIw==
X-Received: by 2002:a17:903:54d:b0:189:f460:d24b with SMTP id jo13-20020a170903054d00b00189f460d24bmr15621201plb.5.1673311084593;
        Mon, 09 Jan 2023 16:38:04 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ij4-20020a170902ab4400b00192ed1330c8sm6601635plb.260.2023.01.09.16.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 16:38:04 -0800 (PST)
Message-ID: <2f0f4f28-4096-ab76-5be3-56c44231fed3@kernel.dk>
Date:   Mon, 9 Jan 2023 17:38:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
 <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
 <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
 <681a991f-e09a-eeb6-805a-ee807250c399@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <681a991f-e09a-eeb6-805a-ee807250c399@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 5:32?PM, Damien Le Moal wrote:
> It may be way simpler to rely on:
> 1) none scheduler
> 2) some light re-ordering of write requests in the driver itself to avoid
> any requeue to higher level (essentially, handle requeueing in the driver
> itself).

Let's not start adding requeueing back into the drivers, that was a
giant mess that we tried to get out of for a while.

And all of this strict ordering mess really makes me think that we
should just have a special scheduler mandated for devices that have that
kind of stupid constraints...

-- 
Jens Axboe

