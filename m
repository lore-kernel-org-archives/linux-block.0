Return-Path: <linux-block-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60579 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbcHLLMO (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 12 Aug 2016 07:12:14 -0400
MIME-Version: 1.0
In-Reply-To: <20160811140253.GA2867@infradead.org>
References: <1459914212-9330-1-git-send-email-ming.lei@canonical.com>
 <alpine.LRH.2.11.1608102132120.10662@mail.ewheeler.net> <20160811140253.GA2867@infradead.org>
From: Ming Lei <ming.lei@canonical.com>
Date: Fri, 12 Aug 2016 19:12:10 +0800
Message-ID: <CACVXFVNUpsht4LmGeOOwvWJ65tZGVQTRFsyd-SXGKHxkpUCHSw@mail.gmail.com>
Subject: Re: [PATCH v2] block: make sure big bio is splitted into at most 256 bvecs
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Wheeler <bcache@lists.ewheeler.net>,
	Jens Axboe <axboe@fb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:BCACHE (BLOCK LAYER CACHE)" <linux-bcache@vger.kernel.org>,
	"open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
	<linux-raid@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Sebastian Roesner <sroesner-kernelorg@roesner-online.de>,
	"4.3+" <stable@vger.kernel.org>, Shaohua Li <shli@fb.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 11, 2016 at 10:02 PM, Christoph Hellwig <hch@infradead.org> wrote:
> Please just fix bcache to not submit bios larger than BIO_MAX_PAGES for
> now, until we can support such callers in general and enable common
> used code to do so.

IMO it can't be efficient to do that in bcache because it need to figure out
how many bvecs one bio includes.

This patch(block: make sure big bio is splitted into at most 256 bvecs)
can support such callers.

Also this kind of usage does simplify drivers.

Thanks,
Ming

> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
