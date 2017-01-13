Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:39810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750701AbdAMVyS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 16:54:18 -0500
Subject: Re: [PATCH 3/4] nvme: use blk_rq_payload_bytes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1484306953-3194-1-git-send-email-hch@lst.de>
 <1484306953-3194-4-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f72d327f-8072-f643-1790-0f58a5fe7260@grimberg.me>
Date: Fri, 13 Jan 2017 23:54:12 +0200
MIME-Version: 1.0
In-Reply-To: <1484306953-3194-4-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
