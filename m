Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54473 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbeCVESG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Mar 2018 00:18:06 -0400
Subject: Re: [for-4.17 20/20] bcache: Fix a compiler warning in
 bcache_device_init()
To: Michael Lyle <mlyle@lyle.org>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Cc: axboe@fb.com, Bart Van Assche <bart.vanassche@wdc.com>
References: <20180319003633.27225-1-mlyle@lyle.org>
 <20180319003633.27225-21-mlyle@lyle.org>
 <694c5331-72a8-c4d4-f882-1a4284f95690@suse.de>
 <875e1c80-9221-4947-aafc-aced5d6f5764@lyle.org>
From: Coly Li <colyli@suse.de>
Message-ID: <db41f5d0-952f-e76e-ee0d-25f78781a509@suse.de>
Date: Thu, 22 Mar 2018 12:17:57 +0800
MIME-Version: 1.0
In-Reply-To: <875e1c80-9221-4947-aafc-aced5d6f5764@lyle.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 22/03/2018 2:38 AM, Michael Lyle wrote:
> On 03/18/2018 06:32 PM, Coly Li wrote:
>> On 19/03/2018 8:36 AM, Michael Lyle wrote:
>>> From: Bart Van Assche <bart.vanassche@wdc.com>
>>>
>>> Avoid that building with W=1 triggers the following compiler warning:
>>>
>>> drivers/md/bcache/super.c:776:20: warning: comparison is always false due to limited range of data type [-Wtype-limits]
>>>       d->nr_stripes > SIZE_MAX / sizeof(atomic_t)) {
>>>                     ^
>>>
>>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>>> Reviewed-by: Michael Lyle <mlyle@lyle.org>
>>
>> There is a missing Reviewed-by: Coly Li <colyli@suse.de> from me :-)
> 
> Hi Coly--- sorry that I lost these.

The major motivation is just making my employer know where they pay for
my time :-)

Thanks.

Coly Li
