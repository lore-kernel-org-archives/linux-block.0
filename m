Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2233BEB64DC
	for <linux-block@archiver.kernel.org>; Tue, 18 Jul 2023 22:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjGRWyE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjGRWyD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2023 18:54:03 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182FDE0
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 15:54:02 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-55fcc0ab0b4so3617216a12.1
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 15:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720841; x=1692312841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqU9bs1OKhzTtOGVstjKDWpnXlacfMjTAqHiHV3XCxE=;
        b=SYCJFbs+6dvsoIaAMYtjWiAlw9hB+6DnI2tOnu7DaJUeVpr6VygVaILnBVHI0lOAgy
         JYEzJAe3UfDgXwh0U0z5xXeJo4MuFHu2IoUm8CXcOmYT+UCN5qa1/X8+ogpPmRMDS1WF
         6JWUhuRU65Oama58XjXiLGiW8XrUSdMNSFuuK8UdyJOLDO14anpR9Ih0nBzCE3+y7MTS
         Uc6ucqT9lmhTnFyCGsgOhP2SL03zKfJDG+1AZ8q+iy/Uk8LUnlaBdjM001IysitxqhGj
         ebFVD23WmskamHKBWQfM8QTc3NCJBpqgJiLRIzCxrPt7DWUSqAX7vhBIg8s7kJn1Gr11
         AQMw==
X-Gm-Message-State: ABy/qLZUiBbhuIjAoy6yWJcewqpeTLht7N77iIAiTvJchdc9Cs8OcJqU
        Ngt3dR1lViEWYPSE4uJ1hbo=
X-Google-Smtp-Source: APBJJlFrp9idLpb4BIPDOhBbvrR+faXbwdmxMRThn1cEDEWp8IM6WJQ2WQ4h6APIOYG4dg1VHC9VDQ==
X-Received: by 2002:a17:90a:b896:b0:263:71ff:d0c3 with SMTP id o22-20020a17090ab89600b0026371ffd0c3mr15248308pjr.8.1689720841347;
        Tue, 18 Jul 2023 15:54:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3cb6:9d30:79d0:90cc? ([2620:15c:211:201:3cb6:9d30:79d0:90cc])
        by smtp.gmail.com with ESMTPSA id jh18-20020a170903329200b001ab2b4105ddsm2410544plb.60.2023.07.18.15.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 15:54:00 -0700 (PDT)
Message-ID: <fb8b1b7e-4054-6598-8204-eb252395227d@acm.org>
Date:   Tue, 18 Jul 2023 15:53:59 -0700
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <52d41b27-f429-fc4c-c522-a963f67114bd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/17/23 23:47, Damien Le Moal wrote:
> On 7/11/23 03:01, Bart Van Assche wrote:
>> Send commands that failed with an unaligned write error to the SCSI error
>> handler. Let the SCSI error handler sort SCSI commands per LBA before
>> resubmitting these.
>>
>> Increase the number of retries for write commands sent to a sequential
>> zone to the maximum number of outstanding commands.
> 
> I think I mentioned this before. When we started btrfs work, we did something
> similar (but at the IO scheduler level) to try to avoid adding a big lock in
> btrfs to serialize (and thus order) writes. What we discovered is that it was
> extremely easy to fall into a situation were the maximum number of possible
> outstanding request is already issued, but they all are behind a "hole" and
> indefinitely delayed because the missing request cannot be issued due to the max
> nr request limit being reached. No forward progress and deadlock.
> 
> I do not see how your change addresses this problem. The same will happen with
> this and I do not have any suggestion how to solve this. For btrfs, we ended up
> using cone append emulation for scsi to avoid the big lock and avoid the FS from
> having to order writes. That solution guarantees forward progress. Delaying
> already issued writes that are not sequential has no such guarantees.

Hi Damien,

Thank you for having explained in detail the scenario that you ran into.

I think what has been explained above is a scenario in which the filesystem
allocates requests per zone in another order than the LBA order. How about
requiring that the filesystem allocates and submits zoned writes in LBA order
per zone? I think that this is how F2FS supports zoned storage.

Thanks,

Bart.
