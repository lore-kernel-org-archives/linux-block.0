Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50C2C77B7F
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 21:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjEEV4S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 17:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjEEV4R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 17:56:17 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475204C28
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 14:56:15 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-64115eef620so22666753b3a.1
        for <linux-block@vger.kernel.org>; Fri, 05 May 2023 14:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683323775; x=1685915775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71NfKieDxvlq36FDFU6DpY6tS4FFm1XCLysTho6ib2E=;
        b=T2rPhWWLbjioFgDYD7zccZnngJk3KqCkuBI49/hEVxMpfJ8tojtUPpAQMJTvtrWhoS
         0JnI2d+UL+3LPB4/HeqQj60jC8P6xSxPSwc0H3Ug7KVWVQKJMAzDMVdbUNjWYF7Uxrp8
         cHNbZK8nMjCVuA64+T1RAU0d4j3glUmt1+CInTvS90wSmt/yKJxWY9f8jiabg6ksbKmZ
         eH3NYMxgXQ/PgJBcIPSBrFETpOMkYBYt5B4FBp3Oe+ejimdJtaRaGmpqngVGk+izRpZk
         VbZXUAKecbzth7nTe0g6uNIyy/WASyPOgpvWtO7vAEUYpGyuTE8fz7qHtVFl0Nvcd6MS
         hvuw==
X-Gm-Message-State: AC+VfDyvcGn/tbKs8sQajL8XI2YYfT0mjUf/ww1Z5/yLpcBAk1uR505d
        +VDAt9444OunW50xe+h6OTauqEScf4A=
X-Google-Smtp-Source: ACHHUZ4YnyvdijFX1Ay0SvmogWg8GNvCY1nMs0BfkIKZD/+7gNV5Bu1EisTXwhDnG3VbXSNkFcz9Ow==
X-Received: by 2002:a17:902:da91:b0:1a6:81ac:c34d with SMTP id j17-20020a170902da9100b001a681acc34dmr10222099plx.28.1683323774589;
        Fri, 05 May 2023 14:56:14 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:127d:5561:7469:3abc? ([2620:15c:211:201:127d:5561:7469:3abc])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902820f00b001aaefe48b93sm2198478pln.295.2023.05.05.14.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 14:56:14 -0700 (PDT)
Message-ID: <831f9373-642a-65db-8e00-7b147bc2e68c@acm.org>
Date:   Fri, 5 May 2023 14:56:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 04/11] block: Introduce blk_rq_is_seq_zoned_write()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230503225208.2439206-1-bvanassche@acm.org>
 <20230503225208.2439206-5-bvanassche@acm.org> <20230505055306.GC11748@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230505055306.GC11748@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/4/23 22:53, Christoph Hellwig wrote:
> On Wed, May 03, 2023 at 03:52:01PM -0700, Bart Van Assche wrote:
>> +bool blk_rq_is_seq_zoned_write(struct request *rq)
>> +{
>> +	return op_is_zoned_write(req_op(rq)) && blk_rq_zone_is_seq(rq);
>> +}
>> +EXPORT_SYMBOL_GPL(blk_rq_is_seq_zoned_write);
> 
> Would it make more sense to just inline this function?

Hi Christoph,

I will declare this function as inline and move it into include/linux/blk-mq.h.

Thanks,

Bart.

