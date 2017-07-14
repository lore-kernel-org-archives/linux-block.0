Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36974 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbdGNFMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2017 01:12:43 -0400
Received: by mail-wm0-f47.google.com with SMTP id i127so11421744wma.0
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2017 22:12:43 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] elevator: allow specifying elevator by config boot param for blk-mq devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <49033d7d-8941-3c17-962f-dab170401bcf@kernel.dk>
Date: Fri, 14 Jul 2017 07:12:39 +0200
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Alex Ivanov <yourbestfriend@openmailbox.org>,
        linux-block@vger.kernel.org
Message-Id: <CB3E928A-5632-47E1-96BC-6DF39F480843@linaro.org>
References: <20170712185708.5987-1-yourbestfriend@openmailbox.org> <0661f4cc-a5dc-5747-dd38-de78586843a2@kernel.dk> <20170713101154.GH5212@linux-x5ow.site> <49033d7d-8941-3c17-962f-dab170401bcf@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 13 lug 2017, alle ore 16:02, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 07/13/2017 04:11 AM, Johannes Thumshirn wrote:
>> On Wed, Jul 12, 2017 at 04:51:33PM -0600, Jens Axboe wrote:
>>> No, that boot option was a mistake, let's not propagate that to mq
>>> scheduling as well.
>>=20
>> Can you please explain why? I as well have requests from our users to
>> select the mq schedulers on the command line.
>=20
> Because it sucks as an interface - there's no way to apply different
> settings to different devices, and using the kernel command line to
> control something like this is ugly. It never should have been done.
>=20
> The sysfs interface, either manually, scripted, or through udev,
> makes a lot more sense.
>=20

One doubt: with the new interface, and using, I guess, udev, is it
still possible to control which I/O scheduler is actually used during
all the boot process, or at least almost all of it?

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
