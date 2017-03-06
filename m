Return-Path: <fengguang.wu@intel.com>
Date: Mon, 6 Mar 2017 09:19:30 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: [bdi_unregister] 165a5e22fa INFO: task swapper:1 blocked for
 more than 120 seconds.
Message-ID: <20170306011930.caykve5eanc5pn5m@wfg-t540p.sh.intel.com>
References: <20170305022111.yqtwyd6ognmco4gx@wfg-t540p.sh.intel.com>
 <912e4814-eeee-a959-c049-2aa22bb80781@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <912e4814-eeee-a959-c049-2aa22bb80781@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sun, Mar 05, 2017 at 08:12:30AM -0700, Jens Axboe wrote:
>On 03/04/2017 07:21 PM, Fengguang Wu wrote:
>> Hi Jan,
>>
>> FYI next-20170303 is good while mainline is bad with this error.
>> The attached reproduce-* may help reproduce the issue.
>
>What's the test case here? It's Sunday, we need to make a quick
>decision on whether to revert this patch or not. I'm inclined to
>do so.

It's boot-and-trinity test. The initrd (that the reproduce-* script
will auto download) is hard coded to do that.

Thanks,
Fengguang
