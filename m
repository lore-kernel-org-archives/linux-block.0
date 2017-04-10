Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51389 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752211AbdDJQKI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 12:10:08 -0400
Date: Mon, 10 Apr 2017 18:09:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, osandov@fb.com, hch@lst.de,
        bart.vanassche@sandisk.com
Subject: Re: [PATCH 1/3] blk-mq: unify hctx delayed_run_work and run_work
Message-ID: <20170410160956.GA16553@lst.de>
References: <1491839696-24783-1-git-send-email-axboe@fb.com> <1491839696-24783-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491839696-24783-2-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
