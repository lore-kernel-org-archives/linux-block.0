Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20161026101903.GA22361@infradead.org>
Date: Wed, 26 Oct 2016 14:37:58 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org,
 linus.walleij@linaro.org,
 broonie@kernel.org,
 hare@suse.de,
 arnd@arndb.de,
 bart.vanassche@sandisk.com,
 grant.likely@secretlab.ca,
 jack@suse.cz,
 James.Bottomley@HansenPartnership.com
Message-Id: <E3C56654-2814-454D-8A60-67FE2788B590@linaro.org>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org> <20161026101903.GA22361@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 26 ott 2016, alle ore 12:19, Christoph Hellwig =
<hch@infradead.org> ha scritto:
>=20
> Just as last time:
>=20
> big NAK for introducing giant new infrastructure like a new I/O =
scheduler
> for the legacy request structure.
>=20

I would fully agree, if there weren't important problems involved.
But there are.

Linux has been suffering for years from responsiveness and latency
problems, related to I/O (and I/O bandwidth fairness is still just not
available). Users are not happy about that.

BFQ apparently solves these problems in most scenarios.  Adding BFQ
would not be disruptive for any use case.  People could just try it if
they want, and check whether things get better.

IMO these problems are more important than the clear code-
maintenance issue you raise.

> Please direct your engergy towards blk-mq instead.

Definitely.  I would really like to help.  To this purpose, I
have already tried to stimulate discussion, as well offer and ask for
help [1].

And I think that addressing these latency problems (and not only) is
even more important with blk-mq.  In fact, with blk-mq, they get
worse, as no I/O scheduler is available yet.

Thanks,
Paolo

[1] http://www.spinics.net/lists/linux-block/msg04555.html

> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
