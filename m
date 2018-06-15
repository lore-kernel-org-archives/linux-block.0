Return-Path: <mwilck@suse.com>
Message-ID: <51d72b3bcc384edf3f90892667d1707e9c1036f8.camel@suse.com>
Subject: Re: [PATCH] dm-zoned-tools: add zoned disk udev rules for scheduler
 / dmsetup
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@infradead.org>, Bart Van Assche
	 <Bart.VanAssche@wdc.com>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>, "mcgrof@kernel.org"
 <mcgrof@kernel.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  "agk@redhat.com" <agk@redhat.com>,
 "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "yuchao0@huawei.com" <yuchao0@huawei.com>, "ghe@suse.com" <ghe@suse.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "tchvatal@suse.com"
 <tchvatal@suse.com>
Date: Fri, 15 Jun 2018 13:07:16 +0200
In-Reply-To: <20180614134235.GA21624@infradead.org>
References: <20180614001147.1545-1-mcgrof@kernel.org>
	 <791e0a85-be07-4a31-f13d-282a1c94bf22@wdc.com>
	 <bd7abc194c69bce0f9cc7d08f435449242ae4f8c.camel@wdc.com>
	 <20180614134235.GA21624@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-06-14 at 06:42 -0700, Christoph Hellwig wrote:
> On Thu, Jun 14, 2018 at 01:39:50PM +0000, Bart Van Assche wrote:
> > On Thu, 2018-06-14 at 10:01 +0000, Damien Le Moal wrote:
> > > Applied. Thanks Luis !
> > 
> > Hello Damien,
> > 
> > Can this still be undone? I agree with Mike that it's wrong to
> > invoke
> > "/sbin/dmsetup create ... zoned ..." from a udev rule.
> 
> Yes.  We'll really need to verfify the device has dm-zoned metadata
> first.  Preferably including a uuid for stable device naming.

libblkid would be the central hub for metadata discovery, so perhaps a
patch should be made to make libblkid dm-zoned-aware.

Anyway, as Damien explained, dmzoned bails out if it doesn't find
matching meta data, so AFAICS, little harm is done by calling it for a
SMR device in host-managed mode. I fail to get the point why this would
be wrong in general - what's the difference to e.g. calling "mdadm -I"?

Regards
Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
