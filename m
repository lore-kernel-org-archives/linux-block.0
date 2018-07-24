Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388333AbeGXQOX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jul 2018 12:14:23 -0400
Date: Tue, 24 Jul 2018 11:07:25 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: data corruption with 'splt' workload to XFS on DM cache with its
 3 underlying devices being on same NVMe device
Message-ID: <20180724150725.GA3235@redhat.com>
References: <20180723163357.GA29658@redhat.com>
 <e761830f-e3f7-3e88-1697-b4b150e84e5f@suse.de>
 <bc63227473a19cb23d6b2bb38eefa564dfec1ffc.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bc63227473a19cb23d6b2bb38eefa564dfec1ffc.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 24 2018 at 10:25am -0400,
Bart Van Assche <Bart.VanAssche@wdc.com> wrote:

> On Tue, 2018-07-24 at 08:00 +0200, Hannes Reinecke wrote:
> > So, have you tested that request-based multipathing works on a partition 
> > _at all_? I'm not sure if partition mapping is done correctly here; we 
> > never remap the start of the request (nor bio, come to speak of it), so 
> > it looks as if we would be doing the wrong things here.
> > 
> > Have you checked that partition remapping is done correctly?
> 
> I think generic_make_request() takes care of partition remapping by calling
> blk_partition_remap(). generic_make_request() is called by submit_bio(). Is
> that sufficient to cover all dm drivers?

Seems not for request-based DM (see my previous reply in this thread).

But bio-based DM-multipath seems to work just fine.
