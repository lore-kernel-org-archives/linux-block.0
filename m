Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933157AbdBPWQq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 17:16:46 -0500
Date: Thu, 16 Feb 2017 14:16:42 -0800
From: Shaohua Li <shli@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 00/17] md: cleanup on direct access to bvec table
Message-ID: <20170216221642.sobqndndd7fbjoo7@kernel.org>
References: <1487245547-24384-1-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487245547-24384-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 16, 2017 at 07:45:30PM +0800, Ming Lei wrote:
> In MD's resync I/O path, there are lots of direct access to bio's
> bvec table. This patchset kills most of them, and the conversion
> is quite straightforward.

I don't like this approach. The MD uses a hacky way to manage pages allocated,
this is the root of the problem. The patches add another hack way to do the
management. I'd like to see explict management of the pages, for example, add
data structure in r1bio to manage the pages, then we can use existing API for
all the stuffes we need.

Thanks,
Shaohua
