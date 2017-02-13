Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:33323 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbdBMHy1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 02:54:27 -0500
Date: Sun, 12 Feb 2017 23:54:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Scott Bauer <scott.bauer@intel.com>
Cc: linux-nvme@lists.infradead.org, David.Laight@ACULAB.COM,
        arnd@arndb.de, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH V4 2/2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
Message-ID: <20170213075422.GB20361@infradead.org>
References: <1486742454-3254-1-git-send-email-scott.bauer@intel.com>
 <1486742454-3254-3-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486742454-3254-3-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>  int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
>  {
> +	void *ioctl_ptr;
> +	int ret = -ENOTTY;
>  	void __user *arg = (void __user *)ptr;

Can we use this opportunity to clean up the usual ioctl argument mess.
Id say pass the "void __user *argp" argument already (nvme_ioctl should
have a local variable for it anyway), and then just rename ioctl_ptr
variable to the usual short p.

> +	unsigned int cmd_size = _IOC_SIZE(cmd);
>  

> +	ioctl_ptr = memdup_user(arg, cmd_size);

cmd_size is only used once, so why not opencode the expression in the
argument to memdup_user.
