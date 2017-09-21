Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751804AbdIUO7p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 10:59:45 -0400
Subject: Re: [PATCH] block: drop "sending ioctl to a partition" message
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1506005362-13429-1-git-send-email-pbonzini@redhat.com>
 <20170921145300.GA1617@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7717bb8d-4223-9401-f9fa-0deb6d33f784@redhat.com>
Date: Thu, 21 Sep 2017 16:59:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170921145300.GA1617@infradead.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 21/09/2017 16:53, Christoph Hellwig wrote:
> This looks ok to me, but do we even need to keep the special
> cases above?  Is there anything relying on the safe but not very
> useful ioctls?

No idea, I stuck to the usual "don't break userspace" rule.

Honestly I doubt anything is using most of those ioctls _in general_,
not just on a partition.

Paolo

> Condensing the thing down to:
> 
> int scsi_verify_blk_ioctl(struct block_device *bd, unsigned int cmd)
> {
> 	if (bd && bd == bd->bd_contains)
> 		return 0;
> 	if (capable(CAP_SYS_RAWIO))
> 		return 0;
> 	return -ENOIOCTLCMD;
> }
> 
> would certainly be nice.
