Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [BUG] Deadlock in blk_mq_register_disk error path
To: Jinpu Wang <jinpu.wang@profitbricks.com>
References: <CAMGffEmw8ako59nAkDfpHWH06xAngkKR0YYpxF24LwZMjA9P2g@mail.gmail.com>
 <16bc5b4f-e217-969e-4f26-5f4b04705dcc@kernel.dk>
 <30d05b8b-7707-a0bf-f55b-65325f55b7d8@sandisk.com>
 <CAMGffE=D3yaxD1YgZLonJZ=C+eqoXnGdSNgdm7oOfkZev3RwMg@mail.gmail.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <4d764fbe-590c-26de-c70d-0120a28b7e68@sandisk.com>
Date: Mon, 15 Aug 2016 09:22:25 -0700
MIME-Version: 1.0
In-Reply-To: <CAMGffE=D3yaxD1YgZLonJZ=C+eqoXnGdSNgdm7oOfkZev3RwMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 08/15/2016 09:01 AM, Jinpu Wang wrote:
> It's more likely you hit another bug, my colleague Roman fix that:
>
> http://www.spinics.net/lists/linux-block/msg04552.html

Hello Jinpu,

Interesting. However, I see that wrote the following: "Firstly this 
wrong sequence raises two kernel warnings: 1st. WARNING at 
lib/percpu-recount.c:309 percpu_ref_kill_and_confirm called more than 
once 2nd. WARNING at lib/percpu-refcount.c:331". I haven't seen any of 
these kernel warnings ...

Thanks,

Bart.
