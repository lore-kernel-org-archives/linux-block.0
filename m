Return-Path: <BATV+a6fbff1bfc78a84bb09b+4713+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: resend: a few more fixups for the ops vs flags split
Date: Tue, 19 Jul 2016 11:28:40 +0200
Message-Id: <1468920523-3189-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Get rid of the very confusing bio_rw helper, which mixes OPs and flags,
and shrink the bio back to it's original size.

Btw, I'm not really sure if having bi_rw and bi_flags really is the
right thing in the long run, it seem rather confusing for users.

Compared to the last posting on June 13 this just adds Reviewed-by tags.
