Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752694AbdBCIBP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Feb 2017 03:01:15 -0500
Subject: Re: [PATCH 5/9] virtio: allow drivers to request IRQ affinity when
 creating VQs
To: Christoph Hellwig <hch@lst.de>, mst@redhat.com
References: <1485504997-17584-1-git-send-email-hch@lst.de>
 <1485504997-17584-6-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jason Wang <jasowang@redhat.com>
Message-ID: <315fa499-2b2c-e883-4097-a8c2c415dfd4@redhat.com>
Date: Fri, 3 Feb 2017 16:01:04 +0800
MIME-Version: 1.0
In-Reply-To: <1485504997-17584-6-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 2017年01月27日 16:16, Christoph Hellwig wrote:
> Add a struct irq_affinity pointer to the find_vqs methods, which if set
> is used to tell the PCI layer to create the MSI-X vectors for our I/O
> virtqueues with the proper affinity from the start.  Compared to after
> the fact affinity hints this gives us an instantly working setup and
> allows to allocate the irq descritors node-local and avoid interconnect
> traffic.  Last but not least this will allow blk-mq queues are created
> based on the interrupt affinity for storage drivers.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> ---

Reviewed-by: Jason Wang <jasowang@redhat.com>
