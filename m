Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35425 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbeCUSia (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Mar 2018 14:38:30 -0400
Received: by mail-pg0-f68.google.com with SMTP id d1so2276042pgv.2
        for <linux-block@vger.kernel.org>; Wed, 21 Mar 2018 11:38:30 -0700 (PDT)
Subject: Re: [for-4.17 20/20] bcache: Fix a compiler warning in
 bcache_device_init()
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Cc: axboe@fb.com, Bart Van Assche <bart.vanassche@wdc.com>
References: <20180319003633.27225-1-mlyle@lyle.org>
 <20180319003633.27225-21-mlyle@lyle.org>
 <694c5331-72a8-c4d4-f882-1a4284f95690@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <875e1c80-9221-4947-aafc-aced5d6f5764@lyle.org>
Date: Wed, 21 Mar 2018 11:38:27 -0700
MIME-Version: 1.0
In-Reply-To: <694c5331-72a8-c4d4-f882-1a4284f95690@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/18/2018 06:32 PM, Coly Li wrote:
> On 19/03/2018 8:36 AM, Michael Lyle wrote:
>> From: Bart Van Assche <bart.vanassche@wdc.com>
>>
>> Avoid that building with W=1 triggers the following compiler warning:
>>
>> drivers/md/bcache/super.c:776:20: warning: comparison is always false due to limited range of data type [-Wtype-limits]
>>       d->nr_stripes > SIZE_MAX / sizeof(atomic_t)) {
>>                     ^
>>
>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>> Reviewed-by: Michael Lyle <mlyle@lyle.org>
> 
> There is a missing Reviewed-by: Coly Li <colyli@suse.de> from me :-)

Hi Coly--- sorry that I lost these.

Mike
