Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC0C61DB3
	for <linux-block@archiver.kernel.org>; Fri, 13 Jan 2023 12:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjAMM5R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Jan 2023 07:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbjAMM4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2023 07:56:44 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C618DFB1
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673613884; x=1705149884;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nwIB1nGyZudFYRb5MpHF4y/OzH5EuTi5rHTGvLHv0q0=;
  b=BrqQoZQqrEAIf+QZviif5XL+e1PHx0n0uUC7hxiz1UZKRVjfellw6rMv
   xyphmYNXnJAqujULYkyBT7T01TgSi3A5c5dKn4igeqZv6qm8B0FW3MS0Q
   J04KBw7ZvXKv6YbVxzaEPNKwgqfwTgD5C0PBYuG2LHqCUsMIkC9FCxGIB
   UUuicr3spUsS583iC/OQGhmtTpZC8xm8YwTKrx4CpsikE9Pz/Ldlvnngr
   J5g5h4DaUrJszTWT+Rdw6bUrT0BC6EyH/JXDnpHU9IVV3XVDEeqEXAEJG
   BxmN9dcL+bv9soxM/V3K5s3huPqWVQcrGFuMLz4UHpGg5N6G4Yq4vjP30
   w==;
X-IronPort-AV: E=Sophos;i="5.97,213,1669046400"; 
   d="scan'208";a="325046269"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2023 20:44:42 +0800
IronPort-SDR: GUuVhSs8GoklivYh9dXmsLF0PzRH/mkuRFddaPm6AtPvDE0aLk4YMKarAgHttoWFXAGlckTBNO
 ROWiSSZKrTZJWOelghBakhAtNogGRdir6K/rihcVgs+jTHW0zXHvKmWn2xmqWpEkHYifNx0luR
 FH0hIub3nfUqvDyFKUDG/bXsaxHZQk2wxCGIzewW48i/YTeFtV7dyOLtO1LGIHMTicUZzrrEIB
 fT1bDGRznSQROmA5YfdcZ16OsMoxcUycIOAc3xrtEYXhN81g5O1+gLgwGxDRmcmk62KFb1VPj6
 Uak=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2023 04:02:29 -0800
IronPort-SDR: HKrA9oRDncQ9opKVyI8gDJPWN5+d8DvYuGkBRxVkbTThwAMFxmhCQUrYW8uz43g6lv8PAAo35H
 uWd1KNZUQ4Q4wxekBxYOH7ijwYmxwCwAoRhHbOMu187y+PGYM91JMGhjyC+MaA1DcYUX5B6LOc
 7RUR1aPWhMT53vZjZMPcDWff8jSXrohlua1dFFbDKFl7aqdT9W1UGcCzc/JdziUWEZ4Bkt28IS
 yQg9/r0DJMdmPE3EIM6RLH2JdDjcY+EuEkCJ1vsi5VEiYuqtNWvlz8F49Io0UumKmBYT00mPSO
 Q4U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2023 04:44:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nth2L5nCnz1Rwt8
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:44:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673613882; x=1676205883; bh=nwIB1nGyZudFYRb5MpHF4y/OzH5EuTi5rHT
        GvLHv0q0=; b=LGvKvK2yFcWkgTyoViWNLaJCvJ6GDYWwb+EXW8eAFUzhX5H2xu2
        HHYg5c6M1WvjntAuUTfRMkPLQnsdrnXohNT9UTDLRlbiFmPODpyrLhpwc+jwcipF
        1j84nSeX5hQJtqLmL2N1QUcIxu9i9TDGqG7bEoRwPxlFUe3YLzN4GA+lZHUdC04x
        lkPW1fIKKZsQCOADQ8oNrvOSkI7foRAuqoFa5QBuUmr+XGUuTmsAAB6opn9/pUgB
        pV9ClQh7qHfYOPIGmgNetFVrqJifRuXr48umUgZBBSJzWZFpv7Q0T7/v7X34nfEh
        z/V4/0BxDCAteuMZ/HK/B5WJk7HrdPJF4ow==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rLADd7zjnXzk for <linux-block@vger.kernel.org>;
        Fri, 13 Jan 2023 04:44:42 -0800 (PST)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nth2J6YZHz1RvLy;
        Fri, 13 Jan 2023 04:44:40 -0800 (PST)
Message-ID: <c1423109-dd39-11a3-58eb-5dc8c3e56520@opensource.wdc.com>
Date:   Fri, 13 Jan 2023 21:44:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 07/18] block: introduce duration-limits priority class
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
 <20230112140412.667308-8-niklas.cassel@wdc.com>
 <08d6acff-9aaf-7c2f-6b4d-7fd83c7a68c6@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <08d6acff-9aaf-7c2f-6b4d-7fd83c7a68c6@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/13/23 20:55, Hannes Reinecke wrote:
> On 1/12/23 15:03, Niklas Cassel wrote:
>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>
>> Introduce the IOPRIO_CLASS_DL priority class to indicate that IOs should
>> be executed using duration-limits targets. The duration target to apply
>> to a command is indicated using the priority level. Up to 8 levels are
>> supported, with level 0 indiating "no limit".
>>
>> This priority class has effect only if the target device supports the
>> command duration limits feature and this feature is enabled by the user.
>> In BFQ and mq-deadline, all requests with this new priority class are
>> handled using the highest priority class RT and priority level 0.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>> ---
>>   block/bfq-iosched.c         | 10 ++++++++++
>>   block/blk-ioprio.c          |  3 +++
>>   block/ioprio.c              |  3 ++-
>>   block/mq-deadline.c         |  1 +
>>   include/linux/ioprio.h      |  2 +-
>>   include/uapi/linux/ioprio.h |  7 +++++++
>>   6 files changed, 24 insertions(+), 2 deletions(-)
>>
> I wonder.
> 
> _Normally_ a command timeout is only in force once the command is being 
> handed off to the driver. As such it doesn't apply for any scheduling 
> being done before that; most notably the I/O scheduler is not affected 
> by any command timeout.
> 
> And I was under the impression that CDL really only allows the drive to 
> impose a command timeout on its own.
> (Pray correct me if I'm mistaken)

The CDL descriptors to be used for read/write commands are defined by the
user and set on the drive (write log command). By default, the drive does
not have any CDL descriptor set, so no limit == regular behavior (no
timeout aborts). Also keep in mind that CDLs may be of the (1) "best
effort" flavor, or the (2) "abort" flavor. For (2), a command missing its
CDL limit will be aborted by the device (limit set by the user !). But for
(1), the drive will continue executing the command even if the CDL limit
is exceeded, so no timeout error.

> Hence: does CDL really impinge on the I/O scheduler? Or shouldn't we 
> treat CDL just like a 'normal' command timeout, only to be activated 
> when normal command timeout is enabled?

No impact on the IO scheduler, at least for now. But given that CDL is all
about controlling IO latency, we would miss that goal if we have an IO
scheduler that excessively delays a request with a short CDL set...

The main point of this patch is to have CDL commands treated similarly to
high priority commands to avoid such delays. This is also consistant with
the fact that CDL and ATA NCQ priority commands are mutually exclusive
features. They cannot be used together. So there we cannot have a mix of
CDL and NCQ prio commands together to the same drive.

-- 
Damien Le Moal
Western Digital Research

