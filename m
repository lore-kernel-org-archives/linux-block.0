Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbcJTNMT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2016 09:12:19 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: clean up block ops defintions
Date: Thu, 20 Oct 2016 15:12:08 +0200
Message-Id: <1476969135-32732-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

this series takes advantage of the the new REQ_OP* scheme to further
clean up the way how we classify bios and requests.

After the series both the bio and request have a field where the
REQ_OP operation is stored in directly without any shiting around,
and the coomon REQ_* flags can be ORed into directly as well.  All
the bio flags are now in the existing bi_flags field, and the many
request-only flags are moved into a new field in struct request,
which is split off cmd_flags.

Last but not least this series ensures that we can encode the
operational direction of a command in it's code.  Currently the
op_is_write, bio_data_dir and rq_data_dir helpers all assume that
everything but a READ is a data out command.  This surprisingly
actually was true until this week, but the new shingled driver
support conflicts with it - it's just that the relevant path
didn't use any of these helpers so that issue wasn't noticed.
