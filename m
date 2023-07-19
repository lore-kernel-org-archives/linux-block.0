Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF15C0015E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 23:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGSXHp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 19:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGSXHp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 19:07:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAF31FCD
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 16:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AA0061861
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 23:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CEDC433C7;
        Wed, 19 Jul 2023 23:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689808063;
        bh=UXl1vfZsf3GNrPoB0L0G3YEQAZG82gsKtAVm/i4hZf4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KZlX0e6GxmJTcgaJw5bBaR+MziSb5I1vG+SVG5EHMAiM8NosV3vf7KNwH+xdsEqfS
         yeDKU4GE5LLhVDyJCyP0MoRzlxVdxzQOYsWqP14kRBRubXf21e8gclYh1lS+SzdAiG
         rbZce/XXGwUMfhvB0UdZtTWrl/DMPqrOITGmG7Wb1txR5i/YJOxAyECo6T/qxOwjGC
         aKu3/q7MIoAwNJyhNUI7FU+2huXvxhnU1DdTfUj6YMVZeQMCmHUpk7+vzFUXjW3pO0
         0hJZgTYaYptArOmJ4ionTB9S+HpzkgUdfNMNEb6e9qDyYFWtS3Bkd99V1s6xmq0X1u
         uZk/3FI829uXw==
Message-ID: <c4498ce0-d04d-c8d0-800e-d856d8ed8a8c@kernel.org>
Date:   Thu, 20 Jul 2023 08:07:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230710180210.1582299-1-bvanassche@acm.org>
 <20230710180210.1582299-5-bvanassche@acm.org>
 <52d41b27-f429-fc4c-c522-a963f67114bd@kernel.org>
 <fb8b1b7e-4054-6598-8204-eb252395227d@acm.org>
 <fd64fa90-1227-6d4d-8f0b-fc67d8c42a7e@kernel.org>
 <42402057-3806-3930-5ff8-d68816c79ca5@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <42402057-3806-3930-5ff8-d68816c79ca5@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/23 01:31, Bart Van Assche wrote:
> On 7/19/23 02:59, Damien Le Moal wrote:
>> On 7/19/23 07:53, Bart Van Assche wrote:
>>> I think what has been explained above is a scenario in which the filesystem
>>> allocates requests per zone in another order than the LBA order. How about
>>> requiring that the filesystem allocates and submits zoned writes in LBA
>>> order
>>> per zone? I think that this is how F2FS supports zoned storage.
>>
>> Sure. But what if an application uses the drive directly ? You loose
>> guarantees of forward progress then. Given that an application has to
>> use direct IO for writes to sequential zones, this is unlikely to happen
>> in a "good" scenario, but it also would not be hard to write an
>> application that can deadlock the drive forever by simply missing one
>> write in a sequence of writes for a zone... That is my concern. While
>> f2fs would likely be OK, the delay approach is not solid enough for all
>> cases.
> 
> Hi Damien,
> 
> This patch series increases the number of retries for zoned writes
> submitted by a filesystem. Direct I/O from user space is not affected
> since the code that increases the number of retries occurs in
> sd_setup_read_write_cmnd(). As you know scsi_prepare_cmd() only calls
> sd_setup_read_write_cmnd() for requests that come from a filesystem
> and not for pass-through requests.
> 
> Does this address your concern?

Not really. I was not thinking about passthrough requests but rather write
syscalls to /dev/sdX by applications. sd_setup_read_write_cmnd() is used for
these too. After all, /dev/sdX *is* a file system too, albeit the simplest possible.

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

