Return-Path: <bauerman@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Jan Kara <jack@suse.cz>, "Lekshmi C. Pillai" <lekshmi.cpillai@in.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>, Tejun Heo <tj@kernel.org>,
        Tahsin Erdogan <tahsin@google.com>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 0/11 v4] block: Fix block device shutdown related races
Date: Mon, 20 Mar 2017 21:57:34 -0300
In-Reply-To: <20170313151410.5586-1-jack@suse.cz>
References: <20170313151410.5586-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <26171678.1kbYspPCTY@morokweng>
List-ID: <linux-block@vger.kernel.org>

Hello,

Am Montag, 13. M=E4rz 2017, 16:13:59 BRT schrieb Jan Kara:
> People, please have a look at patches. They are mostly simple however the
> interactions are rather complex so I may have missed something. Also I'm
> happy for any additional testing these patches can get - I've stressed th=
em
> with Omar's script, tested memcg writeback, tested static (not udev manag=
ed)
> device inodes.

Lekshmi tested these patches on top of an older kernel version that  is=20
afflicted by this bug (I backported the patches on which this series depend=
s as=20
well), and it fixed  the bug there.

Sorry if that's not as helpful, I had unrelated issues with v4.11-rc2 and=20
wasn't able to test with it yet. :-/

=2D-=20
Thiago Jung Bauermann
IBM Linux Technology Center
