Return-Path: <axboe@kernel.dk>
Subject: Re: make a few block drivers highmem safe
To: Christoph Hellwig <hch@lst.de>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, Geoff Levand <geoff@infradead.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 sparclinux@vger.kernel.org
References: <20180509135948.20329-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e5f3ffef-4fa3-50d3-4fbe-d67ba2a85bd8@kernel.dk>
Date: Fri, 11 May 2018 15:08:26 -0600
MIME-Version: 1.0
In-Reply-To: <20180509135948.20329-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/9/18 7:59 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series converts a few random block drivers to be highmem safe,
> in preparation of eventually getting rid of the block layer bounce
> buffering support.

Applied, thanks.

-- 
Jens Axboe
