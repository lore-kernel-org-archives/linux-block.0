Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:58025 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbcHOSSG (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 15 Aug 2016 14:18:06 -0400
Date: Mon, 15 Aug 2016 20:17:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix secure erase
Message-ID: <20160815181754.GA9918@lst.de>
References: <20160811140533.GA16543@lst.de> <1471270071-28921-1-git-send-email-adrian.hunter@intel.com> <20160815181328.GA9696@lst.de> <0da0904a-9d46-e043-edec-8d0d34cf0714@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0da0904a-9d46-e043-edec-8d0d34cf0714@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 15, 2016 at 12:16:30PM -0600, Jens Axboe wrote:
>> This really should be a:
>>
>> 	if (req_op(rq) != req_op(pos))
>>
>> I'l lleave it up to Jens if he wants that in this patch or not, otherwise
>> I'll send an incremental patch.
>
> Let's get a v2 with that fixed up, it makes a big readability
> difference.

It's not just readbility, it's also a potential correctness issue.
Not sure if we'd hit it for other request types at the moment, but
we'd surely hit if people add more..
