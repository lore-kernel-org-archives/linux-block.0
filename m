Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Remove leading whitespace and trailing newline in
 elevator switch error message
To: "markus@trippelsdorf.de" <markus@trippelsdorf.de>
References: <20170506052243.GB291@x4>
 <TU4PR84MB03040339EFF3AB676CBD1382ABEF0@TU4PR84MB0304.NAMPRD84.PROD.OUTLOOK.COM>
 <27B041E0-D0FD-4072-ADAA-B36EDC8D09C0@kernel.dk> <20170509044209.GB17152@x4>
Cc: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>,
 Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5fa0d1bd-bf5c-0b5b-0c3f-ca138a06de5e@kernel.dk>
Date: Tue, 9 May 2017 08:57:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170509044209.GB17152@x4>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/08/2017 10:42 PM, markus@trippelsdorf.de wrote:
> On 2017.05.08 at 20:22 -0600, Jens Axboe wrote:
>>
>>> On May 8, 2017, at 8:18 PM, Elliott, Robert (Persistent Memory)
>>> <elliott@hpe.com> wrote:
>>>> +        printk(KERN_ERR "elevator: type %s not found\n", name);
>>> ...
>>>> +    printk(KERN_ERR "elevator: switch to %s failed\n",
>>>
>>> That leaves two lines of error prints for a single error, and
>>> the second line doesn't convey additional information.
>>
>> Yeah good point. Honestly I think we should just kill both lines. None
>> of them add value. 
> 
> They at least help debugging of udev rules, e.g. on Gentoo they have:
> 
>  # set noop on solid state drives
>  SUBSYSTEM=="block", ACTION=="add", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="noop"
> 
> And this will of course fail for mq. But how will you notice it without
> any dmesg error message?

The echo to the sysfs file fails. udev should report such failures. Using
dmesg as the channel to report and discover errors like that is not a
great idea, and it was a mistake to put that code in the switch path
in the first place.

-- 
Jens Axboe
