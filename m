Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60413 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbeJRAeO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Oct 2018 20:34:14 -0400
Date: Wed, 17 Oct 2018 18:37:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Steve Wise <swise@opengridcomputing.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v2] block: fix rdma queue mapping
Message-ID: <20181017163744.GB23798@lst.de>
References: <20180820205420.25908-1-sagi@grimberg.me> <20180822131130.GC28149@lst.de> <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me> <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com> <66c41a1a-e57d-8526-366c-e15dcded7cec@grimberg.me> <c14b6091-781d-580e-833f-d2c6db54a5d2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c14b6091-781d-580e-833f-d2c6db54a5d2@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 15, 2018 at 06:04:46PM -0700, Sagi Grimberg wrote:
> Would you prefer we fallback to the naive mapping if the device is not
> using manged affinity?

Yes.
