Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754720AbdDFLgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 07:36:03 -0400
Date: Thu, 6 Apr 2017 04:35:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 3/9] bio-integrity:  bio_integrity_advance must update
 integrity seed
Message-ID: <20170406113559.GA9312@infradead.org>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-4-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491332201-26926-4-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
