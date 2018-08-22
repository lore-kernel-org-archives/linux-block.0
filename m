Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:35580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeHVJnn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Aug 2018 05:43:43 -0400
Date: Tue, 21 Aug 2018 23:20:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jeff Lien <jeff.lien@wdc.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, herbert@gondor.apana.org.au,
        tim.c.chen@linux.intel.com, david.darrington@wdc.com,
        jeff.furlong@wdc.com
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
Message-ID: <20180822062016.GA10356@infradead.org>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
 <yq1in4gq5jf.fsf@oracle.com>
 <yq1lg8zb2lp.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1lg8zb2lp.fsf@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 21, 2018 at 09:40:34PM -0400, Martin K. Petersen wrote:
> When crc-t10dif is initialized, the crypto infrastructure will pick the
> algorithm with the highest priority currently registered. Both block and
> SCSI will cause crc-t10dif to be compiled as a built-in so this
> selection happens very early.

Ouch.  This might actually happen in a lot of other users of the crypto
functionality as well.

> However, it seems like a bit of a deficiency in crypto that there is no
> way to upgrade existing transformations if higher priority algorithms
> become available. btrfs and a few others work around this issue by not
> using the generic lib/ CRC functions (which defeats the purpose of
> having these in the first place). Instead they are registering their own
> transformation at a later time where any accelerator modules are more
> likely to be loaded.

If we can't fix this in crypto (which doesn't seem that easy), we
should at least clearly document the issue somewhere, and fix this in
the t10pi code by initializing crct10dif_tfm in a lazy fashion only
once the fist block device starts using it.
