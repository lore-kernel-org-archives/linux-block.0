Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:30620 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbcFOCPY (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 22:15:24 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, axboe@fb.com, sitsofe@yahoo.com,
	snitzer@redhat.com, Kernel-team@fb.com
Subject: Re: [PATCH V2] block: correctly fallback for zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20160606223357.GA52883@shli-mbp.local>
	<yq18tydiyuf.fsf@sermon.lab.mkp.net>
	<20160610025435.GA48899@shli-mbp.local>
	<yq1shwkfq9z.fsf@sermon.lab.mkp.net>
	<20160613082001.GA27508@infradead.org>
Date: Tue, 14 Jun 2016 22:14:50 -0400
In-Reply-To: <20160613082001.GA27508@infradead.org> (Christoph Hellwig's
	message of "Mon, 13 Jun 2016 01:20:01 -0700")
Message-ID: <yq1bn33b3l1.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> We can move the sanity checks out.  Or even better get rid of
Christoph> the stupid behavior of ignoring the late -EOPNOTSUPP in this
Christoph> low level helper and instead leaving it to the caller(s) that
Christoph> care.

It definitely should be a caller decision whether to ignore the return
value or not.

>> I am OK with your patch as a stable fix but this really needs to be
>> fixed up properly.

Christoph> And I'd much prefer to get this right now.  It's not like
Christoph> this is recently introduced behavior.

Unfortunately there are quite a few callers of blkdev_issue_discard()
these days. Some of them ignore the return value but not all of
them. I'm concerned about causing all sorts of breakage if we suddenly
start returning errors various places in the stable trees.

-- 
Martin K. Petersen	Oracle Linux Engineering
