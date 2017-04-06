Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45289 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933313AbdDFLtv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 07:49:51 -0400
Date: Thu, 6 Apr 2017 04:49:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 9/9] bio-integrity: Restore original iterator on verify
 stage
Message-ID: <20170406114951.GG9312@infradead.org>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-10-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491332201-26926-10-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
