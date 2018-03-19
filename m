Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V5 1/5] scsi: hpsa: fix selection of reply queue
To: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "snitzer@redhat.com" <snitzer@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "hare@suse.de" <hare@suse.de>, "mroos@linux.ee" <mroos@linux.ee>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "don.brace@microsemi.com" <don.brace@microsemi.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "loberman@redhat.com" <loberman@redhat.com>,
 "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>
References: <20180313094243.8710-1-ming.lei@redhat.com>
 <20180313094243.8710-2-ming.lei@redhat.com>
 <1521460114.4592.29.camel@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cf7fd125-f809-cd13-ef56-280acba80f00@kernel.dk>
Date: Mon, 19 Mar 2018 08:31:48 -0600
MIME-Version: 1.0
In-Reply-To: <1521460114.4592.29.camel@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/19/18 5:48 AM, Bityutskiy, Artem wrote:
> On Tue, 2018-03-13 at 17:42 +0800, Ming Lei wrote:
>> From 84676c1f21 (genirq/affinity: assign vectors to all possible CPUs),
>> one msix vector can be created without any online CPU mapped, then one
>> command's completion may not be notified.
> 
> Hello Martin, James,
> 
> we have this patch-set and it fixes megaraid regression in v4.16. Do
> you plan to mege it to v4.16-rcX? I am worried - there seem to be no
> sight that this is going to me merged. They are not in the linux-next.

I'm assuming that Martin will eventually queue this up. But probably
for 4.17, then we can always flag it for a backport to stable once
it's been thoroughly tested.

-- 
Jens Axboe
