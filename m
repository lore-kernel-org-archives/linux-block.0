Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA8BC43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 23:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiFNXui (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFNXu3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 19:50:29 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD85A3E0DE
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 16:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655250628; x=1686786628;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2FMqwe6uRD0ZwwbgrrFH1Op22frCIVZ/ZEyFO8DyCXA=;
  b=Q/vVq3G5H+kOXJj7ETFNthjb/C+wo66W9gtqWg5byZPWQuTMKUAKwzG/
   yunIUIlf8p6FJOzT4dzflI6hI+LwQ8468ZwIo0fpD2fSxsVk+gb2XBA8H
   rxU2KEv1/X5c/Bt17ayk6NqWoNCgIr2VKXxKitS/8YA3j+sNleorDxBSW
   APPgPVE7T+NtFzRUW+QWzh/4azRKqeOLizY6n6wRp5GFNmslZoNSeozM/
   ZBrI8o68clGSq64VD2jP6twQrQWp6YjuJ50OMuhtRIFAkoi30VcyqaX2E
   WJiCeQLkeBhFgPhjBeyKEADidCncXg3cGVYFBKjN5snEvmHiMhcplAryQ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647273600"; 
   d="scan'208";a="201881400"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 07:50:27 +0800
IronPort-SDR: G19SmmfPl1JiurVdN8U+bKBTXI1id92JAOYTt1RpeSuVNduTgR6qVzKtnCGnhkMfwZ40YVEOq8
 ci1+ScF9F4/GQcCCPearHKzgQ5tk5KOv3UiVFCAayzJXzFYOX3rWjUQebBae1Ov0qGeBcP+r6u
 78mI0wweUmoQNjo2nE7nHdM/J7rxx/yBVJAPKSpCg4wU4V+FnZpmLkONhUhI4uRJ98TvD7q6jt
 ClKhXg4oi/37YQjWRgKDeG11QzWEB1e9K2UWGVn6ftkdaK33u0p91zZ/6CeDAIHaCOSkPAj5yL
 pVeLIE1vAbTZX1/iMzuWzh1K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 16:13:23 -0700
IronPort-SDR: PuLFzI1O0zC9EwGKzUB/uJk0J/AGsf0BTBZgitZEKBGSl4sUyAfBR9FFWQbk8YgloTnRpWfqdK
 mjjNArVzOGsEo+5KTUfOcvyFK7OlN1r/EbKGvskKeXcnNo44s+rcJ297gLFoWRyAXsHqK0KxD+
 BqDqg7TzT8861DfJjhxN3XstLitna2QWOm9tJsOT8DP8U5BOOR52wH4Elw8+TXQviCrDjdQMuP
 Ghzv3CULCkMSgZXmtSZtzmlJ8nNf22zdYz4KFHxzS214EIHQ8CgYXdu74HrG+ll9CfLPhVrSj0
 moI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 16:50:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LN4tm3tTYz1SVp2
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 16:50:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655250623; x=1657842624; bh=2FMqwe6uRD0ZwwbgrrFH1Op22frCIVZ/ZEy
        FO8DyCXA=; b=YXsEyNd4QbXZ8wNq8JbKt5ZVCR4jEgMBCIjF0k5Q5spnr3IfasF
        O462vagmNhoKrkVJXFWhIl/xx+5Pk2m6v8i6I3epTTeSM283y2zb+KGrEOfK9PCV
        06XJYwiFDsjttm1dfAUV+BzdGpvfD6aEtHYFkuxnT4JL3qLn9Apv+q2bBolNxFZ9
        Qwfq1jYo9Eq5KdNyrHdJdmSeeyIR33YE+LaNCQqRl4Dvn4jr6KBzIkqAtJ8/4ODk
        nguhIRIEQidw9NGp+s9PRNds0IEodrkm15WIwr+PKFskw0laoiIu138ZFk2yzW8l
        JvLU85Hh5aDy9n3jvOuSedVIor3cnmElFJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BFeCq9rqH0Hc for <linux-block@vger.kernel.org>;
        Tue, 14 Jun 2022 16:50:23 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LN4tk0R9Nz1Rvlc;
        Tue, 14 Jun 2022 16:50:21 -0700 (PDT)
Message-ID: <c8e55085-4b7d-ef11-a22a-39ac71e63227@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 08:50:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-3-bvanassche@acm.org>
 <CACGdZYJ7HfykzbgiPpT7Ymd0h39qQE3qfz90QCNeoBjK04-HSw@mail.gmail.com>
 <186833db-bb36-e3c3-5670-ac8ff0b2906b@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <186833db-bb36-e3c3-5670-ac8ff0b2906b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/22 07:39, Bart Van Assche wrote:
> On 6/14/22 14:47, Khazhy Kumykov wrote:
>> On Tue, Jun 14, 2022 at 10:49 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>>
>>>  From ZBC-2: "The device server terminates with CHECK CONDITION status, with
>>> the sense key set to ILLEGAL REQUEST, and the additional sense code set to
>>> UNALIGNED WRITE COMMAND a write command, other than an entire medium write
>>> same command, that specifies: a) the starting LBA in a sequential write
>>> required zone set to a value that is not equal to the write pointer for that
>>> sequential write required zone; or b) an ending LBA that is not equal to the
>>> last logical block within a physical block (see SBC-5)."
>>>
>>> I am not aware of any other conditions that may trigger the UNALIGNED
>>> WRITE COMMAND response.
>>>
>>> Retry unaligned writes in preparation of removing zone locking.
>> Is /just/ retrying effective here? A series of writes to the same zone
>> would all need to be sent in order - in the worst case (requests
>> somehow ordered in reverse order) this becomes quadratic as only 1
>> request "succeeds" out of the N outstanding requests, with the rest
>> all needing to retry. (Imagine a user writes an entire "zone" - which
>> could be split into hundreds of requests).
>>
>> Block layer / schedulers are free to do this reordering, which I
>> understand does happen whenever we need to requeue - and would result
>> in a retry of all writes after the first re-ordered request. (side
>> note: fwiw "requests somehow in reverse order" can happen - bfq
>> inherited cfq's odd behavior of sometimes issuing sequential IO in
>> reverse order due to back_seek, e.g.)
> 
> Hi Khazhy,
> 
> For zoned block devices I propose to only support those I/O schedulers 
> that either preserve the LBA order or fix the LBA order if two or more 
> out-of-order requests are received by the I/O scheduler.

We try that "fix" with the work for zoned btrfs. It does not work. Even
adding a delay to wait for out of order requests (if there is a hole in a
write sequence) does not reliably work as FSes may sometimes take 10s of
seconds to issue all write requests that can be all ordered into a nice
write stream. Even with that delay increased to minutes, we were still
seeing unaligned write errors.

> 
> I agree that in the worst case the number of retries is proportional to 
> the square of the number of pending requests. However, for the use case 
> that matters most to me, F2FS on top of a UFS device, we haven't seen 
> any retries in our tests without I/O scheduler. This is probably because 
> of how F2FS submits writes combined with the UFS controller only 
> supporting a single hardware queue. I expect to see a small number of 
> retries once UFS controllers become available that support multiple 
> hardware queues.
> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
