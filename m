Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH v5 12/14] SRP transport, scsi-mq: Wait for .queue_rq() if
 necessary
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
 <32accadb-3ed3-cd5d-e92f-655f8f3cb9bc@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6fc88a33-7a93-2be4-5d38-6e476676cd6b@grimberg.me>
Date: Tue, 1 Nov 2016 18:03:16 +0200
MIME-Version: 1.0
In-Reply-To: <32accadb-3ed3-cd5d-e92f-655f8f3cb9bc@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

and again,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
