Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
In-Reply-To: <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Oct 2018 10:25:43 +0200
Message-ID: <CACRpkdb1YSw3WWpGSqwxORaMSAeemiaP4i6cWJcY5VtADfzorQ@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To: oleksandr@natalenko.name
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>,
	Artem Bityutskiy <dedekind1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
	aherrmann@suse.com, mgorman@suse.com,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, bfq-iosched@googlegroups.com,
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 3, 2018 at 1:49 PM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:

> On another hand, the users of embedded devices, mentioned by Linus,
> should already know what scheduler to choose because dealing with
> embedded world assumes the person can decide this on their own, or with
> the help of abovementioned udev scripts and/or Documentation/ as a
> reference point.
>
> So I see no obstacles here, and the choice to rely on udev by default
> sounds reasonable.

I am sorry but I do not agree with this.

There are several historical precedents where we have
concluded that just "have the kernel do the right thing
by default" is the way to go.

Example 1: pluggable CPU schedulers.
The reasoning was that users or distros have no clue what
scheduler they want, only scheduler developers do. We
drove it to the point where we have one and one
scheduler only, not different flavors. (Special
usecases have special scheduling classes inside the
one scheduler instead.)

Example 2: Automatic process group scheduling
The reasoning was that daemons such as systemd would
be better at placing processes/tasks into the right
control groups to manage their resources, so this would
be a userspace policy handled by the udev/systemd
complex. We did not do that. Instead the kernel does
autogrouping per-session, indeed it is a Kconfig option
but even e.g. Fedora has this enabled by default.
(commit 5091faa449ee)

As pointed out elsewhere: these defaults make it
easy for custom builds not using udev+systemd to
get a system up and running with sensible defaults.

Simple embedded systems use Busybox' mdev (I wouldn't
trust it do do any complex decisions). OpenWRT
has ubox+ubus+uci, also extremely lightweight,
Android has its own init system that I don't
manage to keep track of anymore. Instead of running
all over the map and fixing these userspaces to
do the right thing, it makes sense to make the
right thing the default.

And these are millions and millions of deployed
systems not using udev+systemd we are talking about,
they are not fringe hobby projects. It's not that I
personally dislike udev or anything, I kind of like
it, but these tailored distros simply don't use it
and they are huge in numbers. They need help to do
the right thing. Fixing a udev rule doesn't solve
even half the world's problems I'm afraid.

Yours,
Linus Walleij
