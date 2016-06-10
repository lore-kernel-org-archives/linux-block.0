Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:40102 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbcFJCFy (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2016 22:05:54 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@redhat.com>, Shaohua Li <shli@fb.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	sitsofe@yahoo.com, axboe@fb.com, Kernel-team@fb.com
Subject: Re: block: correctly fallback for zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20160526180813.GA49039@shli-mbp.local>
	<20160529064728.GA14383@infradead.org>
	<yq1h9dbrmwf.fsf@sermon.lab.mkp.net>
	<20160603035415.GA8236@redhat.com>
	<yq1mvmxohix.fsf@sermon.lab.mkp.net>
	<20160607063842.GA21032@infradead.org>
Date: Thu, 09 Jun 2016 22:05:21 -0400
In-Reply-To: <20160607063842.GA21032@infradead.org> (Christoph Hellwig's
	message of "Mon, 6 Jun 2016 23:38:42 -0700")
Message-ID: <yq14m91iyse.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

>> Userland apps rely on EOPNOTSUPP, we can't break that.

Christoph> Rely on what exactly?  Current we return EOPNOTSUPP if the
Christoph> device doesn't claim to support discards, but it returns 0 if
Christoph> the device first claims to support it but then fails the I/O.

Hopefully we can clean up this when/if we go the fallocate() route.

-- 
Martin K. Petersen	Oracle Linux Engineering
