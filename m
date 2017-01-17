Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35506 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdAQINn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2017 03:13:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170117075011.GA9732@infradead.org>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
 <CACVXFVM+DyiyyZJEGD0dtRtCFEd4OLV6k-bfLiz7-opsc5rkxw@mail.gmail.com>
 <20170116151813.GA28410@infradead.org> <CACVXFVPW4GFDy+vXfO+nksTYDoGAmedzP5cN88f_uC-TJp6MAg@mail.gmail.com>
 <20170117075011.GA9732@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 17 Jan 2017 16:13:39 +0800
Message-ID: <CACVXFVPrYCLOYy_XirwG5_E8BqxNB7UyqBZKWT+EoWyxK3KFZA@mail.gmail.com>
Subject: Re: [PATCH v1 00/54] block: support multipage bvec
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 17, 2017 at 3:50 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Jan 17, 2017 at 10:40:36AM +0800, Ming Lei wrote:
>> IMO, the only one left is raid(1/5/10) which can be dealt with by the
>> "NO_MP" flag.
>
> No, they can't in the long run.  They need to handle the bvecs just
> like everyone else.

OK, looks raid(1/5/10) becomes blocker for multipage bvec now.
I will study it a bit, and maybe need help from raid guys.


Thanks,
Ming Lei
