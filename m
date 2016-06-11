Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:45608 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbcFKBuW (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 10 Jun 2016 21:50:22 -0400
To: Shaohua Li <shli@fb.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<axboe@fb.com>, <sitsofe@yahoo.com>, <snitzer@redhat.com>,
	<hch@infradead.org>, <Kernel-team@fb.com>
Subject: Re: [PATCH V2] block: correctly fallback for zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20160606223357.GA52883@shli-mbp.local>
	<yq18tydiyuf.fsf@sermon.lab.mkp.net>
	<20160610025435.GA48899@shli-mbp.local>
Date: Fri, 10 Jun 2016 21:49:44 -0400
In-Reply-To: <20160610025435.GA48899@shli-mbp.local> (Shaohua Li's message of
	"Thu, 9 Jun 2016 19:54:36 -0700")
Message-ID: <yq1shwkfq9z.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Shaohua" == Shaohua Li <shli@fb.com> writes:

Shaohua,

>> What does the extra io_err buy us? Just have this function return an
>> error. And then in blkdev_issue_discard if you get -EOPNOTSUPP you
>> special case it there.

Shaohua> The __blkdev_issue_discard returns -EOPNOTSUPP if disk doesn't
Shaohua> support discard.  in that case, blkdev_issue_discard doesn't
Shaohua> return 0. blkdev_issue_discard only returns 0 if IO error is
Shaohua> -EOPNOTSUPP.

Oh, I see. The sanity checks are now in __blkdev_issue_discard() so
there is no way to distinguish between -EOPNOTSUPP and the other
-EOPNOTSUPP. *sigh*

I am OK with your patch as a stable fix but this really needs to be
fixed up properly.

-- 
Martin K. Petersen	Oracle Linux Engineering
