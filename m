Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35931 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbdA1I3C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2017 03:29:02 -0500
Date: Sat, 28 Jan 2017 09:29:00 +0100
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: split scsi passthrough fields out of struct request V2
Message-ID: <20170128082900.GE4728@lst.de>
References: <1485365126-23210-1-git-send-email-hch@lst.de> <1485552454.4267.29.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485552454.4267.29.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 27, 2017 at 09:27:53PM +0000, Bart Van Assche wrote:
> Have you considered to convert all block drivers to the new
> approach and to get rid of request.special? If so, do you already
> have plans to start working on this? I'm namely wondering wheter I
> should start working on this myself.

Hi Bart,

I'd love to have all drivers move of using .special (and thus reducing
request size further).  I think the general way to do that is to convert
them to blk-mq and not using the legacy cmd_size field.
