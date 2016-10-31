Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH v5 14/14] nvme: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
To: Laurence Oberman <loberman@redhat.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
 <fe057bf0-6ede-fc9e-9a53-9d790c9782c2@sandisk.com>
 <540193784.5466628.1477921998345.JavaMail.zimbra@redhat.com>
CC: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <c8c503bf-4fcb-5e1d-487a-53277bc1c300@sandisk.com>
Date: Mon, 31 Oct 2016 06:59:35 -0700
MIME-Version: 1.0
In-Reply-To: <540193784.5466628.1477921998345.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 10/31/2016 06:53 AM, Laurence Oberman wrote:
> Ran multiple read/write buffered and directio tests via RDMA/SRP and mlx5 (100Gbit) with max_sectors_kb set to 1024, 2048, 4096 and 8196
> Ran multiple read/write buffered and directio tests via RDMA/SRP and mlx4 (56Gbit)  with max_sectors_kb set to 1024, 2048, 4096 and 8196
> Reset the SRP hosts multiple times with multipath set to no_path_retry queue
> Ran basic NVME read/write testing with no hot plug disconnects on multiple block sizes
>
> All tests passed.
>
> For the series:
> Tested-by: Laurence Oberman <loberman@redhat.com>

Hello Laurence,

Thanks for having tested this version of this patch series again so quickly!

Bart.
