Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44685 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeGIHzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jul 2018 03:55:00 -0400
Received: by mail-lf0-f67.google.com with SMTP id g6-v6so3730585lfb.11
        for <linux-block@vger.kernel.org>; Mon, 09 Jul 2018 00:55:00 -0700 (PDT)
Subject: Re: [PATCH 0/2] null_blk: zone support
To: loberman@redhat.com, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart.VanAssche@wdc.com, Damien.LeMoal@wdc.com
References: <20180706173839.28355-1-mb@lightnvm.io>
 <1530899118.31977.1.camel@redhat.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
Date: Mon, 9 Jul 2018 09:54:57 +0200
MIME-Version: 1.0
In-Reply-To: <1530899118.31977.1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/06/2018 07:45 PM, Laurence Oberman wrote:
> On Fri, 2018-07-06 at 19:38 +0200, Matias Bjørling wrote:
>> This series adds support for exposing a zone block device using the
>> null_blk device driver.
>>
>> The first patch moves core null_blk data structures to a shared
>> header
>> file. The second implements the actual zone support. The patchset
>> adds
>> two new options. One to enable the zone interface, and another to
>> define the size of the zones to expose.
>>
>> Thanks,
>> Matias
>>
>> Matias Bjørling (2):
>>    null_blk: move shared definitions to header file
>>    null_blk: add zone support
>>
>>   Documentation/block/null_blk.txt |   7 ++
>>   drivers/block/Makefile           |   5 +-
>>   drivers/block/null_blk.c         | 124 ++++++++++++-----------------
>> ---
>>   drivers/block/null_blk.h         | 108 ++++++++++++++++++++++++++++
>>   drivers/block/null_blk_zoned.c   | 149
>> +++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 315 insertions(+), 78 deletions(-)
>>   create mode 100644 drivers/block/null_blk.h
>>   create mode 100644 drivers/block/null_blk_zoned.c
>>
> 
> Thank you for this will be very useful.
> I will test it to add value.
> I dont know the code well enough to review it
> Regards
> Laurence
> 

Great.

For fio, you can use the zone support here:

   https://github.com/bvanassche/fio

It is in the process of being upstreamed.

Also, you'll need the latest libzbc/util-linux (blkzone) if you want to 
report zones. A bug was fixed around detection of the drive.

   https://github.com/hgst/libzbc
   https://github.com/karelzak/util-linux
