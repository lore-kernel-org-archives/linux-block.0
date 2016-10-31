Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944106AbcJaPdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 11:33:22 -0400
Date: Mon, 31 Oct 2016 08:33:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 16/60] block: pktcdvd: comment on direct access to bvec
 table
Message-ID: <20161031153321.GI30919@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-17-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477728600-12938-17-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Please pick up my "pktcdvd: don't scribble over the bvec array"
patch instead of the pktcdvd patches in this series.
