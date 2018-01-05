Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:32768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbeAETdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 14:33:51 -0500
Subject: Re: [GIT PULL 18/25] lightnvm: set target over-provision on create
 ioctl
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20180105131621.20808-1-m@bjorling.me>
 <20180105131621.20808-19-m@bjorling.me>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fd47bd97-8ff7-1f6a-b07f-c86449ec1834@infradead.org>
Date: Fri, 5 Jan 2018 11:33:49 -0800
MIME-Version: 1.0
In-Reply-To: <20180105131621.20808-19-m@bjorling.me>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/05/2018 05:16 AM, Matias Bjørling wrote:
> From: Javier González <javier@cnexlabs.com>
> 
> Allow to set the over-provision percentage on target creation. In case
> that the value is not provided, fall back to the default value set by
> the target.
> 
> In pblk, set the default OP to 11% of the total size of the device

> +#define PBLK_DEFAULT_OP (11)

Hi,
Just curious -- where does 11 come from?  Is it a spec value?

thanks,
-- 
~Randy
