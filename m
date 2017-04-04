Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52373 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbdDDHDv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 03:03:51 -0400
Date: Tue, 4 Apr 2017 00:03:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 4/7] bio-integrity: fix interface for bio_integrity_trim
Message-ID: <20170404070350.GE12008@infradead.org>
References: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org>
 <1491204212-9952-5-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491204212-9952-5-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 03, 2017 at 11:23:29AM +0400, Dmitry Monakhov wrote:
> bio_integrity_trim inherent it's interface from bio_trim and accept
> offset and size, but this API is error prone because data offset
> must always be insync with bio's data offset. That is why we have
> integrity update hook in bio_advance()
> 
> So only meaningful offset is 0. Let's just remove it completely.

I think we can get rid of size as well and derive it from the bio,
can't we?
