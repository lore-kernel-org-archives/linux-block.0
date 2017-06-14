Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbdFNUZr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2017 16:25:47 -0400
Date: Wed, 14 Jun 2017 13:25:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 03/11] fs: add support for an inode to carry stream
 related data
Message-ID: <20170614202546.GA7022@infradead.org>
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
 <1497467134-6323-4-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497467134-6323-4-git-send-email-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 14, 2017 at 01:05:26PM -0600, Jens Axboe wrote:
> No functional changes in this patch, just in preparation for
> allowing applications to pass in hints about data life times
> for writes.
> 
> Pack the i_stream field into a 2-byte hole, so we don't grow
> the size of the inode.

Can't we find space for 4 flags somewhere else?
