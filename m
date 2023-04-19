Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B80C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 18:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDSSao (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 14:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDSSan (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 14:30:43 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C917A84
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 11:30:39 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-63b70f0b320so229958b3a.1
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 11:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681929039; x=1684521039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4owbXbfvK1wj7/kyBM0p/BsuN7T/b3C8fCHP1GBBwdU=;
        b=BGwjWIdow+YkrYf4QpF9kCbC1oh2gZ7/uCZg+m1WkbNkjbU+JL4FQormbx6cVTt+of
         EfZzwxJpg0jimybkyMNhls6gYl4G1EP3Y/v2BT/9sPcj0UbG0V7fsu5iHdc8OWfFz/e1
         4fjKL9PK2myM0urRSmAWeMMxSoZxOXcRh75eYVNkrs2o17HEsJJwx0ji9bWZxfzOHZMU
         GAZd5BBGuML6KM2UGd+arOSu35wnVvHnsHdeLl7MlOQ0bMN6TRCgWr9dE6a0NORFSwT7
         XncuANgZzYVGGVtm/zW3YEjzFiFnMZwwv8FHRQuFoFNhDBHkNSfMTjtBQQ0Y8ZKGE/wq
         U2mw==
X-Gm-Message-State: AAQBX9dDcVq34OTVd/KUCri8kOhlS8WH3+Wb22yfG4zDyW1SVmOH/SRD
        mxtl2sEdbB9pqGrRJHR5IHI=
X-Google-Smtp-Source: AKy350a420jluOmM6HZm5nsPxQcn0dFRkUhj5l/6zeKAVYX1V2EpLoEKGcR0/9wheZTkHtqcvGLzlQ==
X-Received: by 2002:a05:6a00:1251:b0:63d:4358:9140 with SMTP id u17-20020a056a00125100b0063d43589140mr4970310pfi.34.1681929038967;
        Wed, 19 Apr 2023 11:30:38 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:d65e:8f40:1b48:5b0b? ([2620:15c:211:201:d65e:8f40:1b48:5b0b])
        by smtp.gmail.com with ESMTPSA id j2-20020aa78002000000b0063932e36437sm11349104pfi.134.2023.04.19.11.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 11:30:38 -0700 (PDT)
Message-ID: <790b6dc9-90fc-dab6-e6ff-64742fefee86@acm.org>
Date:   Wed, 19 Apr 2023 11:30:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 02/11] block: Micro-optimize
 blk_req_needs_zone_write_lock()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-3-bvanassche@acm.org> <20230419041106.GB25329@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230419041106.GB25329@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/23 21:11, Christoph Hellwig wrote:
> On Tue, Apr 18, 2023 at 03:39:53PM -0700, Bart Van Assche wrote:
>> Instead of using the following expression to translate a request pointer
>> into a request queue pointer: rq->q->disk->part0->bd_queue, use the
>> following expression: rq->q.
> 
> This looks correct, but I also kinda hate adding queue back in more
> places.

Hi Christoph,

How about changing queue_op_is_zoned_write() into 
disk_op_is_zoned_write()? That won't be as efficient as patch 2/11 in 
this series but still removes the 'part0' dereference.

Thanks,

Bart.
