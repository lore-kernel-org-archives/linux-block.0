Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:36970 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753939AbdBASOR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Feb 2017 13:14:17 -0500
Date: Wed, 1 Feb 2017 19:14:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shaohua Li <shli@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        bhelgaas@google.com, hch@lst.de, axboe@fb.com
Subject: Re: [PATCH V2 3/3] nvme: allocate nvme_queue in correct node
Message-ID: <20170201181415.GC11852@lst.de>
References: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com> <127b7a810d47b6b3530f29cb5ce36d7057a24e7e.1485971427.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <127b7a810d47b6b3530f29cb5ce36d7057a24e7e.1485971427.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
