Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729952AbeGQDqi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jul 2018 23:46:38 -0400
Subject: Re: [PATCH 1/4] lib/crc64: add crc64 option to lib/Kconfig
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20180716165507.23100-1-colyli@suse.de>
 <20180716165507.23100-2-colyli@suse.de>
 <9a57ba5a-ec33-b275-43f8-1fa103966d1d@infradead.org>
From: Coly Li <colyli@suse.de>
Message-ID: <d692a9c4-9d25-0e8e-f2db-756a3ae0a0b0@suse.de>
Date: Tue, 17 Jul 2018 11:16:06 +0800
MIME-Version: 1.0
In-Reply-To: <9a57ba5a-ec33-b275-43f8-1fa103966d1d@infradead.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/7/17 1:48 AM, Randy Dunlap wrote:
> On 07/16/2018 09:55 AM, Coly Li wrote:
>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> This patch adds crc64 option entry in lib/Kconfig. This patch is part of
>> a patch originally written by Andy Shevchenko, Coly Li cherry-picks it
>> and compose the commit log for a re-written crc64 source code.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Luis R. Rodriguez <mcgrof@suse.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>> ---
>>  lib/Kconfig | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 706836ec314d..4059df9ec4c7 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -170,6 +170,14 @@ config CRC32_BIT
>>  
>>  endchoice
>>  
>> +config CRC64
>> +	tristate "CRC64 functions"
>> +	help
>> +	  This option is provided for the case where no in-kernel-tree
>> +	  modules require CRC64 functions, but a module built outside
>> +	  the kernel tree does. Such modules that use library CRC64
>> +	  functions require M he
> 

Hi Randy,

> eh?  missing something here.
> 

Fix it in v2 series. Thanks.

Coly Li
