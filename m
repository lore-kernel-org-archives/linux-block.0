Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34034 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbdBAJcF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Feb 2017 04:32:05 -0500
Date: Wed, 1 Feb 2017 10:32:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shaohua Li <shli@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@lst.de, axboe@fb.com
Subject: Re: [PATCH 1/2] blk-mq: allocate blk_mq_tags and requests in
        correct node
Message-ID: <20170201093203.GA1189@lst.de>
References: <1c91ab2c0073598592f66f007ff72cfa58a17a54.1485922654.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1c91ab2c0073598592f66f007ff72cfa58a17a54.1485922654.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Shaohua,

the code your patching has changed a lot in Jens' tree, so I think
you'll have to respin it.  But the idea looks fine.
