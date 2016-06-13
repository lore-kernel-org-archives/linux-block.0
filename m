Return-Path: <BATV+a67a43e55467fd1c3dfd+4677+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mchristi@redhat.com,
	linux-block@vger.kernel.org
Subject: a few more fixups for the ops vs flags split
Date: Mon, 13 Jun 2016 16:48:32 +0200
Message-Id: <1465829315-23137-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Get rid of the very confusing bio_rw helper, which mixes OPs and flags,
and shrink the bio back to it's original size.

Btw, I'm not really sure if having bi_rw and bi_flags really is the
right thing in the long run, it seem rather confusing for users.

Maybe it's time to give up the shared REQ_* flags again now that the
ops are split out and there are only about two hand full of common flags
left?
