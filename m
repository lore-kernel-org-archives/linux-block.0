Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Switching to MQ by default may generate some bug reports
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170805115404.vsrb3zuapskes3zi@techsingularity.net>
Date: Mon, 7 Aug 2017 19:35:32 +0200
Cc: Christoph Hellwig <hch@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Message-Id: <3FBAC9F0-740C-40E5-AC16-E299E7F1D9A1@linaro.org>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net> <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org> <20170803110144.vvadm3cc5oetf7up@techsingularity.net> <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org> <20170804110103.oljdzsy7bds6qylo@techsingularity.net> <34B4C2EB-18B2-4EAB-9BBC-8095603D733D@linaro.org> <20170805115404.vsrb3zuapskes3zi@techsingularity.net>
To: Mel Gorman <mgorman@techsingularity.net>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 05 ago 2017, alle ore 13:54, Mel Gorman =
<mgorman@techsingularity.net> ha scritto:
> ...
>=20
>> In addition, as for coverage, we made the empiric assumption that
>> start-up time measured with each of the above easy-to-benchmark
>> applications gives an idea of the time that it would take with any
>> application of the same size and complexity.  User feedback confirmed
>> this assumptions so far.  Of course there may well be exceptions.
>>=20
>=20
> FWIW, I also have anecdotal evidence from at least one user that using
> BFQ is way better on their desktop than CFQ ever was even under the =
best
> of circumstances. I've had problems directly measuring it empirically =
but
> this was also the first time I switched on BFQ to see what fell out so
> it's early days yet.
>=20

Yeah, I'm constantly trying (without great success so far :) ) to turn
this folklore into shared, repeatable tests and numbers.  The latter
could then be reliably evaluated, questioned or defended.

Thanks,
Paolo

> --=20
> Mel Gorman
> SUSE Labs
