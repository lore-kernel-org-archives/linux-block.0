Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH] blk-mq-pci: Remove unneeded includes
To: Christoph Hellwig <hch@lst.de>
References: <1491474816-15422-1-git-send-email-sagi@grimberg.me>
 <20170406115144.GA4786@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b24f714e-dfe7-eed6-638e-5f03ce8a06eb@grimberg.me>
Date: Thu, 6 Apr 2017 14:58:45 +0300
MIME-Version: 1.0
In-Reply-To: <20170406115144.GA4786@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

> Stephen added the first two includes after a linux-next build
> failure.  Did this go through a long buildbot cycle to verify
> it's really not needed anymore?

Umm no. I just compiled it and ran and it worked...

If these are actually needed then we can safely discard
this patch.
