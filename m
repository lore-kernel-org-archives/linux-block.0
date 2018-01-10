Return-Path: <hch@lst.de>
Date: Wed, 10 Jan 2018 09:31:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: axboe@kernel.dk, hch@lst.de, Bart.VanAssche@wdc.com,
	dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [for-4.16 PATCH v2 1/3] block: only bdi_unregister() in
	del_gendisk() if !GENHD_FL_HIDDEN
Message-ID: <20180110083117.GB10185@lst.de>
References: <20180110024104.34885-1-snitzer@redhat.com> <20180110024104.34885-2-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180110024104.34885-2-snitzer@redhat.com>
List-ID: <linux-block@vger.kernel.org>

It's in fact completely harmless :)  But not even calling it
obviously is just as fine.
