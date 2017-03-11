Return-Path: <axboe@kernel.dk>
Subject: Re: 4.11.0-rc1 boot resulted in WARNING: CPU: 14 PID: 1722 at
 fs/sysfs/dir.c:31 .sysfs_warn_dup+0x78/0xb0
To: Brian Foster <bfoster@redhat.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>
References: <1488904264.3961.17.camel@abdul-ThinkPad-T450>
 <20170308131705.GB23404@bfoster.bfoster>
 <1489056606.3961.41.camel@abdul-ThinkPad-T450>
 <20170309125919.GA16713@bfoster.bfoster>
Cc: linux-xfs@vger.kernel.org, mpe@ellerman.id,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <158127ce-d71d-56a5-3dd3-f676b106c65d@kernel.dk>
Date: Sat, 11 Mar 2017 15:46:36 -0700
MIME-Version: 1.0
In-Reply-To: <20170309125919.GA16713@bfoster.bfoster>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 03/09/2017 05:59 AM, Brian Foster wrote:
> cc linux-block
> 
> On Thu, Mar 09, 2017 at 04:20:06PM +0530, Abdul Haleem wrote:
>> On Wed, 2017-03-08 at 08:17 -0500, Brian Foster wrote:
>>> On Tue, Mar 07, 2017 at 10:01:04PM +0530, Abdul Haleem wrote:
>>>>
>>>> Hi,
>>>>
>>>> Today's mainline (4.11.0-rc1) booted with warnings on Power7 LPAR.
>>>>
>>>> Issue is not reproducible all the time.

Is that still the case with -git as of yesterday? Check that you
have this merge:

34bbce9e344b47e8871273409632f525973afad4

in your tree.

-- 
Jens Axboe
