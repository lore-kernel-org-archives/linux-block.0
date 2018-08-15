Return-Path: <prvs=75856d2a9=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mb@lightnvm.io" <mb@lightnvm.io>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"loberman@redhat.com" <loberman@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le Moal
	<Damien.LeMoal@wdc.com>
Subject: Re: Zoned block device support for fio
Date: Wed, 15 Aug 2018 18:07:54 +0000
Message-ID: <c3dae05ba4895b58442b64640b8c7a16103fa214.camel@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
	 <1530899118.31977.1.camel@redhat.com>
	 <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
	 <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
	 <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
	 <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
	 <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
	 <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
	 <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
	 <be88923a-b960-0786-bd21-a4107cccd834@kernel.dk>
	 <8d1946fb8f46c66b572a7643d47f9762154d1e8b.camel@wdc.com>
	 <b9e3dd53-4b0d-3d95-ee28-aa4c1dc9b8d7@kernel.dk>
In-Reply-To: <b9e3dd53-4b0d-3d95-ee28-aa4c1dc9b8d7@kernel.dk>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-08-09 at 15:03 -0600, Jens Axboe wrote:
+AD4- Yes exactly. Basically come up with something that just maps fio zone=
s on
+AD4- top of SMR zones. Then come up with something that allows you to have
+AD4- sequential writes IO within a zone, and something that allows you to =
decide
+AD4- how many zones to use, when to skip between zones, etc.

Hello Jens,

SMR support for fio has been reworked. The reworked patches are available a=
t
https://github.com/axboe/fio/pull/585. The following two test scripts allow=
 to
verify whether the fio behavior is identical for SMR and non-SMR storage me=
dia:
+ACo- t/zbd/run-tests-against-regular-nullb
+ACo- t/zbd/run-tests-against-zoned-nullb

Thanks,

Bart.
