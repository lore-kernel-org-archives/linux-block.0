Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76CEC0015E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 16:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjGSQbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGSQbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 12:31:09 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5681734
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 09:31:08 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so4790213b3a.0
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 09:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689784268; x=1692376268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weh9SpV+dJziJ/05efyq871yN+ft5SqAvneUY9I4U54=;
        b=jHkZwzqAe7fkDOAHOpSTWxlxYknjUUI/plFHTvKGIGHhElwSI8+R2f8ESAJivZBROa
         5qyl411vZUTKUkQxJAfBEwPbKDL3VYxJGZQAV14rU04AIQujZEpMsKavKDvkKhQ3mAZi
         ALiCOz5fILxMDeXEHkjZSXzAykAmjInhJJVJmZhSH07r8JR5zdD2pYn694fMYBGIZE7n
         liMgWRSsOzLodn5zmloHqAH/Eqw/lmagWj4ZQzZVbLzyrg14hDm+8APcq2WcCRAOPcGK
         /e5OagZPjpGt+Tq1k8gLwifVP8AVf3qI3EQFaO69aUcHzrApbgQEkaCnXHR820PuEtxb
         XwHA==
X-Gm-Message-State: ABy/qLbAfudwIM2xfh+iN1iKA8poZtDVQHZ6yzKu3X9hpJ0UIaApvmy8
        eC8S+S9vKQb7BjLj5X837sf3mZbu9nQ=
X-Google-Smtp-Source: APBJJlFoeQI4XnnodeIqsAnpQ4bp8wpUAC5tyPU8YpeROPBCsuJ5lAonGBZhZER9PodWEjNOVWXfAw==
X-Received: by 2002:a05:6a00:b47:b0:653:de9a:d933 with SMTP id p7-20020a056a000b4700b00653de9ad933mr21453311pfo.17.1689784267726;
        Wed, 19 Jul 2023 09:31:07 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a2ab:183f:c76c:d30d? ([2620:15c:211:201:a2ab:183f:c76c:d30d])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b00673e652985esm3180854pfh.44.2023.07.19.09.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 09:31:06 -0700 (PDT)
Message-ID: <42402057-3806-3930-5ff8-d68816c79ca5@acm.org>
Date:   Wed, 19 Jul 2023 09:31:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230710180210.1582299-1-bvanassche@acm.org>
 <20230710180210.1582299-5-bvanassche@acm.org>
 <52d41b27-f429-fc4c-c522-a963f67114bd@kernel.org>
 <fb8b1b7e-4054-6598-8204-eb252395227d@acm.org>
 <fd64fa90-1227-6d4d-8f0b-fc67d8c42a7e@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fd64fa90-1227-6d4d-8f0b-fc67d8c42a7e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/19/23 02:59, Damien Le Moal wrote:
> On 7/19/23 07:53, Bart Van Assche wrote:
>> I think what has been explained above is a scenario in which the filesystem
>> allocates requests per zone in another order than the LBA order. How about
>> requiring that the filesystem allocates and submits zoned writes in LBA
>> order
>> per zone? I think that this is how F2FS supports zoned storage.
> 
> Sure. But what if an application uses the drive directly ? You loose
> guarantees of forward progress then. Given that an application has to
> use direct IO for writes to sequential zones, this is unlikely to happen
> in a "good" scenario, but it also would not be hard to write an
> application that can deadlock the drive forever by simply missing one
> write in a sequence of writes for a zone... That is my concern. While
> f2fs would likely be OK, the delay approach is not solid enough for all
> cases.

Hi Damien,

This patch series increases the number of retries for zoned writes
submitted by a filesystem. Direct I/O from user space is not affected
since the code that increases the number of retries occurs in
sd_setup_read_write_cmnd(). As you know scsi_prepare_cmd() only calls
sd_setup_read_write_cmnd() for requests that come from a filesystem
and not for pass-through requests.

Does this address your concern?

Thanks,

Bart.

