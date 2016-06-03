Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49188 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbcFCDHl (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2016 23:07:41 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, sitsofe@yahoo.com,
	snitzer@redhat.com, axboe@fb.com, martin.petersen@oracle.com,
	Kernel-team@fb.com
Subject: Re: [PATCH] block: correctly fallback for zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20160526180813.GA49039@shli-mbp.local>
	<20160529064728.GA14383@infradead.org>
Date: Thu, 02 Jun 2016 23:06:56 -0400
In-Reply-To: <20160529064728.GA14383@infradead.org> (Christoph Hellwig's
	message of "Sat, 28 May 2016 23:47:28 -0700")
Message-ID: <yq1h9dbrmwf.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> As part of that I also removed the strange EOPNOTSUPP ignore,
Christoph> but Mike reverted it just because it changed something in the
Christoph> dm testsuite.

Mike?

Christoph> I still believe we should never ignore it in this helper, and
Christoph> only do so in callers that believe it's the right thing.

Yeah.

I really wish EOPNOTSUPP would just go away except for ioctl callers.
Now that we have real bi_error I don't understand why we need it.

-- 
Martin K. Petersen	Oracle Linux Engineering
