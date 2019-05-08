Return-Path: <SRS0=FTzM=TI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D1C04A6B
	for <linux-block@archiver.kernel.org>; Wed,  8 May 2019 17:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5F221530
	for <linux-block@archiver.kernel.org>; Wed,  8 May 2019 17:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmyJhKNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfEHRJG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 May 2019 13:09:06 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:39430 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfEHRJG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 May 2019 13:09:06 -0400
Received: by mail-qk1-f172.google.com with SMTP id z128so10238724qkb.6;
        Wed, 08 May 2019 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Nt12g+srN8LSCbASsVdKOaiT1UztuP9TGIhKvt1XgUc=;
        b=lmyJhKNQJBPNxaW6Cdgon51SHhm7cezA+3E56R9u6GzkYP1TaevG92SRXiidYQIuGJ
         Fv+p7GvvADhRIi2XMQY+71P1gYnjXo1lS7HxuQ2VtP7Xhq7rrY9OPzcKs9l3xfAAZd6k
         rud9cBkJfOwjTGh8Aqj2hEjt/Gr7kkwrewLyAGHgNRmXea9111y2qejeM7FlCRwC849t
         MwH8M+SD83tUuj7yiMwp7sOQ5RyIjquJ6bD1ujPWDjbf92bGaZLDQinc24i84NyJZ7bQ
         wR5Ake5NTapdHTinU1cmar5KeXLmCRcAaJ6+puDlWjK8R/YmYDZaUsUHhg/NvLzYCBH0
         Vm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Nt12g+srN8LSCbASsVdKOaiT1UztuP9TGIhKvt1XgUc=;
        b=FXIV4c6dpuk4yNDMNYcZQ9dTYnBzi8tWF9Y/A354ox3LHm/XdqDOyEbqVnJBUSxbLF
         l2rkvVymqNSrDV3i+FC2mf9pvIlnqoHklkcwlieUxImIXFaBBPyRlQLtUHWDjLZ/KlTg
         qZUNosSl3YRPzeEPmKIbjBWrF+biDFyg9t+R8t2YPsQJWTyAtm2iGBYgibFnbeCvcHpO
         i316GDHt9iPPgz3yQsE2goKFb12O+OPyDY+DMqSYepQRK/0fb+XBuC4Gt/3GkjFjeolw
         pJx7f/6dIgcX916uAlJd9jXA58d9rcQ5aQA8iT4lszfCaNU9Da+QjA2y8Wy7DnPqhaId
         UeYg==
X-Gm-Message-State: APjAAAVt0gvMDiml2ZuE6VDIzN7P0QAuajHeDUVo4JdQT7CxDuRwv4ot
        f/UlSI7VJ8JO+rwPU5TnsQkTlNSXkk8=
X-Google-Smtp-Source: APXvYqzkkSzpxyecRYP5aApO1PN1rtetfpo21NFvYHtrK8HSAM42Q+83uHb8FK/a8bJGZ9n8AuOfEA==
X-Received: by 2002:ae9:f30f:: with SMTP id p15mr31669114qkg.182.1557335345640;
        Wed, 08 May 2019 10:09:05 -0700 (PDT)
Received: from localhost.localdomain ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id u6sm2691945qkj.27.2019.05.08.10.09.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 10:09:04 -0700 (PDT)
Subject: Re: Testing devices for discard support properly
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507220449.GP1454@dread.disaster.area>
 <a409b3d1-960b-84a4-1b8d-1822c305ea18@gmail.com>
 <20190508011407.GQ1454@dread.disaster.area>
 <13b63de0-18bc-eb24-63b4-3c69c6a007b3@gmail.com> <yq1a7fwlvzb.fsf@oracle.com>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <0a16285c-545a-e94a-c733-bcc3d4556557@gmail.com>
Date:   Wed, 8 May 2019 13:09:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yq1a7fwlvzb.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 5/8/19 1:03 PM, Martin K. Petersen wrote:
> Ric,
>
>> That all makes sense, but I think it is orthogonal in large part to
>> the need to get a good way to measure performance.
> There are two parts to the performance puzzle:
>
>   1. How does mixing discards/zeroouts with regular reads and writes
>      affect system performance?
>
>   2. How does issuing discards affect the tail latency of the device for
>      a given workload? Is it worth it?
>
> Providing tooling for (1) is feasible whereas (2) is highly
> workload-specific. So unless we can make the cost of (1) negligible,
> we'll have to defer (2) to the user.

Agree, but I think that there is also a base level performance question 
- how does the discard/zero perform by itself.

Specifically, we have had to punt the discard of a whole block device 
before mkfs (back at RH) since it tripped up a significant number of 
devices. Similar pain for small discards (say one fs page) - is it too 
slow to do?

>
>> For SCSI, I think the "WRITE_SAME" command *might* do discard
>> internally or just might end up re-writing large regions of slow,
>> spinning drives so I think it is less interesting.
> WRITE SAME has an UNMAP flag that tells the device to deallocate, if
> possible. The results are deterministic (unlike the UNMAP command).
>
> WRITE SAME also has an ANCHOR flag which provides a use case we
> currently don't have fallocate plumbing for: Allocating blocks without
> caring about their contents. I.e. the blocks described by the I/O are
> locked down to prevent ENOSPC for future writes.

Thanks for that detail! Sounds like ANCHOR in this case exposes whatever 
data is there (similar I suppose to normal block device behavior without 
discard for unused space)? Seems like it would be useful for virtually 
provisioned devices (enterprise arrays or something like dm-thin 
targets) more than normal SSD's?

Ric


