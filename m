Return-Path: <bauerman@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, NeilBrown <neilb@suse.de>,
        lekshmicpillai@in.ibm.com
Subject: Re: [PATCH 0/10] block: Fix block device shutdown related races
Date: Mon, 13 Feb 2017 12:27:14 -0200
In-Reply-To: <20170209124433.2626-1-jack@suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2573999.VcEKEPpiaH@morokweng>
List-ID: <linux-block@vger.kernel.org>

Hi,

Am Donnerstag, 9. Februar 2017, 13:44:23 BRST schrieb Jan Kara:
> People, please have a look at patches. The are mostly simple however the
> interactions are rather complex so I may have missed something. Also I'm
> happy for any additional testing these patches can get - I've stressed them
> with Omar's script, tested memcg writeback, tested static (not udev managed)
> device inodes.

Lekshmi has been stress-testing these patches for 4 days now without problems.
If this is the version that goes in, you can add:

Tested-by: Lekshmi Pillai <lekshmicpillai@in.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
