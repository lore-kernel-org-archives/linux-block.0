Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: Time to make dynamically allocated devt the default for scsi
 disks?
To: Dan Williams <dan.j.williams@intel.com>
References: <CAPcyv4jK8W52ss2FhJDa=95B_1q8Szv4AmH0f7p_jzyfEXv0Ag@mail.gmail.com>
 <1471047451.2407.95.camel@HansenPartnership.com>
 <CAPcyv4jqEaBY1atyrjG3G4PYOzaoLvAMfHgK1PD0Si=MRRwAuw@mail.gmail.com>
 <CAPcyv4i=85fCAm1A5Zh2+nYSw7vwXOD=i-B0g4m2eJ+XkEW3tw@mail.gmail.com>
 <1471101800.2397.9.camel@HansenPartnership.com>
 <CAPcyv4gDw49gZBO=Y+K9krgth68OUHcs8urGDNXiZzLNa6kotg@mail.gmail.com>
 <1471110212.2397.39.camel@HansenPartnership.com>
 <CAPcyv4gHq=RraHgcJGx_txk7YJHC8YQ3gCT4CHL0hvzsGpU1wg@mail.gmail.com>
 <1471195252.2355.18.camel@HansenPartnership.com>
 <cf141c9f-2bda-060a-0a7d-86638c2f5818@sandisk.com>
 <CAPcyv4hzda80kqNtyTUHL7_mpoiDzLvQaj5OQL9OxePU3BKjEw@mail.gmail.com>
CC: James Bottomley <James.Bottomley@hansenpartnership.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <d314f49b-36a2-5c83-6096-0ccd0a7012e2@sandisk.com>
Date: Tue, 30 Aug 2016 13:53:55 -0700
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hzda80kqNtyTUHL7_mpoiDzLvQaj5OQL9OxePU3BKjEw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 08/30/2016 01:43 PM, Dan Williams wrote:
> I tried running this, but it seems I'm failing to configure my test
> environment correctly [1], but I'm worried that this "re-parenting the
> scsi-disk" approach, even if the above warning is addressed, may not
> be backwards compatible.  We now have an ordering difference where the
> link to the "block" attribute group is established after the disk's
> KOBJ_ADD event which seems in the same class of problems that Fam
> Zheng's patchset [2] is trying to solve.
>
> Bart, if you can help me get the test case running I can take a look
> at finishing off the disk_devt approach I proposed earlier.
>
> [1]: https://gist.github.com/djbw/1c72526c90d1ea8fe2a05dcfbfc73dda
> [2]: https://lkml.org/lkml/2016/8/17/63

Hello Dan,

Today running the srp-test software is only possible on a system 
equipped with at least one InfiniBand port. Since the soft-RoCE driver 
has been accepted in kernel v4.8 (drivers/infiniband/sw/rxe) it should 
be possible to modify the srp-test software such that it runs on any 
system equipped with at least one Ethernet port. However, that will 
require adding RoCE (RDMA over Ethernet) support to the ib_srp and 
ib_srpt drivers.

Bart.
