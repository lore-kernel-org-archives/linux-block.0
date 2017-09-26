Return-Path: <ming.lei@redhat.com>
Date: Tue, 26 Sep 2017 17:15:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH v4 0/7] Make suspend and resume safe for md-on-SCSI
Message-ID: <20170926091539.GF518@ming.t460p>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925202924.16603-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 01:29:17PM -0700, Bart Van Assche wrote:
> Hello Jens,
> 
> It is known that during the resume following a hibernate, especially when
> using an md RAID1 array created on top of SCSI devices, sometimes the
> system hangs instead of coming up properly. This patch series fixes this
> problem. This patch series is an alternative for Ming Lei's "[PATCH V5
> 0/10] block/scsi: safe SCSI quiescing" patch series. The advantages of
> this patch series are:

No, if you only address issue on MD device, that is definitely not
alternative of my patchset.

Guys have verified that my patches can fix either MD and
non-MD(btrfs/raid, transport_spi) case. And my patchset can fix this
kind of issue on any SCSI device, w/w.o MD.

-- 
Ming
