Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39115 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750899AbcIIN4V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Sep 2016 09:56:21 -0400
Subject: Re: [PATCH 3/5] nbd: use flags instead of bool
To: Joe Perches <joe@perches.com>, Josef Bacik <jbacik@fb.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <mpa@pengutronix.de>,
        <nbd-general@lists.sourceforge.net>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <1473369130-22986-4-git-send-email-jbacik@fb.com>
 <1473384038.13672.23.camel@perches.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <bda72452-8a5f-8a6a-2409-145585ea41f5@fb.com>
Date: Fri, 9 Sep 2016 07:55:52 -0600
MIME-Version: 1.0
In-Reply-To: <1473384038.13672.23.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/08/2016 07:20 PM, Joe Perches wrote:
> On Thu, 2016-09-08 at 17:12 -0400, Josef Bacik wrote:
>> In preparation for some future changes, change a few of the state bools over to
>> normal bits to set/clear properly.
> []
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> []
>> @@ -41,8 +41,12 @@
>>
>>  #include <linux/nbd.h>
>>
>> +#define NBD_TIMEDOUT			0
>> +#define NBD_DISCONNECT_REQUESTED	1
>> +
>>  struct nbd_device {
>>  	u32 flags;
>> +	unsigned long runtime_flags;
>
> Better to use DECLARE_BITMAP

It's a few flags, we know it fits in a long. There's no point to using
anything but that, and set/test/clear_bit().

-- 
Jens Axboe

