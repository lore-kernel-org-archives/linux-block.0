Return-Path: <BATV+44f69bf97f3b7d1cdb28+5056+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 27 Jun 2017 07:44:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, adilger@dilger.ca,
	martin.petersen@oracle.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 9/9] nvme: add support for streams and directives
Message-ID: <20170627144405.GA4605@infradead.org>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-10-git-send-email-axboe@kernel.dk>
 <20170626095907.GG14057@infradead.org>
 <d2dcae41-d0b2-71a7-a63d-b7ef25ae47d2@kernel.dk>
 <20170627141115.GA2541@infradead.org>
 <ba468c95-40e0-41e7-0eb5-f5b4b70d3e3e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ba468c95-40e0-41e7-0eb5-f5b4b70d3e3e@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 27, 2017 at 08:16:49AM -0600, Jens Axboe wrote:
> But we have to handle it, not doing so would be fragile. So our
> options are:
> 
> 1) Keep the stream_mappings[] array. It's simple, and it'll work
>    for any number of streams.
> 
> 2) Kill stream_mappings[] and just do the MOD again.

3) print a message and tell streams aren't supported on this device.
