Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp-km-2.mail.tiscali.it ([213.205.35.82]:51776 "EHLO
        smtp-km-2.mail.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162172AbeBNSpn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Feb 2018 13:45:43 -0500
Date: Wed, 14 Feb 2018 19:37:21 +0100
From: Michele Ballabio <barra_cuda@katamail.com>
To: csoren@cpinternet.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: block: oopses on 4.13.*, 4.14.* and 4.15-rc2
Message-ID: <20180214193721.6a740f59@darkstar.example.org>
In-Reply-To: <a428082c000fedab69295e4dade5b88c@cpinternet.com>
References: <a428082c000fedab69295e4dade5b88c@cpinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 13 Feb 2018 21:20:47 -0600
csoren@cpinternet.com wrote:
> Greetings Ming,
> 
> Do you have the patches that fix this? I'm getting these crashes too
> on Linux 4.13.
> 
> The link to mark.info doesn't have the patches anymore, at least not
> that I can tell.
> 
> TIA!
> 

You can cherry-pick them from git, commits:
14cb0dc6479dc5ebc63b3a459a5d89a2f1b39fed
0abc2a10389f0c9070f76ca906c7382788036b93

Also here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=14cb0dc6479dc5ebc63b3a459a5d89a2f1b39fed
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=0abc2a10389f0c9070f76ca906c7382788036b93

If I remember correctly, these patches should apply cleanly on 4.13.x.

You probably know this already, but if not: consider upgrading
to 4.14.x or 4.15.x (both contain the patches you are interested in).

    Michele

[Re-added ML on CC:]


> On Sat, Dec 9, 2017 at 7:27 AM, Michele Ballabio
> <barra_cuda@katamail.com> wrote:
> > On Fri, 8 Dec 2017 13:08:37 -0700
> > Jens Axboe <axboe@kernel.dk> wrote:
> >  
> >> On 12/08/2017 08:38 AM, Michele Ballabio wrote:  
> >> > Hi,
> >> > kernels 4.13.*, 4.14.* 4.15-rc2 crash on occasion,
> >> > especially on x86-32 systems. To trigger the problem, run as
> >> > root:
> >> >
> >> > while true
> >> > do
> >> > /sbin/udevadm trigger --type=subsystems --action=change
> >> > /sbin/udevadm trigger --type=devices --action=change
> >> > /sbin/udevadm settle --timeout=120
> >> > done
> >> >
> >> > (Thanks to Patrick Volkerding for the reproducer).
> >> >
> >> > Sometimes the kernel oopses immediately, sometimes a bit later
> >> > (less than five minutes).
> >> >
> >> > The bisection pointed to commit
> >> > caa4b02476e31fc7933d2138062f7f355d3cd8f7 (blk-map: call
> >> > blk_queue_bounce from blk_rq_append_bio). A revert fixes the
> >> > problem (tested on 4.13 and master).  
> >>
> >> Thanks for your report - can you try the below patch? Totally
> >> untested...  
> >
> > I applied the patch on master
> > (968edbd93c0cbb40ab48aca972392d377713a0c3), I tried two times to
> > boot the system but couldn't get to the shell. I found this in the
> > log:  
> 
> Hi Michele,
> 
> Please test the patches I sent out and see if it fixes your issue. In
> my environment
> the two just works fine.
> 
> https://marc.info/?l=linux-block&m=151358285916762&w=2 [1]
> 
