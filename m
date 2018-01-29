Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block changes for 4.16-rc
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <5a2213b5-bc7f-da73-f566-886c38a6d3c9@kernel.dk>
 <CA+55aFyUYmkX44WBb7XNGp5rH=QijefA_GGG+mdKhznqR+7_rQ@mail.gmail.com>
 <354fd487-3eb2-84ea-ed32-02261b228d41@kernel.dk>
 <CA+55aFx3-2CFC_0BXtMC3kQ+nW_6aK2etyMi1AJks1m5z2W=qA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2f01d9a7-2788-00d2-c41f-11b9d6b991b0@kernel.dk>
Date: Mon, 29 Jan 2018 13:17:11 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFx3-2CFC_0BXtMC3kQ+nW_6aK2etyMi1AJks1m5z2W=qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/29/18 1:14 PM, Linus Torvalds wrote:
> On Mon, Jan 29, 2018 at 12:08 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Yes of course, I can switch to using signed tags for pull requests
>> for you.
> 
> Thanks. I don't actually know the maintainership status of kernel.dk.
> 
> You show up as the 'whois' contact, but I'm also assuming it doesn't
> have the same kind of fairly draconian access control as the
> kernel.org suite of sites, and I'm actively trying to make sure we
> either use signed tags or the kernel.org repos (and honestly, even
> with the kernel.org ones I tend to prefer signed tags).
> 
> Right now I only _require_ it for public hosting, but I'm trying to
> move to just signed tags being the default everywhere.

The box is sitting right next to me in my office, which is locked.  But
it's not kernel.org, and I don't have a dedicated sysadmin. My tree does
mirror to git.kernel.org, so they should be in sync (albeit with some
delay). If you're fine with signed tags on git.kernel.dk, I'd prefer
continue using that, but just signing the pull requests.

I sign all fio releases with the same key, so it'd be trivial for me to
just sign pulls as well.

-- 
Jens Axboe
