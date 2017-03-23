Subject: Re: [PATCH] block: make nr_iovecs unsigned in bio_alloc_bioset()
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20170323102455.GA20154@mwanda>
Cc: Ming Lei <tom.leiming@gmail.com>, Mike Christie <mchristi@redhat.com>,
 Kent Overstreet <kent.overstreet@gmail.com>, Hannes Reinecke
 <hare@suse.com>, Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>,
 Mike Snitzer <snitzer@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <0a6f04c4-7006-397f-21ac-4e8b35363a8b@fb.com>
Date: Thu, 23 Mar 2017 08:16:35 -0600
MIME-Version: 1.0
In-Reply-To: <20170323102455.GA20154@mwanda>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/23/2017 04:24 AM, Dan Carpenter wrote:
> There isn't a bug here, but Smatch is not smart enough to know that
> "nr_iovecs" can't be negative so it complains about underflows.
> Really, it's slightly cleaner to make this parameter unsigned.

Applied, thanks Dan.

-- 
Jens Axboe
