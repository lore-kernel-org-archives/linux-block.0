Return-Path: <dave@znu.io>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Hard LOCKUP on 4.15-rc9 + 'blkmq/for-next' branch
From: David Zarzycki <dave@znu.io>
In-Reply-To: <6025644f-e147-903a-e836-a2f53d3a61e9@kernel.dk>
Date: Tue, 23 Jan 2018 08:48:14 -0500
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <79205A92-2997-45D6-9277-6F56EC7CA989@znu.io>
References: <95E75EBE-D01A-4236-8762-FF3522D6DBAD@znu.io>
 <78e10971-611e-8dd7-104e-8266c3ba3b5c@kernel.dk>
 <7E93BF17-8476-4A93-BD27-D2E22E5DAB00@znu.io>
 <6025644f-e147-903a-e836-a2f53d3a61e9@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> On Jan 22, 2018, at 20:20, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> All of these are off the blk-wbt completion path. I suggested earlier =
to
> try and disable CONFIG_BLK_WBT to see if it goes away, or at least to
> see if the pattern changes.

Hi Jens,

Bingo! Disabling CONFIG_BLK_WBT makes the problem go away.

>=20
>> I=E2=80=99m open to trying anything at this point. Thanks for =
helping,
>=20
> I'd try other types of stress testing. Has the machine otherwise been
> stable, or is it a new box?

It is a new box. Other than the CONFIG_BLK_WBT problem, it handles =
stress just fine. If you want to debug this further, I=E2=80=99m willing =
to run instrumented code.

Thanks for helping me,
Dave=
