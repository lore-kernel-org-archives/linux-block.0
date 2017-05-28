Return-Path: <BATV+bd2cc6fb32ca617cb22a+5026+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 28 May 2017 02:27:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	axboe@kernel.dk, linux-api@vger.kernel.org, adam.manzanares@wdc.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/10 v9] No wait AIO
Message-ID: <20170528092728.GA14519@infradead.org>
References: <20170524164150.9492-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170524164150.9492-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

>  Changes since v8:
>  + Err out AIO reads with -EINVAL flagged as RWF_NOWAIT

Ugg, why?  Reads aren't really treated any different than writes in
the direct I/O code.
