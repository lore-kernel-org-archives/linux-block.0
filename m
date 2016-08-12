Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34970 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbcHLQhA (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 12 Aug 2016 12:37:00 -0400
Date: Fri, 12 Aug 2016 08:36:56 -0800
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Wheeler <bcache@lists.ewheeler.net>,
	Ming Lei <ming.lei@canonical.com>, Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
	Sebastian Roesner <sroesner-kernelorg@roesner-online.de>,
	"4.3+" <stable@vger.kernel.org>, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH v2] block: make sure big bio is splitted into at most 256
 bvecs
Message-ID: <20160812163656.GA13370@kmo-pixel>
References: <1459914212-9330-1-git-send-email-ming.lei@canonical.com>
 <alpine.LRH.2.11.1608102132120.10662@mail.ewheeler.net>
 <20160811140253.GA2867@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160811140253.GA2867@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 11, 2016 at 07:02:53AM -0700, Christoph Hellwig wrote:
> Please just fix bcache to not submit bios larger than BIO_MAX_PAGES for
> now, until we can support such callers in general and enable common
> used code to do so.

Christoph, what's wrong with Ming's patch? Leaving bcache aside, just
considering the block layer, do you think that patch is the wrong approach?
