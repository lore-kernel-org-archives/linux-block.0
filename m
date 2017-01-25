Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34292 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdAYOXJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 09:23:09 -0500
Received: by mail-it0-f66.google.com with SMTP id o185so2067767itb.1
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2017 06:23:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485352053.5902.0@smtp.office365.com>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
 <1484949412-6903-4-git-send-email-jbacik@fb.com> <20170121090531.GB27048@kroah.com>
 <1485182528.9861.22@smtp.office365.com> <20170123145212.GA19582@kroah.com>
 <1485183472.21123.0@smtp.office365.com> <20170123150325.GB26884@kroah.com>
 <1485186762.21123.1@smtp.office365.com> <20170124071152.GB13251@kroah.com> <1485352053.5902.0@smtp.office365.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 Jan 2017 15:23:07 +0100
Message-ID: <CAK8P3a10K-8GwwcZLd4HwYHzxcB8cwww3y73np_Th65af7m6gQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] nbd: add a nbd-control interface
To: Josef Bacik <jbacik@fb.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, axboe@fb.com,
        nbd-general@lists.sourceforge.net, linux-block@vger.kernel.org,
        kernel-team@fb.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 25, 2017 at 2:47 PM, Josef Bacik <jbacik@fb.com> wrote:
> On Tue, Jan 24, 2017 at 2:11 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Mon, Jan 23, 2017 at 10:52:42AM -0500, Josef Bacik wrote:
>>>  On Mon, Jan 23, 2017 at 10:03 AM, Greg KH <gregkh@linuxfoundation.org>
>>>  Loop accomplishes this with the /dev/loop-control
>>>  and an ioctl.  Then we also need a way to figure out what is the first
>>>  /dev/nbd# device that isn't currently in use in order to pick the next
>>> one
>>>  to configure.  Keep in mind that all of the configuration for /dev/nbd#
>>>  devices is done through ioctls to those devices, so having a ioctl
>>> interface
>>>  for the control device is consistent with the rest of how NBD works.
>>
>>
>> But adding a random char device node and using ioctls on it is different
>> than using an ioctl on an existing block device node that is already
>> there.
>>
>> So what _exactly_ do you need to do with this interface?  What data do
>> you need sent/received to/from the kernel?  Specifics please.
>
>
> I need to say "Hey kernel, can you setup some new nbd devices for me?" and
> "Hey kernel, what is the first free nbd device I can use for this new
> connection and (optionally) create a new device for me if one does not
> exist?"  Loop accomplished this (in 2011 btw, not some far off date) with
> /dev/loop-control.  Btrfs has it's scanning stuff controlled by
> /dev/btrfs-control.  Device mapper has /dev/mapper/control.  This is a well
> established and widely used way for control block based device drivers.

We have multiple established ways to deal with this kind of problem, the most
common ones being a separate chardev as you propose, a sysfs interface and
netlink.

They all have their own set of problems, but the needs of nbd as a network
storage interface seem most closely resemble what we have for other network
related interfaces, where we typically use netlink to do the setup, see e.g.
macvtap as an example for a network chardev interface.

Can you have a look if that would solve your problem more nicely?

     Arnd
