Return-Path: <jinpu.wang@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <4d764fbe-590c-26de-c70d-0120a28b7e68@sandisk.com>
References: <CAMGffEmw8ako59nAkDfpHWH06xAngkKR0YYpxF24LwZMjA9P2g@mail.gmail.com>
 <16bc5b4f-e217-969e-4f26-5f4b04705dcc@kernel.dk> <30d05b8b-7707-a0bf-f55b-65325f55b7d8@sandisk.com>
 <CAMGffE=D3yaxD1YgZLonJZ=C+eqoXnGdSNgdm7oOfkZev3RwMg@mail.gmail.com> <4d764fbe-590c-26de-c70d-0120a28b7e68@sandisk.com>
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Tue, 16 Aug 2016 10:18:54 +0200
Message-ID: <CAMGffEncuGm77r8OD3EQRCX3sJHY7swbFHod05rt9BGWvkazJw@mail.gmail.com>
Subject: Re: [BUG] Deadlock in blk_mq_register_disk error path
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 15, 2016 at 6:22 PM, Bart Van Assche
<bart.vanassche@sandisk.com> wrote:
> On 08/15/2016 09:01 AM, Jinpu Wang wrote:
>>
>> It's more likely you hit another bug, my colleague Roman fix that:
>>
>> http://www.spinics.net/lists/linux-block/msg04552.html
>
>
> Hello Jinpu,
>
> Interesting. However, I see that wrote the following: "Firstly this wrong
> sequence raises two kernel warnings: 1st. WARNING at
> lib/percpu-recount.c:309 percpu_ref_kill_and_confirm called more than onc=
e
> 2nd. WARNING at lib/percpu-refcount.c:331". I haven't seen any of these
> kernel warnings ...
>
> Thanks,
>
> Bart.
>

The warning happened from time to time, but your hung tasks are
similar with ours.
We injected some delay in order to reproduce easily.


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Best Regards,

Jack Wang

Linux Kernel Developer Storage
ProfitBricks GmbH  The IaaS-Company.

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin
Tel: +49 30 5770083-42
Fax: +49 30 5770085-98
Email: jinpu.wang@profitbricks.com
URL: http://www.profitbricks.de

Sitz der Gesellschaft: Berlin.
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B.
Gesch=C3=A4ftsf=C3=BChrer: Andreas Gauger, Achim Weiss.
