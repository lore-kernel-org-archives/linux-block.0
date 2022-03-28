Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70A7C433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 22:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiC1W0X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiC1W0V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 18:26:21 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4281637C6
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 15:24:40 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id j13so15951741plj.8
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 15:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=SgAxJ7IghIplTni3GdbN1AsCr8GKSoFLg+V0i0ne0pw=;
        b=YjxEGAzIGbtt2ryWPtYlfAyl2/Vj7yQHr0lT+AHJDNpXxjxMEg3L4VC+g84Ncob6hG
         qLjpDwmvk/dPsdWWzzap0MDcJlhjRKZQr5rtTQ7F4TCNV8UtEn+Vvu+UqudubX2/4qFB
         phv4kfoFRiToce9b6BZpo4pIag5yJdmcckCr7zYqbKOhIA4X08moIqYVhQF2DH4+m10q
         A9AzwRkTZ47M6IsWE12NSLcOnghRYy2VIOSkGOJmPwwccAv5hOAGbOTi6l77RXvl/IWu
         cvQloM74Um/6wk9lPLn+NoGUXFGAM+EgE3R9j4ru1aRf1pWYil0xbbd+qUOY7YTmyWAE
         kszg==
X-Gm-Message-State: AOAM531zOSEvMk6yHNmJMGgsabnWtyYU1tZGWEFkAkd5GFdXYYnWVjlO
        /OQvV2OGbNbnl0WfqicAByo=
X-Google-Smtp-Source: ABdhPJwB5Q00YgxrpjhaFQA+ufpneZUVl2RZypbbrIFVLcryCdK+8ecWKgWqBiPz0NAmDwNi5MIfdw==
X-Received: by 2002:a17:902:edd5:b0:153:abee:1093 with SMTP id q21-20020a170902edd500b00153abee1093mr28342641plk.77.1648506279399;
        Mon, 28 Mar 2022 15:24:39 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id v17-20020a63b951000000b0038644f62aeesm12694164pgo.68.2022.03.28.15.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 15:24:38 -0700 (PDT)
Message-ID: <7b75c6bf-b446-2883-a571-d6ec3e99d575@acm.org>
Date:   Mon, 28 Mar 2022 15:24:37 -0700
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

An update: I can reproduce the slowness with (a) the patch at the start of
this thread reverted and (b) both the BFQ and the Kyber I/O schedulers. So
it seems like a regression has been introduced related to handling of queue
depth 1. I will try to bisect this.

Bart.
