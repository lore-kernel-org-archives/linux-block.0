Return-Path: <linux-scsi-owner@vger.kernel.org>
To: "Bityutskiy\, Artem" <artem.bityutskiy@intel.com>
Cc: "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley\@HansenPartnership.com"
        <James.Bottomley@HansenPartnership.com>,
        "axboe\@fb.com" <axboe@fb.com>,
        "ming.lei\@redhat.com" <ming.lei@redhat.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer\@redhat.com" <snitzer@redhat.com>,
        "hch\@lst.de" <hch@lst.de>, "hare\@suse.de" <hare@suse.de>,
        "mroos\@linux.ee" <mroos@linux.ee>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "don.brace\@microsemi.com" <don.brace@microsemi.com>,
        "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "loberman\@redhat.com" <loberman@redhat.com>,
        "kashyap.desai\@broadcom.com" <kashyap.desai@broadcom.com>
Subject: Re: [PATCH V5 1/5] scsi: hpsa: fix selection of reply queue
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180313094243.8710-1-ming.lei@redhat.com>
        <20180313094243.8710-2-ming.lei@redhat.com>
        <1521460114.4592.29.camel@intel.com>
Date: Mon, 19 Mar 2018 23:16:36 -0400
In-Reply-To: <1521460114.4592.29.camel@intel.com> (Artem Bityutskiy's message
        of "Mon, 19 Mar 2018 11:48:35 +0000")
Message-ID: <yq1in9r1lnv.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


Artem,

> we have this patch-set and it fixes megaraid regression in v4.16. Do
> you plan to mege it to v4.16-rcX? I am worried - there seem to be no
> sight that this is going to me merged. They are not in the linux-next.

I merged them into scsi-fixes last week.

It happens push a combined fixes+queue to linux-next to get more zeroday
coverage. However, most of the time linux-next is one 4.x+1 material
only.

-- 
Martin K. Petersen	Oracle Linux Engineering
