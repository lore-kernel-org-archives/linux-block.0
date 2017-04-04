Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49915 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdDDHGm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 03:06:42 -0400
Date: Tue, 4 Apr 2017 00:06:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 5/7] bio-integrity: add bio_integrity_setup helper
Message-ID: <20170404070641.GF12008@infradead.org>
References: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org>
 <1491204212-9952-6-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491204212-9952-6-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 03, 2017 at 11:23:30AM +0400, Dmitry Monakhov wrote:
> Currently all integrity prep hooks are open-coded, and if prepare fails
> we ignore it's code and fail bio with EIO. Let's return real error to
> upper layer, so later caller may react accordingly. For example retry in
> case of ENOMEM.

bio_integrity_enabled and bio_integrity_prep seem to be unused outside
of  bio_integrity_setup, so they can be removed / folded into
bio_integrity_setup.  Which at this point might just keep the
bio_integrity_prep name to fit into the blocking traditions :)

Also please update Documentation/block/data-integrity.txt for your
changes and add a kerneldoc comment for the new function.
