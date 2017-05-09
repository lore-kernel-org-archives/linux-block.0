Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <B3E68D58-EAAF-4DDE-BE0E-C60444C971C7@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4CE2B4BE-4149-4EC3-9A9A-EFAF4FEAD0F7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Large latency on blk_queue_enter
Date: Tue, 9 May 2017 13:21:47 +0200
In-Reply-To: <20170509105845.GA24858@ming.t460p>
Cc: Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 linux-block@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
To: Ming Lei <ming.lei@redhat.com>
References: <576f9601-b0de-c636-8195-07e12fe99734@fb.com>
 <991bbc1d-1849-94d9-5787-69a630e7e10d@kernel.dk>
 <A781A1A3-58FA-49DF-9197-35FBD05E7476@lightnvm.io>
 <347b1a1d-de9e-509f-13c2-df0d4c427682@kernel.dk>
 <EAD85BFB-0DB3-44E4-992A-FF789DA1F46C@lightnvm.io>
 <822b8db4-9b98-da1f-2157-12b2af599b82@kernel.dk>
 <98125B90-AA08-49F4-8214-56AC86E4A645@lightnvm.io>
 <7f6e8c4b-504e-b786-da52-776c666e8c73@kernel.dk>
 <9AFF433E-1B77-4800-8B27-8E335F2F5DDE@lightnvm.io>
 <C3E13E05-ECE3-4CEB-ADFD-B8D6A7E6B0D7@lightnvm.io>
 <20170509105845.GA24858@ming.t460p>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_4CE2B4BE-4149-4EC3-9A9A-EFAF4FEAD0F7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 9 May 2017, at 12.58, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Tue, May 09, 2017 at 12:34:42PM +0200, Javier Gonz=C3=A1lez wrote:
>>> On 8 May 2017, at 18.39, Javier Gonz=C3=A1lez <jg@lightnvm.io> =
wrote:
>>>=20
>>>> On 8 May 2017, at 18.06, Jens Axboe <axboe@kernel.dk> wrote:
>>>>=20
>>>> On 05/08/2017 09:49 AM, Javier Gonz=C3=A1lez wrote:
>>>>>> On 8 May 2017, at 17.40, Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>=20
>>>>>> On 05/08/2017 09:38 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>> On 8 May 2017, at 17.25, Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>>=20
>>>>>>>> On 05/08/2017 09:22 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>>> Javier
>>>>>>>>>=20
>>>>>>>>>> On 8 May 2017, at 17.14, Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>>>>=20
>>>>>>>>>> On 05/08/2017 09:08 AM, Jens Axboe wrote:
>>>>>>>>>>> On 05/08/2017 09:02 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>>>>>>> On 8 May 2017, at 16.52, Jens Axboe <axboe@fb.com> wrote:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> On 05/08/2017 08:46 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>>>>>>>>> On 8 May 2017, at 16.23, Jens Axboe <axboe@fb.com> =
wrote:
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> On 05/08/2017 08:20 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>>>>>>>>>>> On 8 May 2017, at 16.13, Jens Axboe <axboe@fb.com> =
wrote:
>>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>> On 05/08/2017 07:44 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>>>>>>>>>>>>> On 8 May 2017, at 14.27, Ming Lei =
<ming.lei@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>>>> On Mon, May 08, 2017 at 01:54:58PM +0200, Javier =
Gonz=C3=A1lez wrote:
>>>>>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>>>>> I find an unusual added latency(~20-30ms) on =
blk_queue_enter when
>>>>>>>>>>>>>>>>>>>> allocating a request directly from the NVMe driver =
through
>>>>>>>>>>>>>>>>>>>> nvme_alloc_request. I could use some help =
confirming that this is a bug
>>>>>>>>>>>>>>>>>>>> and not an expected side effect due to something =
else.
>>>>>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>>>>> I can reproduce this latency consistently on =
LightNVM when mixing I/O
>>>>>>>>>>>>>>>>>>>> from pblk and I/O sent through an ioctl using =
liblightnvm, but I don't
>>>>>>>>>>>>>>>>>>>> see anything on the LightNVM side that could impact =
the request
>>>>>>>>>>>>>>>>>>>> allocation.
>>>>>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>>>>> When I have a 100% read workload sent from pblk, =
the max. latency is
>>>>>>>>>>>>>>>>>>>> constant throughout several runs at ~80us (which is =
normal for the media
>>>>>>>>>>>>>>>>>>>> we are using at bs=3D4k, qd=3D1). All pblk I/Os =
reach the nvme_nvm_submit_io
>>>>>>>>>>>>>>>>>>>> function on lightnvm.c., which uses =
nvme_alloc_request. When we send a
>>>>>>>>>>>>>>>>>>>> command from user space through an ioctl, then the =
max latency goes up
>>>>>>>>>>>>>>>>>>>> to ~20-30ms. This happens independently from the =
actual command
>>>>>>>>>>>>>>>>>>>> (IN/OUT). I tracked down the added latency down to =
the call
>>>>>>>>>>>>>>>>>>>> percpu_ref_tryget_live in blk_queue_enter. Seems =
that the queue
>>>>>>>>>>>>>>>>>>>> reference counter is not released as it should =
through blk_queue_exit in
>>>>>>>>>>>>>>>>>>>> blk_mq_alloc_request. For reference, all ioctl I/Os =
reach the
>>>>>>>>>>>>>>>>>>>> nvme_nvm_submit_user_cmd on lightnvm.c
>>>>>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>>>>> Do you have any idea about why this might happen? I =
can dig more into
>>>>>>>>>>>>>>>>>>>> it, but first I wanted to make sure that I am not =
missing any obvious
>>>>>>>>>>>>>>>>>>>> assumption, which would explain the reference =
counter to be held for a
>>>>>>>>>>>>>>>>>>>> longer time.
>>>>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>>>> You need to check if the .q_usage_counter is working =
at atomic mode.
>>>>>>>>>>>>>>>>>>> This counter is initialized as atomic mode, and =
finally switchs to
>>>>>>>>>>>>>>>>>>> percpu mode via percpu_ref_switch_to_percpu() in =
blk_register_queue().
>>>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>>> Thanks for commenting Ming.
>>>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>>> The .q_usage_counter is not working on atomic mode. =
The queue is
>>>>>>>>>>>>>>>>>> initialized normally through blk_register_queue() and =
the counter is
>>>>>>>>>>>>>>>>>> switched to percpu mode, as you mentioned. As I =
understand it, this is
>>>>>>>>>>>>>>>>>> how it should be, right?
>>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>> That is how it should be, yes. You're not running with =
any heavy
>>>>>>>>>>>>>>>>> debugging options, like lockdep or anything like that?
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> No lockdep, KASAN, kmemleak or any of the other usual =
suspects.
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> What's interesting is that it only happens when one of =
the I/Os comes
>>>>>>>>>>>>>>>> from user space through the ioctl. If I have several =
pblk instances on
>>>>>>>>>>>>>>>> the same device (which would end up allocating a new =
request in
>>>>>>>>>>>>>>>> parallel, potentially on the same core), the latency =
spike does not
>>>>>>>>>>>>>>>> trigger.
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> I also tried to bind the read thread and the =
liblightnvm thread issuing
>>>>>>>>>>>>>>>> the ioctl to different cores, but it does not help...
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> How do I reproduce this? Off the top of my head, and =
looking at the code,
>>>>>>>>>>>>>>> I have no idea what is going on here.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Using LightNVM and liblightnvm [1] you can reproduce it =
by:
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> 1. Instantiate a pblk instance on the first channel (luns =
0 - 7):
>>>>>>>>>>>>>>  sudo nvme lnvm create -d nvme0n1 -n test0 -t pblk -b 0 =
-e 7 -f
>>>>>>>>>>>>>> 2. Write 5GB to the test0 block device with a normal fio =
script
>>>>>>>>>>>>>> 3. Read 5GB to verify that latencies are good (max. =
~80-90us at bs=3D4k, qd=3D1)
>>>>>>>>>>>>>> 4. Re-run 3. and in parallel send a command through =
liblightnvm to a
>>>>>>>>>>>>>> different channel. A simple command is an erase (erase =
block 900 on
>>>>>>>>>>>>>> channel 2, lun 0):
>>>>>>>>>>>>>> 	sudo nvm_vblk line_erase /dev/nvme0n1 2 2 0 0 900
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> After 4. you should see a ~25-30ms latency on the read =
workload.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> I tried to reproduce the ioctl in a more generic way to =
reach
>>>>>>>>>>>>>> __nvme_submit_user_cmd(), but SPDK steals the whole =
device. Also, qemu
>>>>>>>>>>>>>> is not reliable for this kind of performance testing.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> If you have a suggestion on how I can mix an ioctl with =
normal block I/O
>>>>>>>>>>>>>> read on a standard NVMe device, I'm happy to try it and =
see if I can
>>>>>>>>>>>>>> reproduce the issue.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Just to rule out this being any hardware related delays in =
processing
>>>>>>>>>>>>> IO:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> 1) Does it reproduce with a simpler command, anything =
close to a no-op
>>>>>>>>>>>>> that you can test?
>>>>>>>>>>>>=20
>>>>>>>>>>>> Yes. I tried with a 4KB read and with a fake command I drop =
right after
>>>>>>>>>>>> allocation.
>>>>>>>>>>>>=20
>>>>>>>>>>>>> 2) What did you use to time the stall being =
blk_queue_enter()?
>>>>>>>>>>>>=20
>>>>>>>>>>>> I have some debug code measuring time with ktime_get() in =
different
>>>>>>>>>>>> places in the stack, and among other places, around =
blk_queue_enter(). I
>>>>>>>>>>>> use them then to measure max latency and expose it through =
sysfs. I can
>>>>>>>>>>>> see that the latency peak is recorded in the probe before
>>>>>>>>>>>> blk_queue_enter() and not in the one after.
>>>>>>>>>>>>=20
>>>>>>>>>>>> I also did an experiment, where the normal I/O path =
allocates the
>>>>>>>>>>>> request with BLK_MQ_REQ_NOWAIT. When running the experiment =
above, the
>>>>>>>>>>>> read test fails since we reach:
>>>>>>>>>>>> 	if (nowait)
>>>>>>>>>>>> 	  return -EBUSY;
>>>>>>>>>>>>=20
>>>>>>>>>>>> in blk_queue_enter.
>>>>>>>>>>>=20
>>>>>>>>>>> OK, that's starting to make more sense, that indicates that =
there is indeed
>>>>>>>>>>> something wrong with the refs. Does the below help?
>>>>>>>>>>=20
>>>>>>>>>> No, that can't be right, it does look balanced to begin with.
>>>>>>>>>> blk_mq_alloc_request() always grabs a queue ref, and always =
drops it. If
>>>>>>>>>> we return with a request succesfully allocated, then we have =
an extra
>>>>>>>>>> ref on it, which is dropped when it is later freed.
>>>>>>>>>=20
>>>>>>>>> I agree, it seems more like a reference is put too late. I =
looked into
>>>>>>>>> into the places where the reference is put, but it all seems =
normal. In
>>>>>>>>> any case, I run it (just to see), and it did not help.
>>>>>>>>>=20
>>>>>>>>>> Something smells fishy, I'll dig a bit.
>>>>>>>>>=20
>>>>>>>>> Thanks! I continue looking into it myself; let me know if I =
can help
>>>>>>>>> with something more specific.
>>>>>>>>=20
>>>>>>>> What exact kernel are you running? And does the device have a =
scheduler
>>>>>>>> attached, or is it set to "none"?
>>>>>>>=20
>>>>>>> I can reproduce the issue on 4.11-rc7. I will rebase on top of =
your
>>>>>>> for-4.12/block, but I cannot see any patches that might be =
related. If
>>>>>>> it changes I'll ping you.
>>>>>>=20
>>>>>> I don't suspect it will do anything for you. I just ask to know =
what
>>>>>> base you are on.
>>>>>>=20
>>>>>>> I mentioned the problem to Christoph last week and disabling the
>>>>>>> schedulers was the first thing he recommended. I measured time =
around
>>>>>>> blk_mq_sched_get_request and for this particular test the choose =
of
>>>>>>> scheduler (including BFQ and kyber) does not seem to have an =
effect.
>>>>>>=20
>>>>>> kyber vs none would be the interesting test. Some of the paths =
are a
>>>>>> little different depending if there's a scheduler attached or =
not, so
>>>>>> it's good to know that we're seeing this in both cases.
>>>>>=20
>>>>> I just tested on your for-4.12/block with none and kyber and the =
latency
>>>>> spike appears in both cases.
>>>>=20
>>>> OK good. I looked at your reproduction case. Looks like we =
ultimately
>>>> end up submitting IO through nvme_nvm_submit_user_cmd() when you do =
the
>>>> nvm_vblk line_erase, which is basically the same code as
>>>> NVME_IOCTL_SUBMIT_IO as far as request alloc, setup, issue, free =
goes.
>>>> So does it reproduce for you as well on a normal nvme device, if =
you run
>>>> a nvme read /dev/nvme0 [...] while running the same read fio job?
>>>=20
>>> Ok. I'll try that.
>>=20
>> I cannot reproduce the latency on a normal nvme drive when mixing I/O
>> from a fio job and ioctls.
>>=20
>> The path is different from the one in pblk, since normal block I/O
>> uses the generic_make_request(), but still, they both need to
>> blk_queue_enter(), allocate a request, etc. They only "major" =
difference
>> I see is that normal block I/O requests are given by get_request()
>> (which as far as I understand takes pre-allocated requests from the
>> queue request list), while pblk allocates each request via
>> nvme_alloc_request().
>>=20
>> What puzzles me most is that having different pblk instances, issuing
>> I/O in parallel does not trigger the long tail. Otherwise, I would =
think
>> that we are just unlucky and get scheduled out. Still, 20ms...
>>=20
>> BTW, in order to discard NUMA, I tried on a single socket machine, =
and
>> same, same.
>=20
> I suspect the .q_usage_counter is DEAD, and you can check it via
> percpu_ref_is_dying(), or just check if slow path is reached.
>=20
> The fast path is that percpu_ref_tryget_live() returns directly,
> and slow path is reached only if queue is freezed or dead.
>=20
> If that is true, you can add a dump_stack() in =
blk_freeze_queue_start()
> to see where the unusual freezing/unfreezing is from.


Thanks for the hint Ming! You are right. We somehow trigger a re-read
partition:

[  324.010184]  dump_stack+0x63/0x90
[  324.010191]  blk_freeze_queue_start+0x1e/0x50
[  324.010194]  blk_mq_freeze_queue+0x12/0x20
[  324.010199]  __nvme_revalidate_disk+0xa4/0x350
[  324.010203]  nvme_revalidate_disk+0x53/0x90
[  324.010206]  rescan_partitions+0x8d/0x380
[  324.010211]  ? tlb_flush_mmu_free+0x36/0x60
[  324.010218]  ? security_capable+0x48/0x60
[  324.010221]  __blkdev_reread_part+0x65/0x70
[  324.010223]  blkdev_reread_part+0x23/0x40
[  324.010225]  blkdev_ioctl+0x387/0x910
[  324.010229]  ? locks_insert_lock_ctx+0x7e/0xd0
[  324.010235]  block_ioctl+0x3d/0x50
[  324.010239]  do_vfs_ioctl+0xa1/0x5d0
[  324.010242]  ? locks_lock_inode_wait+0x51/0x150
[  324.010247]  ? kmem_cache_alloc+0xd7/0x1b0
[  324.010249]  ? locks_alloc_lock+0x1b/0x70
[  324.010252]  SyS_ioctl+0x79/0x90
[  324.010254]  ? SyS_flock+0x11c/0x180
[  324.010260]  entry_SYSCALL_64_fastpath+0x1e/0xad

I'm checking why this happens now...

Javier



--Apple-Mail=_4CE2B4BE-4149-4EC3-9A9A-EFAF4FEAD0F7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZEaZLAAoJEGMfBTt1mRjKrCoP/1ALtMWU4MVtKqUW1RlNTTa0
w+129P2pPyKdd8ftWaRhLGRwZfCQXgTDqqERcxv2qzeQRbaOOZPviw317ajJraYE
f1ule8ARPxRwKG60yyWWr+cLswxmjGE1AXaHU3hThFIAJmTiSNt8nS6IEJitCOhM
AqXsNKA3kek1hGozKCEcU4g22k70scBon3+v7nEyM1z5l1ES5/IiDlHP9qokiNJk
q2c7IVLCyDLelIzDo4CHJwoE9kfrVFLVPcvsrL9pkZ4OES9i1Ph/cNZ3/yBz299K
hL2QeVvsaPBRkVQqR7aqXWBCu4PPK10kZ2kw/+QdUa9cnT4kSSKJJOjyQ2LATmQU
EE8XyFZAZcbH1bI9tKo0qdR/QGvfVCaSjmeJmiiGaMMF1KczjC+S3CUEt/XLmLMJ
hsGcxRtij712WS9gE5mddpku7es2Qv0m0AcutnLfWCRLiaCO5FoTmPVCCyWZ1MeY
dFeH7f2SvMd6wW7VdntFC1wzq7QZJQ089XLl2s0yQmE1Ih+NFk3QwIkzCDGXKqlA
V5xuh+a9Gxe9Wdhx7swoGkBAl1Gf6wfip+oswo1ojYqxwJp4G68nc5PoPrDtiMow
G7mIhZnfVa/ceXMRFMT0hd6KwdjHFGTi1cwrkV9gVXSok/FbWbuHmzic/XTJ4DZZ
aRibDRmahi93Gi8h+UEr
=X5q1
-----END PGP SIGNATURE-----

--Apple-Mail=_4CE2B4BE-4149-4EC3-9A9A-EFAF4FEAD0F7--
