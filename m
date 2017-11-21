Return-Path: <axboe@kernel.dk>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Bart Van Assche <Bart.VanAssche@wdc.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <9c5eec5d-f542-4d76-6933-6fe31203ce09@de.ibm.com>
 <1511205644.2396.32.camel@wdc.com>
 <04526c98-ffc5-1eca-3aa8-50f9212c4323@de.ibm.com>
 <5c9f2228-0a8b-8225-7038-e6cb3f31ca0b@kernel.dk>
 <2e44dbd3-2f90-c267-560c-91d1d4b0e892@de.ibm.com>
 <823b9dd5-7781-5a72-03ff-bc931433fc19@kernel.dk>
 <bd928410-4d38-603e-00c9-4c4db20d8e86@de.ibm.com>
 <15f232d2-2aaa-df7c-57e8-2f710e051e84@de.ibm.com>
 <c8bd769e-9742-205d-11b0-469428a8579c@de.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b7b3cf4b-837e-f9ba-61c0-4f9ddd8b9a95@kernel.dk>
Date: Tue, 21 Nov 2017 10:27:04 -0700
MIME-Version: 1.0
In-Reply-To: <c8bd769e-9742-205d-11b0-469428a8579c@de.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/21/2017 03:14 AM, Christian Borntraeger wrote:
> Bisect points to
> 
> 1b5a7455d345b223d3a4658a9e5fce985b7998c1 is the first bad commit
> commit 1b5a7455d345b223d3a4658a9e5fce985b7998c1
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Jun 26 12:20:57 2017 +0200
> 
>     blk-mq: Create hctx for each present CPU
>     
>     commit 4b855ad37194f7bdbb200ce7a1c7051fecb56a08 upstream.
>     
>     Currently we only create hctx for online CPUs, which can lead to a lot
>     of churn due to frequent soft offline / online operations.  Instead
>     allocate one for each present CPU to avoid this and dramatically simplify
>     the code.
>     
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Jens Axboe <axboe@kernel.dk>
>     Cc: Keith Busch <keith.busch@intel.com>
>     Cc: linux-block@vger.kernel.org
>     Cc: linux-nvme@lists.infradead.org
>     Link: http://lkml.kernel.org/r/20170626102058.10200-3-hch@lst.de
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
>     Cc: Mike Galbraith <efault@gmx.de>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I wonder if we're simply not getting the masks updated correctly. I'll
take a look.

-- 
Jens Axboe
