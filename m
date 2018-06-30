Return-Path: <jdow@earthlink.net>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Michael Schmitz <schmitzmic@gmail.com>,
 Martin Steigerwald <martin@lichtvoll.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <CAMuHMdXqkQLtcUFxxhMYiGxMfLyuYVSxFfOpnu7_qn3+0eOt=w@mail.gmail.com>
 <76bf5b8d-6ee1-8e77-4c2a-e0b5a095992b@gmail.com> <2499668.52U9LxLmUp@merkaba>
 <e52c09b3-da8e-6c20-aea0-f9a8f28c6736@gmail.com>
From: jdow <jdow@earthlink.net>
Message-ID: <a72b639f-cc75-c65f-4ebf-465585fe8785@earthlink.net>
Date: Fri, 29 Jun 2018 17:49:24 -0700
MIME-Version: 1.0
In-Reply-To: <e52c09b3-da8e-6c20-aea0-f9a8f28c6736@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 20180629 16:24, Michael Schmitz wrote:
 > Martin,
 >
 >
...
 > The problem that still remains is with unpatched legacy versions. RDB
 > does support large enough partitions out of the box, due to C/H/S all
 > using u32. We all agree there. The question is with file systems and

Nope, I bothered to read the source code includes files. As long as anything in 
the OS uses the blocks per cylinder variables in various structures you're SOL. 
rdb_CylinderBlocks is just for starters. The GlobalVec entry also includes a 
CylinderBlocks entry. And it's only uint32_t size.

As I say, good luck gentlemen. Changes, big changes, probably need to be made to 
go beyond 2TB except by using larger block sizes. But, 64k block sizes are sort 
of "putrid" to say the least.

{^_^}
