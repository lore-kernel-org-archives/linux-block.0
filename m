Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Add should_fail_bio() for bpf error injection
To: Omar Sandoval <osandov@osandov.com>,
 Howard McLauchlan <hmclauchlan@fb.com>
Cc: linux-block@vger.kernel.org, Josef Bacik <jbacik@fb.com>
References: <20180124232258.17164-1-hmclauchlan@fb.com>
 <20180206192732.GA16027@vader.DHCP.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6cb9b347-66b5-e688-97c1-9fb039da7423@kernel.dk>
Date: Tue, 6 Feb 2018 12:50:08 -0700
MIME-Version: 1.0
In-Reply-To: <20180206192732.GA16027@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/6/18 12:27 PM, Omar Sandoval wrote:
> On Wed, Jan 24, 2018 at 03:22:58PM -0800, Howard McLauchlan wrote:
>> The classic error injection mechanism, should_fail_request() does not
>> support use cases where more information is required (from the entire
>> struct bio, for example).
>>
>> To that end, this patch introduces should_fail_bio(), which calls
>> should_fail_request() under the hood but provides a convenient
>> place for kprobes to hook into if they require the entire struct bio.
>> This patch also replaces some existing calls to should_fail_request()
>> with should_fail_bio() with no degradation in performance.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> Jens, can we pick this up for 4.16? The necessary BPF support has been
> merged into Linus' tree.

I don't see why not - but the patch no longer applies. Howard, can you
respin it?

-- 
Jens Axboe
