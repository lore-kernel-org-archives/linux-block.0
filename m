Return-Path: <jdow@earthlink.net>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Martin Steigerwald <martin@lichtvoll.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <3488210.nMeMqUQulA@merkaba> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <1604984.EVDKEPedqG@merkaba>
 <CAMuHMdU40oRv+2GE_kWj3MQeEfOyy8efMnP_=Pkbn5bQxuBBSA@mail.gmail.com>
From: jdow <jdow@earthlink.net>
Message-ID: <8874239d-2c8e-ea8c-b023-691b49c51450@earthlink.net>
Date: Thu, 28 Jun 2018 02:34:18 -0700
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU40oRv+2GE_kWj3MQeEfOyy8efMnP_=Pkbn5bQxuBBSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 20180628 00:39, Geert Uytterhoeven wrote:
> Hi Martin,
> 
> On Thu, Jun 28, 2018 at 9:29 AM Martin Steigerwald <martin@lichtvoll.de> wrote:
>> Michael Schmitz - 28.06.18, 06:58:
>> […]
>>>>> In the interest of least surprises, we have to fix the 32 bit
>>>>> overflow (so we can even detect that it would have happened), and
>>>>> give the user the chance to carefully consider whether to accept
>>>>> the new behaviour. That means refusing to make available any
>>>>> partition that would have been affected by such overflow.
>>>>
>>>> That is acceptable for me as I told before. Either mount or refuse
>>>> to
>>>> mount, but do not overflow and mount nonetheless :)
>>>>
>>>> Mind you, I am not using my Amiga machines either at the moment. And
>>>> I repurposed the 2 TB disk years ago.
>>>
>>> That's fine - I understand the 'profile' image was a true binary copy
>>> of the RDB, and placing that file at offset 0 in an image file is a
>>> legitimate use?
>>
>> You actually ask me to remember about what that 'profile' image was? :)
>>
>> Well, in the attachment note on the bug report I wrote: "should be just
>> a binary copy", so I did not know exactly back then either. However the
>> file starts with "RDSK" and then it has "PART" headers and so on. That
>> looks pretty much like a binary copy of an RDB. I am a bit surprised by
>> its small size of 2 KiB. But I see three partitions in there. According
>> to the screenshot I also provided, the disk had three partitions. So
>> probably Media Toolbox has been intelligent enough to just copy the used
>> space of the reserved RDB area. Cause I think the reserved space must
>> have been higher than 2 KiB. However the RDB/disk geometry editing
>> screen does not display it and off hand I do not know where to look
>> inside the RDB to see how much space has been reserved. Interestingly
>> the "Total sectors" value in that Media Toolbox window also overflowed.
> 
> The RDB can be anywhere in the first 2 tracks of the disk, and is identified
> by the "RDSK" block (with a correct checksum). The remainder (e.g. "PART"
> blocks) is in a linked list. So 2 KiB sounds fine for 3 partitions (1 RDSK +
> 3 * PART = 4 blocks = 4 * 512 bytes).

The RDB can be anywhere in the first 16 blocks on the disk if we are speaking 
officially. That's the entire area that is guaranteed to be inspected for an 
RDSK block. The PART block can, I think, even be located in front of the RDSK if 
you want to be obscene about it. {^_-} That's the kind of thing I checked with 
the HardFrame device driver ROM image. I preferred block 3 to keep it away from 
the space used by other partitioning schemes. It also enabled me to embed it a 
reserved area within the first actual partition just for the halibut. (Pronounce 
it sideways and it makes more sense.) I used that technique fairly often. If you 
think about it that gives you a wee tiny bit more disk space because you can 
tailor the reserved area to precisely fit the filesystem image plus some extra 
in case of updates. I toyed with using a pointer to FDSK blocks in the Dev 
directory but that got too insane. RDBs are insanely flexible, which may not be 
a good thing.

{^_^}
