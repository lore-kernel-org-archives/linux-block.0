Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:42458 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbeHJWP0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 18:15:26 -0400
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
Date: Fri, 10 Aug 2018 19:43:48 +0000
Message-ID: <6A8BCAB8-5887-4CDE-8BF1-1D371C090D7E@nutanix.com>
References: <53EA26B1-86F8-40BF-A128-33137217A3F9@nutanix.com>
 <20180810023128.GB2816@ming.t460p> <20180810101541.GB31002@kroah.com>
 <A18BBE4D-6470-4B57-92EB-B3129CFD3583@nutanix.com>
 <20180810183228.GB18728@kroah.com>
In-Reply-To: <20180810183228.GB18728@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 10 Aug 2018, at 11:32, Greg Kroah-Hartman <gregkh@linuxfoundation.org>=
 wrote:
>=20
> On Fri, Aug 10, 2018 at 05:10:52PM +0000, Felipe Franciosi wrote:
>>=20
>>> On 10 Aug 2018, at 03:15, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
>>>=20
>>> On Fri, Aug 10, 2018 at 10:31:29AM +0800, Ming Lei wrote:
>>>> On Fri, Aug 10, 2018 at 02:09:01AM +0000, Felipe Franciosi wrote:
>>>>> Hi Ming (and all),
>>>>>=20
>>>>> Your series "scsi: virtio_scsi: fix IO hang caused by irq vector auto=
matic affinity" which forces virtio-scsi to use blk-mq fixes an issue intro=
duced by 84676c1f. We noticed that this bug also exists in 4.14.y (as ef86f=
3a72adb), but your series was not backported to that stable branch.
>>>>>=20
>>>>> Are there any plans to do that? At least CoreOS is using 4.14 and sho=
wing issues on AHV (which provides an mq virtio-scsi controller).
>>>>>=20
>>>>=20
>>>> Hi Felipe,
>>>>=20
>>>> Looks the following 4 patches should have been marked as stable, sorry
>>>> for missing that.
>>>>=20
>>>> b5b6e8c8d3b4 scsi: virtio_scsi: fix IO hang caused by automatic irq ve=
ctor affinity
>>>> 2f31115e940c scsi: core: introduce force_blk_mq
>>>> adbe552349f2 scsi: megaraid_sas: fix selection of reply queue
>>>> 8b834bff1b73 scsi: hpsa: fix selection of reply queue
>>>>=20
>>>> Usually this backporting is done by our stable guys, so I will CC stab=
le
>>>> and leave them handle it, but I am happy to provide any help for
>>>> addressing conflicts or sort of thing.
>>>=20
>>> As the above patches do not apply "cleanly" to the 4.14.y tree at all,
>>> can you please provide a set of backported patches that I can apply?
>>=20
>> Actually, adbe552349f2 is already present in 4.14.y. It is commit e58114=
824fa6.
>>=20
>> If you skip that, all the other three apply cleanly.
>=20
> Ok, that works, but there's another bug report of aacraid having
> problems.  Any ideas?

Heya, I actually have no idea which bug you are talking about. TBH I'm only=
 experiencing the bug fixed by b5b6e8c8d3b4, which only requires 2f31115e94=
0c. (I tested a 4.14 with both commits which resolves the bug.)

I doubt any of that would have any interference with aacraid and should be =
safe backports in that respect.

Thanks,
Felipe

>=20
> greg k-h
