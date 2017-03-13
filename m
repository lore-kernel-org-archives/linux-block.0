Return-Path: <abdhalee@linux.vnet.ibm.com>
Subject: Re: 4.11.0-rc1 boot resulted in WARNING: CPU: 14 PID: 1722 at
 fs/sysfs/dir.c:31 .sysfs_warn_dup+0x78/0xb0
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, mpe@ellerman.id,
        linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Mon, 13 Mar 2017 23:00:27 +0530
In-Reply-To: <158127ce-d71d-56a5-3dd3-f676b106c65d@kernel.dk>
References: <1488904264.3961.17.camel@abdul-ThinkPad-T450>
	 <20170308131705.GB23404@bfoster.bfoster>
	 <1489056606.3961.41.camel@abdul-ThinkPad-T450>
	 <20170309125919.GA16713@bfoster.bfoster>
	 <158127ce-d71d-56a5-3dd3-f676b106c65d@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1489426227.19698.36.camel@abdul>
List-ID: <linux-block@vger.kernel.org>

On Sat, 2017-03-11 at 15:46 -0700, Jens Axboe wrote:
> On 03/09/2017 05:59 AM, Brian Foster wrote:
> > cc linux-block
> > 
> > On Thu, Mar 09, 2017 at 04:20:06PM +0530, Abdul Haleem wrote:
> >> On Wed, 2017-03-08 at 08:17 -0500, Brian Foster wrote:
> >>> On Tue, Mar 07, 2017 at 10:01:04PM +0530, Abdul Haleem wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> Today's mainline (4.11.0-rc1) booted with warnings on Power7 LPAR.
> >>>>
> >>>> Issue is not reproducible all the time.
> 
> Is that still the case with -git as of yesterday? Check that you
> have this merge:
> 
> 34bbce9e344b47e8871273409632f525973afad4
> 
> in your tree.
> 

Thanks for pointing out, with the below merge commit warnings disappear.

commit 34bbce9e344b47e8871273409632f525973afad4
Merge: bb61ce5 672a2c8
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Mar 9 15:53:25 2017 -0800

    Merge branch 'for-linus' of git://git.kernel.dk/linux-block


Thanks for the fix !

Reported-by & Tested-by : Abdul Haleem <abdhalee@linux.vnet.ibm.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
