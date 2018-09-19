Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out002.mailprotect.be ([83.217.72.86]:54127 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeISFiC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Sep 2018 01:38:02 -0400
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
 <20180824002133.GA14674@vader> <66df74ec-43d3-c7c4-73d0-16e008b23695@acm.org>
 <20180918232429.GB479@vader>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <e73f116a-f665-7222-1c3e-63ef1c031687@acm.org>
Date: Tue, 18 Sep 2018 17:02:47 -0700
MIME-Version: 1.0
In-Reply-To: <20180918232429.GB479@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 9/18/18 4:24 PM, Omar Sandoval wrote:
> On Tue, Sep 18, 2018 at 02:20:59PM -0700, Bart Van Assche wrote:
>> Can you have a look at the updated master branch of
>> https://github.com/bvanassche/blktests? That code should no longer fail if
>> unloading the nvme kernel module fails. Please note that you will need
>> kernel v4.18 to test these scripts - a KASAN complaint appears if I run
>> these tests against kernel v4.19-rc4.
> 
> Thanks, these pass now. Is it expected that my nvme device gets a
> multipath device configured after running these tests?
> 
> $ lsblk
> NAME     MAJ:MIN RM SIZE RO TYPE  MOUNTPOINT
> vda      254:0    0  16G  0 disk
> └─vda1   254:1    0  16G  0 part  /
> vdb      254:16   0   8G  0 disk
> vdc      254:32   0   8G  0 disk
> vdd      254:48   0   8G  0 disk
> nvme0n1  259:0    0   8G  0 disk
> └─mpatha 253:0    0   8G  0 mpath

No, all multipath devices that were created during a test should be 
removed before that test finishes. I will look into this.

> Also, can you please fix:
> 
> 	_have_kernel_option NVME_MULTIPATH && exit 1
> 
> to not exit on failure? It should use SKIP_REASON and return 1. You
> might need to add something like _dont_have_kernel_option to properly
> handle the case where the config is not found.

OK, I will change this.

> Side note which isn't a blocker for merging is that there's a lot of
> duplicated code between these helpers and the srp helpers. How hard
> would it be to refactor that?

Are you perhaps referring to the code that is shared between the 
tests/srp/rc tests/nvmeof-mp/rc shell scripts? The hardest part is 
probably to chose a location where to store these functions. Should I 
create a file with common code under common/, under tests/srp/, under 
tests/nvmeof-mp/ or perhaps somewhere else?

Thanks,

Bart.
