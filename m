Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] lightnvm: pblk fix for 4.13
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>, mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
References: <1501247596-23999-1-git-send-email-javier@javigon.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <924b7b4b-78ee-80d8-ed35-7f41b4d60a91@kernel.dk>
Date: Fri, 28 Jul 2017 08:06:52 -0600
MIME-Version: 1.0
In-Reply-To: <1501247596-23999-1-git-send-email-javier@javigon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/28/2017 07:13 AM, Javier González wrote:
> Hi Jens,
> 
> Can you pick up this fix for 4.13? It is a fix to a read corruption in
> pblk that has been there form the beginning. It is due to a bad bio
> manipulation in the case that an I/O containing lbas that are invalid,
> point to data in the host cache and point to data on the device, all
> three in a single bio.
> 
> The patch applies on top of you for-4.13/block and is available too at:
>   - https://github.com/OpenChannelSSD/linux/tree/pblk.for-4.13
> 
> I marked the patch to fix the original pblk commit, but it does not
> apply anymore on the original 4.12 code. How do we handle these
> situations? We make a backport when Greg makes 4.12 stable?

Greg will email you if it doesn't apply, then you can reply back
with a version that does apply against 4.12.

Applied for 4.13.

-- 
Jens Axboe
