Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:49154 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeBESEu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Feb 2018 13:04:50 -0500
Subject: Re: [PATCH 3/4] lightnvm: add 2.0 geometry identification
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <20180205121505.27563-1-mb@lightnvm.io>
 <20180205121505.27563-4-mb@lightnvm.io>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b8ddae5a-064c-7468-d5e2-a5a20a93de19@infradead.org>
Date: Mon, 5 Feb 2018 10:04:45 -0800
MIME-Version: 1.0
In-Reply-To: <20180205121505.27563-4-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/05/2018 04:15 AM, Matias Bjørling wrote:
> Implement the geometry data structures for 2.0 and enable a drive
> to be identified as one, including exposing the appropriate 2.0
> sysfs entries.
> 
> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
> ---
>  drivers/lightnvm/core.c      |   2 +-
>  drivers/nvme/host/lightnvm.c | 334 +++++++++++++++++++++++++++++++++++++------
>  include/linux/lightnvm.h     |  11 +-
>  3 files changed, 295 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index c72863b36439..250e74dfa120 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -934,7 +934,7 @@ static int nvm_init(struct nvm_dev *dev)
>  	pr_debug("nvm: ver:%x nvm_vendor:%x\n",
>  			dev->identity.ver_id, dev->identity.vmnt);
>  
> -	if (dev->identity.ver_id != 1) {
> +	if (dev->identity.ver_id != 1 && dev->identity.ver_id != 2) {
>  		pr_err("nvm: device not supported by kernel.");
>  		goto err;
>  	}

Hi,
The pr_err() above could be a bit more informative to the user. E.g.,
		pr_err("nvm: device ver_id %d not supported by kernel.",
			dev->identity.ver_id);

BTW, isn't that line missing a '\n'?

-- 
~Randy
