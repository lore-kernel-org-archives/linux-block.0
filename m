Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] scsi: scsi-mq: don't hold host_busy in IO path
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "snitzer@redhat.com" <snitzer@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "hare@suse.de" <hare@suse.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "don.brace@microsemi.com" <don.brace@microsemi.com>,
 "james.bottomley@hansenpartnership.com"
 <james.bottomley@hansenpartnership.com>, "osandov@fb.com" <osandov@fb.com>,
 "loberman@redhat.com" <loberman@redhat.com>,
 "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>
References: <20180420065742.8043-1-ming.lei@redhat.com>
 <87619135ac0bfefa07f510170024b609e641db0c.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <607c4d2f-28e7-4152-dbf5-7fb4387e9413@kernel.dk>
Date: Fri, 27 Apr 2018 09:39:47 -0600
MIME-Version: 1.0
In-Reply-To: <87619135ac0bfefa07f510170024b609e641db0c.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/27/18 9:31 AM, Bart Van Assche wrote:
> On Fri, 2018-04-20 at 14:57 +0800, Ming Lei wrote:
>> This patches removes the expensive atomic opeation on host-wide counter
>> of .host_busy for scsi-mq, and it is observed that IOPS can be increased by
>> 15% with this change in IO test over scsi_debug.
>>
>>
>> Ming Lei (3):
>>   scsi: introduce scsi_host_busy()
>>   scsi: read host_busy via scsi_host_busy()
>>   scsi: avoid to hold host-wide counter of host_busy for scsi_mq
>>
>>  drivers/scsi/advansys.c                   |  8 ++++----
>>  drivers/scsi/hosts.c                      | 32 +++++++++++++++++++++++++++++++
>>  drivers/scsi/libsas/sas_scsi_host.c       |  4 ++--
>>  drivers/scsi/megaraid/megaraid_sas_base.c |  2 +-
>>  drivers/scsi/mpt3sas/mpt3sas_base.c       |  4 ++--
>>  drivers/scsi/qlogicpti.c                  |  2 +-
>>  drivers/scsi/scsi.c                       |  2 +-
>>  drivers/scsi/scsi_error.c                 |  6 +++---
>>  drivers/scsi/scsi_lib.c                   | 23 ++++++++++++++++------
>>  drivers/scsi/scsi_sysfs.c                 |  2 +-
>>  include/scsi/scsi_host.h                  |  1 +
>>  11 files changed, 65 insertions(+), 21 deletions(-)\
> 
> Hello Ming,
> 
> From the MAINTAINERS file:
> 
> SCSI SUBSYSTEM
> M:      "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git
> M:      "Martin K. Petersen" <martin.petersen@oracle.com>
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
> L:      linux-scsi@vger.kernel.org
> S:      Maintained
> F:      Documentation/devicetree/bindings/scsi/
> F:      drivers/scsi/
> F:      include/scsi/
> 
> Hence my surprise when I saw that you sent this patch series to Jens instead
> of James and Martin?

Martin and James are both on the CC as well. For what it's worth, the patch
seems like a good approach to me. To handle the case that Hannes was concerned
about (older drivers doing internal command issue), I would suggest that those
drivers get instrumented to include a inc/dec of the host busy count for
internal commands that bypass the normal tagging. That means the mq case needs
to be

blk_mq_tagset_busy_iter(&shost->tag_set, scsi_host_check_in_flight,
			&in_flight);
return in_flight.cnt + atomic_read(&shost->host_busy);

The atomic read is basically free, once we get rid of the dirty of that
variable on each IO.

-- 
Jens Axboe
