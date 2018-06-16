Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41978 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbeFPT1b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jun 2018 15:27:31 -0400
Received: by mail-lf0-f68.google.com with SMTP id d24-v6so19180704lfa.8
        for <linux-block@vger.kernel.org>; Sat, 16 Jun 2018 12:27:30 -0700 (PDT)
Subject: Re: [PATCH 2/5] lightnvm: pblk: Remove resv field for sec meta
To: igor.j.konopko@intel.com, javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, michal.sorn@intel.com,
        marcin.dziegielewski@intel.com
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
 <20180615222706.3801-3-igor.j.konopko@intel.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c3723e66-9183-6ee3-c780-06e4f012a844@lightnvm.io>
Date: Sat, 16 Jun 2018 21:27:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180615222706.3801-3-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/16/2018 12:27 AM, Igor Konopko wrote:
> Since we have flexible size of pblk_sec_meta
> which depends on drive metadata size we can
> remove not needed reserved field from that
> structure
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index f82c3a0b0de5..27658dc6fc1a 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -82,7 +82,6 @@ enum {
>   };
>   
>   struct pblk_sec_meta {
> -	u64 reserved;
>   	__le64 lba;
>   };
>   
> 

Looks good to me. Javier may have some comment on this, since it is not 
completely obvious from the code why that reserved attribute is there. I 
do like the change to go in, as it needlessly extends the requirement 
from 8 to 16bytes.
