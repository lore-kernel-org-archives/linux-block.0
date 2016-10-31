Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36248 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947834AbcJaXI0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 19:08:26 -0400
MIME-Version: 1.0
In-Reply-To: <20161031153149.GH30919@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-16-git-send-email-tom.leiming@gmail.com> <20161031153149.GH30919@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 1 Nov 2016 07:08:24 +0800
Message-ID: <CACVXFVPE5BMBS-qwgRDxiab9s=SQGYay0VWhU+SGU8Z390hp7g@mail.gmail.com>
Subject: Re: [PATCH 15/60] block: loop: comment on direct access to bvec table
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Mike Christie <mchristi@redhat.com>,
        Minfei Huang <mnghuan@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 31, 2016 at 11:31 PM, Christoph Hellwig <hch@infradead.org> wrote:
> Btw, the lib/iov_iter.c code that iterates over bvec currently
> expects single-page segments.  Is the loop code fine with that?

lib/iov_iter.c has switched to bvec iterator already in the mp-bvec
preparing patchset, so every thing will be fine after multipage bvec
is enabled.

Another multipage bvec benefit for lib/iov_iter.c(dio) is that we
can return whole pages in one segment, instead of one page
each time, such as iov_iter_get_pages(), but that can be
a follow-up optimization.

> Even if it is I think we'd be much better off if it becomes multipage
> segment aware.

This patch is for auditing possible effect with multipage bvec, so
looks we should expose as much as possible direct access to
bvec table.

Thanks,
Ming Lei
