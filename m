Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
In-Reply-To: <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Oct 2018 10:14:38 +0200
Message-ID: <CACRpkdYG2Y=rspbZ_o=H3REXTEfOcaiqEyQD4kzO=G=d63V3yA@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000b6b481057762bf13"
List-ID: <linux-block@vger.kernel.org>

--000000000000b6b481057762bf13
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 3, 2018 at 1:49 PM Oleksandr Natalenko <oleksandr@natalenko.name>
wrote:

On another hand, the users of embedded devices, mentioned by Linus,
> should already know what scheduler to choose because dealing with
> embedded world assumes the person can decide this on their own, or with
> the help of abovementioned udev scripts and/or Documentation/ as a
> reference point.
>
> So I see no obstacles here, and the choice to rely on udev by default
> sounds reasonable.
>

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

--000000000000b6b481057762bf13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;courier new&quot;,monospace"><span style=3D"font-family:Aria=
l,Helvetica,sans-serif">On Wed, Oct 3, 2018 at 1:49 PM Oleksandr Natalenko =
&lt;<a href=3D"mailto:oleksandr@natalenko.name">oleksandr@natalenko.name</a=
>&gt; wrote:</span><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:&quot;courier new&quot;,monospace"><span style=3D"font-family:Arial,Hel=
vetica,sans-serif"><br></span></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On another hand, the users of embedde=
d devices, mentioned by Linus, <br>
should already know what scheduler to choose because dealing with <br>
embedded world assumes the person can decide this on their own, or with <br=
>
the help of abovementioned udev scripts and/or Documentation/ as a <br>
reference point.<br>
<br>
So I see no obstacles here, and the choice to rely on udev by default <br>
sounds reasonable.<br></blockquote><div><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:&quot;courier new&quot;,monospace">I am sorry but =
I do not agree with this.</div><div class=3D"gmail_default" style=3D"font-f=
amily:&quot;courier new&quot;,monospace"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;courier new&quot;,monospace">There are seve=
ral historical precedents where we have</div><div class=3D"gmail_default" s=
tyle=3D"font-family:&quot;courier new&quot;,monospace">concluded that just =
&quot;have the kernel do the right thing</div><div class=3D"gmail_default" =
style=3D"font-family:&quot;courier new&quot;,monospace">by default&quot; is=
 the way to go.</div><div class=3D"gmail_default" style=3D"font-family:&quo=
t;courier new&quot;,monospace"><br></div><div class=3D"gmail_default" style=
=3D"font-family:&quot;courier new&quot;,monospace">Example 1: pluggable CPU=
 schedulers.</div><div class=3D"gmail_default" style=3D"font-family:&quot;c=
ourier new&quot;,monospace">The reasoning was that users or distros have no=
 clue what</div><div class=3D"gmail_default" style=3D"font-family:&quot;cou=
rier new&quot;,monospace">scheduler they want, only scheduler developers do=
. We</div><div class=3D"gmail_default" style=3D"font-family:&quot;courier n=
ew&quot;,monospace">drove it to the point where we have one and one</div><d=
iv class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,mon=
ospace">scheduler only, not different flavors. (Special</div><div class=3D"=
gmail_default" style=3D"font-family:&quot;courier new&quot;,monospace">usec=
ases have special scheduling classes inside the</div><div class=3D"gmail_de=
fault" style=3D"font-family:&quot;courier new&quot;,monospace">one schedule=
r instead.)</div><div class=3D"gmail_default" style=3D"font-family:&quot;co=
urier new&quot;,monospace"><br></div><div class=3D"gmail_default" style=3D"=
font-family:&quot;courier new&quot;,monospace">Example 2: Automatic process=
 group scheduling</div><div class=3D"gmail_default" style=3D"font-family:&q=
uot;courier new&quot;,monospace">The reasoning was that daemons such as sys=
temd would</div><div class=3D"gmail_default" style=3D"font-family:&quot;cou=
rier new&quot;,monospace">be better at placing processes/tasks into the rig=
ht</div><div class=3D"gmail_default" style=3D"font-family:&quot;courier new=
&quot;,monospace">control groups to manage their resources, so this would</=
div><div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quo=
t;,monospace">be a userspace policy handled by the udev/systemd</div><div c=
lass=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospa=
ce">complex. We did not do that. Instead the kernel does</div><div class=3D=
"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospace">aut=
ogrouping per-session, indeed it is a Kconfig option</div><div class=3D"gma=
il_default" style=3D"font-family:&quot;courier new&quot;,monospace">but eve=
n e.g. Fedora has this enabled by default.</div><div class=3D"gmail_default=
"><font face=3D"courier new, monospace">(commit 5091faa449ee)</font><br></d=
iv><div class=3D"gmail_default"><font face=3D"courier new, monospace"><br><=
/font></div><div class=3D"gmail_default"><font face=3D"courier new, monospa=
ce">As pointed out elsewhere: these defaults make it</font></div><div class=
=3D"gmail_default"><font face=3D"courier new, monospace">easy for custom bu=
ilds not using udev+systemd to</font></div><div class=3D"gmail_default"><fo=
nt face=3D"courier new, monospace">get a system up and running with sensibl=
e defaults.</font></div><div class=3D"gmail_default"><font face=3D"courier =
new, monospace"><br></font></div><div class=3D"gmail_default"><font face=3D=
"courier new, monospace">Simple embedded systems use Busybox&#39; mdev (I w=
ouldn&#39;t</font></div><div class=3D"gmail_default"><font face=3D"courier =
new, monospace">trust it do do any complex decisions). OpenWRT</font></div>=
<div class=3D"gmail_default"><font face=3D"courier new, monospace">has ubox=
+ubus+uci, also extremely lightweight,</font></div><div class=3D"gmail_defa=
ult"><font face=3D"courier new, monospace">Android has its own init system =
that I don&#39;t</font></div><div class=3D"gmail_default"><font face=3D"cou=
rier new, monospace">manage to keep track of anymore. Instead of running</f=
ont></div><div class=3D"gmail_default"><font face=3D"courier new, monospace=
">all over the map and fixing these userspaces to</font></div><div class=3D=
"gmail_default"><font face=3D"courier new, monospace">do the right thing, i=
t makes sense to make the</font></div><div class=3D"gmail_default"><font fa=
ce=3D"courier new, monospace">right thing the default.</font></div><div cla=
ss=3D"gmail_default"><font face=3D"courier new, monospace"><br></font></div=
><div class=3D"gmail_default"><font face=3D"courier new, monospace">And the=
se are millions and millions of deployed</font></div><div class=3D"gmail_de=
fault"><font face=3D"courier new, monospace">systems not using udev+systemd=
 we are talking about,</font></div><div class=3D"gmail_default"><font face=
=3D"courier new, monospace">they are not fringe hobby=C2=A0</font><span sty=
le=3D"font-family:&quot;courier new&quot;,monospace">projects. It&#39;s not=
 that I</span></div><div class=3D"gmail_default"><span style=3D"font-family=
:&quot;courier new&quot;,monospace">personally dislike udev or anything, I =
kind of like</span></div><div class=3D"gmail_default"><span style=3D"font-f=
amily:&quot;courier new&quot;,monospace">it, but these tailored distros sim=
ply don&#39;t use it</span></div><div class=3D"gmail_default"><span style=
=3D"font-family:&quot;courier new&quot;,monospace">and they are huge in num=
bers. They need help to do</span></div><div class=3D"gmail_default"><span s=
tyle=3D"font-family:&quot;courier new&quot;,monospace">the right thing. Fix=
ing a udev rule doesn&#39;t solve</span></div><div class=3D"gmail_default">=
<font face=3D"courier new, monospace">even half the world&#39;s problems I&=
#39;m afraid.</font></div><div class=3D"gmail_default"><font face=3D"courie=
r new, monospace"><br></font></div><div class=3D"gmail_default" style=3D"fo=
nt-family:&quot;courier new&quot;,monospace">Yours,</div><div class=3D"gmai=
l_default" style=3D"font-family:&quot;courier new&quot;,monospace">Linus Wa=
lleij</div></div></div></div>

--000000000000b6b481057762bf13--
