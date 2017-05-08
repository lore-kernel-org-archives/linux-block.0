Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34608 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754890AbdEHPCx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 May 2017 11:02:53 -0400
Received: by mail-wr0-f177.google.com with SMTP id l9so46593597wre.1
        for <linux-block@vger.kernel.org>; Mon, 08 May 2017 08:02:53 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <375D00C3-8B76-40FA-BB81-69829270BF5A@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F5BDE69A-5D59-4062-BCF8-6055319C05CF";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Large latency on blk_queue_enter
Date: Mon, 8 May 2017 17:02:49 +0200
In-Reply-To: <a088cc3d-7d85-98bf-e7a4-93368cadd238@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
To: Jens Axboe <axboe@fb.com>
References: <1656B440-3ECA-4F2B-B95C-418CF0F347E9@lightnvm.io>
 <20170508122738.GC5696@ming.t460p>
 <76E35BA3-FEC9-46D6-B36F-554F464FA9ED@lightnvm.io>
 <bbe256c2-f9ff-e594-45c9-7f9ac233ee7a@fb.com>
 <E169E488-53EC-468A-9221-DF11F0944298@lightnvm.io>
 <661d4b67-cf0c-a703-331b-ce24d75e782d@fb.com>
 <C6ED0F6F-EEC2-4F2A-A498-34B0882BA924@lightnvm.io>
 <a088cc3d-7d85-98bf-e7a4-93368cadd238@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_F5BDE69A-5D59-4062-BCF8-6055319C05CF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 8 May 2017, at 16.52, Jens Axboe <axboe@fb.com> wrote:
>=20
> On 05/08/2017 08:46 AM, Javier Gonz=C3=A1lez wrote:
>>> On 8 May 2017, at 16.23, Jens Axboe <axboe@fb.com> wrote:
>>>=20
>>> On 05/08/2017 08:20 AM, Javier Gonz=C3=A1lez wrote:
>>>>> On 8 May 2017, at 16.13, Jens Axboe <axboe@fb.com> wrote:
>>>>>=20
>>>>> On 05/08/2017 07:44 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>> On 8 May 2017, at 14.27, Ming Lei <ming.lei@redhat.com> wrote:
>>>>>>>=20
>>>>>>> On Mon, May 08, 2017 at 01:54:58PM +0200, Javier Gonz=C3=A1lez =
wrote:
>>>>>>>> Hi,
>>>>>>>>=20
>>>>>>>> I find an unusual added latency(~20-30ms) on blk_queue_enter =
when
>>>>>>>> allocating a request directly from the NVMe driver through
>>>>>>>> nvme_alloc_request. I could use some help confirming that this =
is a bug
>>>>>>>> and not an expected side effect due to something else.
>>>>>>>>=20
>>>>>>>> I can reproduce this latency consistently on LightNVM when =
mixing I/O
>>>>>>>> from pblk and I/O sent through an ioctl using liblightnvm, but =
I don't
>>>>>>>> see anything on the LightNVM side that could impact the request
>>>>>>>> allocation.
>>>>>>>>=20
>>>>>>>> When I have a 100% read workload sent from pblk, the max. =
latency is
>>>>>>>> constant throughout several runs at ~80us (which is normal for =
the media
>>>>>>>> we are using at bs=3D4k, qd=3D1). All pblk I/Os reach the =
nvme_nvm_submit_io
>>>>>>>> function on lightnvm.c., which uses nvme_alloc_request. When we =
send a
>>>>>>>> command from user space through an ioctl, then the max latency =
goes up
>>>>>>>> to ~20-30ms. This happens independently from the actual command
>>>>>>>> (IN/OUT). I tracked down the added latency down to the call
>>>>>>>> percpu_ref_tryget_live in blk_queue_enter. Seems that the queue
>>>>>>>> reference counter is not released as it should through =
blk_queue_exit in
>>>>>>>> blk_mq_alloc_request. For reference, all ioctl I/Os reach the
>>>>>>>> nvme_nvm_submit_user_cmd on lightnvm.c
>>>>>>>>=20
>>>>>>>> Do you have any idea about why this might happen? I can dig =
more into
>>>>>>>> it, but first I wanted to make sure that I am not missing any =
obvious
>>>>>>>> assumption, which would explain the reference counter to be =
held for a
>>>>>>>> longer time.
>>>>>>>=20
>>>>>>> You need to check if the .q_usage_counter is working at atomic =
mode.
>>>>>>> This counter is initialized as atomic mode, and finally switchs =
to
>>>>>>> percpu mode via percpu_ref_switch_to_percpu() in =
blk_register_queue().
>>>>>>=20
>>>>>> Thanks for commenting Ming.
>>>>>>=20
>>>>>> The .q_usage_counter is not working on atomic mode. The queue is
>>>>>> initialized normally through blk_register_queue() and the counter =
is
>>>>>> switched to percpu mode, as you mentioned. As I understand it, =
this is
>>>>>> how it should be, right?
>>>>>=20
>>>>> That is how it should be, yes. You're not running with any heavy
>>>>> debugging options, like lockdep or anything like that?
>>>>=20
>>>> No lockdep, KASAN, kmemleak or any of the other usual suspects.
>>>>=20
>>>> What's interesting is that it only happens when one of the I/Os =
comes
>>>> from user space through the ioctl. If I have several pblk instances =
on
>>>> the same device (which would end up allocating a new request in
>>>> parallel, potentially on the same core), the latency spike does not
>>>> trigger.
>>>>=20
>>>> I also tried to bind the read thread and the liblightnvm thread =
issuing
>>>> the ioctl to different cores, but it does not help...
>>>=20
>>> How do I reproduce this? Off the top of my head, and looking at the =
code,
>>> I have no idea what is going on here.
>>=20
>> Using LightNVM and liblightnvm [1] you can reproduce it by:
>>=20
>> 1. Instantiate a pblk instance on the first channel (luns 0 - 7):
>>        sudo nvme lnvm create -d nvme0n1 -n test0 -t pblk -b 0 -e 7 -f
>> 2. Write 5GB to the test0 block device with a normal fio script
>> 3. Read 5GB to verify that latencies are good (max. ~80-90us at =
bs=3D4k, qd=3D1)
>> 4. Re-run 3. and in parallel send a command through liblightnvm to a
>> different channel. A simple command is an erase (erase block 900 on
>> channel 2, lun 0):
>> 	sudo nvm_vblk line_erase /dev/nvme0n1 2 2 0 0 900
>>=20
>> After 4. you should see a ~25-30ms latency on the read workload.
>>=20
>> I tried to reproduce the ioctl in a more generic way to reach
>> __nvme_submit_user_cmd(), but SPDK steals the whole device. Also, =
qemu
>> is not reliable for this kind of performance testing.
>>=20
>> If you have a suggestion on how I can mix an ioctl with normal block =
I/O
>> read on a standard NVMe device, I'm happy to try it and see if I can
>> reproduce the issue.
>=20
> Just to rule out this being any hardware related delays in processing
> IO:
>=20
> 1) Does it reproduce with a simpler command, anything close to a no-op
>   that you can test?

Yes. I tried with a 4KB read and with a fake command I drop right after
allocation.

> 2) What did you use to time the stall being blk_queue_enter()?
>=20

I have some debug code measuring time with ktime_get() in different
places in the stack, and among other places, around blk_queue_enter(). I
use them then to measure max latency and expose it through sysfs. I can
see that the latency peak is recorded in the probe before
blk_queue_enter() and not in the one after.

I also did an experiment, where the normal I/O path allocates the
request with BLK_MQ_REQ_NOWAIT. When running the experiment above, the
read test fails since we reach:
	if (nowait)
	  return -EBUSY;

in blk_queue_enter.

Javier

--Apple-Mail=_F5BDE69A-5D59-4062-BCF8-6055319C05CF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZEIiaAAoJEGMfBTt1mRjKJXEQAMsFrATI8LoaJrj+S8vzdVN6
AyVfySM3h+0Lj9Bh4sDhs0N3NdEeUWoRWeOmPFMaTSbdekMWf4RpU5wNStAftLpX
QWjo0LRmfQQtbB1L1cF0FXKYdRPOvxpcbZu6N9rnrRdpKff4xzVbignpS3sSdaWs
Fr9pL9B8G+iwuNN2FSLa3v7pQTPEzWDNyxAq7s2J0rcTZ6D1dMaXunmIxS8EB0Xz
Y7HeM3mrBDoko3R9ik/T+KrHszvX4svB7gnsacg8NTaQ6F7m22p7QSt/MJrIXnPV
a6J1oLGLU2hpW2ZdI5ckMzC5Z8g5On1+RJDrxKW6KCez1Ita0MSMYGYWEntwKZc2
8uR9lxED5UCOK9SBzgWdJp+WeVNVqU0W8C1v84+CVDJl8qlOxQeXAbX7LB9tk5hf
LNz8URKM2d7nCNlaUxIEo9faiUWMHGZRs4f6dtUguK9uMUiv8t20abvA20vKP41J
/yo2aEAsM+lSevVot8Zit/rIdeSOo5QRHw79NBRKvvSBuzICrnHYhSjfrucxtlxO
t99U8sryKCNwoWD0YwkCoA3Rbv2hILgzfFGEtmhGF873+eFFlNw1lCi/3/4aVrpB
xwLT1yXnWwV+grO28anCCR3DzFU4auobsC4LAJjGh0Hmp2g9taFzDyFKsirtqpqb
ikeWWeDEowZgZQloNIaa
=nQS7
-----END PGP SIGNATURE-----

--Apple-Mail=_F5BDE69A-5D59-4062-BCF8-6055319C05CF--
