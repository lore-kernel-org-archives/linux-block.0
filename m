Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36353 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbdEHOUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 May 2017 10:20:42 -0400
Received: by mail-wr0-f182.google.com with SMTP id l50so45245941wrc.3
        for <linux-block@vger.kernel.org>; Mon, 08 May 2017 07:20:42 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <E169E488-53EC-468A-9221-DF11F0944298@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5E3D6DCA-AB72-4F76-92F8-B0F20396BD7D";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Large latency on blk_queue_enter
Date: Mon, 8 May 2017 16:20:39 +0200
In-Reply-To: <bbe256c2-f9ff-e594-45c9-7f9ac233ee7a@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@fb.com>
References: <1656B440-3ECA-4F2B-B95C-418CF0F347E9@lightnvm.io>
 <20170508122738.GC5696@ming.t460p>
 <76E35BA3-FEC9-46D6-B36F-554F464FA9ED@lightnvm.io>
 <bbe256c2-f9ff-e594-45c9-7f9ac233ee7a@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_5E3D6DCA-AB72-4F76-92F8-B0F20396BD7D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 8 May 2017, at 16.13, Jens Axboe <axboe@fb.com> wrote:
>=20
> On 05/08/2017 07:44 AM, Javier Gonz=C3=A1lez wrote:
>>> On 8 May 2017, at 14.27, Ming Lei <ming.lei@redhat.com> wrote:
>>>=20
>>> On Mon, May 08, 2017 at 01:54:58PM +0200, Javier Gonz=C3=A1lez =
wrote:
>>>> Hi,
>>>>=20
>>>> I find an unusual added latency(~20-30ms) on blk_queue_enter when
>>>> allocating a request directly from the NVMe driver through
>>>> nvme_alloc_request. I could use some help confirming that this is a =
bug
>>>> and not an expected side effect due to something else.
>>>>=20
>>>> I can reproduce this latency consistently on LightNVM when mixing =
I/O
>>>> from pblk and I/O sent through an ioctl using liblightnvm, but I =
don't
>>>> see anything on the LightNVM side that could impact the request
>>>> allocation.
>>>>=20
>>>> When I have a 100% read workload sent from pblk, the max. latency =
is
>>>> constant throughout several runs at ~80us (which is normal for the =
media
>>>> we are using at bs=3D4k, qd=3D1). All pblk I/Os reach the =
nvme_nvm_submit_io
>>>> function on lightnvm.c., which uses nvme_alloc_request. When we =
send a
>>>> command from user space through an ioctl, then the max latency goes =
up
>>>> to ~20-30ms. This happens independently from the actual command
>>>> (IN/OUT). I tracked down the added latency down to the call
>>>> percpu_ref_tryget_live in blk_queue_enter. Seems that the queue
>>>> reference counter is not released as it should through =
blk_queue_exit in
>>>> blk_mq_alloc_request. For reference, all ioctl I/Os reach the
>>>> nvme_nvm_submit_user_cmd on lightnvm.c
>>>>=20
>>>> Do you have any idea about why this might happen? I can dig more =
into
>>>> it, but first I wanted to make sure that I am not missing any =
obvious
>>>> assumption, which would explain the reference counter to be held =
for a
>>>> longer time.
>>>=20
>>> You need to check if the .q_usage_counter is working at atomic mode.
>>> This counter is initialized as atomic mode, and finally switchs to
>>> percpu mode via percpu_ref_switch_to_percpu() in =
blk_register_queue().
>>=20
>> Thanks for commenting Ming.
>>=20
>> The .q_usage_counter is not working on atomic mode. The queue is
>> initialized normally through blk_register_queue() and the counter is
>> switched to percpu mode, as you mentioned. As I understand it, this =
is
>> how it should be, right?
>=20
> That is how it should be, yes. You're not running with any heavy
> debugging options, like lockdep or anything like that?

No lockdep, KASAN, kmemleak or any of the other usual suspects.

What's interesting is that it only happens when one of the I/Os comes
from user space through the ioctl. If I have several pblk instances on
the same device (which would end up allocating a new request in
parallel, potentially on the same core), the latency spike does not
trigger.

I also tried to bind the read thread and the liblightnvm thread issuing
the ioctl to different cores, but it does not help...

Javier

--Apple-Mail=_5E3D6DCA-AB72-4F76-92F8-B0F20396BD7D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZEH63AAoJEGMfBTt1mRjKBNQP/R1AQipesse9V9Ezj4EeR0Xp
R6tdWne+FtsIF2NnbXFqSGDZnXCI9GaDtacYOCZBDKCc7BUuKD+glvZGpbYbLf2X
Yz+h3rIGOud3XUA7aborbcmiqXnCn+LMZDWWQ5iLQl4l/xPYJ85OfrhMA1wAUxZ1
ak6JEUeeVermJBiMo8QY+27Of9HtCvxDTNUlzkj1OvvzvlmXARlO9DxtXuMQJv9L
j8pOoZd/QBhQ1dulYIYlRvyR4ej+ImPiSRcjFkmgtO2SRHEMOPCFX0Su0LIEkxXK
inmkkHZ+v7XR0KFeHoHbo0wivUhhwcYXXCi0xl6GBqOf473DwTK7gyn8scYOj7xS
KWxkdjn7cVJu29TPZEeodbajCpsL4czECpyJBGdmF73DQZZ5XGEkx5lCR6ZmAtuU
IHLS0c1NxxcLevTQC5hxJRNBNfuqzjRKWXHuORqy3LSdwUZicnZv3EC/ZJXUU/5e
MLRBHqnF0oGquzk/iqH0/HBW3kjJbvY+FLM1UwcgsJ1v5H82kTPM4cBmUSBeLoYS
/9B3INGRoSR79wqEYe6BNQR2DQ1yIpcIDrdiBkdWwGuYqXe6OzOdFoNJF9oTfift
SObybERa/mceTyHn9gVUNlQnqB8Bb6MIgp2YeftBAJ+GlsJqRhAD79z1lVe4ukQ2
u8V5Y6+zMBusX+bGXpfF
=qNkS
-----END PGP SIGNATURE-----

--Apple-Mail=_5E3D6DCA-AB72-4F76-92F8-B0F20396BD7D--
