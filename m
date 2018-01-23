Return-Path: <dave@znu.io>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Hard LOCKUP on 4.15-rc9 + 'blkmq/for-next' branch
From: David Zarzycki <dave@znu.io>
In-Reply-To: <78e10971-611e-8dd7-104e-8266c3ba3b5c@kernel.dk>
Date: Mon, 22 Jan 2018 20:05:54 -0500
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <7E93BF17-8476-4A93-BD27-D2E22E5DAB00@znu.io>
References: <95E75EBE-D01A-4236-8762-FF3522D6DBAD@znu.io>
 <78e10971-611e-8dd7-104e-8266c3ba3b5c@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> On Jan 22, 2018, at 18:34, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 1/22/18 4:31 PM, David Zarzycki wrote:
>> Hello,
>>=20
>> I previously reported a hang when building LLVM+clang on a block =
multi-queue device (NVMe _or_ loopback onto tmpfs with the =E2=80=99none=E2=
=80=99 scheduler).
>>=20
>> I=E2=80=99ve since updated the kernel to 4.15-rc9, merged the =
=E2=80=98blkmq/for-next=E2=80=99 branch, disabled nohz_full parameter =
(used for testing), and tried again. Both NVMe and loopback now lock up =
hard (ext4 if it matters). Here are the backtraces:
>>=20
>> NVMe:      http://znu.io/IMG_0366.jpg
>> Loopback:  http://znu.io/IMG_0367.jpg
>=20
> I tried to reproduce this today using the exact recipe that you =
provide,
> but it ran fine for hours. Similar setup, nvme on a dual socket box
> with 48 threads.

Hi Jens,

Thanks for the quick reply and thanks for trying to reproduce this. =
I=E2=80=99m not sure if this makes a difference, but this dual Skylake =
machine has 96 threads, not 48 threads. Also, just to be clear, NVMe =
doesn=E2=80=99t seem to matter. I hit this bug with a tmpfs loopback =
device set up like so:

dd if=3D/dev/zero bs=3D1024k count=3D10000 of=3D/tmp/loopdisk
losetup /dev/loop0 /tmp/loopdisk
echo none > /sys/block/loop0/queue/scheduler
mkfs -t ext4 -L loopy /dev/loop0
mount /dev/loop0 /l
### build LLVM+clang in /l
### 'ninja check-all=E2=80=99 in a loop in /l

(No swap is setup because the machine has 192 GiB of RAM.)

>=20
>> What should I try next to help debug this?
>=20
> This one looks different than the other one. Are you sure your hw is =
sane?

I can build LLVM+clang in /tmp (tmpfs) reliably which suggests the the =
fundamental hardware is sane. It=E2=80=99s only when the software =
multi-queue layer gets involved that I see quick crashes/hangs.

As for the different backtraces, that's probably because I removed =
nohz_full from the kernel boot parameters.

> I'd probably try and enable lockdep debugging etc and see if you catch =
anything.

Thanks. I turned on lockdep plus other lock debugging. Here is the =
resulting backtrace:

http://znu.io/IMG_0368.jpg

Here is the resulting backtrace with transparent huge pages disabled:

http://znu.io/IMG_0369.jpg

Here is the resulting backtrace with transparent huge pages disabled AND =
with systemd-coredumps disabled too:

http://znu.io/IMG_0370.jpg

I=E2=80=99m open to trying anything at this point. Thanks for helping,
Dave=
