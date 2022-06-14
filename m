Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C79C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 23:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiFNX44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFNX4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 19:56:55 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112EC48315
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 16:56:55 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d13so8999795plh.13
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 16:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lR39znNSObPtVvPIKx9TBjwJYselIndH+aG5vlDJIFI=;
        b=O8+p+49ouJus523BR8Cg2ayrgDo/bZUMEk4rBo+oTzJ5brMHELoHW1EJ7GmzwWLgoR
         jjifmtE9AriBdVBy+2z1rF8dvkcZYJs0qnGlu34NnyNBCdJbEUyuKfjGCd+WDPDdlMC1
         brjwMRoS/5/wNpP7/Xzn9n87sx0q7WA8zUsM6qVI4gbAz1AV0ENUWMyyK8O1DGHjzqV0
         05XG/KVQ6mNoHgVYw8oY5Ha/RXdWvwEyYF3W6tPZaOGOePS36Wj5/GNgWurUaFuOG/db
         MnMqiKGydILrBI6Yj4G6XhXmrn1JsWzDKbDFYX5GRmArIxW9tB8jOybX7h/vHDpDrH7W
         bITQ==
X-Gm-Message-State: AJIora8dDFqfculFr2ZOcDyPbl37cQF9HZpPzBvh5xqGlWev4WI2EWGz
        Wh1ZhLd4wIop9t71mk9LL2Y=
X-Google-Smtp-Source: AGRyM1v2BOdJPXPbH0gKr5H/mLVgZGV2+X6t+laanY6+LlNNjbAHJFLb5CHuqWqW6bZWgzBccBDR6g==
X-Received: by 2002:a17:902:8bc2:b0:167:7645:e76a with SMTP id r2-20020a1709028bc200b001677645e76amr6858388plo.115.1655251014407;
        Tue, 14 Jun 2022 16:56:54 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id f19-20020a637553000000b003fc4001fd5fsm8456259pgn.10.2022.06.14.16.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 16:56:53 -0700 (PDT)
Message-ID: <29a13708-56b1-60e8-558a-ec4a469eaa6d@acm.org>
Date:   Tue, 14 Jun 2022 16:56:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-3-bvanassche@acm.org>
 <399e595b-06d2-ceb1-1b42-2a98a7724320@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <399e595b-06d2-ceb1-1b42-2a98a7724320@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 16:29, Damien Le Moal wrote:
> On 6/15/22 02:49, Bart Van Assche wrote:
>>  From ZBC-2: "The device server terminates with CHECK CONDITION status, with
>> the sense key set to ILLEGAL REQUEST, and the additional sense code set to
>> UNALIGNED WRITE COMMAND a write command, other than an entire medium write
>> same command, that specifies: a) the starting LBA in a sequential write
>> required zone set to a value that is not equal to the write pointer for that
>> sequential write required zone; or b) an ending LBA that is not equal to the
>> last logical block within a physical block (see SBC-5)."
>>
>> I am not aware of any other conditions that may trigger the UNALIGNED
>> WRITE COMMAND response.
>>
>> Retry unaligned writes in preparation of removing zone locking.
> 
> Arg. No. No way. AHCI will totally break with that because most AHCI
> adapters do not send commands to the drive in the order they are delivered
> to the LLD. In more details, the order in which tag bit in the AHCI ready
> register are set does not determine the order of command delivery to the
> disk. So if zone locking is removed, you constantly get unaligned write
> errors.

The performance penalty of zone locking is not acceptable for our use 
case. Does this mean that zone locking needs to be preserved for AHCI 
but not for UFS?

Thanks,

Bart.

