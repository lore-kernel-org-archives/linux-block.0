Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32752 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751472AbdBMQYm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 11:24:42 -0500
Date: Mon, 13 Feb 2017 09:15:10 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: David.Laight@ACULAB.COM, arnd@arndb.de, axboe@fb.com,
        keith.busch@intel.com, jonathan.derrick@intel.com,
        hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH V5 1/4] block: sed-opal: change ioctl to take user
 pointer instead of unsinged long
Message-ID: <20170213161509.GA18913@sbauer-Z170X-UD5>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
 <1487002272-17940-2-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487002272-17940-2-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

esOn Mon, Feb 13, 2017 at 09:11:09AM -0700, Scott Bauer wrote:
> Signed-off-by: Scott Bauer <scott.bauer@intel.com>
> ---
>  block/sed-opal.c         | 6 ++++--
>  drivers/nvme/host/core.c | 3 ++-
>  include/linux/sed-opal.h | 4 ++--
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index bf1406e..2448d4a 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -2344,9 +2344,11 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
>  }
>  EXPORT_SYMBOL(opal_unlock_from_suspend);
>  
> -int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
> +int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>  {
> -	void __user *arg = (void __user *)ptr;
> +	void *ioctl_ptr;
> +	int ret = -ENOTTY;
> +	unsigned int cmd_size = _IOC_SIZE(cmd);

ugh, I apparently messed up my rebase these should be in patch 2 or maybe I should
sqash p1 and p2  together.
