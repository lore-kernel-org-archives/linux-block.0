Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59281 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933372AbcKDAJz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2016 20:09:55 -0400
Date: Thu, 3 Nov 2016 17:09:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com
Subject: Re: [PATCH V2 2/2] blk-mq: immediately dispatch big size request
Message-ID: <20161104000954.GA10266@infradead.org>
References: <05e8cb8c7e09903c7db36e81a6bbd0b39b24deff.1478217670.git.shli@fb.com>
 <6297c9a39cf21c94c65d5a9b3a19e54ba5b8b573.1478217671.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6297c9a39cf21c94c65d5a9b3a19e54ba5b8b573.1478217671.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 03, 2016 at 05:03:54PM -0700, Shaohua Li wrote:
> This is corresponding part for blk-mq. Disk with multiple hardware
> queues doesn't need this as we only hold 1 request at most.

Any reason you only do this for the SQ and not the MQ case?
