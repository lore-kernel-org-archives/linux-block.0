Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:53242 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbdAUM4c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Jan 2017 07:56:32 -0500
Date: Sat, 21 Jan 2017 13:11:49 +0100
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <jbacik@fb.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, axboe@fb.com,
        nbd-general@lists.sourceforge.net, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [Nbd] [PATCH 4/4] nbd: add a nbd-control interface
Message-ID: <20170121121149.2wdztzezil2bkcft@grep.be>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
 <1484949412-6903-4-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484949412-6903-4-git-send-email-jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 20, 2017 at 04:56:52PM -0500, Josef Bacik wrote:
> This patch mirrors the loop back device behavior with a few changes.  First
> there is no DEL operation as NBD doesn't get as much churn as loop devices do.
> Secondly the GET_NEXT operation can optionally create a new NBD device or not.
> Our infrastructure people want to not allow NBD to create new devices as it
> causes problems for them in containers.  However allow this to be optional as
> things like the OSS NBD client probably doesn't care and would like to just be
> given a device to use.

Don't be so sure :-)

I agree that having a control device for NBD is useful and would make
certain things much easier. If that's added, then I'll move to using
that as a way to control the device rather than opening a device and
dealing with it that way. In fact, at some point in the past I did
suggest something along those ways myself; it's just not happened yet.

Obviously though this would require an intermediate situation in which
the control master would be available as well as (optionally perhaps)
the old way where you open a specific device node, so that we don't
break existing implementations before they've had a chance to follow
suit.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
