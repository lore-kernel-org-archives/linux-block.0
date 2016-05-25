Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38696 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbcEYHLd (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 25 May 2016 03:11:33 -0400
Received: by mail-wm0-f42.google.com with SMTP id n129so50368995wmn.1
        for <linux-block@vger.kernel.org>; Wed, 25 May 2016 00:11:31 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: clear reserved bit on generic addr
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1462968506-9292-1-git-send-email-javier@cnexlabs.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	=?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <57455021.6080204@lightnvm.io>
Date: Wed, 25 May 2016 09:11:29 +0200
MIME-Version: 1.0
In-Reply-To: <1462968506-9292-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/11/2016 02:08 PM, Javier González wrote:
> When an address is converted from device to generic mode, the reserved
> bit needs to be cleared in order to signal that the address points to a
> flash block, not to a cacheline on the write buffer.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   include/linux/lightnvm.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 45be892..3d2c380 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -418,6 +418,9 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
>   	l.g.ch |= (r.ppa >> dev->ppaf.ch_offset) &
>   					(((1 << dev->ppaf.ch_len) - 1));
>
> +	/* On device side, reserved bit is always 0 */
> +	l.g.reserved = 0;
> +
>   	return l;
>   }
>
>

Thanks Javier. Applied for 4.8. I have changed it to l.ppa = 0 and 
updated the description a bit.
