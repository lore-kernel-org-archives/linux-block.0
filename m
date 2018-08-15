Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:60826 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729437AbeHOUs1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Aug 2018 16:48:27 -0400
From: Felipe Franciosi <felipe@nutanix.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Ming Lei <ming.lei@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Greg A. Smith" <gasmith@nutanix.com>,
        Peter Turschmid <peter.turschm@nutanix.com>
Subject: Re: Fix for 84676c1f (b5b6e8c8) missing in 4.14.y
Date: Wed, 15 Aug 2018 17:28:46 +0000
Message-ID: <AE96295F-BE62-4F27-AE15-84E11AD979B0@nutanix.com>
References: <53EA26B1-86F8-40BF-A128-33137217A3F9@nutanix.com>
 <20180810023128.GB2816@ming.t460p> <20180810101541.GB31002@kroah.com>
 <A18BBE4D-6470-4B57-92EB-B3129CFD3583@nutanix.com>
 <20180810183228.GB18728@kroah.com>
 <6A8BCAB8-5887-4CDE-8BF1-1D371C090D7E@nutanix.com>
 <6A42DA82-A572-41D1-B884-64F6458543BC@nutanix.com>
 <20180815152812.GA524@kroah.com>
In-Reply-To: <20180815152812.GA524@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 15 Aug 2018, at 16:28, Greg Kroah-Hartman <gregkh@linuxfoundation.org>=
 wrote:
>=20
> On Wed, Aug 15, 2018 at 02:30:23PM +0000, Felipe Franciosi wrote:
>>=20
>>> On 10 Aug 2018, at 20:43, Felipe Franciosi <felipe@nutanix.com> wrote:
>>>=20
>>>=20
>>>> On 10 Aug 2018, at 11:32, Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg> wrote:
>>>>=20
>>>> On Fri, Aug 10, 2018 at 05:10:52PM +0000, Felipe Franciosi wrote:
>>>>>=20
>>>>>> On 10 Aug 2018, at 03:15, Greg Kroah-Hartman <gregkh@linuxfoundation=
.org> wrote:
>>>>>>=20
>>>>>> On Fri, Aug 10, 2018 at 10:31:29AM +0800, Ming Lei wrote:
>>>>>>> On Fri, Aug 10, 2018 at 02:09:01AM +0000, Felipe Franciosi wrote:
>>>>>>>> Hi Ming (and all),
>>>>>>>>=20
>>>>>>>> Your series "scsi: virtio_scsi: fix IO hang caused by irq vector a=
utomatic affinity" which forces virtio-scsi to use blk-mq fixes an issue in=
troduced by 84676c1f. We noticed that this bug also exists in 4.14.y (as ef=
86f3a72adb), but your series was not backported to that stable branch.
>>>>>>>>=20
>>>>>>>> Are there any plans to do that? At least CoreOS is using 4.14 and =
showing issues on AHV (which provides an mq virtio-scsi controller).
>>>>>>>>=20
>>>>>>>=20
>>>>>>> Hi Felipe,
>>>>>>>=20
>>>>>>> Looks the following 4 patches should have been marked as stable, so=
rry
>>>>>>> for missing that.
>>>>>>>=20
>>>>>>> b5b6e8c8d3b4 scsi: virtio_scsi: fix IO hang caused by automatic irq=
 vector affinity
>>>>>>> 2f31115e940c scsi: core: introduce force_blk_mq
>>>>>>> adbe552349f2 scsi: megaraid_sas: fix selection of reply queue
>>>>>>> 8b834bff1b73 scsi: hpsa: fix selection of reply queue
>>>>>>>=20
>>>>>>> Usually this backporting is done by our stable guys, so I will CC s=
table
>>>>>>> and leave them handle it, but I am happy to provide any help for
>>>>>>> addressing conflicts or sort of thing.
>>>>>>=20
>>>>>> As the above patches do not apply "cleanly" to the 4.14.y tree at al=
l,
>>>>>> can you please provide a set of backported patches that I can apply?
>>>>>=20
>>>>> Actually, adbe552349f2 is already present in 4.14.y. It is commit e58=
114824fa6.
>>>>>=20
>>>>> If you skip that, all the other three apply cleanly.
>>>>=20
>>>> Ok, that works, but there's another bug report of aacraid having
>>>> problems.  Any ideas?
>>>=20
>>> Heya, I actually have no idea which bug you are talking about. TBH I'm =
only experiencing the bug fixed by b5b6e8c8d3b4, which only requires 2f3111=
5e940c. (I tested a 4.14 with both commits which resolves the bug.)
>>>=20
>>> I doubt any of that would have any interference with aacraid and should=
 be safe backports in that respect.
>>=20
>> Hi Greg, sorry to bother but I didn't hear anything back about this.
>> Are you picking up 2f31115e940c and b5b6e8c8d3b4 for 4.14.y or waiting
>> for some other action?
>=20
> They are in 4.14.63-rc1 right now, did you not see them?

Hi Greg, terribly sorry. I fetched the wrong remote and didn't see them bef=
ore. Double checked now and it's there. :)

Thanks!
F.

>=20
> thanks,
>=20
> greg k-h
