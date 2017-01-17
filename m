Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: multipart/alternative; boundary="Apple-Mail=_BFBE3350-B7C8-4CD1-8EDC-E90BF0564F62"
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHSET v4] blk-mq-scheduling framework
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <b258d716-5c9a-c999-cec4-6bea38a8b975@fb.com>
Date: Tue, 17 Jan 2017 11:47:12 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Omar Sandoval <osandov@fb.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <85B37FBF-4C3F-436B-8883-48E734967732@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com> <7A8A5078-E9B8-4EBF-BAB1-9E8EEBF3A043@linaro.org> <dd9501e9-5fc2-66d3-5c62-f8b727a6b6c9@fb.com> <CF1D593B-8BD0-4B59-9193-9D1D4E8BE3E4@linaro.org> <f5303f81-811a-8d0a-b271-d091d8839778@fb.com> <37570439-97C8-4009-B143-C5E78789A137@linaro.org> <b258d716-5c9a-c999-cec4-6bea38a8b975@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_BFBE3350-B7C8-4CD1-8EDC-E90BF0564F62
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

[RESENDING, BECAUSE OF REJECT FROM SERVERS]

> Il giorno 17 gen 2017, alle ore 03:47, Jens Axboe <axboe@fb.com =
<mailto:axboe@fb.com>> ha scritto:
>=20
> On 12/22/2016 08:28 AM, Paolo Valente wrote:
>>=20
>>> ...
>>>=20
>>=20
>> Problem: whereas it seems easy and safe to do somewhere else the
>> simple increment that was done in activate_request, I wonder if it =
may
>> happen that a request is deactivate before being completed.  In it =
may
>> happen, then, without a deactivate_request hook, the increments would
>> remain unbalanced.  Or are request completions always guaranteed till
>> no hw/sw components breaks?
>=20
> You should be able to do it in get/put_request. But you might need =
some
> extra tracking, I'd need to double check.

Exactly, AFAICT something extra is apparently needed.  In particular,
get is not ok, because dispatch is a different event (but dispatch is
however an already controlled event), while put could be used,
provided that it is guaranteed to be executed only after dispatch.  If
it is not, then I think that an extra flag or something should be
added to the request.  I don't know whether adding this extra piece
would be worst than adding an extra hook.

> I'm trying to avoid adding
> hooks that we don't truly need, the old interface had a lot of that. =
If
> you find that you need a hook and it isn't there, feel free to add it.
> activate/deactivate might be a good change.
>=20

If my comments above do not trigger any proposal of a better solution,
then I will try by adding only one extra 'deactivate' hook.  Unless
unbalanced hooks are a bad idea too.

Thanks,
Paolo

> --=20
> Jens Axboe


--Apple-Mail=_BFBE3350-B7C8-4CD1-8EDC-E90BF0564F62
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"><meta http-equiv=3D"Content-Type" content=3D"text/html=
 charset=3Dus-ascii"><meta http-equiv=3D"Content-Type" =
content=3D"text/html charset=3Dwindows-1252"></head><body =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D"">[RESENDING, BECAUSE =
OF REJECT FROM SERVERS]<div class=3D""><br class=3D""><div =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">Il =
giorno 17 gen 2017, alle ore 03:47, Jens Axboe &lt;<a =
href=3D"mailto:axboe@fb.com" class=3D"">axboe@fb.com</a>&gt; ha =
scritto:</div><br class=3D"Apple-interchange-newline"><div =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">On 12/22/2016 08:28 AM, Paolo Valente =
wrote:</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">...<br class=3D""><br =
class=3D""></blockquote><br class=3D"">Problem: whereas it seems easy =
and safe to do somewhere else the<br class=3D"">simple increment that =
was done in activate_request, I wonder if it may<br class=3D"">happen =
that a request is deactivate before being completed. &nbsp;In it may<br =
class=3D"">happen, then, without a deactivate_request hook, the =
increments would<br class=3D"">remain unbalanced. &nbsp;Or are request =
completions always guaranteed till<br class=3D"">no hw/sw components =
breaks?<br class=3D""></blockquote><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">You should be able to do it in =
get/put_request. But you might need some</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">extra tracking, I'd need to double =
check.</span></div></blockquote><div class=3D""><div class=3D""><br =
class=3D""></div><div class=3D""><div class=3D""><div class=3D""><div =
class=3D""><div class=3D""><div class=3D"">Exactly, AFAICT something =
extra is apparently needed. &nbsp;In particular,</div><div class=3D"">get =
is not ok, because dispatch is a different event (but dispatch =
is</div><div class=3D"">however an already controlled event), while put =
could be used,</div><div class=3D"">provided that it is guaranteed to be =
executed only after dispatch. &nbsp;If</div><div class=3D"">it is not, =
then I think that an extra flag or something should be</div><div =
class=3D"">added to the request. &nbsp;I don't know whether adding this =
extra piece</div><div class=3D"">would be worst than adding an extra =
hook.</div><div class=3D""><br =
class=3D""></div></div></div></div></div></div></div></div><div =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D""> I'm trying to avoid adding</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">hooks that we don't =
truly need, the old interface had a lot of that. If</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">you find that you =
need a hook and it isn't there, feel free to add it.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">activate/deactivate =
might be a good change.</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div class=3D""><div class=3D""><br =
class=3D""></div><div class=3D"">If my comments above do not trigger any =
proposal of a better solution,</div><div class=3D"">then I will try by =
adding only one extra 'deactivate' hook. &nbsp;Unless</div><div =
class=3D"">unbalanced hooks are a bad idea too.</div><div class=3D""><br =
class=3D""></div></div></div><div class=3D"">Thanks,</div><div =
class=3D"">Paolo</div><div class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D""><div class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">--<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">Jens =
Axboe</span></div></blockquote></div><br class=3D""></div></body></html>=

--Apple-Mail=_BFBE3350-B7C8-4CD1-8EDC-E90BF0564F62--
