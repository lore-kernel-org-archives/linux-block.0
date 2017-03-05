Return-Path: <axboe@kernel.dk>
Subject: Re: [bdi_unregister] 165a5e22fa INFO: task swapper:1 blocked for more
 than 120 seconds.
To: Fengguang Wu <fengguang.wu@intel.com>, Jan Kara <jack@suse.cz>
References: <20170305022111.yqtwyd6ognmco4gx@wfg-t540p.sh.intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 LKP <lkp@01.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <912e4814-eeee-a959-c049-2aa22bb80781@kernel.dk>
Date: Sun, 5 Mar 2017 08:12:30 -0700
MIME-Version: 1.0
In-Reply-To: <20170305022111.yqtwyd6ognmco4gx@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/04/2017 07:21 PM, Fengguang Wu wrote:
> Hi Jan,
> 
> FYI next-20170303 is good while mainline is bad with this error.
> The attached reproduce-* may help reproduce the issue.

What's the test case here? It's Sunday, we need to make a quick
decision on whether to revert this patch or not. I'm inclined to
do so.

Jan?

-- 
Jens Axboe
