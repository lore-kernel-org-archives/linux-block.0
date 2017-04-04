Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdDDHBl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 03:01:41 -0400
Date: Tue, 4 Apr 2017 00:01:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 3/7] bio-integrity: bio_trim should truncate integrity
 vector accordingly
Message-ID: <20170404070141.GD12008@infradead.org>
References: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org>
 <1491204212-9952-4-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491204212-9952-4-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
