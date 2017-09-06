Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:41128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbdIFNol (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 09:44:41 -0400
Date: Wed, 6 Sep 2017 06:44:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: axboe@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH] block: export symbol for bio_copy_kern
Message-ID: <20170906134440.GA3960@infradead.org>
References: <1504693225-11715-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1504693225-11715-1-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 06, 2017 at 12:20:25PM +0200, Javier Gonz�lez wrote:
> Export symbol for bio_copy_kern so that we can use it in modules.

NAK.  Always allocate the request first and then map the data to
the request.
