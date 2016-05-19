Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37893 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbcESMke (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 19 May 2016 08:40:34 -0400
Received: by mail-wm0-f41.google.com with SMTP id n129so33756255wmn.1
        for <linux-block@vger.kernel.org>; Thu, 19 May 2016 05:40:33 -0700 (PDT)
Subject: Re: [PATCH 1/2] lightnvm: break the loop when rqd is not null
To: Wenwei Tao <wwtao0320@163.com>
References: <1463639921-1824-1-git-send-email-wwtao0320@163.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	ww.tao0320@gmail.com
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <573DB43F.2070303@lightnvm.io>
Date: Thu, 19 May 2016 14:40:31 +0200
MIME-Version: 1.0
In-Reply-To: <1463639921-1824-1-git-send-email-wwtao0320@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/19/2016 08:38 AM, Wenwei Tao wrote:
> From: Wenwei Tao <ww.tao0320@gmail.com>
>
> Break the loop when rqd is not null to reduce
> unnecessary schedule.
>
> Signed-off-by: Wenwei Tao <ww.tao0320@gmail.com>
> ---
>   drivers/lightnvm/rrpc.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
> index 2103e97..2915e39 100644
> --- a/drivers/lightnvm/rrpc.c
> +++ b/drivers/lightnvm/rrpc.c
> @@ -98,6 +98,9 @@ static void rrpc_discard(struct rrpc *rrpc, struct bio *bio)
>
>   	do {
>   		rqd = rrpc_inflight_laddr_acquire(rrpc, slba, len);
> +		if (rqd)
> +			break;
> +
>   		schedule();
>   	} while (!rqd);
>
>

If that case, mind if I convert the do..while to while?

while(1) {
	rqd = rrpc_inflight_laddr_acquire(rrpc, slba, len);
	if (rqd)
		break;
	schedule();
}
