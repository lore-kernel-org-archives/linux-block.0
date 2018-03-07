Return-Path: <ming.lei@redhat.com>
Date: Wed, 7 Mar 2018 13:27:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>, Don Brace <don.brace@microsemi.com>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance via
 .host_tagset
Message-ID: <20180307052725.GB15024@ming.t460p>
References: <20180227100750.32299-1-ming.lei@redhat.com>
 <20180227100750.32299-9-ming.lei@redhat.com>
 <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 28, 2018 at 08:28:48PM +0530, Kashyap Desai wrote:
> Ming -
> 
> Quick testing on my setup -  Performance slightly degraded (4-5% drop)for
> megaraid_sas driver with this patch. (From 1610K IOPS it goes to 1544K)
> I confirm that after applying this patch, we have #queue = #numa node.
> 
> ls -l
> /sys/devices/pci0000:80/0000:80:02.0/0000:83:00.0/host10/target10:2:23/10:
> 2:23:0/block/sdy/mq
> total 0
> drwxr-xr-x. 18 root root 0 Feb 28 09:53 0
> drwxr-xr-x. 18 root root 0 Feb 28 09:53 1
> 
> 
> I would suggest to skip megaraid_sas driver changes using shared_tagset
> until and unless there is obvious gain. If overall interface of using
> shared_tagset is commit in kernel tree, we will investigate (megaraid_sas
> driver) in future about real benefit of using it.

Hi Kashyap,

Now I have put patches for removing operating on scsi_host->host_busy
in V4[1], especially which are done in the following 3 patches:

	9221638b9bc9 scsi: avoid to hold host_busy for scsi_mq
	1ffc8c0ffbe4 scsi: read host_busy via scsi_host_busy()
	e453d3983243 scsi: introduce scsi_host_busy()


Could you run your test on V4 and see if IOPS can be improved on
megaraid_sas?


[1] https://github.com/ming1/linux/commits/v4.16-rc-host-tags-v4

Thanks,
Ming
