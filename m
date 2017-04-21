Return-Path: <elena.reshetova@intel.com>
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Eric Biggers <ebiggers3@gmail.com>, Kees Cook <keescook@chromium.org>
CC: Christoph Hellwig <hch@infradead.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "james.bottomley@hansenpartnership.com"
	<james.bottomley@hansenpartnership.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"fujita.tomonori@lab.ntt.co.jp" <fujita.tomonori@lab.ntt.co.jp>,
	"mingo@redhat.com" <mingo@redhat.com>, "clm@fb.com" <clm@fb.com>,
	"jbacik@fb.com" <jbacik@fb.com>, "dsterba@suse.com" <dsterba@suse.com>
Subject: RE: [PATCH 0/5] v2: block subsystem refcounter conversions
Date: Fri, 21 Apr 2017 10:55:29 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C8E21B@IRSMSX102.ger.corp.intel.com>
References: <1492687644-4405-1-git-send-email-elena.reshetova@intel.com>
 <20170420135651.GA26595@infradead.org>
 <2236FBA76BA1254E88B949DDB74E612B41C8DA36@IRSMSX102.ger.corp.intel.com>
 <20170420183319.GB103004@gmail.com>
In-Reply-To: <20170420183319.GB103004@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

> Hi Elena,
>=20
> On Thu, Apr 20, 2017 at 04:10:16PM +0000, Reshetova, Elena wrote:
> >
> > > All the objections from DaveM on the amount of cycles spent on the
> > > new refcount_t apply to the block layer fast path operations as well.
> >
> > Ok, could you please indicate the correct way to measure the impact for=
 the
> block layer?
> > We can do the measurements.
> >
> > Best Regards,
> > Elena.
> >
> > >
> > > Please don't send any more conversions until those have been resolved=
.
>=20
> Like I suggested months ago, how about doing an efficient implementation =
of
> refcount_t which doesn't use the bloated cmpxchg loop?  Then there would =
be
> no
> need for endless performance arguments.  In fact, in PaX there are alread=
y
> example implementations for several architectures.  It's unfortunate that
> they're still being ignored for some reason.

Providing efficient arch. specific implementation for refcount_t is likely =
the next step
to make performance-sensitive places happy. However, in order to do it, we =
will need
to measure for each subsystem a) current atomic_t usage - base measurement=
=20
b) pure refcount_t usage impact
c) arch. specific refcount_t impact=20

Otherwise I have a chicken and egg problem here: people want better perform=
ance
and want to see arch. specific code for this, but in order to convince main=
tainer
in need of arch. specific code, I need to show that we do have indeed a per=
formance issue.=20

So, that's why I was endlessly asking for each subsystem that said that poi=
nted out=20
performance reasons to give hints on what should be measured.=20
This way we can come back with real numbers (including for arch. specific i=
mplement) and
then decide what makes the most sense.=20

>=20
> At the very least, what is there now could probably be made about twice a=
s fast
> by removing the checks that don't actually help mitigate refcount overflo=
w bugs,
> specifically all the checks in refcount_dec(), and the part of refcount_i=
nc()
> where it doesn't allow incrementing a 0 refcount.  Hint: if a refcount is=
 0, the
> object has already been freed, so the attacker will have had the opportun=
ity to
> allocate it with contents they control already.

refcount_dec() is used very little through the code actually, it is more li=
ke an exception
case since in order to use it one must really be sure that refcounter doesn=
't drop to zero.
Removing the warn around it wouldn't likely affect much overall and thus it=
 is better to
stay to discourage people of API itself :)

refcount_inc() is of course a different story, it is extensively used. I gu=
ess the perf issue
on checking increment from zero might only come from WARNs being printed,
but not really from an additional check here for zero since it is trivial a=
nd part of
the needed loop anyway. So, I think only removing the
WARNs might have any visible impact, but even this is probably not really t=
hat big.=20

So, I think these changes won't really help adoption of interface if argume=
nts against
is performance. If we do have a performance issue, I think arch. specific i=
mplementation
is likely the only way to considerably speed it up.=20

>=20
> Of course, having extra checks behind a debug option is fine.  But they s=
hould
> not be part of the base feature; the base feature should just be mitigati=
on of
> reference count *overflows*.  It would be nice to do more, of course; but=
 when
> the extra stuff prevents people from using refcount_t for performance rea=
sons,
> it defeats the point of the feature in the first place.

Sure, but as I said above, I think the smaller tricks and fixes won't be co=
nvincing enough,
so their value is questionable.=20

>=20
> I strongly encourage anyone who has been involved in refcount_t to experi=
ment
> with removing a reference count decrement somewhere in their kernel, then
> trying
> to exploit it to gain code execution.  If you don't know what you're tryi=
ng to
> protect against, you will not know which defences work and which don't.

Well, we had successful CVEs and even exploits on this in the past.=20
@Kees, do you store a list of them in the project?

What do you actually want to verify? The fact that if you manage to create =
use-after-free
situation, you are able to take advantage of it?=20

Best Regards,
Elena.

>=20
> - Eric
