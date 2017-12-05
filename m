Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:42513 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbdLEHRI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Dec 2017 02:17:08 -0500
Received: by mail-pg0-f52.google.com with SMTP id e14so10091570pgr.9
        for <linux-block@vger.kernel.org>; Mon, 04 Dec 2017 23:17:08 -0800 (PST)
Subject: Re: [PATCH] [PATCH v2] bcache: segregate flash only volume write
 streams from cached devices
To: tang.junhui@zte.com.cn, colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1512367914-9257-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <b7474776-7126-2d7d-43e4-f956b66d1fdb@lyle.org>
Date: Mon, 4 Dec 2017 23:17:04 -0800
MIME-Version: 1.0
In-Reply-To: <1512367914-9257-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Tang Junhui--

Hi

On 12/03/2017 10:11 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> Hello Mike & Coly
> 
> Could you please have a reveiw for this patch?
> 
>> From: Tang Junhui <tang.junhui@zte.com.cn>
>>
>> In such scenario that there are some flash only volumes
>> , and some cached devices, when many tasks request these devices in
>> writeback mode, the write IOs may fall to the same bucket as bellow:
>> | cached data | flash data | cached data | cached data| flash data|
>> then after writeback of these cached devices, the bucket would
>> be like bellow bucket:
>> | free | flash data | free | free | flash data |
>>
>> So, there are many free space in this bucket, but since data of flash
>> only volumes still exists, so this bucket cannot be reclaimable,
>> which would cause waste of bucket space.
>>
>> In this patch, we segregate flash only volume write streams from
>> cached devices, so data from flash only volumes and cached devices
>> can store in different buckets.
>>
>> Compare to v1 patch, this patch do not add a additionally open bucket
>> list, and it is try best to segregate flash only volume write streams
>> from cached devices, sectors of flash only volumes may still be mixed
>> with dirty sectors of cached device, but the number is very small.
>>
>> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>

LGTM, and I have added to my staging tree, though it required
cleanpatch. (executable, line ending).

Thanks,

Mike
