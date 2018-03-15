Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33939 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeCOQ4O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 12:56:14 -0400
Subject: Re: [PATCH 06/16] bcache: Suppress more warnings about
 set-but-not-used variables
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "mlyle@lyle.org" <mlyle@lyle.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-7-bart.vanassche@wdc.com>
 <53cbda05-917f-cce3-91ff-73e363448773@suse.de>
 <1521132616.2834.6.camel@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <23ade802-7774-ad61-0521-c7c0718a3f79@suse.de>
Date: Fri, 16 Mar 2018 00:55:00 +0800
MIME-Version: 1.0
In-Reply-To: <1521132616.2834.6.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 16/03/2018 12:50 AM, Bart Van Assche wrote:
> On Fri, 2018-03-16 at 00:20 +0800, Coly Li wrote:
>> On 15/03/2018 11:08 PM, Bart Van Assche wrote:
>>> This patch does not change any functionality.
>>>
>>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>>
>> Hi Bart,
>>
>> This patch looks good to me. A question is, does GCC later than 4.3
>> supports such annotation like '__maybe_unused' ?
> 
> Hello Coly,
> 
> You may want to have a look at the following commit:
> 
> commit 0d7ebbbc6eaa5539f78ab20ed6ff1725a4e332ef
> Author: David Rientjes <rientjes@google.com>
> Date:   Wed May 9 02:35:27 2007 -0700
> 
>     compiler: introduce __used and __maybe_unused
> 
>     __used is defined to be __attribute__((unused)) for all pre-3.3 gcc
>     compilers to suppress warnings for unused functions because perhaps they
>     are referenced only in inline assembly.  It is defined to be
>     __attribute__((used)) for gcc 3.3 and later so that the code is still
>     emitted for such functions.
> 
Hi Bart,

Thanks for the hint, I don't need to worry about it.

Reviewed-by: Coly Li <colyli@suse.de>

Coly Li
