Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35201 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbcGAEed (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 1 Jul 2016 00:34:33 -0400
Date: Fri, 1 Jul 2016 06:25:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ming Lei <ming.lei@canonical.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: Re: Question about loop device DIO/AIO and FLUSH
Message-ID: <20160701042510.GA381@lst.de>
References: <CAOQ4uxhEzr=yaFPO4ZVzndct84VC6c57W5DNEtqUHUcBjdTjQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOQ4uxhEzr=yaFPO4ZVzndct84VC6c57W5DNEtqUHUcBjdTjQg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 30, 2016 at 11:54:48PM +0300, Amir Goldstein wrote:
> Hi Ming,
> 
> I was reading through the code of loop DIO/AIO
> and I was wondering whether lo_req_flush() really
> honors REQ_FLUSH by calling  vfs_fsync() on a backing file
> that is open with O_DIRECT?
> 
> Shouldn't lo_req_flush() actually wait for completion of
> all the in-flight loop AIO requests to complete?
> Am I missing something?

Both fsync and flush semanrics only apply to I/O requests that have already
completed.
