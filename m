Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35855 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754089AbdGNPE3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2017 11:04:29 -0400
Date: Fri, 14 Jul 2017 17:03:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Liu Bo <bo.li.liu@oracle.com>, Filipe Manana <FdManana@suse.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: note about cloned bios and
 bio_for_each_segment_all
Message-ID: <20170714150313.GJ2866@suse.cz>
Reply-To: dsterba@suse.cz
References: <20170714134051.22756-1-dsterba@suse.com>
 <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 14, 2017 at 09:47:30PM +0800, Ming Lei wrote:
> On Fri, Jul 14, 2017 at 9:40 PM, David Sterba <dsterba@suse.com> wrote:
> > We've switched to cloned bios in btrfs and hit a nasty bug leading to
> > corruptions, when cloned bios are iterated by bio_for_each_segment_all.
> 
> No, you simply can't use bio_for_each_segment_all on cloned bio, and the
> reason is obviously.

This was not obvious to us, speaking for the btrfs developers trying to
make more use of the of the bio API, so we had to find out the hard way.

The proposed WARN_ON, possibly more sanity checks or documentation would
help us not to trip over similar problems in the future. I try to take
great care when dealing with code changing bios on our side so I read
the headers, and partially the implementation, but still can miss
something.
