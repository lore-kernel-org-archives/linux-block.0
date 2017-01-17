Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35364 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdAQCkk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2017 21:40:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170116151813.GA28410@infradead.org>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
 <CACVXFVM+DyiyyZJEGD0dtRtCFEd4OLV6k-bfLiz7-opsc5rkxw@mail.gmail.com> <20170116151813.GA28410@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 17 Jan 2017 10:40:36 +0800
Message-ID: <CACVXFVPW4GFDy+vXfO+nksTYDoGAmedzP5cN88f_uC-TJp6MAg@mail.gmail.com>
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

On Mon, Jan 16, 2017 at 11:18 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jan 16, 2017 at 11:19:19AM +0800, Ming Lei wrote:
>> Any comments on this version?
>
> We'll need to make sure all drivers can handle multi-page bvecs
> before continuing any other work.  Without that the series is a no-go.
> Note that in general making a drivers capable of handling multipage
> bvecs will clean it up by using new helpers and be worthwhile on it's
> own.

IMO, the only one left is raid(1/5/10) which can be dealt with by the
"NO_MP" flag. This point can be observed by result from runnig 'git grep':

          $git grep -n -E "bi_vcnt|bi_io_vec" ./

Also this patchset addes comment in cases of direct access to bvec table,
and the cases have been minimized too, and most of them are single
bvec based.


Thanks,
Ming Lei
