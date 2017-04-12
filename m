Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59214 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbdDLGe1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2017 02:34:27 -0400
Date: Wed, 12 Apr 2017 08:34:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH rfc 0/6] Automatic affinity settings for nvme over rdma
Message-ID: <20170412063426.GA20883@lst.de>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me> <14fd128d-7155-ab13-492f-952f072808d5@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14fd128d-7155-ab13-492f-952f072808d5@opengridcomputing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 10, 2017 at 01:05:50PM -0500, Steve Wise wrote:
> I'll test cxgb4 if you convert it. :)

That will take a lot of work.  The problem with cxgb4 is that it
allocatesd all the interrupts at device enable time, but then only
allocates them to ULDs when they attached, while this scheme assumes
as way to map out queues / vectors at initialization time.
