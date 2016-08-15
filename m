Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:58006 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbcHOSPB (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 15 Aug 2016 14:15:01 -0400
Date: Mon, 15 Aug 2016 20:14:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Josh Bingaman <josh.bingaman@seagate.com>
Subject: Re: [PATCH] block: Fix secure erase
Message-ID: <20160815181457.GA9781@lst.de>
References: <20160811140533.GA16543@lst.de> <1471270071-28921-1-git-send-email-adrian.hunter@intel.com> <CAJVOszDxKmaEEsg49yMT+Vr8oNbKLmgAGJ_P9KNa=zQcqcx+CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJVOszDxKmaEEsg49yMT+Vr8oNbKLmgAGJ_P9KNa=zQcqcx+CQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 15, 2016 at 11:43:12AM -0500, Shaun Tancheff wrote:
> Hmm ... Since REQ_SECURE implied REQ_DISCARD doesn't this
> mean that we should include REQ_OP_SECURE_ERASE checking
> wherever REQ_OP_DISCARD is being checked now in drivers/scsi/sd.c ?
> 
> (It's only in 3 spots so it's a quickie patch)

SCSI doesn't support secure erase operations.  Only MMC really
supports it, plus the usual cargo culting in Xen blkfront that's
probably never been tested..
