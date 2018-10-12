Return-Path: <ecashin@gmail.com>
MIME-Version: 1.0
References: <20181011165909.32615-1-axboe@kernel.dk> <20181011165909.32615-15-axboe@kernel.dk>
 <CADvA-dnKCWSBZsmtnG=w_iAfU-aFxEq9oi_z_XV044648GYejA@mail.gmail.com> <fee272b4-4f75-4b70-fa32-1143bd34f6af@kernel.dk>
In-Reply-To: <fee272b4-4f75-4b70-fa32-1143bd34f6af@kernel.dk>
From: Ed Cashin <ed.cashin@acm.org>
Date: Fri, 12 Oct 2018 12:17:08 -0400
Message-ID: <CADvA-dnUNB7UcaiXbbYS_VF22Po5h52MHwYCGP5+44isZ=duAw@mail.gmail.com>
Subject: Re: [PATCH 14/17] aoe: convert aoeblk to blk-mq
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, "Ed L. Cashin" <ed.cashin@acm.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 12, 2018 at 10:20 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/12/18 5:28 AM, Ed Cashin wrote:
> > OK.  We always tried to avoid putting includes in the .h file, so
> > if you wouldn't mind moving the include to the C files, that would
> > be nice.  I wouldn't insist, though.
>
> There's really no way around it, since I'm embedding the tag_set
> in the device.
>
> Is that OK with you?

Yes, it's fine.  Thank you.
