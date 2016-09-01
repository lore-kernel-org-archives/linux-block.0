Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:37917 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbcIAVs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2016 17:48:29 -0400
Received: by mail-it0-f52.google.com with SMTP id c198so5419284ith.1
        for <linux-block@vger.kernel.org>; Thu, 01 Sep 2016 14:48:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGA4w7nO+mrRwY-Rg0i_O8zBcrNeSS0KurLXN34duR2JJqvEmA@mail.gmail.com>
References: <CAGA4w7nO+mrRwY-Rg0i_O8zBcrNeSS0KurLXN34duR2JJqvEmA@mail.gmail.com>
From: Alex Austin <aaustin@oceantechonline.com>
Date: Thu, 1 Sep 2016 16:48:28 -0500
Message-ID: <CAGA4w7=eM9+sHMNaCXx5tXCEEyeJp0wb7ZqpAiuW35u+PEiSBw@mail.gmail.com>
Subject: Re: Block-level access
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CC'ing linux-scsi and linux-block.

Also, please CC me in replies.

On Thu, Sep 1, 2016 at 4:43 PM, Alex Austin <aaustin@oceantechonline.com> wrote:
> Hello,
> What is the most performant way to directly interface with an attached hard
> drive? I've so far used read()/write() on /dev/sd_ but I find error handling
> exceedingly difficult, as I don't always even get errors reported, even if the
> open() call includes O_DIRECT. I've also used ioctl(SG_IO), but find that it's
> extremely slow due to the lack of queuing support in the API. Is there a
> mid-level API that will get me decent error handling while allowing command
> queuing, or do I just need to make multiple threads all doing separate SG_IO
> ioctls?
>
> Thank you,
> - Alex Austin
>
> --
> Intelligence is knowing that a tomato is a fruit; wisdom is knowing that it
> doesn't go in a fruit salad; charisma is selling a tomato-based fruit salad.



-- 
Intelligence is knowing that a tomoato is a fruit; wisdom is knowing
that it doesn't go in a fruit salad; charisma is selling a
tomato-based fruit salad.
