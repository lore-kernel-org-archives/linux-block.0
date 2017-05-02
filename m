Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:36842 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbdEBH2V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 03:28:21 -0400
Date: Tue, 2 May 2017 09:28:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de
Subject: Re: [PATCH 5/6] blk-mq-sched: remove hack that bypasses scheduler
        for reserved requests
Message-ID: <20170502072820.GB11582@lst.de>
References: <1493398473-29872-1-git-send-email-axboe@fb.com> <1493398473-29872-6-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493398473-29872-6-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
