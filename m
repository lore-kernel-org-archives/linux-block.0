Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34631 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbcIVHyi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2016 03:54:38 -0400
Received: by mail-pa0-f67.google.com with SMTP id i5so170191pad.1
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2016 00:54:37 -0700 (PDT)
Date: Wed, 21 Sep 2016 23:54:34 -0800
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Guoqing Jiang <gqjiang@suse.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@fb.com>, Mike Snitzer <snitzer@redhat.com>,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH] block: export bio_free_pages to other modules
Message-ID: <20160922075434.konxegjpdryh4m5g@kmo-pixel>
References: <1474528201-23359-1-git-send-email-gqjiang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474528201-23359-1-git-send-email-gqjiang@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 22, 2016 at 03:10:01AM -0400, Guoqing Jiang wrote:
> bio_free_pages is introduced in commit 1dfa0f68c040
> ("block: add a helper to free bio bounce buffer pages"),
> we can reuse the func in other modules after it was
> imported.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Shaohua Li <shli@fb.com>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Signed-off-by: Guoqing Jiang <gqjiang@suse.com>

Acked-by: Kent Overstreet <kent.overstreet@gmail.com>
