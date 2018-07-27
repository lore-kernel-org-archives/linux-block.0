Return-Path: <axboe@kernel.dk>
Subject: Re: [Regression] Linux-Next Merge 25Jul2018 breaks mmc on Tegra.
To: Peter Geis <pgwipeout@gmail.com>, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <dacd3c28-2bfc-dd42-18a2-641217848126@gmail.com>
 <835eb17a-e192-d991-04b6-f0c82c32311e@kernel.dk>
 <f21ec2ef-7d88-117b-5dab-04c778a2d23a@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5a1c3316-8ec6-658d-c037-d45e385032c7@kernel.dk>
Date: Fri, 27 Jul 2018 13:31:20 -0600
MIME-Version: 1.0
In-Reply-To: <f21ec2ef-7d88-117b-5dab-04c778a2d23a@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/25/18 12:29 PM, Peter Geis wrote:
> On 07/25/2018 02:17 PM, Jens Axboe wrote:
>> On 7/25/18 10:28 AM, Peter Geis wrote:
>>> Good Afternoon,
>>>
>>> I have encountered an issue on both Tegra 2 and Tegra 3 devices
>>> accessing emmc following the 25 July 2018 remote tracking merge.
>>>
>>> The offending commit is:
>>> 6ce3dd6eec114930cf2035a8bcb1e80477ed79a8
>>> blk-mq: issue directly if hw queue isn't busy in case of 'none'.
>>
>> Can you try my current for-next? This should fix it:
>>
>> commit 8824f62246bef288173a6624a363352f0d4d3b09
>> Author: Ming Lei <ming.lei@redhat.com>
>> Date:   Sun Jul 22 14:10:15 2018 +0800
>>
>>      blk-mq: fail the request in case issue failure
>>
> 
> That commit made the current merge window, it must be reverted before 
> reverting the offending commit.
> 
> With that patch, the bug triggers then the kernel waits for the mmc to 
> recover. It seems however that the bug leaves the mmc in a zombie state, 
> where it is processing the previous command but the kernel has no 
> control over it.
> 
> [    4.233073] mmc0: Got command interrupt 0x00000001 even though no 
> command operation was in progress.
> [    4.242189] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    4.248616] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000001
> [    4.255041] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
> [    4.261465] mmc0: sdhci: Argument:  0x002e3b10 | Trn mode: 0x00000033
> [    4.267890] mmc0: sdhci: Present:   0x1ff70000 | Host ctl: 0x00000031
> [    4.274314] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [    4.280737] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> [    4.287162] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000002
> [    4.293586] mmc0: sdhci: Int enab:  0x02ff000b | Sig enab: 0x02fc000b
> [    4.300010] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
> [    4.306433] mmc0: sdhci: Caps:      0xe7ffd080 | Caps_1:   0x00000074
> [    4.312857] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00969696
> [    4.319281] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x04800e92
> [    4.325705] mmc0: sdhci: Resp[2]:   0x074b8000 | Resp[3]:  0x00000240
> [    4.332128] mmc0: sdhci: Host ctl2: 0x00000000
> [    4.336560] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xae2f9220
> [    4.342981] mmc0: sdhci: ============================================
> 
> Without that patch, it goes into a constant loop between reading/writing 
> and dumping errors until it finishes booting.

Ming??


-- 
Jens Axboe
