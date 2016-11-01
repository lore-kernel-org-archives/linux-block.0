Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1169191AbcKANkV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:40:21 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: untange block operations and fs READ/WRITE
Date: Tue,  1 Nov 2016 07:40:01 -0600
Message-Id: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

this series removes the READ_* and WRITE_* defintions from fs.h and makes
all bio submitters use the REQ_* flags directly.  To make that easier
we also change the meaning of some of the flags slightly, so that the
callers don't have to set half a dozen flags for normal operations.

After that the READ and WRITE defintions are decouple from REQ_OP_READ
and REQ_OP_WRITE and moved to kernel.h, and last but not least we can
now stop including blk_types.h from fs.h and avoid the CONFIG_BLOCK
ifdefs in it.

