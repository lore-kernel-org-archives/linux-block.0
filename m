Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
Message-Id: <FBF6DCBB-B0F5-446B-8FD1-106E2538A9C1@linaro.org>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_A1EBE600-DB60-46A9-8A12-AE2DB7E7F0E0"
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
Date: Wed, 7 Feb 2018 10:45:14 +0100
In-Reply-To: <1517995431.25619.5.camel@gmx.de>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
 Alban Browaeys <alban.browaeys@gmail.com>,
 Ming Lei <ming.lei@redhat.com>,
 Ivan Kozik <ivan@ludios.org>,
 SERENA ZIVIANI <169364@studenti.unimore.it>,
 Serena Ziviani <ziviani.serena@gmail.com>,
 =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
To: Mike Galbraith <efault@gmx.de>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
 <1517903761.9843.12.camel@gmx.de>
 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
 <1517918234.25841.31.camel@gmx.de>
 <77124223e6116350a5184a5199850304@natalenko.name>
 <1517924768.25841.32.camel@gmx.de>
 <8842084cc8a26b7f46ae600bda8a7bd0@natalenko.name>
 <CC8CDDA5-A232-41A6-BE1E-CDB0B361C3DB@linaro.org>
 <82ffc96aacc3945861cbb708df346338@natalenko.name>
 <E52CCDEA-279A-40D8-AD9B-F4D1AF351BF1@linaro.org>
 <1517995431.25619.5.camel@gmx.de>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_A1EBE600-DB60-46A9-8A12-AE2DB7E7F0E0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 07 feb 2018, alle ore 10:23, Mike Galbraith <efault@gmx.de> =
ha scritto:
>=20
> On Wed, 2018-02-07 at 10:08 +0100, Paolo Valente wrote:
>>=20
>> The first piece of information I need is whether this failure happens
>> even without "BFQ hierarchical scheduling support".
>=20
> I presume you mean BFQ_GROUP_IOSCHED, which I do not have enabled.
>=20

Great (so to speak), this saves us one step.

So, here's my next request for help: please apply the attached patch =
(compressed to preserve it from my email client) and retry. It adds =
several anomaly checks. I hope I have not added any false-positive =
check.

Thanks,
Paolo


--Apple-Mail=_A1EBE600-DB60-46A9-8A12-AE2DB7E7F0E0
Content-Disposition: attachment;
	filename=0001-block-bfq-instrument-requeue-and-finish-request.patch.zip
Content-Type: application/zip;
	x-unix-mode=0644;
	name="0001-block-bfq-instrument-requeue-and-finish-request.patch.zip"
Content-Transfer-Encoding: base64

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
AAAAAAEAAQB0AAAAUgUAAAAA
--Apple-Mail=_A1EBE600-DB60-46A9-8A12-AE2DB7E7F0E0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



> 	-Mike 


--Apple-Mail=_A1EBE600-DB60-46A9-8A12-AE2DB7E7F0E0--
