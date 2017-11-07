Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH] scsi_debugfs: fix crash in scsi_show_rq()
To: Ming Lei <ming.lei@redhat.com>,
        James Bottomley <JBottomley@parallels.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20171107145526.19315-1-ming.lei@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, <linux-scsi@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Hannes Reinecke <hare@suse.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <88aa2b0b-ef36-411e-a429-06da2dda50d3@huawei.com>
Date: Tue, 7 Nov 2017 15:04:09 +0000
MIME-Version: 1.0
In-Reply-To: <20171107145526.19315-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hi Ming,

On 07/11/2017 14:55, Ming Lei wrote:
 > +		strcpy(buf, "unknow");

typo?

Thanks,
John
