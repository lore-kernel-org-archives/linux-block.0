Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD3BC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8835920815
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="rbLU6dOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCDMte (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:49:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34572 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDMtd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 07:49:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id a16so4149641edn.1
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 04:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VRW9GN3NxKN3Bp2TdtOOZt4N6iOKa5qiL8VBKpPaxs0=;
        b=rbLU6dOzZfQ7rzjFuF/xRdugeCoxWbgH0J4Bqhl9l9tpI/mxlMlROogz/QgeliTJul
         14ZytF8bOCmwPOb4FZcyaUgriBhkByc27veagd4gMqFw8/tT6Qr3PTlWmB8aGOG9oLil
         rx5mnKImA0XKRlD2IoIi547gPMTOQWGIuzREOQNMDlhyiBpNLQrzqLacRUqn7Edk7nCg
         +mbZYuk9M3K5JSjYFgj/N7VRnP7pWONOEJYUeJ0fr+DLpqMHFA4zFsNNrIR98ipoqDPG
         9sBSAYlybbHqAYxr/8QvtdbMlX4+3xoHldk82rLgv0U8qR1xrOb8TRhZ4kSV5XNg+h80
         bKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VRW9GN3NxKN3Bp2TdtOOZt4N6iOKa5qiL8VBKpPaxs0=;
        b=j5VfxXiBUDdR0137fvZ0a48z5CI6BUOP2ZHzgFOYqZuGBthmpUVms6CN7mcH27C4tk
         +A0KWPajnw+pLV21g3bYUeDAgZOjSuiu6nZFCGDOZARj56L9n3ztxHawvmAMKOVuILlw
         6Tjr6n85imJL3NNp9SaBBF9ZZSCouiFbB7ab+SbiU+dQMemB9VAcOYJPLYOVceCVSXPc
         v7iKpWi5FWYEVi19V/t77kLUI+XhvthNA9G3sColRApPliuBkLjwQVmq3G4NGkbLcdu+
         HbgxMJVdWPkw4QmR4xDt7pRROX6quHAt1jGDuY/BFVtyf1+2I/ecdUkj3PR5CO+Tp0y2
         PYyA==
X-Gm-Message-State: APjAAAVbyoKv3D2xuKqNyeXb5mA48VKS3os7/sKtoR+TTNLsE2TYbo7O
        wRXeyCPtH0vnHMAhCRws/h44piEBOVs=
X-Google-Smtp-Source: APXvYqzkL08XFyNLf0O5nUJVVDE/dSFevUnrmuQt8OThxight1ZNa7o3nq8sNFLKgIbCw3MI0Y6sVQ==
X-Received: by 2002:a50:8f24:: with SMTP id 33mr15585923edy.290.1551703771414;
        Mon, 04 Mar 2019 04:49:31 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id o1sm1172613eja.18.2019.03.04.04.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 04:49:30 -0800 (PST)
Subject: Re: [PATCH 04/13] lightnvm: pblk: Rollback in gc read
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-5-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <725e0ae9-5486-2731-bd73-9bda8faf8ca3@lightnvm.io>
Date:   Mon, 4 Mar 2019 13:49:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190227171442.11853-5-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/27/19 6:14 PM, Igor Konopko wrote:
> Currently in case of error returned by pblk_gc_line
> to pblk_gc_read we leave current line unassigned
> from all the lists. This patch fixes that issue.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk-gc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 511ed0d5333c..533da6ea3e15 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -361,8 +361,13 @@ static int pblk_gc_read(struct pblk *pblk)
>   
>   	pblk_gc_kick(pblk);
>   
> -	if (pblk_gc_line(pblk, line))
> +	if (pblk_gc_line(pblk, line)) {
>   		pblk_err(pblk, "failed to GC line %d\n", line->id);
> +		/* rollback */
> +		spin_lock(&gc->r_lock);
> +		list_add_tail(&line->list, &gc->r_list);
> +		spin_unlock(&gc->r_lock);
> +	}
>   
>   	return 0;
>   }
> 

Thanks Igor. I've reworded your description a bit. Applied for 5.2.
