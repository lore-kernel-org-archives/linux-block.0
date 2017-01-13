Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbdAMIRP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 03:17:15 -0500
Date: Fri, 13 Jan 2017 00:17:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        osandov@osandov.com, bart.vanassche@sandisk.com
Subject: Re: [PATCH 05/10] blk-mq: export some helpers we need to the
 scheduling framework
Message-ID: <20170113081714.GC637@infradead.org>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-6-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484170803-9311-6-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Do we really need to make any of the blk-mq scheduling modular?
