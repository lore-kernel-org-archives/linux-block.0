Return-Path: <dan.carpenter@oracle.com>
Date: Sat, 26 Aug 2017 09:01:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 3/4] skd: Make it easier for static analyzers to analyze
 skd_free_disk()
Message-ID: <20170826022525.56ix4wxpf2uo2knh@mwanda>
References: <20170825212414.28322-1-bart.vanassche@wdc.com>
 <20170825212414.28322-4-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170825212414.28322-4-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

No, no.  That's not required.  I've been thinking about this false
positive and I have a plan to fix Smatch to parse this code correctly.
Potentially it will take a year or so to get around to it but I'm sure
it will get done.

regards,
dan carpenter
