Return-Path: <hch@lst.de>
Date: Thu, 10 Nov 2016 20:29:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: clear all of bi_opf in bio_set_op_attrs
Message-ID: <20161110192937.GA21189@lst.de>
References: <1478716684-5085-1-git-send-email-hch@lst.de> <469312f1-e28c-0618-9df1-7c636b5c9e0d@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <469312f1-e28c-0618-9df1-7c636b5c9e0d@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 10, 2016 at 08:31:11AM -0800, Bart Van Assche wrote:
> Have you verified whether or not this change affects the behavior of the 
> bcache driver? From commit ad0d9e76a412:

It doesn't, bcache only calls bch_data_verify from a read completion
handler.

> Additionally, since bio_set_op_attrs is a macro please surround 'op' and 
> 'op_flags' with parentheses or change this macro into an inline function.

Makese sense, thanks.
