Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39153 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdC0JP5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 05:15:57 -0400
Date: Mon, 27 Mar 2017 02:15:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shaohua Li <shli@kernel.org>
Cc: NeilBrown <neilb@suse.com>, Ming Lei <tom.leiming@gmail.com>,
        Jens Axboe <axboe@fb.com>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 02/14] md: move two macros into md.h
Message-ID: <20170327091553.GF6879@infradead.org>
References: <20170316161235.27110-1-tom.leiming@gmail.com>
 <20170316161235.27110-3-tom.leiming@gmail.com>
 <87tw6j8be6.fsf@notabene.neil.brown.name>
 <20170324165325.nek4kb4yezz2xmow@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170324165325.nek4kb4yezz2xmow@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 24, 2017 at 09:53:25AM -0700, Shaohua Li wrote:
> 
> I had the same concern when I looked at this patch firstly. The number for
> raid1/10 doesn't need to be the same. But if we don't move the number to a
> generic header, the third patch will become a little more complicated. I
> eventually ignored this issue. If we really need different number for raid1/10,
> lets do it at that time.

Which brings up my usual queastion:  Is is really that benefitical for
us to keep the raid1.c code around instead of making it a special short
cut case in raid10.c?
