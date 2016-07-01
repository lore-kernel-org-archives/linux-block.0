Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35272 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbcGAFE6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 1 Jul 2016 01:04:58 -0400
Date: Fri, 1 Jul 2016 07:04:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@hgst.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Ming Lei <ming.lei@canonical.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@fb.com>
Subject: Re: Question about loop device DIO/AIO and FLUSH
Message-ID: <20160701050455.GA828@lst.de>
References: <CAOQ4uxhEzr=yaFPO4ZVzndct84VC6c57W5DNEtqUHUcBjdTjQg@mail.gmail.com> <20160701042510.GA381@lst.de> <E8DEFE4F-67B6-4A9A-83F0-3AA554AEFFB1@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E8DEFE4F-67B6-4A9A-83F0-3AA554AEFFB1@hgst.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 01, 2016 at 05:00:18AM +0000, Damien Le Moal wrote:
> Did you mean "...I/O requests that have already been fully submitted" ?

No.

> Flushing I/Os that have already completed does not seem
> to make much sense. Or I am also missing something...

With a volatile write cache this makes a lot of sense.  And fsync
flushes the volatile fs metadata to disk, while flush flushes the
volatile disk write cache.
