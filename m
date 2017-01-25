Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35636 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbdAYSYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 13:24:33 -0500
Received: by mail-qt0-f176.google.com with SMTP id x49so30886280qtc.2
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2017 10:24:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAK8P3a10K-8GwwcZLd4HwYHzxcB8cwww3y73np_Th65af7m6gQ@mail.gmail.com>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
 <1484949412-6903-4-git-send-email-jbacik@fb.com> <20170121090531.GB27048@kroah.com>
 <1485182528.9861.22@smtp.office365.com> <20170123145212.GA19582@kroah.com>
 <1485183472.21123.0@smtp.office365.com> <20170123150325.GB26884@kroah.com>
 <1485186762.21123.1@smtp.office365.com> <20170124071152.GB13251@kroah.com>
 <1485352053.5902.0@smtp.office365.com> <CAK8P3a10K-8GwwcZLd4HwYHzxcB8cwww3y73np_Th65af7m6gQ@mail.gmail.com>
From: Paul Clements <paul.clements@us.sios.com>
Date: Wed, 25 Jan 2017 13:24:32 -0500
Message-ID: <CAECXXi5kuv1=kwZGj9c86GxTCw2HA5VDYsWggRXhD1oqFarOCA@mail.gmail.com>
Subject: Re: [Nbd] [PATCH 4/4] nbd: add a nbd-control interface
To: Arnd Bergmann <arnd@arndb.de>
Cc: Josef Bacik <jbacik@fb.com>, axboe@fb.com,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@fb.com,
        linux-block@vger.kernel.org,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 25, 2017 at 9:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> They all have their own set of problems, but the needs of nbd as a network
> storage interface seem most closely resemble what we have for other network
> related interfaces, where we typically use netlink to do the setup, see e.g.
> macvtap as an example for a network chardev interface.

But nbd is a virtual block device, first and foremost. That means it
is very similar to both loop (Pavel began nbd as a copy of loop, I
believe) and device mapper.

Also, it uses ioctls for all configuration and administration currently.

--
Paul
