Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH v5 08/14] blk-mq: Add a kick_requeue_list argument to
 blk_mq_requeue_request()
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
 <01d525ec-5b5b-b22d-4b17-36d7406920ed@sandisk.com>
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
Message-ID: <41909d98-a3ac-a008-3869-207ff98b7fdc@grimberg.me>
Date: Tue, 1 Nov 2016 18:02:36 +0200
MIME-Version: 1.0
In-Reply-To: <01d525ec-5b5b-b22d-4b17-36d7406920ed@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Looks useful,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
