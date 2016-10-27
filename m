Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20161027124258.GD13200@lst.de>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <5143c240-39af-9fe2-d3e6-ed69f9c20531@sandisk.com>
 <CACVXFVPWL=izFmUPtpi-+RLrhNX0LFfw2m6eurgMC5GvfDWsxQ@mail.gmail.com>
 <7690b469-f5b7-ab04-4b6f-fa0d679e0f18@acm.org>
 <CACVXFVNvdNXm4JXsXo2p1_pZLqDpCos0MTTR+svR98p_vw5PCA@mail.gmail.com>
 <16074653-5e31-27b0-90db-33d36a9df0bc@acm.org>
 <CACVXFVNyRnJFnsSO9TNksE5GNy7TJKL=iZnqrv38=u0XCrW7jA@mail.gmail.com>
 <8404f2d1-5bc3-6c84-7ca0-24e7672ff67d@acm.org> <20161027124258.GD13200@lst.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 27 Oct 2016 21:16:29 +0800
Message-ID: <CACVXFVOpc2rwydYWjSHWs18QmACr+-fSP75rwk+tBv6WWAwg2g@mail.gmail.com>
Subject: Re: [PATCH 05/12] blk-mq: Introduce blk_mq_quiesce_queue()
To: Christoph Hellwig <hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 Bart Van Assche <bvanassche@acm.org>, Mike Snitzer <snitzer@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Doug Ledford <dledford@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Laurence Oberman <loberman@redhat.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 27, 2016 at 8:42 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Oct 26, 2016 at 08:05:14PM -0700, Bart Van Assche wrote:
>> I'll leave it to Jens to decide whether I should repost the patch series
>> with this change integrated or whether to realize this change with a
>> follow-up patch.
>
> I would prefer to get the series in now.  I think we should eventually
> the stop queues call, the quience call and even the cancellation of
> the requeues into a single function, but it's not as urgent.  I think
> this series actually is Linux 4.9 material.

Yeah, that is fine to cleanup in follow-up patch.

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks
Ming Lei

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
