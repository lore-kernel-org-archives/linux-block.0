Return-Path: <colyli@suse.de>
Subject: Re: [PATCH 2/5] bcache: Split out crc64 to library
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, axboe@kernel.dk,
 linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180522093200.67193-1-colyli@suse.de>
 <20180522093200.67193-3-colyli@suse.de>
 <b7b0e4a9-10bf-dbff-f8ab-979345f3cd3b@suse.de>
 <d00e1db87dec40dcc2a78f06a62e7df8fbfbdd51.camel@linux.intel.com>
From: Coly Li <colyli@suse.de>
Message-ID: <b8eb9b75-873f-beb3-9e2e-ccdcd4465d4a@suse.de>
Date: Tue, 22 May 2018 21:03:10 +0800
MIME-Version: 1.0
In-Reply-To: <d00e1db87dec40dcc2a78f06a62e7df8fbfbdd51.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/5/22 7:42 PM, Andy Shevchenko wrote:
> On Tue, 2018-05-22 at 18:33 +0800, Coly Li wrote:
>> On 2018/5/22 5:31 PM, Coly Li wrote:
>>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>
>>> For generic use split out crc64 code to a separate module
>>> in the library folder.
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Signed-off-by: Coly Li <colyli@suse.de>
>>
>> Hi Jens and Andy,
>>
>> After discussed on mailing list, I realize the original crc64 code was
>> copied from postgreSQL with PostgreSQL license. So we are not able to
>> move the code into lib/crc64 and grant GPL license to the symbols.
> 

Hi Andy,

> Indeed, I also didn't pay much attention to the exporting the symbols.
> Another question if that code may be present in kernel in the first
> place.
>>> I will ask lawyers about how to handle the license issue.
>> For this moment I will hold this patch and not submit it to Linux
>> v4.18.
> 
> You still can apply the rest of clean ups which do not touch this part.
> 

Yes, rest patches will go forward, just this one will be held before I
have a reliable answer from lawyer.

>> Sorry for the inconvenience.
> 
> I have to apologize as well for not being picky about licenses when was
> cooking a patch.
> 

Indeed, I didn't realize it at beginning. Anyway, moving crc64 into lib/
is great idea and I support it. Let's see how to push things forward.

Thanks.

Coly Li
