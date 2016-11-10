Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37799 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752397AbcKJTfY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2016 14:35:24 -0500
Date: Thu, 10 Nov 2016 11:35:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 04/60] block: floppy: use bio_add_page()
Message-ID: <20161110193523.GA11452@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-5-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477728600-12938-5-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming,

any chance you could send out a series with the various bio_add_page
soon-ish?  I'd really like to get all the good prep work in for
this merge window, so that we can look at the real multipage-bvec
work for the next one.
