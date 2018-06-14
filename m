Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754869AbeFNNmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jun 2018 09:42:37 -0400
Date: Thu, 14 Jun 2018 06:42:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "mwilck@suse.com" <mwilck@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "agk@redhat.com" <agk@redhat.com>, "hare@suse.de" <hare@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "ghe@suse.com" <ghe@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "tchvatal@suse.com" <tchvatal@suse.com>,
        "zren@suse.com" <zren@suse.com>
Subject: Re: [PATCH] dm-zoned-tools: add zoned disk udev rules for scheduler
 / dmsetup
Message-ID: <20180614134235.GA21624@infradead.org>
References: <20180614001147.1545-1-mcgrof@kernel.org>
 <791e0a85-be07-4a31-f13d-282a1c94bf22@wdc.com>
 <bd7abc194c69bce0f9cc7d08f435449242ae4f8c.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bd7abc194c69bce0f9cc7d08f435449242ae4f8c.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 14, 2018 at 01:39:50PM +0000, Bart Van Assche wrote:
> On Thu, 2018-06-14 at 10:01 +0000, Damien Le Moal wrote:
> > Applied. Thanks Luis !
> 
> Hello Damien,
> 
> Can this still be undone? I agree with Mike that it's wrong to invoke
> "/sbin/dmsetup create ... zoned ..." from a udev rule.

Yes.  We'll really need to verfify the device has dm-zoned metadata
first.  Preferably including a uuid for stable device naming.
