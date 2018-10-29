Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725984AbeJ2Qaw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Oct 2018 12:30:52 -0400
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-12-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <61ddcb9e-267d-ff36-dcec-70485ee3aa47@suse.de>
Date: Mon, 29 Oct 2018 08:43:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211626.12692-12-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/25/18 11:16 PM, Jens Axboe wrote:
> A driver may have a need to allocate multiple sets of MSI/MSI-X
> interrupts, and have them appropriately affinitized. Add support for
> defining a number of sets in the irq_affinity structure, of varying
> sizes, and get each set affinitized correctly across the machine.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   include/linux/interrupt.h |  4 ++++
>   kernel/irq/affinity.c     | 31 +++++++++++++++++++++++++------
>   2 files changed, 29 insertions(+), 6 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
