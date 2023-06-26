Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5D0EB64D7
	for <linux-block@archiver.kernel.org>; Mon, 26 Jun 2023 16:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFZQyH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjFZQyG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2023 12:54:06 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52EFC4
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 09:54:05 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-262ec7b261bso1109102a91.3
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 09:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798445; x=1690390445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDwF8PsaTvSUNVn+09IhyMiedF4rSW51KL9+JLS7BQQ=;
        b=Y6igkl4wP1l66xT5UFP4h4J1ali2EcsWsq04otNOoluJs9RgTLxxXBelHi3GhVEjI6
         6ZIlq/OhHxk6QAJfomkYN6P67zQfZK8wOcmn/tjqjwCSMUqF1w5jAB6BslxsViKVX7He
         9CqNhxxyFHgdeARGgOWRUrCzpmKoc5axAxtDT3jGo6XsPz7/+ydWZxRfW0Kr+O7KClmC
         iNzJv4p6d8Tz2alpy7LcVRQDzceK/I/4DM/KuthB0m3P8g7L3/M63dgqqSX5C6EyiVvm
         1W5ImfnhyzanHH0iLrRuZxtq0Cj+qinfZQ6opUnvq1fJ9MoewODTz08Ep0JLXpsXNvfm
         rs/w==
X-Gm-Message-State: AC+VfDzSEq0FXcw6MvPZIgoppTW0BxddoIa6hq4V3CMkz61lekxpmzMZ
        +/A+pluEQxY3iTCvT9X35dU=
X-Google-Smtp-Source: ACHHUZ7ZRzY3r7L53UdeIBCDwh/MxIOhZ46F9TCMxneL2W4YWjMZIDDwLj5P45snT36lsTnFQQXwSA==
X-Received: by 2002:a17:90a:7481:b0:262:e574:87a5 with SMTP id p1-20020a17090a748100b00262e57487a5mr4621131pjk.6.1687798445082;
        Mon, 26 Jun 2023 09:54:05 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ed06:6565:a250:4b59? ([2620:15c:211:201:ed06:6565:a250:4b59])
        by smtp.gmail.com with ESMTPSA id nw13-20020a17090b254d00b00262ff206931sm1546793pjb.42.2023.06.26.09.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:54:04 -0700 (PDT)
Message-ID: <79a4bb66-31b5-f383-020c-952541653608@acm.org>
Date:   Mon, 26 Jun 2023 09:54:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 4/7] block: One requeue list per hctx
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
 <20230621201237.796902-5-bvanassche@acm.org>
 <ZJlHtQySAAVYLbNy@ovpn-8-20.pek2.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZJlHtQySAAVYLbNy@ovpn-8-20.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/26/23 01:09, Ming Lei wrote:
> On Wed, Jun 21, 2023 at 01:12:31PM -0700, Bart Van Assche wrote:
>> Prepare for processing the requeue list from inside __blk_mq_run_hw_queue().
> 
> Please add more details about the motivation for this kind of change.
> 
> IMO requeue is supposed to be run in slow code path, not see reason why
> it has to be moved to hw queue level.

As Damien explained, the code for sending requeued requests to the I/O
scheduler should be dropped because this is not necessary in order to
prevent reordering of requeued zoned writes.

The remaining advantages of this patch series are:
* Simplification of the block layer API since the
   blk_mq_{,delay_}kick_requeue_list() functions are removed.
* Faster requeuing. Although I don't have any use case that needs
   faster requeuing, it is interesting to see that this patch series
   makes the blktest test that tests requeuing run twice as fast.

Is there agreement to proceed with this patch series if all review
comments are addressed?

Thanks,

Bart.


