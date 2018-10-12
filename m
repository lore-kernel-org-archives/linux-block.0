Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeJMGWQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Oct 2018 02:22:16 -0400
Subject: Re: [PATCH 03/17] ps3disk: convert to blk-mq
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-4-axboe@kernel.dk>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <17539e5f-742b-796e-8e36-31327120f883@infradead.org>
Date: Fri, 12 Oct 2018 15:47:37 -0700
MIME-Version: 1.0
In-Reply-To: <20181011165909.32615-4-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

On 10/11/2018 09:58 AM, Jens Axboe wrote:
> Convert from the old request_fn style driver to blk-mq.

I tested this on PS3 applied to v4.19-rc7, and on boot it either
gets a deadlock message or becomes unstable with various other
block related error messages.

For what its worth, I put an image of the deadlock message here:

  https://storage.googleapis.com/public-tmp-files/blk-deadlock.jpg

-Geoff
