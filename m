Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbdDDHAX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 03:00:23 -0400
Date: Tue, 4 Apr 2017 00:00:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 1/7] bio-integrity: Do not allocate integrity context for
 bio w/o data
Message-ID: <20170404070022.GB12008@infradead.org>
References: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org>
 <1491204212-9952-2-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491204212-9952-2-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
