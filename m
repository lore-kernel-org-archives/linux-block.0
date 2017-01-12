Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:14016
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750791AbdALVQt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 16:16:49 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCHSET v6] blk-mq scheduling framework
Date: Thu, 12 Jan 2017 21:16:38 +0000
Message-ID: <1484255784.2720.11.camel@sandisk.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-1-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-11 at 14:39 -0700, Jens Axboe wrote:
> I've reworked bits of this to get rid of the shadow requests, thanks
> to Bart for the inspiration. The missing piece, for me, was the fact
> that we have the tags->rqs[] indirection array already. I've done this
> somewhat differently, though, by having the internal scheduler tag
> map be allocated/torn down when an IO scheduler is attached or
> detached. This also means that when we run without a scheduler, we
> don't have to do double tag allocations, it'll work like before.

Hello Jens,

Thanks for having done the rework!=A0This series looks great to me. I have =
a
few small comments though. I will post these as replies to the individual
patches.

Bart.=
