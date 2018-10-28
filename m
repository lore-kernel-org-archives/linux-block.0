Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45198 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeJ2DXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Oct 2018 23:23:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id c24-v6so4370066lfi.12
        for <linux-block@vger.kernel.org>; Sun, 28 Oct 2018 11:38:27 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: Fix uninitialized return value in
 nvm_get_chunk_meta()
To: geert@linux-m68k.org, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me
Cc: arnd@arndb.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181028160726.24450-1-geert@linux-m68k.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a0fa4599-f6c1-1f45-43f4-4cf30b8de509@lightnvm.io>
Date: Sun, 28 Oct 2018 19:38:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181028160726.24450-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/28/2018 05:07 PM, Geert Uytterhoeven wrote:
> With gcc 4.1:
> 
>      drivers/lightnvm/core.c: In function ‘nvm_get_bb_meta’:
>      drivers/lightnvm/core.c:977: warning: ‘ret’ may be used uninitialized in this function
> 
> and
> 
>      drivers/nvme/host/lightnvm.c: In function ‘nvme_nvm_get_chk_meta’:
>      drivers/nvme/host/lightnvm.c:580: warning: ‘ret’ may be used uninitialized in this function
> 
> Indeed, if (for the former) the number of channels or LUNs is zero, or
> (for both) the passed number of chunks is zero, ret will be returned
> uninitialized.
> 
> Fix this by preinitializing ret to zero.
> 
> Fixes: aff3fb18f957de93 ("lightnvm: move bad block and chunk state logic to core")
> Fixes: a294c199455187d1 ("lightnvm: implement get log report chunk helpers")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> I don't know if this can happen in practice, but given this is core
> functionality that can be called from other files, or even from other
> modules, I think it's better to be safe than sorry.
> 
> The latter seems to be a pre-existing issue since v4.17.
> I didn't notice it before, due to the dependency of NVM on PCI (my gcc
> 4.1 targets m68k, i.e. no PCI).
> ---
>   drivers/lightnvm/core.c      | 2 +-
>   drivers/nvme/host/lightnvm.c | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index efb976a863d2295a..73ab3cf2686804ba 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -974,7 +974,7 @@ static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba,
>   	struct ppa_addr ppa;
>   	u8 *blks;
>   	int ch, lun, nr_blks;
> -	int ret;
> +	int ret = 0;
>   
>   	ppa.ppa = slba;
>   	ppa = dev_to_generic_addr(dev, ppa);
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index a4f3b263cd6c60ee..d64805dc8efbaa02 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -577,7 +577,8 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>   	struct ppa_addr ppa;
>   	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
>   	size_t log_pos, offset, len;
> -	int ret, i, max_len;
> +	int i, max_len;
> +	int ret = 0;
>   
>   	/*
>   	 * limit requests to maximum 256K to avoid issuing arbitrary large
> 

Thanks Geert. Applied for 4.21/5.1.
