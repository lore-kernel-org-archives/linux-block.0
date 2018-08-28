Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kashyap.desai@broadcom.com, loberman@redhat.com, osandov@fb.com, hch@lst.de,
 bart.vanassche@wdc.com, hare@suse.de, ming.lei@redhat.com
References: <20180828154727.3589-1-ianwmorrison@gmail.com>
 <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
 <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
 <1cbdba28-3ff5-2bbe-a2cf-b533249c6970@kernel.dk>
 <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk>
Date: Tue, 28 Aug 2018 10:13:50 -0600
MIME-Version: 1.0
In-Reply-To: <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/28/18 10:10 AM, Ian W MORRISON wrote:
> On Wed, 29 Aug 2018 at 02:09, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/28/18 10:07 AM, Ian W MORRISON wrote:
>>> On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
>>>>> Kernel oops when booting on Bay and Cherry Trail devices
>>>>> such as Intel Compute Stick. Bisected as:
>>>>>
>>>>> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
>>>>>
>>>>> This patch reverts the above commit.
>>>>
>>>> Did I miss the posting of that oops? Just curious where this is
>>>> going wrong. Not adverse to reverting, but I'd like to try to
>>>> understand the issue first.
>>>>
>>>> --
>>>> Jens Axboe
>>>>
>>>
>>> I've not been able to capture it however manually transcribing what is
>>> on the screen:
>>>
>>> mmc0: Got data interrupt 0x00000002 even though no data operation
>>>
>>> followed by:
>>>
>>> mmc0: sdhci: ============= SDHCI REGISTER DUMP ==============
>>>
>>> Do you want any specific register value or should I transcribe each
>>> (as I am working from an image taken at boot)?
>>
>> Just take a picture of the screen, that should be good enough.
>>
>> --
>> Jens Axboe
>>
> 
> Attached as requested.

Can you see if this patch helps?

https://marc.info/?l=linux-mmc&m=153485326025301&w=2

-- 
Jens Axboe
