Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33033 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbdF0Qze (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 12:55:34 -0400
Received: by mail-pf0-f171.google.com with SMTP id e7so19442864pfk.0
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2017 09:55:34 -0700 (PDT)
Date: Tue, 27 Jun 2017 09:55:31 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 0/2] Test I/O to device while resetting PCI
Message-ID: <20170627165531.GA7343@vader.DHCP.thefacebook.com>
References: <20170627134257.15863-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170627134257.15863-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 27, 2017 at 03:42:55PM +0200, Johannes Thumshirn wrote:
> Changes to v1:
> * Ignore fio errors
> * add an additional sleep .2 after re-enabling the pci device
> * directly call readlink in _get_pci_dev_from_blkdev()
> 
> Johannes Thumshirn (2):
>   rc: add helpers to handle PCI test devices
>   block/011: Perform PCI reset while doing IO
> 
>  common/rc           | 13 +++++++++++++
>  tests/block/011     | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/011.out |  2 ++
>  3 files changed, 70 insertions(+)
>  create mode 100755 tests/block/011
>  create mode 100644 tests/block/011.out

Applied, thanks!
