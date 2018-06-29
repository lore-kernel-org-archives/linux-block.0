Return-Path: <jdow@earthlink.net>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Michael Schmitz <schmitzmic@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Martin Steigerwald <martin@lichtvoll.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-m68k
 <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
 <3681004.ZGfTzPZDUK@merkaba>
 <CAMuHMdXqzQFTNjWrRrgUrEO5XVy+X_ztnnCEZo3vYXVCJp4n8w@mail.gmail.com>
 <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com>
From: jdow <jdow@earthlink.net>
Message-ID: <a0974de4-da1f-3991-8d44-4108a81a0014@earthlink.net>
Date: Fri, 29 Jun 2018 02:32:30 -0700
MIME-Version: 1.0
In-Reply-To: <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 20180629 01:42, Michael Schmitz wrote:
> Hi Geert,
> 
> 
> Am 28.06.18 um 21:25 schrieb Geert Uytterhoeven:
>>
>>>> Do we really need the warning?
>>>> Once the parsing is fixed doing 64-bit math, it does not matter for
>>>> Linux anymore.
>>> Well, irony of this is: In my case the RDB has been created on a machine
>>> with a native OS. So Linux warns me about something I already did so on
>>> the native OS without any warning. In this case AmigaOS 4.0.
>> Exactly.
>>
>> So moving a disk partitioned under AmigaOS 4.0 to a system running an
>> older version of AmigaOS can fail miserably. Not a Linux issue.
>> Linux also doesn't warn about disks with GPT failing to work on old MSDOS.
> 
> Would MSDOS recognize the GPT partition as 'probably FAT', and attempt
> to use it?

I believe it would fail to mount it and suggest formatting it. The key is to 
fail the mount and not risk damage to the data on it.

>> Let me clarify: what exactly would the kernel option allow? When to use it?
> 
> Whether to use it if safe (on Linux). But whatever Linux does (after
> this patch), access will go to the right area of the disk (as specified
> by the RDB) so Linux won't any longer stomp on anything that would have
> mattered to 32 bit disk drivers. So it really should be safe.

Martin pointed out something privately about RDBs I'd forgotten over the 
archeological eras gone past. The RDB values are all 32 bit unsigned longs. That 
means as long as they are properly promoted AND the file system does not barf 
from a gross overfeeding disks up to about 2^128 bytes can be supported. But you 
need a new uint128_t datatype. So for Amigas or Linux the real limitation is the 
data type and significance that flows between the RDB parser and the file 
system. That is the value that has to be considered. Then if the filesystem 
somewhere inside coughs up a hairball over some internal overflow or other and 
cannot accept say a full uint64_t maximum value of bytes with grace and polish 
it should error out when it sees an incoming disk positions off its internally 
acceptable range.

This means that any errors and failures to mount should lie with the RDB Parser, 
the filesystem, the device driver, and any intervening code between the three. 
The RDBs can express a value far greater than the number of atoms estimated to 
exist in the observable universe. So RDBs won't ever need a change for disk size 
considerations. The parser and filesystems probably and possibly, respectively, 
will.

Error out and don't mount disks or partitions that are outside the size range 
your element of the datapath from disk to user's program can handle at the first 
place this can be detected. It's the polite thing to do to a user's data rather 
than the Maxine Waters thing to do.

{^_^}
