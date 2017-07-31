Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 02/14] blk-mq: rename flush_busy_ctx_data as ctx_iter_data
Date: Mon, 31 Jul 2017 23:03:04 +0000
Message-ID: <1501542184.2466.24.camel@wdc.com>
References: <20170731165111.11536-1-ming.lei@redhat.com>
         <20170731165111.11536-4-ming.lei@redhat.com>
In-Reply-To: <20170731165111.11536-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-08-01 at 00:50 +0800, Ming Lei wrote:
> The following patch need to reuse this data structure,
> so rename as one generic name.

Hello Ming,

Please drop this patch (see also my comments on the next patch).

Thanks,

Bart.=
