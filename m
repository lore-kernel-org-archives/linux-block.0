Return-Path: <hare@suse.de>
Subject: Re: block: don't check request size in blk_cloned_rq_check_limits()
To: Mike Snitzer <snitzer@redhat.com>
References: <1464593093-93527-1-git-send-email-hare@suse.de>
 <20160610131901.GA28570@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Brian King <brking@us.ibm.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 mark.bergman@uphs.upenn.edu, "Martin K. Petersen"
 <martin.petersen@oracle.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <575AC10F.7020504@suse.de>
Date: Fri, 10 Jun 2016 15:30:55 +0200
MIME-Version: 1.0
In-Reply-To: <20160610131901.GA28570@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/10/2016 03:19 PM, Mike Snitzer wrote:
> On Mon, May 30 2016 at  3:24am -0400,
> Hannes Reinecke <hare@suse.de> wrote:
> 
>> When checking a cloned request there is no need to check
>> the overall request size; this won't have changed even
>> when resubmitting to another queue.
>> Without this patch ppc64le on ibmvfc fails to boot.
> 
> By simply removing the check aren't you papering over the real problem?
> Looking at Martin's commit f31dc1cd490539 (which introduced the current
> variant of the limits check) I'm not convinced it is equivalent to what
> he replaced.  I'll look closer in a bit.
> 
The check itself is wrong, as we need (at least) to check the
max_hw_sectors here; the request is already fully assembled, so there is
a really good chance he's going beyond the max_sectors.
But trying the error still was found to be present.
So I decided to rip it out, as the overall value of this check is zero.

> Also you categorized your fix was for "ppc64le on ibmvfc"; whereas Mark
> has reported this issue (off-list) against x86_64.  By making it seem
> ppc64le specific I didn't take this patch to be generally applicable.
> 
Well, it has been observed on ppc64. That doesn't mean _only_ ppc64 is
affected. If it were ppc64 only it should've been marked as such, right?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
