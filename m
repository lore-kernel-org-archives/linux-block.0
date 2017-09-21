Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58789 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdIUOxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 10:53:03 -0400
Date: Thu, 21 Sep 2017 07:53:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, axboe@kernel.de,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: drop "sending ioctl to a partition" message
Message-ID: <20170921145300.GA1617@infradead.org>
References: <1506005362-13429-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506005362-13429-1-git-send-email-pbonzini@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This looks ok to me, but do we even need to keep the special
cases above?  Is there anything relying on the safe but not very
useful ioctls?

Condensing the thing down to:

int scsi_verify_blk_ioctl(struct block_device *bd, unsigned int cmd)
{
	if (bd && bd == bd->bd_contains)
		return 0;
	if (capable(CAP_SYS_RAWIO))
		return 0;
	return -ENOIOCTLCMD;
}

would certainly be nice.
