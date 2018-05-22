Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39267 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbeEVIrl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 May 2018 04:47:41 -0400
Subject: Re: [PATCH] lib/crc64.c: add MODULE_LICENSE("GPL")
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180522084058.66520-1-colyli@suse.de>
 <6e9bdb5464689cc3ade4c09683e38f9f0104948b.camel@linux.intel.com>
From: Coly Li <colyli@suse.de>
Message-ID: <7525b76a-8e13-b68f-0ae0-427bc6cb72fa@suse.de>
Date: Tue, 22 May 2018 16:47:33 +0800
MIME-Version: 1.0
In-Reply-To: <6e9bdb5464689cc3ade4c09683e38f9f0104948b.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/5/22 4:43 PM, Andy Shevchenko wrote:
> On Tue, 2018-05-22 at 16:40 +0800, Coly Li wrote:
>> This patch adds MODULE_LICENSE("GPL") to lib/crc64.c to remove a
>> compiling
>> warninng.
> 
> I have no opinion about this. Code has a top description from which it
> has been taken / derived, so, I dunno if GPL is what it really is.
> 
> In any case it's probably worth to add SPDX header as well. 
> 

Hmm, there is a warning complains no MODULE_LICENSE() in lib/crc64.c,
when I compile a kernel for testing. The purpose is just to kill a
compiler warning.

And sure, I will post an update version with SPDX header.

Thanks for the hint :-)

Coly Li

>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  lib/crc64.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/crc64.c b/lib/crc64.c
>> index ed0ffac7b26a..586e46684ee8 100644
>> --- a/lib/crc64.c
>> +++ b/lib/crc64.c
>> @@ -135,3 +135,4 @@ uint64_t crc64(const void *data, size_t len)
>>  EXPORT_SYMBOL_GPL(crc64);
>>  
>>  MODULE_DESCRIPTION("CRC64 calculations");
>> +MODULE_LICENSE("GPL");
> 
