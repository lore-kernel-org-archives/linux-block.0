Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BUGFIX] block, bfq: access and cache blkg data only when safe
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170524164704.GF24798@htj.duckdns.org>
Date: Thu, 25 May 2017 09:10:59 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <DBB76394-B3DF-44AE-9536-8CDF270B37D5@linaro.org>
References: <20170519083908.2588-1-paolo.valente@linaro.org> <20170519145442.GA7174@wtj.duckdns.org> <F79460BD-95A4-424B-8E3A-EC765745C447@linaro.org> <20170523204239.GI13222@htj.duckdns.org> <6E15A7C4-398F-4A93-A717-C499B3900EF0@linaro.org> <20170524145023.GA24798@htj.duckdns.org> <C9B2B7D3-1E92-4E22-80FA-8A606643B536@linaro.org> <20170524164704.GF24798@htj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 24 mag 2017, alle ore 17:47, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello,
>=20
> On Wed, May 24, 2017 at 05:43:18PM +0100, Paolo Valente wrote:
>>> so none of the above objects can be destroyed before the request is
>>> done.
>>=20
>> ... the issue seems just to move to a more subtle position: cfq is =
ok,
>> because it protects itself with rq lock, but blk-mq schedulers don't.
>> So, the race that leads to the (real) crashes reported by people may
>> actually be:
>=20
> Oh, I was just thinking about !mq paths the whole time.
>=20
>> 1 blkg_lookup executed on a blkg being destroyed: the scheduler gets =
a
>> copy of the content of the blkg, but the rcu mechanism doesn't =
prevent
>> destruction from going on
>> 2 blkg_get gets executed on the copy of the original blkg
>=20
> So, we can't do that.  We should look up and bump the ref and use the
> original copy.  We probably should switch blkgs to use percpu-refs.
>=20

Ok.  So, just to better understand: as of now, i.e., before you make
the changes you are proposing, the address returned by blkg_lookup can
be used safely only if one both invokes blkg_lookup and gets a
reference, while holding the rq lock all the time.  But then, before
the changes you propose, what is the remaining role of rcu protection
here?  Are there places where the value returned by blkg_lookup is
actually used safely without getting a reference the returned blkg?

Anyway, I'm willing to help with your proposal, if you think I can be
of any help at some point.  In this respect, consider that I'm not an
expert of percpu-refs either.

Finally, I guess that the general fix you have in mind may not be
ready shortly.  So, I'll proceed with my temporary fix for the moment.
In particular, I will
1) fix the typo reported by Jens;
2) add a note stating that this is a temporary fix;
3) if needed, modify commit log and comments in the diffs, to better
    describe the general problem, and the actual critical race.

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun
