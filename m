Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out002.mailprotect.be ([83.217.72.86]:44741 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbeISCzh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 22:55:37 -0400
Subject: Re: [PATCH blktests 0/3] Add NVMeOF multipath tests
To: Omar Sandoval <osandov@osandov.com>
Cc: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "msnitzer@redhat.com" <msnitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180815203728.19521-1-bart.vanassche@wdc.com>
 <20180820073059.quvg3bh4ngv5ka4x@linux-x5ow.site>
 <ee851ae7b88a93b9b5c9f1b0c6e206944c0b3c64.camel@wdc.com>
 <20180821064619.7tyhlst74qkrw4fi@linux-x5ow.site>
 <775a05ab91aed62b980ecfff1525ac3d71017752.camel@wdc.com>
 <20180824002133.GA14674@vader>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <66df74ec-43d3-c7c4-73d0-16e008b23695@acm.org>
Date: Tue, 18 Sep 2018 14:20:59 -0700
MIME-Version: 1.0
In-Reply-To: <20180824002133.GA14674@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 8/23/18 5:21 PM, Omar Sandoval wrote:
> On Thu, Aug 23, 2018 at 01:53:33AM +0000, Bart Van Assche wrote:
>> On Tue, 2018-08-21 at 08:46 +0200, Johannes Thumshirn wrote:
>>> On Mon, Aug 20, 2018 at 03:46:45PM +0000, Bart Van Assche wrote:
>>>> Moving these tests into the nvme directory is possible but will make it
>>>> harder to run the NVMeOF multipath tests separately. Are you fine with this?
>>>
>>> Both way's have it's up and downsides, I agree.
>>>
>>> Having two distinct groups requires to run './check nvme nvmeof-mp' to
>>> run full coverage with nvme.
>>>
>>> Having it all in one group would require to run './check nvme 18 19 20
>>> 21 22 23 24 ...' to get only the dm-mpath ones.
>>>
>>> Honestly I hate both but your's (the two distinct groups) is probably
>>> easier to handle in the end, I have to admit.
>>
>> Omar, do you have a preference for one of the two aforementioned approaches?
> 
> Let's keep it in a separate category, since lots of people running nvme
> tests probably aren't interested in testing multipath.
> 
> A bunch of the tests failed with
> 
> modprobe: FATAL: Module nvme is in use.
> 
> Maybe related to my test VM having an nvme device?

Hello Omar,

Can you have a look at the updated master branch of 
https://github.com/bvanassche/blktests? That code should no longer fail 
if unloading the nvme kernel module fails. Please note that you will 
need kernel v4.18 to test these scripts - a KASAN complaint appears if I 
run these tests against kernel v4.19-rc4.

Thanks,

Bart.
