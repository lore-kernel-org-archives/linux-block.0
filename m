Return-Path: <bhelgaas@google.com>
MIME-Version: 1.0
In-Reply-To: <fa1eaadf-db72-a642-a917-3f633af2ca55@kernel.dk>
References: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
 <b41e8f74-007d-c818-4915-3ea3b7c229b5@fb.com> <fa1eaadf-db72-a642-a917-3f633af2ca55@kernel.dk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 24 Feb 2017 16:30:30 -0600
Message-ID: <CAErSpo5vBeEnn3N8jszteDB_2TsS1-8qyntuYCJkvV8kyCKPAQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] blk-mq: allocate blk_mq_tags and requests in
 correct node
To: Jens Axboe <axboe@kernel.dk>
Cc: Shaohua Li <shli@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Content-Type: multipart/alternative; boundary=001a1147c34c3619fa05494e4877
List-ID: <linux-block@vger.kernel.org>

--001a1147c34c3619fa05494e4877
Content-Type: text/plain; charset=UTF-8

On Fri, Feb 24, 2017 at 4:23 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 02/01/2017 12:09 PM, Jens Axboe wrote:
>> On 02/01/2017 09:53 AM, Shaohua Li wrote:
>>> blk_mq_tags/requests of specific hardware queue are mostly used in
>>> specific cpus, which might not be in the same numa node as disk. For
>>> example, a nvme card is in node 0. half hardware queue will be used by
>>> node 0, the other node 1.
>>
>> All three patches look good to me. Bjorn, to avoid complications, if
>> you can review/ack patch #2, then I will queue it up through the block
>> tree for 4.11.
>
> Bjorn, ping. You were CC'ed on the original patch three weeks ago.

Acked, sorry I missed it.

--001a1147c34c3619fa05494e4877
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Feb 24, 2017 at 4:23 PM, Jens Axboe &lt;<a=
 href=3D"mailto:axboe@kernel.dk">axboe@kernel.dk</a>&gt; wrote:<br>&gt; On =
02/01/2017 12:09 PM, Jens Axboe wrote:<br>&gt;&gt; On 02/01/2017 09:53 AM, =
Shaohua Li wrote:<br>&gt;&gt;&gt; blk_mq_tags/requests of specific hardware=
 queue are mostly used in<br>&gt;&gt;&gt; specific cpus, which might not be=
 in the same numa node as disk. For<br>&gt;&gt;&gt; example, a nvme card is=
 in node 0. half hardware queue will be used by<br>&gt;&gt;&gt; node 0, the=
 other node 1.<br>&gt;&gt;<br>&gt;&gt; All three patches look good to me. B=
jorn, to avoid complications, if<br>&gt;&gt; you can review/ack patch #2, t=
hen I will queue it up through the block<br>&gt;&gt; tree for 4.11.<br>&gt;=
<br>&gt; Bjorn, ping. You were CC&#39;ed on the original patch three weeks =
ago.<br><br><div>Acked, sorry I missed it.</div></div>

--001a1147c34c3619fa05494e4877--
