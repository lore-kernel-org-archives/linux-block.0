Return-Path: <kvigor@gmail.com>
MIME-Version: 1.0
References: <1528130412-4541-1-git-send-email-kvigor@gmail.com>
 <10d1cb78-5d68-0301-ae5c-3d35ce68383a@kernel.dk> <20180605143005.m3bkudt4zydhllu7@destiny>
 <bc33c7b8-b70c-f2a9-56ac-7e87ed9da29f@kernel.dk>
In-Reply-To: <bc33c7b8-b70c-f2a9-56ac-7e87ed9da29f@kernel.dk>
From: Kevin Vigor <kvigor@gmail.com>
Date: Tue, 5 Jun 2018 09:42:22 -0600
Message-ID: <CAFVaERrK1Nxm8ZPnOqobjyCWdOGsr8c6Zm4azewy_6paBzskrA@mail.gmail.com>
Subject: Re: [PATCH] nbd: Consistently use request pointer in debug messages.
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	Kevin Vigor <kvigor@fb.com>
Content-Type: multipart/alternative; boundary="0000000000001c4c38056de6e655"
List-ID: <linux-block@vger.kernel.org>

--0000000000001c4c38056de6e655
Content-Type: text/plain; charset="UTF-8"

Sorry, also foggy from Josef's exploits.

Signed-off-by: Kevin Vigor <kvigor@fb.com>

On Tue, Jun 5, 2018 at 8:32 AM Jens Axboe <axboe@kernel.dk> wrote:

> On 6/5/18 8:30 AM, Josef Bacik wrote:
> > On Tue, Jun 05, 2018 at 08:23:06AM -0600, Jens Axboe wrote:
> >> On 6/4/18 10:40 AM, kvigor@gmail.com wrote:
> >>> From: Kevin Vigor <kvigor@fb.com>
> >>>
> >>> Existing dev_dbg messages sometimes identify request using request
> >>> pointer, sometimes using nbd_cmd pointer. This makes it hard to
> >>> follow request flow. Consistently use request pointer instead.
> >>
> >> You're missing the Signed-off-by.
> >>
> >
> > Blah sorry, still a little foggy,
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> Not you, Kevin :-)
>
> --
> Jens Axboe
>
>

--0000000000001c4c38056de6e655
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry, also foggy from Josef&#39;s exploits.<br><br>Signed=
-off-by: Kevin Vigor &lt;<a href=3D"mailto:kvigor@fb.com" target=3D"_blank"=
>kvigor@fb.com</a>&gt;<br></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr">On Tue, Jun 5, 2018 at 8:32 AM Jens Axboe &lt;<a href=3D"mailto:axboe@=
kernel.dk">axboe@kernel.dk</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">On 6/5/18 8:30 AM, Josef Bacik wrote:<br>
&gt; On Tue, Jun 05, 2018 at 08:23:06AM -0600, Jens Axboe wrote:<br>
&gt;&gt; On 6/4/18 10:40 AM, <a href=3D"mailto:kvigor@gmail.com" target=3D"=
_blank">kvigor@gmail.com</a> wrote:<br>
&gt;&gt;&gt; From: Kevin Vigor &lt;<a href=3D"mailto:kvigor@fb.com" target=
=3D"_blank">kvigor@fb.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Existing dev_dbg messages sometimes identify request using req=
uest<br>
&gt;&gt;&gt; pointer, sometimes using nbd_cmd pointer. This makes it hard t=
o<br>
&gt;&gt;&gt; follow request flow. Consistently use request pointer instead.=
<br>
&gt;&gt;<br>
&gt;&gt; You&#39;re missing the Signed-off-by.<br>
&gt;&gt;<br>
&gt; <br>
&gt; Blah sorry, still a little foggy,<br>
&gt; <br>
&gt; Signed-off-by: Josef Bacik &lt;<a href=3D"mailto:josef@toxicpanda.com"=
 target=3D"_blank">josef@toxicpanda.com</a>&gt;<br>
<br>
Not you, Kevin :-)<br>
<br>
-- <br>
Jens Axboe<br>
<br>
</blockquote></div>

--0000000000001c4c38056de6e655--
