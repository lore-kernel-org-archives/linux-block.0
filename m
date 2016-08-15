Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [BUG] Deadlock in blk_mq_register_disk error path
To: Jens Axboe <axboe@kernel.dk>, Jinpu Wang <jinpu.wang@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <CAMGffEmw8ako59nAkDfpHWH06xAngkKR0YYpxF24LwZMjA9P2g@mail.gmail.com>
 <16bc5b4f-e217-969e-4f26-5f4b04705dcc@kernel.dk>
 <30d05b8b-7707-a0bf-f55b-65325f55b7d8@sandisk.com>
 <3a22a49b-9382-710e-028e-f64a9b6f5a27@kernel.dk>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <dd9decad-32d3-7ae4-1562-72a51093f948@sandisk.com>
Date: Mon, 15 Aug 2016 10:41:32 -0700
MIME-Version: 1.0
In-Reply-To: <3a22a49b-9382-710e-028e-f64a9b6f5a27@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 08/15/2016 10:15 AM, Jens Axboe wrote:
> Can you reproduce at will? Would be nice to know if it hit the error case,
> which is where it would hang.

Hello Jens,

Unfortunately this hang is only triggered sporadically by my tests. 
Since about four weeks ago I triggered several thousand 
scsi_remove_host() calls with my https://github.com/bvanassche/srp-test 
software. This morning was the first time that I ran into a blk-mq 
related hang.

Thanks,

Bart.
