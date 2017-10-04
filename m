Return-Path: <ming.lei@redhat.com>
Date: Wed, 4 Oct 2017 15:53:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 0/8] block, scsi, md: Improve suspend and resume
Message-ID: <20171004075326.GA17729@ming.t460p>
References: <20171002225218.18548-1-bart.vanassche@wdc.com>
 <20171004065607.GA20879@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171004065607.GA20879@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 04, 2017 at 08:56:08AM +0200, Christoph Hellwig wrote:
> Bart, Ming:
> 
> can you guys please work a little better together?  We've now got two
> patchsets that are getting very similar.
> 
> Bart, please at least CC Ming when you send out the patches.
> 
> Ming - instead of sending a separate series right after Bart a
> differential series would be nice.  This also applies the other way
> around if Ming is the first after a while.

Hi Chritoph,

Could you take a look at my yesterday's post V8? Which should
address all previous issues? Except for Tejun's comment
about document __percpu_ref_tryget_live() a bit, and I will
do it in V9.

I have commented on Bart's patchset before, but my comments
never gets addressed:

1) no MD changes required on this issue

2) RCU read lock is missed in fast path

3) bad patch title:

- such as :  'scsi-mq: Reduce suspend latency'
	this is very misleading since it is actually bug fix

- such as : "Make SCSI device suspend and resume work reliably"
	also a bit not accurate

Also holding sdev->state_mutex before freezing queue might
cause deadlock since this lock can be acquired in eh handler(
scsi_eh_offline_sdevs())

-- 
Ming
