Return-Path: <jdow@earthlink.net>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Michael Schmitz <schmitzmic@gmail.com>
Cc: Martin Steigerwald <martin@lichtvoll.de>, Jens Axboe <axboe@kernel.dk>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <2157764.1gpVE8K9i5@merkaba>
 <CAOmrzkLZCE7jPHVP0Et7L7=8UAAG80v7gpYrKpZVJADQz6PeaA@mail.gmail.com>
 <3488210.nMeMqUQulA@merkaba> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
From: jdow <jdow@earthlink.net>
Message-ID: <1737d3b4-ca33-8f59-8c01-fbd458bd2a84@earthlink.net>
Date: Thu, 28 Jun 2018 02:20:09 -0700
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 20180627 23:45, Geert Uytterhoeven wrote:
> Hi Michael,
> 
> On Thu, Jun 28, 2018 at 6:59 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 28.06.2018 um 09:20 schrieb Martin Steigerwald:
>>>>> And as stated in my other reply to the patch:
>>>>> partition needs 64 bit disk device support in AmigaOS or AmigaOS
>>>>> like
>>>>> operating systems (NSD64, TD64 or SCSI direct)
>>>>
>>>> I'd probably leave it at 'disk needs 64 bit disk device support on
>>>> native OS', and only print that warning once.
>>>
>>> This is fine with me.
>>
>> OK, I'll go with that.
> 
> Do we really need the warning?
> Once the parsing is fixed doing 64-bit math, it does not matter for Linux
> anymore.

Dual booting.
{^_^}
