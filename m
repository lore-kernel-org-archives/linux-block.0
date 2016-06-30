Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36487 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbcF3Uyu (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 30 Jun 2016 16:54:50 -0400
MIME-Version: 1.0
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Jun 2016 23:54:48 +0300
Message-ID: <CAOQ4uxhEzr=yaFPO4ZVzndct84VC6c57W5DNEtqUHUcBjdTjQg@mail.gmail.com>
Subject: Question about loop device DIO/AIO and FLUSH
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming,

I was reading through the code of loop DIO/AIO
and I was wondering whether lo_req_flush() really
honors REQ_FLUSH by calling  vfs_fsync() on a backing file
that is open with O_DIRECT?

Shouldn't lo_req_flush() actually wait for completion of
all the in-flight loop AIO requests to complete?
Am I missing something?

Thanks,
Amir.
