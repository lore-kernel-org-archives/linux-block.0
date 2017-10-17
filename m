Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v9 09/10] block, scsi: Make SCSI quiesce and resume work reliably
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171016232905.5047-1-bart.vanassche@wdc.com>
	<20171016232905.5047-10-bart.vanassche@wdc.com>
Date: Tue, 17 Oct 2017 00:17:32 -0400
In-Reply-To: <20171016232905.5047-10-bart.vanassche@wdc.com> (Bart Van
	Assche's message of "Mon, 16 Oct 2017 16:29:04 -0700")
Message-ID: <yq11sm2xvab.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> The contexts from which a SCSI device can be quiesced or resumed are:
> * Writing into /sys/class/scsi_device/*/device/state.
> * SCSI parallel (SPI) domain validation.
> * The SCSI device power management methods. See also scsi_bus_pm_ops.

The SCSI bits look fine to me.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
