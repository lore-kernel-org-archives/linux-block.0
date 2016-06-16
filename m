Return-Path: <mauricfo@linux.vnet.ibm.com>
Subject: Re: block: don't check request size in blk_cloned_rq_check_limits()
To: Brian King <brking@linux.vnet.ibm.com>, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>
References: <1464593093-93527-1-git-send-email-hare@suse.de>
 <20160610131901.GA28570@redhat.com> <yq160tgfoqr.fsf@sermon.lab.mkp.net>
 <575BE182.5010304@suse.de> <yq11t44f0hi.fsf@sermon.lab.mkp.net>
 <575C0DAE.7070502@suse.de> <yq17fdrcjs3.fsf@sermon.lab.mkp.net>
 <5760F6BC.60109@suse.de> <576127FC.9020608@kernel.dk>
 <57612F12.5070505@suse.de> <5761838E.1000106@linux.vnet.ibm.com>
Cc: Mike Snitzer <snitzer@redhat.com>, Brian King <brking@us.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        mark.bergman@uphs.upenn.edu
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Thu, 16 Jun 2016 09:35:47 -0300
MIME-Version: 1.0
In-Reply-To: <5761838E.1000106@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <57629D23.1090704@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Hey,

On 06/15/2016 01:34 PM, Brian King wrote:
> Mauricio was looking at this, adding him to cc. We did have a KVM config
> where we could reproduce this issue as well, I think with some PCI passthrough
> adapters. Mauricio - do you have any more details about the KVM config that
> reproduced this issue and did you ever try to reproduce this with an upstream
> kernel?

It's KVM guest w/ SLES 12 SP1 + kernel updates (3.12.53-60.30 introduced
the error) and PCI passthrough of Emulex FC and FCoE adapters, connected
to 4 storage systems (DS8000, XIV, SVC, and FlashSystem 840).

It seems only the XIV LUNs never hit the problem, but it didn't seem to
be storage-specific, as FS840 LUNs had a mix of hit/not-hit the problem.
One thing is that all paths of a LUN were either failed or not - no mix
within a LUN.

Unfortunately not too much analysis was performed on this system at the
time -- Hannes had already made good progress w/ the customer, and some
test kernel builds that resolved the issue were made available soon.

Now that the topic is under discussion, I've asked for some time slots
on that system, so we can test an upstream kernel and try to reproduce
the problem and analyze it more closely.


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
