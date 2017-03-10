Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <yq1zih4pdhn.fsf@oracle.com>
References: <CAOi1vP8M91kiF-FnT=EoJgTxfstMEsC-nhLY5KtRkrKROjWPWA@mail.gmail.com>
 <yq1efyq25y2.fsf@oracle.com>
 <CAOi1vP-amFyFHbPV3FhG3F1Tp+df6V7a4mcP8LLWY0GZx+JsFw@mail.gmail.com>
 <yq1fuj44geq.fsf@oracle.com>
 <CAOi1vP_g-MMe9XvWDgkVL4R6UjckMQVC_CDF9+hQEpZbxwx0Jw@mail.gmail.com>
 <yq1zih4pdhn.fsf@oracle.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 10 Mar 2017 17:49:22 +0100
Message-ID: <CAOi1vP-VAUYwnuxMMgknpGLKgZR=8+JV_naASKE8vx8h9+R=pQ@mail.gmail.com>
Subject: Re: blk_integrity_revalidate() clears BDI_CAP_STABLE_WRITES
To: "Martin K. Petersen" <martin.petersen@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 Ceph Development <ceph-devel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 2, 2017 at 4:24 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Ilya" == Ilya Dryomov <idryomov@gmail.com> writes:
>
> Ilya,
>
> Ilya> Given the above, I'm not sure what the baseline is --
> Ilya> blk_integrity code isn't invoked for data-only lbafs.  Could nvme
> Ilya> folks please look at this?  rbd regression caused by integrity
> Ilya> revalidate change goes back to 4.4 and I'd really like to get it
> Ilya> fixed.  The proposed patch is attached to my earlier reply on
> Ilya> linux-block.
>
> I've had a couple of fires to attend to this week. I'll try and give
> your patch a spin on my FC setup tomorrow or Friday.

Hi Martin,

Ping...  Did you get a chance to try it?

Thanks,

                Ilya

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
