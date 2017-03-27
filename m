Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:57613 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbdC0JHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 05:07:05 -0400
Date: Mon, 27 Mar 2017 02:06:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] fs: remove _submit_bh()
Message-ID: <20170327090654.GA6879@infradead.org>
References: <20170326040218.28519-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170326040218.28519-1-ebiggers3@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
