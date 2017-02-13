Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.191]:58714 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdBMQaz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 11:30:55 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Scott Bauer' <scott.bauer@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "arnd@arndb.de" <arnd@arndb.de>, "axboe@fb.com" <axboe@fb.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "jonathan.derrick@intel.com" <jonathan.derrick@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH V5 3/4] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
Date: Mon, 13 Feb 2017 16:30:36 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB028519B@AcuExch.aculab.com>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
 <1487002272-17940-4-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1487002272-17940-4-git-send-email-scott.bauer@intel.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Scott Bauer Sent: 13 February 2017 16:11
> When CONFIG_KASAN is enabled, compilation fails:
> 
> block/sed-opal.c: In function 'sed_ioctl':
> block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-
> larger-than=]
> 
> Moved all the ioctl structures off the stack and dynamically activate
> using _IOC_SIZE()

Think I'd not that this simplifies the code considerably.
AFAICT CONFIG_KASAN is a just brainf*ck.
It at least needs annotation that copy_from_user() has properties
similar to memset().
So if the size matches that of the type then no guard space (etc)
is required.

...
> +	ioctl_ptr = memdup_user(arg,  _IOC_SIZE(cmd));
> +	if (IS_ERR_OR_NULL(ioctl_ptr)) {
> +		ret = PTR_ERR(ioctl_ptr);
> +		goto out;
...
> + out:
> +	kfree(ioctl_ptr);
> +	return ret;
>  }

That error path doesn't look quite right to me.

	David
