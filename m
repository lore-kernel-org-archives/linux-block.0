Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <A781A1A3-58FA-49DF-9197-35FBD05E7476@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6B030D3D-F25D-4E13-A4B9-D68F9030134A";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Large latency on blk_queue_enter
Date: Mon, 8 May 2017 17:22:47 +0200
In-Reply-To: <991bbc1d-1849-94d9-5787-69a630e7e10d@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 linux-block@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
To: Jens Axboe <axboe@kernel.dk>
References: <1656B440-3ECA-4F2B-B95C-418CF0F347E9@lightnvm.io>
 <20170508122738.GC5696@ming.t460p>
 <76E35BA3-FEC9-46D6-B36F-554F464FA9ED@lightnvm.io>
 <bbe256c2-f9ff-e594-45c9-7f9ac233ee7a@fb.com>
 <E169E488-53EC-468A-9221-DF11F0944298@lightnvm.io>
 <661d4b67-cf0c-a703-331b-ce24d75e782d@fb.com>
 <C6ED0F6F-EEC2-4F2A-A498-34B0882BA924@lightnvm.io>
 <a088cc3d-7d85-98bf-e7a4-93368cadd238@fb.com>
 <375D00C3-8B76-40FA-BB81-69829270BF5A@lightnvm.io>
 <576f9601-b0de-c636-8195-07e12fe99734@fb.com>
 <991bbc1d-1849-94d9-5787-69a630e7e10d@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_6B030D3D-F25D-4E13-A4B9-D68F9030134A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


Javier

> On 8 May 2017, at 17.14, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 05/08/2017 09:08 AM, Jens Axboe wrote:
>> On 05/08/2017 09:02 AM, Javier Gonz=C3=A1lez wrote:
>>>> On 8 May 2017, at 16.52, Jens Axboe <axboe@fb.com> wrote:
>>>>=20
>>>> On 05/08/2017 08:46 AM, Javier Gonz=C3=A1lez wrote:
>>>>>> On 8 May 2017, at 16.23, Jens Axboe <axboe@fb.com> wrote:
>>>>>>=20
>>>>>> On 05/08/2017 08:20 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>> On 8 May 2017, at 16.13, Jens Axboe <axboe@fb.com> wrote:
>>>>>>>>=20
>>>>>>>> On 05/08/2017 07:44 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>>>> On 8 May 2017, at 14.27, Ming Lei <ming.lei@redhat.com> =
wrote:
>>>>>>>>>>=20
>>>>>>>>>> On Mon, May 08, 2017 at 01:54:58PM +0200, Javier Gonz=C3=A1lez =
wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>=20
>>>>>>>>>>> I find an unusual added latency(~20-30ms) on blk_queue_enter =
when
>>>>>>>>>>> allocating a request directly from the NVMe driver through
>>>>>>>>>>> nvme_alloc_request. I could use some help confirming that =
this is a bug
>>>>>>>>>>> and not an expected side effect due to something else.
>>>>>>>>>>>=20
>>>>>>>>>>> I can reproduce this latency consistently on LightNVM when =
mixing I/O
>>>>>>>>>>> from pblk and I/O sent through an ioctl using liblightnvm, =
but I don't
>>>>>>>>>>> see anything on the LightNVM side that could impact the =
request
>>>>>>>>>>> allocation.
>>>>>>>>>>>=20
>>>>>>>>>>> When I have a 100% read workload sent from pblk, the max. =
latency is
>>>>>>>>>>> constant throughout several runs at ~80us (which is normal =
for the media
>>>>>>>>>>> we are using at bs=3D4k, qd=3D1). All pblk I/Os reach the =
nvme_nvm_submit_io
>>>>>>>>>>> function on lightnvm.c., which uses nvme_alloc_request. When =
we send a
>>>>>>>>>>> command from user space through an ioctl, then the max =
latency goes up
>>>>>>>>>>> to ~20-30ms. This happens independently from the actual =
command
>>>>>>>>>>> (IN/OUT). I tracked down the added latency down to the call
>>>>>>>>>>> percpu_ref_tryget_live in blk_queue_enter. Seems that the =
queue
>>>>>>>>>>> reference counter is not released as it should through =
blk_queue_exit in
>>>>>>>>>>> blk_mq_alloc_request. For reference, all ioctl I/Os reach =
the
>>>>>>>>>>> nvme_nvm_submit_user_cmd on lightnvm.c
>>>>>>>>>>>=20
>>>>>>>>>>> Do you have any idea about why this might happen? I can dig =
more into
>>>>>>>>>>> it, but first I wanted to make sure that I am not missing =
any obvious
>>>>>>>>>>> assumption, which would explain the reference counter to be =
held for a
>>>>>>>>>>> longer time.
>>>>>>>>>>=20
>>>>>>>>>> You need to check if the .q_usage_counter is working at =
atomic mode.
>>>>>>>>>> This counter is initialized as atomic mode, and finally =
switchs to
>>>>>>>>>> percpu mode via percpu_ref_switch_to_percpu() in =
blk_register_queue().
>>>>>>>>>=20
>>>>>>>>> Thanks for commenting Ming.
>>>>>>>>>=20
>>>>>>>>> The .q_usage_counter is not working on atomic mode. The queue =
is
>>>>>>>>> initialized normally through blk_register_queue() and the =
counter is
>>>>>>>>> switched to percpu mode, as you mentioned. As I understand it, =
this is
>>>>>>>>> how it should be, right?
>>>>>>>>=20
>>>>>>>> That is how it should be, yes. You're not running with any =
heavy
>>>>>>>> debugging options, like lockdep or anything like that?
>>>>>>>=20
>>>>>>> No lockdep, KASAN, kmemleak or any of the other usual suspects.
>>>>>>>=20
>>>>>>> What's interesting is that it only happens when one of the I/Os =
comes
>>>>>>> from user space through the ioctl. If I have several pblk =
instances on
>>>>>>> the same device (which would end up allocating a new request in
>>>>>>> parallel, potentially on the same core), the latency spike does =
not
>>>>>>> trigger.
>>>>>>>=20
>>>>>>> I also tried to bind the read thread and the liblightnvm thread =
issuing
>>>>>>> the ioctl to different cores, but it does not help...
>>>>>>=20
>>>>>> How do I reproduce this? Off the top of my head, and looking at =
the code,
>>>>>> I have no idea what is going on here.
>>>>>=20
>>>>> Using LightNVM and liblightnvm [1] you can reproduce it by:
>>>>>=20
>>>>> 1. Instantiate a pblk instance on the first channel (luns 0 - 7):
>>>>>       sudo nvme lnvm create -d nvme0n1 -n test0 -t pblk -b 0 -e 7 =
-f
>>>>> 2. Write 5GB to the test0 block device with a normal fio script
>>>>> 3. Read 5GB to verify that latencies are good (max. ~80-90us at =
bs=3D4k, qd=3D1)
>>>>> 4. Re-run 3. and in parallel send a command through liblightnvm to =
a
>>>>> different channel. A simple command is an erase (erase block 900 =
on
>>>>> channel 2, lun 0):
>>>>> 	sudo nvm_vblk line_erase /dev/nvme0n1 2 2 0 0 900
>>>>>=20
>>>>> After 4. you should see a ~25-30ms latency on the read workload.
>>>>>=20
>>>>> I tried to reproduce the ioctl in a more generic way to reach
>>>>> __nvme_submit_user_cmd(), but SPDK steals the whole device. Also, =
qemu
>>>>> is not reliable for this kind of performance testing.
>>>>>=20
>>>>> If you have a suggestion on how I can mix an ioctl with normal =
block I/O
>>>>> read on a standard NVMe device, I'm happy to try it and see if I =
can
>>>>> reproduce the issue.
>>>>=20
>>>> Just to rule out this being any hardware related delays in =
processing
>>>> IO:
>>>>=20
>>>> 1) Does it reproduce with a simpler command, anything close to a =
no-op
>>>>  that you can test?
>>>=20
>>> Yes. I tried with a 4KB read and with a fake command I drop right =
after
>>> allocation.
>>>=20
>>>> 2) What did you use to time the stall being blk_queue_enter()?
>>>=20
>>> I have some debug code measuring time with ktime_get() in different
>>> places in the stack, and among other places, around =
blk_queue_enter(). I
>>> use them then to measure max latency and expose it through sysfs. I =
can
>>> see that the latency peak is recorded in the probe before
>>> blk_queue_enter() and not in the one after.
>>>=20
>>> I also did an experiment, where the normal I/O path allocates the
>>> request with BLK_MQ_REQ_NOWAIT. When running the experiment above, =
the
>>> read test fails since we reach:
>>> 	if (nowait)
>>> 	  return -EBUSY;
>>>=20
>>> in blk_queue_enter.
>>=20
>> OK, that's starting to make more sense, that indicates that there is =
indeed
>> something wrong with the refs. Does the below help?
>=20
> No, that can't be right, it does look balanced to begin with.
> blk_mq_alloc_request() always grabs a queue ref, and always drops it. =
If
> we return with a request succesfully allocated, then we have an extra
> ref on it, which is dropped when it is later freed.

I agree, it seems more like a reference is put too late. I looked into
into the places where the reference is put, but it all seems normal. In
any case, I run it (just to see), and it did not help.

> Something smells fishy, I'll dig a bit.

Thanks! I continue looking into it myself; let me know if I can help
with something more specific.

Javier

--Apple-Mail=_6B030D3D-F25D-4E13-A4B9-D68F9030134A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZEI1IAAoJEGMfBTt1mRjKVcMP/i3mo47yq6DEZllIbMBei5LX
wkwCMfjGIil3FBmjvaBsQp7g63y5IovpOTH40gjkobfzq+7q2wadlwCC2T3i8E3z
6Lx2YzXwpRFUeR600Ja+KWrq1nBtraW63Z4HqOb30HxFQdINYVwuSanzod92EShB
lOD/kTw+ZLXfPB/ZqQoxkM4rpQ8ShH0JPRlizhofFvae/Q1KVMZsa5nMEFRG9LlM
aNtsbetHVPWKj2S7vOUAKz5jXJ5qkXH+QcHQGSVABiaftPDfP7FpFwNOztC1nbO6
zaj24M69glOD95IB2477JcEds7lN3gZFl1EzwjYygFDmT0P3XilxHkjiOvaQcbAF
p3eNQ786Xaf+v5jXv8j3DNwEoH15SJKsJgn5pdexyLiuRLZwbVUuI8Npd3x8a+Q1
B1PKPsWlMpU8zoj6MQnpp30/F9mcKvplvn0sPO5F/1SzCKQepUZxQVKez0jxZk0A
hwlh22oXfMnrsZMliHk0+8BXm8XrXzXMG+8FVeyfQfl4T/gRaVp6pl13ZbmrUtDl
1Dw8fkyhGZUDFg7ftIEx/3bsvsBHeqG2ysNrAXzwOxLq5RgGdyD7X4qnF8exE+bS
EBnPIjejacIbx9VVMUwhCqzBVFsvW70Xj78kUN0tcnj3OdKxOMZbhcrAgruCMbLA
o/nf9DcsEhUlzz71EFSd
=RRya
-----END PGP SIGNATURE-----

--Apple-Mail=_6B030D3D-F25D-4E13-A4B9-D68F9030134A--
