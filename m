Return-Path: <dedekind1@gmail.com>
Message-ID: <1521470529.4592.51.camel@gmail.com>
Subject: Re: [PATCH V5 1/5] scsi: hpsa: fix selection of reply queue
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: "hch@lst.de" <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "snitzer@redhat.com" <snitzer@redhat.com>, "hare@suse.de" <hare@suse.de>,
 "mroos@linux.ee" <mroos@linux.ee>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>,  "don.brace@microsemi.com"
 <don.brace@microsemi.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "loberman@redhat.com" <loberman@redhat.com>, "kashyap.desai@broadcom.com"
 <kashyap.desai@broadcom.com>,  Jens Axboe <axboe@kernel.dk>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>, "ming.lei@redhat.com"
 <ming.lei@redhat.com>
Date: Mon, 19 Mar 2018 16:42:09 +0200
In-Reply-To: <cf7fd125-f809-cd13-ef56-280acba80f00@kernel.dk>
References: <20180313094243.8710-1-ming.lei@redhat.com>
	 <20180313094243.8710-2-ming.lei@redhat.com>
	 <1521460114.4592.29.camel@intel.com>
	 <cf7fd125-f809-cd13-ef56-280acba80f00@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-03-19 at 08:31 -0600, Jens Axboe wrote:
> I'm assuming that Martin will eventually queue this up. But probably
> for 4.17, then we can always flag it for a backport to stable once
> it's been thoroughly tested.

Jens, thanks for reply.

I wonder if folks agree that in this case we should revert 

84676c1f21e8 genirq/affinity: assign vectors to all possible CPUs

for v4.16.

If this was a minor niche use-case regression the -stable scenario
would probably be OK. But the patch seem to miss the fact that kernel's
"possible CPUs" notion may be way off and side effects are bad.

Christoph, Thomas, what do you think?

Thanks,
Artem.
