Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33325 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753827AbcJSXrs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2016 19:47:48 -0400
MIME-Version: 1.0
In-Reply-To: <0718ec72-d525-2e75-a123-3bf9ea129319@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <e42a952c-f245-eb39-d0a1-0336035573f9@sandisk.com> <0718ec72-d525-2e75-a123-3bf9ea129319@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 20 Oct 2016 07:47:46 +0800
Message-ID: <CACVXFVM1tRXPDkJZbrtxkgZ=Uy9iCAh3OvmHf5BC23RbJkbMKg@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] blk-mq: Introduce blk_mq_quiesce_queue()
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 20, 2016 at 5:04 AM, Bart Van Assche
<bart.vanassche@sandisk.com> wrote:
> On 10/18/2016 02:50 PM, Bart Van Assche wrote:
>>
>> blk_mq_quiesce_queue() waits until ongoing .queue_rq() invocations
>> have finished. This function does *not* wait until all outstanding
>> requests have finished (this means invocation of request.end_io()).
>
>
> (replying to my own e-mail)
>
> The zero-day kernel test infrastructure reported to me that this patch
> causes a build failure with CONFIG_SRCU=n. Should I add "select SRCU" to
> block/Kconfig (excludes TINY_RCU) or should I rather modify this patch such

Select SRCU is fine, and you can see it is done in lots of
places(btrfs, net, quota, kvm, power,...)

> that a mutex or rwsem is used instead of SRCU?

Both should be much worse than SRCU, even not as good as atomic_t.

Thanks,
Ming

>
> Thanks,
>
> Bart.
>



-- 
Ming Lei
