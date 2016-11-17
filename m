Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbcKQKaq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2016 05:30:46 -0500
Date: Thu, 17 Nov 2016 02:30:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: chaitany kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@fb.com, martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/5] nvme.h: add Write Zeroes definitions
Message-ID: <20161117103044.GD8295@infradead.org>
References: <CAK0tqik5oMda+Avk17pR8rX_CS0vCpoPPp3LioEtcgyG3Ex8Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK0tqik5oMda+Avk17pR8rX_CS0vCpoPPp3LioEtcgyG3Ex8Ww@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 15, 2016 at 11:06:58PM -0800, chaitany kulkarni wrote:
> Add the command structure, optional command set support (ONCS) bit and
> a new error code for the Write Zeroes command.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>

Unlike the other patches this one looks white space damaged by a mail
client (and it also arrived out of sequence).

With the whitespaces fixed up this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
