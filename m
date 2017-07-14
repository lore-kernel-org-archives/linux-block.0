Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:37524 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdGNHM7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2017 03:12:59 -0400
Date: Fri, 14 Jul 2017 09:12:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [for-4.14 RFC PATCH 0/2] dm rq: eliminate historic blk-mq and
        .request_fn queue stacking restrictions
Message-ID: <20170714071257.GB17046@lst.de>
References: <20170713211217.52361-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713211217.52361-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Btw, we might want to expedite this to 4.13, a 4.13 now defaults
to blk-mq for scsi, and this patch would make sure that dm keeps
on just working with that switch.
