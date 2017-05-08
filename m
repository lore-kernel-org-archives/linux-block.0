Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34194 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754565AbdEHNoT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 May 2017 09:44:19 -0400
Received: by mail-wr0-f173.google.com with SMTP id l9so44066533wre.1
        for <linux-block@vger.kernel.org>; Mon, 08 May 2017 06:44:18 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <76E35BA3-FEC9-46D6-B36F-554F464FA9ED@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7FCA0A37-7DCC-4A4C-A245-531D7859B065";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Large latency on blk_queue_enter
Date: Mon, 8 May 2017 15:44:14 +0200
In-Reply-To: <20170508122738.GC5696@ming.t460p>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Ming Lei <ming.lei@redhat.com>
References: <1656B440-3ECA-4F2B-B95C-418CF0F347E9@lightnvm.io>
 <20170508122738.GC5696@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_7FCA0A37-7DCC-4A4C-A245-531D7859B065
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 8 May 2017, at 14.27, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Mon, May 08, 2017 at 01:54:58PM +0200, Javier Gonz=C3=A1lez wrote:
>> Hi,
>>=20
>> I find an unusual added latency(~20-30ms) on blk_queue_enter when
>> allocating a request directly from the NVMe driver through
>> nvme_alloc_request. I could use some help confirming that this is a =
bug
>> and not an expected side effect due to something else.
>>=20
>> I can reproduce this latency consistently on LightNVM when mixing I/O
>> from pblk and I/O sent through an ioctl using liblightnvm, but I =
don't
>> see anything on the LightNVM side that could impact the request
>> allocation.
>>=20
>> When I have a 100% read workload sent from pblk, the max. latency is
>> constant throughout several runs at ~80us (which is normal for the =
media
>> we are using at bs=3D4k, qd=3D1). All pblk I/Os reach the =
nvme_nvm_submit_io
>> function on lightnvm.c., which uses nvme_alloc_request. When we send =
a
>> command from user space through an ioctl, then the max latency goes =
up
>> to ~20-30ms. This happens independently from the actual command
>> (IN/OUT). I tracked down the added latency down to the call
>> percpu_ref_tryget_live in blk_queue_enter. Seems that the queue
>> reference counter is not released as it should through blk_queue_exit =
in
>> blk_mq_alloc_request. For reference, all ioctl I/Os reach the
>> nvme_nvm_submit_user_cmd on lightnvm.c
>>=20
>> Do you have any idea about why this might happen? I can dig more into
>> it, but first I wanted to make sure that I am not missing any obvious
>> assumption, which would explain the reference counter to be held for =
a
>> longer time.
>=20
> You need to check if the .q_usage_counter is working at atomic mode.
> This counter is initialized as atomic mode, and finally switchs to
> percpu mode via percpu_ref_switch_to_percpu() in blk_register_queue().

Thanks for commenting Ming.

The .q_usage_counter is not working on atomic mode. The queue is
initialized normally through blk_register_queue() and the counter is
switched to percpu mode, as you mentioned. As I understand it, this is
how it should be, right?

Thanks,
Javier

--Apple-Mail=_7FCA0A37-7DCC-4A4C-A245-531D7859B065
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZEHYvAAoJEGMfBTt1mRjKvlwP/3BOAdwgoDwO5lXtUG/8q0J3
3aTeKVN6aWwpUbOLsNb8NKCJoFAeHROMg7dpXi2TBocqXPLRPYa1uop0NkFu4U77
QkPy55oQOcRHXJJnIs5+qdHkRWWEiNXQqdTVittnMcSvIqX53x0EkW55KCFowbFB
BT88imuuAdABe8h7ZmC4PgnuASHjbrGbgID1j/JT1Y2f8ArTEb4aKazU6VZ3Gl6z
Y7WXkH9djtIyjwYnbR8e0r9ZtPrjkvzSX1SGJgP5z5sX3sVpkehXD4o/xJNrS9pL
UEQPQlRhcggW+ymbbYYFlhTyhot+qHVab/nwdgvOcWzRc2q0rQkXpQptU3Nl11su
77OCP9Ua9u7JPp5BQOastuo+chSppF9hQImw4MU9lw99soU1WjSnPNVuITv2gZe9
oFikGZcbJOQPgC5NuoABb0an6YcNdsqlxiIRWEOtgPXu9KxJvUqt4EQ7KvmR6S3S
Y0kvSOIKCKTQ5N2xKX5JmMXL6/xF/L4jO1qugyev3FK2M7OxGFvkId5B2/wPU8f/
j/jiwk2pymi6/kB3deqALvFnxP0rJi0nFmQwonkulGfMIvCg3otLMgp2l30ViKGf
KJKdnR4ElZYc9sDM8zXL1BVNTrJJeVziv+mQ9Q4AaBs4G4/FGqqjibqxP4YCxJqp
tceqHl2KK8+ACzK7RoB+
=iEsY
-----END PGP SIGNATURE-----

--Apple-Mail=_7FCA0A37-7DCC-4A4C-A245-531D7859B065--
