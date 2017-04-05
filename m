Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] remove the obsolete hd driver
To: Christoph Hellwig <hch@lst.de>
References: <20170405135923.953-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <90ab54f6-4a1d-d3e3-fe53-b06454bb797f@kernel.dk>
Date: Wed, 5 Apr 2017 09:51:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170405135923.953-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/05/2017 07:59 AM, Christoph Hellwig wrote:
> This driver is for pre-IDE hardisk that are only found in PC from the
> stoneage of personal computing, and which we don't support elsewhere
> in the kernel these days.
> 
> It's also been marked broken forever.

Applied for 4.12, who'd trust their data to a driver written by Linus
anyway. Good riddance.

-- 
Jens Axboe
