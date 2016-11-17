Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57565 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbcKQURu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2016 15:17:50 -0500
Date: Thu, 17 Nov 2016 12:17:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCHSET] Add support for simplified async direct-io
Message-ID: <20161117201749.GA15072@infradead.org>
References: <20161114181119.GA9396@infradead.org>
 <f8c29e81-7323-7362-b507-1b7c61e8a19a@fb.com>
 <20161116163147.GA25038@infradead.org>
 <72b1725a-0363-d33e-f890-251b1ac88998@kernel.dk>
 <20161116171652.GA30008@infradead.org>
 <c46c5e60-a5eb-2862-2b1b-f994fd0d3fe3@kernel.dk>
 <c2e20890-16ce-a3bd-c696-c53ae14a583a@kernel.dk>
 <20161117125037.GB14814@infradead.org>
 <204d4a18-e5da-1806-433e-a3ff1b6ca575@kernel.dk>
 <87823f67-a2ec-e959-1a23-9ecf3d6fe6d4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87823f67-a2ec-e959-1a23-9ecf3d6fe6d4@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ok, the updated tree is here:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/new-dio

This moves your O_SYNC patch earlier and makes it not directly
assign bi_opf.

Then comes the main direct I/O path with the various folds, and
a use after free fix ported from the iomap code in the completion
handler.

Last comes the I/O completion handler split - I don't think it's
worth it, but if you prefer it that way go ahead and fold it in.

I couldn't do the bio_kmalloc conversion as bio_kmalloc seems
to not like the front pad.
