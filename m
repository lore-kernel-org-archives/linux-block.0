Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] blk-mq: Introduce blk_quiesce_queue() and
 blk_resume_queue()
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <tom.leiming@gmail.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <a9eb4e95-6d77-e527-c42a-fd2e6f104bed@sandisk.com>
 <CACVXFVOO4P3RsnWci8XHdFoYBhNPq0KqjWJddsie-92+31bpEg@mail.gmail.com>
 <9fb67745-954c-a70f-a89a-d184c99ae9aa@sandisk.com>
 <CACVXFVMY19vuDjsECg2uX0_y_K7DUaaGqXPX9PYiBy5sfXmAEw@mail.gmail.com>
 <a11bb09a-6207-f4a8-cfd4-4fe5627c1700@sandisk.com>
 <09238e87-7d60-89c9-98b0-e51caa0c0839@grimberg.me>
 <6d612be9-7ba7-888e-f9c6-f8aa4ef1606a@sandisk.com>
 <732bf5d6-d7a8-6ff0-6501-8a3d46f12fab@grimberg.me>
CC: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        "Keith Busch" <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <07628c2f-3a4e-b12e-663a-b0711ce20cc9@sandisk.com>
Date: Wed, 5 Oct 2016 14:08:57 -0700
MIME-Version: 1.0
In-Reply-To: <732bf5d6-d7a8-6ff0-6501-8a3d46f12fab@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 10/05/2016 12:11 PM, Sagi Grimberg wrote:
> I was referring to weather we can take srcu in the submission path
> conditional of the hctx being STOPPED?

Hello Sagi,

Regarding run-time overhead:
* rcu_read_lock() is a no-op on CONFIG_PREEMPT_NONE kernels and is
   translated into preempt_disable() with preemption enabled. The latter
   function modifies a per-cpu variable.
* Checking BLK_MQ_S_STOPPED before taking an rcu or srcu lock is only
   safe if the BLK_MQ_S_STOPPED flag is tested in such a way that the
   compiler is told to reread the hctx flags (READ_ONCE()) and if the
   compiler and CPU are told not to reorder test_bit() with the
   memory accesses in (s)rcu_read_lock(). To avoid races
   BLK_MQ_S_STOPPED will have to be tested a second time after the lock
   has been obtained, similar to the double-checked-locking pattern.
* srcu_read_lock() reads a word from the srcu structure, disables
   preemption, calls __srcu_read_lock() and re-enables preemption. The
   latter function increments two CPU-local variables and triggers a
   memory barrier (smp_mp()).

Swapping srcu_read_lock() and the BLK_MQ_S_STOPPED flag test will make 
the code more complicated. Going back to the implementation that calls 
rcu_read_lock() if .queue_rq() won't sleep will result in an 
implementation that is easier to read and to verify. If I overlooked 
something, please let me know.

Bart.


