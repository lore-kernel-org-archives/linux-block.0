Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19069 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbcFCC4S (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2016 22:56:18 -0400
To: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@redhat.com, axboe@fb.com,
	martin.petersen@oracle.com, Kernel-team@fb.com
Subject: Re: [PATCH] block: correctly fallback for zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20160526180813.GA49039@shli-mbp.local>
	<20160527054918.GA9521@sucs.org>
Date: Thu, 02 Jun 2016 22:56:05 -0400
In-Reply-To: <20160527054918.GA9521@sucs.org> (Sitsofe Wheeler's message of
	"Fri, 27 May 2016 06:49:21 +0100")
Message-ID: <yq1lh2nrnei.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Sitsofe" == Sitsofe Wheeler <sitsofe@yahoo.com> writes:

Sitsofe> The original SCSI WRITE SAME has overloaded semantics - not
Sitsofe> only does it mean "write this data multiple times" but it can
Sitsofe> also be used to mean "discard this range" too. If the kernel's
Sitsofe> command was modelled on the SCSI original perhaps this
Sitsofe> conflation clouded things?

REQ_WRITE_SAME in the context of the kernel explicitly means "write
payload to this block range".

A REQ_DISCARD command may be serviced using WRITE SAME(16) with the
UNMAP bit set in the SCSI disk driver but that's entirely orthogonal.

-- 
Martin K. Petersen	Oracle Linux Engineering
