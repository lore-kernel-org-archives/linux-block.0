Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19319 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbcFGCdQ (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Mon, 6 Jun 2016 22:33:16 -0400
To: Mike Snitzer <snitzer@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, sitsofe@yahoo.com, axboe@fb.com,
	Kernel-team@fb.com
Subject: Re: block: correctly fallback for zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20160526180813.GA49039@shli-mbp.local>
	<20160529064728.GA14383@infradead.org>
	<yq1h9dbrmwf.fsf@sermon.lab.mkp.net>
	<20160603035415.GA8236@redhat.com>
Date: Mon, 06 Jun 2016 22:32:38 -0400
In-Reply-To: <20160603035415.GA8236@redhat.com> (Mike Snitzer's message of
	"Thu, 2 Jun 2016 23:54:15 -0400")
Message-ID: <yq1mvmxohix.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Mike" == Mike Snitzer <snitzer@redhat.com> writes:

Mike> But hch was originally in favor of _always_ dropping EOPNOTSUPP on
Mike> the floor (that is what his commit 38f25255330 did).  Then he said
Mike> he disagrees with these interfaces playing games with masking
Mike> EOPNOTSUPP -- to which you seemingly really don't agree.  Unless
Mike> I'm completely misreading you.

Userland apps rely on EOPNOTSUPP, we can't break that.

What I don't like this is "soft" error special casing of EOPNOTSUPP in
the actual implementation of discard, write same, etc. These functions
should return either success or failure. And the ioctl wrapper should
then decide whether to return EOPNOTSUPP, EIO or EPONIES.

I.e. separate the policy from the implementation. This would also solve
some of the grievances for the target folks.

-- 
Martin K. Petersen	Oracle Linux Engineering
