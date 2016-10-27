Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: A question regarding "multiple SGL"
To: Christoph Hellwig <hch@lst.de>, "Qiuxin (robert)" <qiuxin@huawei.com>
References: <20161027005230.9904DC00097@webmail.sinamail.sina.com.cn>
 <20161027064115.GA5864@lst.de>
 <B78D1A958924E54594997EFF975251625BD49445@szxeml592-mbx.china.huawei.com>
 <20161027071009.GA6434@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <178765fb-0fcf-0fdc-dc5e-0cc226375827@grimberg.me>
Date: Thu, 27 Oct 2016 12:02:20 +0300
MIME-Version: 1.0
In-Reply-To: <20161027071009.GA6434@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Ming Lei <tom.leiming@gmail.com>, Tiger zhao <tiger.zhao@huawei.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Doug Ledford <dledford@redhat.com>,
 Laurence Oberman <loberman@redhat.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>


> Hi Robert,

Hey Robert, Christoph,

> please explain your use cases that isn't handled.  The one and only
> reason to set MSDBD to 1 is to make the code a lot simpler given that
> there is no real use case for supporting more.
>
> RDMA uses memory registrations to register large and possibly
> discontiguous data regions for a single rkey, aka single SGL descriptor
> in NVMe terms.  There would be two reasons to support multiple SGL
> descriptors:  a) to support a larger I/O size than supported by a single
> MR, or b) to support a data region format not mappable by a single
> MR.
>
> iSER only supports a single rkey (or stag in IETF terminology) and has
> been doing fine on a) and mostly fine on b).   There are a few possible
> data layouts not supported by the traditional IB/iWarp FR WRs, but the
> limit is in fact exactly the same as imposed by the NVMe PRPs used for
> PCIe NVMe devices, so the Linux block layer has support to not generate
> them.  Also with modern Mellanox IB/RoCE hardware we can actually
> register completely arbitrary SGLs.  iSER supports using this registration
> mode already with a trivial code addition, but for NVMe we didn't have a
> pressing need yet.

Good explanation :)

The IO transfer size is a bit more pressing on some devices (e.g.
cxgb3/4) where the number of pages per-MR can be indeed lower than
a reasonable transfer size (Steve can correct me if I'm wrong).

However, if there is a real demand for this we'll happily accept
patches :)

Just a note, having this feature in-place can bring unexpected behavior
depending on how we implement it:
- If we can use multiple MRs per IO (for multiple SGLs) we can either
prepare for the worst-case and allocate enough MRs to satisfy the
various IO patterns. This will be much heavier in terms of resource
allocation and can limit the scalability of the host driver.
- Or we can implement a shared MR pool with a reasonable number of MRs.
In this case each IO can consume one or more MRs on the expense of
other IOs. In this case we may need to requeue the IO later when we
have enough available MRs to satisfy the IO. This can yield some
unexpected performance gaps for some workloads.

Cheers,
Sagi.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
