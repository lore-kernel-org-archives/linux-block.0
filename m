Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:43957 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdBYSXI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Feb 2017 13:23:08 -0500
Date: Sat, 25 Feb 2017 10:23:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1 02/14] block: introduce bio_remove_last_page()
Message-ID: <20170225182306.GC26447@infradead.org>
References: <1487950971-1131-1-git-send-email-tom.leiming@gmail.com>
 <1487950971-1131-3-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487950971-1131-3-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 24, 2017 at 11:42:39PM +0800, Ming Lei wrote:
> MD need this helper to remove the last added page, so introduce
> it.

If MD really has a valid use case for this it should open code the
operation.  The semantics look deeply fishy to me.
