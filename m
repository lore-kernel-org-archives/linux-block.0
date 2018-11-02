Return-Path: <thomas@fjellstrom.ca>
From: Thomas Fjellstrom <thomas@fjellstrom.ca>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: recent issues with heavy delete's causing soft lockups
Date: Fri, 02 Nov 2018 12:25:04 -0600
Message-ID: <22668288.jsZX13hhXo@natasha>
In-Reply-To: <BE7DD8B0-3D16-4AAC-9B49-E809EA30A0B6@kernel.dk>
References: <2800911.LnhMzhikfW@natasha> <BE7DD8B0-3D16-4AAC-9B49-E809EA30A0B6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

On Saturday, October 27, 2018 1:20:10 PM MDT Jens Axboe wrote:
> On Oct 27, 2018, at 12:40 PM, Thomas Fjellstrom <thomas@fjellstrom.ca> 
wrote:
> > Hi
[snip explanation of problem]
> 
> Can you try 4.19? A patch went in since 4.18 that fixes a starvation issue
> around requeue conditions, which SATA is the one to most often hit.

Gave it a shot. with the vanila kernel from git linux-stable/v4.9. It was a 
bit of a pain as the amdgpu driver seems to be broken for my r9 390 on many 
kernels, including 4.19. Had to reconfigure to the radeon driver, which I must 
say seems to work a lot better than it used to.

At any rate, it doesn't seem to have helped a lot so far. I did end up adding 
"scsi_mod.use_blk_mq=0 dm_mod.use_blk_mq=0" to the default kernel boot command 
line in grub. It seems to have helped a little, but I haven't tested fully 
with a full delete of the build directory. haven't had time to sit and wait 
the 40+ minutes it takes to re build the entire thing. And I'm low enough on 
disk space that I can't easily make a copy of the 109GB build folder. I've got 
about 25GB free out of 780GB. I'll try and test some more soon.

> Jens


-- 
Thomas Fjellstrom
thomas@fjellstrom.ca
