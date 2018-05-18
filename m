Return-Path: <BATV+77ddf8e9b1b344f28472+5381+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 18 May 2018 09:23:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Message-ID: <20180518162314.GC25227@infradead.org>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <b3970608-95dd-3d4f-140c-3d7cbd12cf8d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b3970608-95dd-3d4f-140c-3d7cbd12cf8d@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 11, 2018 at 03:13:38PM -0600, Jens Axboe wrote:
> Looked over the series, and looks like both good cleanups and optimizations.
> If we can get the mempool patch sorted, I can apply this for 4.18.

FYI, I agree on the actual cleanups and optimization, but we really
shouldn't add new functions or even just exports without the code
using them.  I think it is enough if we can collect ACKs on them, but
there is no point in using them.  Especially as I'd really like to see
the users for some of them first.
