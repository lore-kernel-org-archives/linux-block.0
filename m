Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38881 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdDDG5U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 02:57:20 -0400
Date: Mon, 3 Apr 2017 23:57:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: convert unrecovered read error to -EILSEQ
Message-ID: <20170404065719.GB4614@infradead.org>
References: <1491221029-1609-1-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491221029-1609-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I'm planning to introduce new block-layer specific status code ASAP,
so I'd prefer not to add new errno special cases.

I'll port your patches to the new code and will send them out with
my series in a few days, though.
