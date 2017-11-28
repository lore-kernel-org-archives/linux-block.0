Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f52.google.com ([209.85.160.52]:37409 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbdK1AYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Nov 2017 19:24:47 -0500
Received: by mail-pl0-f52.google.com with SMTP id 61so9544658plf.4
        for <linux-block@vger.kernel.org>; Mon, 27 Nov 2017 16:24:47 -0800 (PST)
Date: Mon, 27 Nov 2017 16:24:45 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH blktests] common/rc: allow 5-digit domains in
 _get_pci_dev_from_blkdev
Message-ID: <20171128002445.GA5260@vader.DHCP.thefacebook.com>
References: <1511819345-18092-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511819345-18092-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 27, 2017 at 02:49:05PM -0700, Jon Derrick wrote:
> At least one driver (VMD) uses 32-bit pci domains, but is effectively
> limited to 5-digit domains. Allow tests to access devices with 4-5 digit
> domains.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Thanks, Jon, applied.
