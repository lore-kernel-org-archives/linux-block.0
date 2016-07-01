Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35351 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbcGAFdZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 1 Jul 2016 01:33:25 -0400
Date: Fri, 1 Jul 2016 07:32:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@hgst.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Ming Lei <ming.lei@canonical.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@fb.com>
Subject: Re: Question about loop device DIO/AIO and FLUSH
Message-ID: <20160701053227.GA917@lst.de>
References: <CAOQ4uxhEzr=yaFPO4ZVzndct84VC6c57W5DNEtqUHUcBjdTjQg@mail.gmail.com> <20160701042510.GA381@lst.de> <E8DEFE4F-67B6-4A9A-83F0-3AA554AEFFB1@hgst.com> <20160701050455.GA828@lst.de> <3D8F3502-8EA7-4568-882B-90E48C8F6BCF@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D8F3502-8EA7-4568-882B-90E48C8F6BCF@hgst.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 01, 2016 at 05:17:28AM +0000, Damien Le Moal wrote:
> Thank you for the clarification. Makes sense.
> Just to be picky though, I think that "completed I/Os" applies only
> to flush in this case (flush of the volatile device cache to media).
> fsync of the host cache (page cache most of the time) to the device
> will issue new BIOs, and those will be waited for until completed.
> Right ?

For fsync the completed I/O at the syscall / VFS level.  Fsync only
needs to cover read/write calls that have return to the user, be that
through a synchronous call or aio completion.
