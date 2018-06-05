Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39207 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeFEALY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jun 2018 20:11:24 -0400
Received: by mail-pg0-f67.google.com with SMTP id w12-v6so254160pgc.6
        for <linux-block@vger.kernel.org>; Mon, 04 Jun 2018 17:11:24 -0700 (PDT)
Date: Mon, 4 Jun 2018 17:11:22 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [blktests PATCHv2] Fix block/011 to not use sysfs for device
 disabling
Message-ID: <20180605001122.GA16585@vader>
References: <20180604225141.8950-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180604225141.8950-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 04, 2018 at 04:51:41PM -0600, Keith Busch wrote:
> The PCI sysfs interface may not be a dependable method for toggling the
> PCI device state to trigger the timeouts. This patch goes directly to
> the config space to make device failure occur.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
> v1 -> v2:
> 
>   Toggling only PCI Command Register BME bit, rather than including MEM.

Thanks, Keith, applied.
