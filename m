Return-Path: <hare@suse.de>
Subject: Re: block: don't check request size in blk_cloned_rq_check_limits()
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@redhat.com>
References: <1464593093-93527-1-git-send-email-hare@suse.de>
 <20160610131901.GA28570@redhat.com> <yq160tgfoqr.fsf@sermon.lab.mkp.net>
Cc: Jens Axboe <axboe@kernel.dk>, Brian King <brking@us.ibm.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 mark.bergman@uphs.upenn.edu
From: Hannes Reinecke <hare@suse.de>
Message-ID: <575BE182.5010304@suse.de>
Date: Sat, 11 Jun 2016 12:01:38 +0200
MIME-Version: 1.0
In-Reply-To: <yq160tgfoqr.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/11/2016 04:22 AM, Martin K. Petersen wrote:
>>>>>> "Mike" == Mike Snitzer <snitzer@redhat.com> writes:
>
>>> When checking a cloned request there is no need to check the overall
>>> request size; this won't have changed even when resubmitting to
>>> another queue.  Without this patch ppc64le on ibmvfc fails to boot.
>
> Why is the number of sectors in the request bigger than the queue limit?
>
Because we're checking the wrong limit.
blk_queue_get_max_sectors() is checking limits.max_sectors(), but the 
requests are already fully formed and can extend up to 
limits.max_hw_sectors().

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
