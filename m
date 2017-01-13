Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750701AbdAMV4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 16:56:07 -0500
Subject: Re: [PATCH 4/4] sd: remove __data_len hack for WRITE SAME
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1484306953-3194-1-git-send-email-hch@lst.de>
 <1484306953-3194-5-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f8cc7c28-fb7d-d5b6-1994-b2e447bd1f56@grimberg.me>
Date: Fri, 13 Jan 2017 23:56:00 +0200
MIME-Version: 1.0
In-Reply-To: <1484306953-3194-5-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
