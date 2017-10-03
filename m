Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Tue, 3 Oct 2017 07:14:59 -0700
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Cathy Avery <cavery@redhat.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V8 5/8] percpu-refcount: introduce
 __percpu_ref_tryget_live
Message-ID: <20171003141459.GI3301751@devbig577.frc2.facebook.com>
References: <20171003140406.26060-1-ming.lei@redhat.com>
 <20171003140406.26060-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171003140406.26060-6-ming.lei@redhat.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue, Oct 03, 2017 at 10:04:03PM +0800, Ming Lei wrote:
> Block layer need to call this function after holding
> rcu lock in a real hot path, so introduce this helper.

The patch description is too anemic.  It doesn't even describe what
changes are being made, let alone justifying them.

Thanks.

-- 
tejun
