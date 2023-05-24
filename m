Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FE6C77B73
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 18:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjEXSZa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 14:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjEXSZ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 14:25:29 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B64122
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 11:25:28 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5346d150972so573418a12.3
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 11:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684952727; x=1687544727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1Ij/oyCEeKHYTId7OFc6lx3LGscqOvZMN9n8hZn/kc=;
        b=Tae7A/yvyWs7wX2qGHtxN48uHpbGRnV1rqi2pa6Up3+UvtJt41SVoebtznzvMgKO7b
         GChogUbVXiyH79cZW08wKs3cggtUt/7epR+Uzweq8KEzTww9TEFdXaByP77eJaal22gB
         cZS4ffOwklzVIhGzmHQYU+70pC3vN/htLAFnwZi5Bn45veiWibLkGWcdzWNLxRk7jt7a
         2oE7C0E2duw6iblRKnEVvUj33U6714WajRlAAxd+CEuBXrDnDZwMiOsTjZy2HlsECv5u
         pZe7y7oGcqpwTJW04AZZE70QZ++Sflwt36XnkxvzYJW4KGHjQRmWQcrStIrE0zQpi7p1
         8C8Q==
X-Gm-Message-State: AC+VfDxTE5FiR54KG3FyA1OzcSmn3h/iTDMdYa/8wz0K06ebek966Q9c
        CZRsQBIr4O/5hoq9M6BoXuM=
X-Google-Smtp-Source: ACHHUZ4HiwYlWMOOv7Cb0pZ5Ya7U1zVCBKCtyzMABoLd6PqTaFhRJ3pktdDzmU9OGQMfEbF2teUGnA==
X-Received: by 2002:a17:903:2343:b0:1ac:a9c1:b61d with SMTP id c3-20020a170903234300b001aca9c1b61dmr20795345plh.11.1684952727383;
        Wed, 24 May 2023 11:25:27 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001ab2a0733aasm9038314plg.39.2023.05.24.11.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 11:25:27 -0700 (PDT)
Message-ID: <356fff5c-9818-a62f-be91-5573e9f7f09b@acm.org>
Date:   Wed, 24 May 2023 11:25:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/7] block: Make it easier to debug zoned write
 reordering
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-5-bvanassche@acm.org> <20230523071957.GD8758@lst.de>
 <41dd1a93-2491-a094-dc61-f424b51af6cb@acm.org>
 <20230524061356.GE19611@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230524061356.GE19611@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 23:13, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 12:34:38PM -0700, Bart Van Assche wrote:
>>> What makes sequential writes here special vs other requests that are
>>> supposed to be using the scheduler and not a bypass?
>>
>> Hi Christoph,
>>
>> If some REQ_OP_WRITE or REQ_OP_WRITE_ZEROES requests are submitted to the
>> I/O scheduler and others bypass the I/O scheduler this may lead to
>> reordering. Hence this patch that triggers a kernel warning if any
>> REQ_OP_WRITE or REQ_OP_WRITE_ZEROES requests bypass the I/O scheduler.
> 
> But why would we ever do a direct insert when using a scheduler for
> write (an read for that matter) commands when not on a zoned device?

Patch 2/7 of this series removes a blk_mq_request_bypass_insert() call 
from blk_mq_requeue_work(). I think this shows that without this patch 
series blk_mq_request_bypass_insert() could get called for REQ_OP_WRITE 
/ REQ_OP_WRITE_ZEROES requests.

Thanks,

Bart.
