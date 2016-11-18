Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32768 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752090AbcKRPbU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 10:31:20 -0500
Date: Fri, 18 Nov 2016 10:41:29 -0500
From: Keith Busch <keith.busch@intel.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@fb.com, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: Re: [PATCH v2 2/5] block: add support for REQ_OP_WRITE_ZEROES
Message-ID: <20161118154129.GE12377@localhost.localdomain>
References: <1479421031-6060-1-git-send-email-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479421031-6060-1-git-send-email-ckulkarnilinux@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 17, 2016 at 02:17:11PM -0800, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
> 
> This adds a new block layer operation to zero out a range of
> LBAs. This allows to implement zeroing for devices that don't use
> either discard with a predictable zero pattern or WRITE SAME of zeroes.
> The prominent example of that is NVMe with the Write Zeroes command,
> but in the future this should also help with improving the way
> zeroing discards work.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
> ---

I think we also to assign queue_limits for stacked devices in
blk_stack_limits. Otherwise, looks good.
