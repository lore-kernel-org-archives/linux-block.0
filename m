Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/2] block, bfq: improve and refactor throughput-boosting logic
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170804053511.2389-1-paolo.valente@linaro.org>
Date: Thu, 10 Aug 2017 21:55:08 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org,
 broonie@kernel.org,
 lucmiccio@gmail.com
Message-Id: <66099037-D7F7-4803-B9A6-8A4866EAE43A@linaro.org>
References: <20170804053511.2389-1-paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 04 ago 2017, alle ore 07:35, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
> these two patches improve throughput-boosting logic in two
> aspects. The first patch refactors the parts of the device-idling
> logic, related to throughput boosting, that are still scattered across
> the source file bfq-iosched.c. The patch concetrates all the logic in
> one function. The second patch fixes/improves device idling for
> flash-based devices that have no internal queueing of I/O requests.
>=20
> The contribution in the first patch has been triggered by that in the
> second patch: finding the change made by the second patch has been
> more difficult than it had to be, because the logic that decides
> whether to idle the device is scattered across three functions.
>=20
> The second patch provides a significant throghput boost, for random
> I/O with flash-based non-queueing devices. For example, on a HiKey
> board, throughput increases by up to 125%, growing, e.g., from 6.9MB/s
> to 15.6MB/s with two or three random readers in parallel.
>=20

Hi Jens,
any idea about the fate of these two patches?

Thanks,
Paolo

> Thanks,
> Paolo
>=20
> Paolo Valente (2):
>  block,bfq: refactor device-idling logic
>  block, bfq: boost throughput with flash-based non-queueing devices
>=20
> block/bfq-iosched.c | 144 =
++++++++++++++++++++++++++++------------------------
> block/bfq-iosched.h |  12 ++---
> 2 files changed, 85 insertions(+), 71 deletions(-)
>=20
> --
> 2.10.0
