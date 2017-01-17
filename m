Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: multipart/alternative; boundary="Apple-Mail=_6B3EFF0F-ABFB-4343-9E56-63E4588324D9"
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHSET v4] blk-mq-scheduling framework
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <b258d716-5c9a-c999-cec4-6bea38a8b975@fb.com>
Date: Tue, 17 Jan 2017 11:43:06 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Omar Sandoval <osandov@fb.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <67AAE551-3C8E-469A-BB29-10396025EE4C@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com> <7A8A5078-E9B8-4EBF-BAB1-9E8EEBF3A043@linaro.org> <dd9501e9-5fc2-66d3-5c62-f8b727a6b6c9@fb.com> <CF1D593B-8BD0-4B59-9193-9D1D4E8BE3E4@linaro.org> <f5303f81-811a-8d0a-b271-d091d8839778@fb.com> <37570439-97C8-4009-B143-C5E78789A137@linaro.org> <b258d716-5c9a-c999-cec4-6bea38a8b975@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_6B3EFF0F-ABFB-4343-9E56-63E4588324D9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


> Il giorno 17 gen 2017, alle ore 03:47, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> On 12/22/2016 08:28 AM, Paolo Valente wrote:
>>=20
>>> Il giorno 19 dic 2016, alle ore 22:05, Jens Axboe <axboe@fb.com> ha =
scritto:
>>>=20
>>> On 12/19/2016 11:21 AM, Paolo Valente wrote:
>>>>=20
>>>>> Il giorno 19 dic 2016, alle ore 16:20, Jens Axboe <axboe@fb.com> =
ha scritto:
>>>>>=20
>>>>> On 12/19/2016 04:32 AM, Paolo Valente wrote:
>>>>>>=20
>>>>>>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> =
ha scritto:
>>>>>>>=20
>>>>>>> This is version 4 of this patchset, version 3 was posted here:
>>>>>>>=20
>>>>>>> https://marc.info/?l=3Dlinux-block&m=3D148178513407631&w=3D2
>>>>>>>=20
>>>>>>> =46rom the discussion last time, I looked into the feasibility =
of having
>>>>>>> two sets of tags for the same request pool, to avoid having to =
copy
>>>>>>> some of the request fields at dispatch and completion time. To =
do that,
>>>>>>> we'd have to replace the driver tag map(s) with our own, and =
augment
>>>>>>> that with tag map(s) on the side representing the device queue =
depth.
>>>>>>> Queuing IO with the scheduler would allocate from the new map, =
and
>>>>>>> dispatching would acquire the "real" tag. We would need to =
change
>>>>>>> drivers to do this, or add an extra indirection table to map a =
real
>>>>>>> tag to the scheduler tag. We would also need a 1:1 mapping =
between
>>>>>>> scheduler and hardware tag pools, or additional info to track =
it.
>>>>>>> Unless someone can convince me otherwise, I think the current =
approach
>>>>>>> is cleaner.
>>>>>>>=20
>>>>>>> I wasn't going to post v4 so soon, but I discovered a bug that =
led
>>>>>>> to drastically decreased merging. Especially on rotating =
storage,
>>>>>>> this release should be fast, and on par with the merging that we
>>>>>>> get through the legacy schedulers.
>>>>>>>=20
>>>>>>=20
>>>>>> I'm to modifying bfq.  You mentioned other missing pieces to =
come.  Do
>>>>>> you already have an idea of what they are, so that I am somehow
>>>>>> prepared to what won't work even if my changes are right?
>>>>>=20
>>>>> I'm mostly talking about elevator ops hooks that aren't there in =
the new
>>>>> framework, but exist in the old one. There should be no hidden
>>>>> surprises, if that's what you are worried about.
>>>>>=20
>>>>> On the ops side, the only ones I can think of are the activate and
>>>>> deactivate, and those can be done in the dispatch_request hook for
>>>>> activate, and put/requeue for deactivate.
>>>>>=20
>>>>=20
>>>> You mean that there is no conceptual problem in moving the code of =
the
>>>> activate interface function into the dispatch function, and the =
code
>>>> of the deactivate into the put_request? (for a requeue it is a =
little
>>>> less clear to me, so one step at a time)  Or am I missing
>>>> something more complex?
>>>=20
>>> Yes, what I mean is that there isn't a 1:1 mapping between the old =
ops
>>> and the new ops. So you'll have to consider the cases.
>>>=20
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


--Apple-Mail=_6B3EFF0F-ABFB-4343-9E56-63E4588324D9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">Il giorno 17 gen 2017, alle ore 03:47, Jens Axboe &lt;<a =
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
class=3D""><blockquote type=3D"cite" class=3D"">Il giorno 19 dic 2016, =
alle ore 22:05, Jens Axboe &lt;<a href=3D"mailto:axboe@fb.com" =
class=3D"">axboe@fb.com</a>&gt; ha scritto:<br class=3D""><br =
class=3D"">On 12/19/2016 11:21 AM, Paolo Valente wrote:<br =
class=3D""><blockquote type=3D"cite" class=3D""><br class=3D""><blockquote=
 type=3D"cite" class=3D"">Il giorno 19 dic 2016, alle ore 16:20, Jens =
Axboe &lt;<a href=3D"mailto:axboe@fb.com" class=3D"">axboe@fb.com</a>&gt; =
ha scritto:<br class=3D""><br class=3D"">On 12/19/2016 04:32 AM, Paolo =
Valente wrote:<br class=3D""><blockquote type=3D"cite" class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">Il giorno 17 dic 2016, =
alle ore 01:12, Jens Axboe &lt;<a href=3D"mailto:axboe@fb.com" =
class=3D"">axboe@fb.com</a>&gt; ha scritto:<br class=3D""><br =
class=3D"">This is version 4 of this patchset, version 3 was posted =
here:<br class=3D""><br class=3D""><a =
href=3D"https://marc.info/?l=3Dlinux-block&amp;m=3D148178513407631&amp;w=3D=
2" =
class=3D"">https://marc.info/?l=3Dlinux-block&amp;m=3D148178513407631&amp;=
w=3D2</a><br class=3D""><br class=3D"">=46rom the discussion last time, =
I looked into the feasibility of having<br class=3D"">two sets of tags =
for the same request pool, to avoid having to copy<br class=3D"">some of =
the request fields at dispatch and completion time. To do that,<br =
class=3D"">we'd have to replace the driver tag map(s) with our own, and =
augment<br class=3D"">that with tag map(s) on the side representing the =
device queue depth.<br class=3D"">Queuing IO with the scheduler would =
allocate from the new map, and<br class=3D"">dispatching would acquire =
the "real" tag. We would need to change<br class=3D"">drivers to do =
this, or add an extra indirection table to map a real<br class=3D"">tag =
to the scheduler tag. We would also need a 1:1 mapping between<br =
class=3D"">scheduler and hardware tag pools, or additional info to track =
it.<br class=3D"">Unless someone can convince me otherwise, I think the =
current approach<br class=3D"">is cleaner.<br class=3D""><br class=3D"">I =
wasn't going to post v4 so soon, but I discovered a bug that led<br =
class=3D"">to drastically decreased merging. Especially on rotating =
storage,<br class=3D"">this release should be fast, and on par with the =
merging that we<br class=3D"">get through the legacy schedulers.<br =
class=3D""><br class=3D""></blockquote><br class=3D"">I'm to modifying =
bfq. &nbsp;You mentioned other missing pieces to come. &nbsp;Do<br =
class=3D"">you already have an idea of what they are, so that I am =
somehow<br class=3D"">prepared to what won't work even if my changes are =
right?<br class=3D""></blockquote><br class=3D"">I'm mostly talking =
about elevator ops hooks that aren't there in the new<br =
class=3D"">framework, but exist in the old one. There should be no =
hidden<br class=3D"">surprises, if that's what you are worried about.<br =
class=3D""><br class=3D"">On the ops side, the only ones I can think of =
are the activate and<br class=3D"">deactivate, and those can be done in =
the dispatch_request hook for<br class=3D"">activate, and put/requeue =
for deactivate.<br class=3D""><br class=3D""></blockquote><br =
class=3D"">You mean that there is no conceptual problem in moving the =
code of the<br class=3D"">activate interface function into the dispatch =
function, and the code<br class=3D"">of the deactivate into the =
put_request? (for a requeue it is a little<br class=3D"">less clear to =
me, so one step at a time) &nbsp;Or am I missing<br class=3D"">something =
more complex?<br class=3D""></blockquote><br class=3D"">Yes, what I mean =
is that there isn't a 1:1 mapping between the old ops<br class=3D"">and =
the new ops. So you'll have to consider the cases.<br class=3D""><br =
class=3D""><br class=3D""></blockquote><br class=3D"">Problem: whereas =
it seems easy and safe to do somewhere else the<br class=3D"">simple =
increment that was done in activate_request, I wonder if it may<br =
class=3D"">happen that a request is deactivate before being completed. =
&nbsp;In it may<br class=3D"">happen, then, without a deactivate_request =
hook, the increments would<br class=3D"">remain unbalanced. &nbsp;Or are =
request completions always guaranteed till<br class=3D"">no hw/sw =
components breaks?<br class=3D""></blockquote><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
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
check.</span></div></blockquote><div><div><br =
class=3D""></div><div><div><div><div><div><div>Exactly, AFAICT something =
extra is apparently needed. &nbsp;In particular,</div><div>get is not =
ok, because dispatch is a different event (but dispatch =
is</div><div>however an already controlled event), while put could be =
used,</div><div>provided that it is guaranteed to be executed only after =
dispatch. &nbsp;If</div><div>it is not, then I think that an extra flag =
or something should be</div><div>added to the request. &nbsp;I don't =
know whether adding this extra piece</div><div>would be worst than =
adding an extra hook.</div><div class=3D""><br =
class=3D""></div></div></div></div></div></div></div></div><div><blockquot=
e type=3D"cite" class=3D""><div class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D""> I'm trying to =
avoid adding</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">hooks that we don't truly need, the old =
interface had a lot of that. If</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">you find that you need a hook and it =
isn't there, feel free to add it.</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">activate/deactivate might be a good =
change.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><div><br class=3D""></div><div>If my =
comments above do not trigger any proposal of a better =
solution,</div><div>then I will try by adding only one extra =
'deactivate' hook. &nbsp;Unless</div><div>unbalanced hooks are a bad =
idea too.</div><div class=3D""><br =
class=3D""></div></div></div><div>Thanks,</div><div>Paolo</div><div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">--<span =
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
Axboe</span></div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_6B3EFF0F-ABFB-4343-9E56-63E4588324D9--
