Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbdCBSHH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Mar 2017 13:07:07 -0500
Date: Wed, 1 Mar 2017 23:52:02 -0800
From: Shaohua Li <shli@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
        <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 09/13] md: raid1: use bio_segments_all()
Message-ID: <20170302075202.ipnx64sodjzxisqs@kernel.org>
References: <1488296503-4987-1-git-send-email-tom.leiming@gmail.com>
 <1488296503-4987-10-git-send-email-tom.leiming@gmail.com>
 <20170228234212.3wjwxsegg4v57nxu@kernel.org>
 <CACVXFVOLLJ1Og7ezOsDTbuBsJg+qxJdqmf0MO+VDwDZiSoFn1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVOLLJ1Og7ezOsDTbuBsJg+qxJdqmf0MO+VDwDZiSoFn1g@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 02, 2017 at 10:34:25AM +0800, Ming Lei wrote:
> Hi Shaohua,
> 
> On Wed, Mar 1, 2017 at 7:42 AM, Shaohua Li <shli@kernel.org> wrote:
> > On Tue, Feb 28, 2017 at 11:41:39PM +0800, Ming Lei wrote:
> >> Use this helper, instead of direct access to .bi_vcnt.
> >
> > what We really need to do for the behind IO is:
> > - allocate memory and copy bio data to the memory
> > - let behind bio do IO against the memory
> >
> > The behind bio doesn't need to have the exactly same bio_vec setting. If we
> > just track the new memory, we don't need use the bio_segments_all and access
> > bio_vec too.
> 
> But we need to figure out how many vecs(each vec store one page) to be
> allocated for the cloned/behind bio, and that is the only value of
> bio_segments_all() here. Or you have idea to avoid that?

As I said, the behind bio doesn't need to have the exactly same bio_vec
setting. We just allocate memory and copy original bio data to the memory,
then do IO against the new memory. The behind bio
segments == (bio->bi_iter.bi_size + PAGE_SIZE - 1) >> PAGE_SHIFT

Thanks,
Shaohua
