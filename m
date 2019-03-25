Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D8EC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5C82063F
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="IUkUCanx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfCYLJt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:09:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45095 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYLJt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:09:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id m16so7103680edd.12
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FjfrgSbp6D+6/tM1hDlQgqQi0BvwTuTLi845dZix0us=;
        b=IUkUCanx2VlXdZmOB7UK3OBTiOK6y6td6cEFna45LIdUIeovT0IK91+7kYlK/2VonE
         uFOcohSN4rttC0Maf/k5pls0qfJNHagXZpQ554UKTOcJnjX5JxXrchWFpGiJXuySJznv
         S4wOTRz/IAVhKyvWSTY9db71pjBgccplG1+1/A5M42N6aMrbBC2ke5lf57q9lnu8c0Po
         gqr6aVQgeR7BDQVcwSnaxFxijQx0nrp2OHPH8fneX8K+zOCJuYOabSM2g5ZrmUzXnBLI
         mMHmjXZwQH5+TFNJL8XMbUOJxLVidho7e/+AvwMYs4nL2wHesj2EHHCpcqcBP8MBimT2
         hv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FjfrgSbp6D+6/tM1hDlQgqQi0BvwTuTLi845dZix0us=;
        b=H5m8kwT/12uW8kLxjNqv0OWt6uDct0eIbCiiZd4I9Ij9YbFQzNhDyh0ZyUXLLo2ew+
         Jf56bttO8ePZiMDjiqM3uPYeyAUmTMPeFU9cP2tbA9pc5jWOS9f94Rl7ydrlpNSpRlHj
         c38aXx0OibUh1Rt2BNDn107FiJRG7HvwwaIrJn5z5OE3y2guEwS37YZOR3TdTJi5CVim
         k82oTjjGfmiWFYyTrC6ClyPVVGw1Z1TXQ95RzD3v9Rrd/ggkwgGIPa+y+w7s4cKrOpTz
         jkc0J+KtFjfM70xOoga6JVHcQxwlGvwI6VjU9LDINJg+bDZuAsdkMv7Sr/IAboYezHdm
         axkg==
X-Gm-Message-State: APjAAAWxjycr0N/rd+W/bwz1Dr3xl0mDhBAAyaxoF8zw5rHNcIiQ0zTx
        rhLPbeSiP9AoG91CZ/AFGQay6TOl0Sk=
X-Google-Smtp-Source: APXvYqw/b6MZ9cRBMIdfRZdTTnP+w03Qc7Rm5lXOb92lbjVX73B1eRR/4ak6KtjyTSIonrbXkS2n1w==
X-Received: by 2002:aa7:d3d8:: with SMTP id o24mr16562362edr.53.1553512187168;
        Mon, 25 Mar 2019 04:09:47 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id h8sm5476388eda.27.2019.03.25.04.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:09:46 -0700 (PDT)
Subject: Re: [PATCH v2 09/16] lightnvm: pblk: fix spin_unlock order
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-10-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <713cc13c-e21f-2125-de20-4786da887aa1@lightnvm.io>
Date:   Mon, 25 Mar 2019 12:09:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190322144843.9602-10-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 3:48 PM, Igor Konopko wrote:
> In pblk_rb_tear_down_check() spin_unlock() functions are not
> called in proper order. This patch fixes that.
> 
> Fixes: a4bd217 ("lightnvm: physical block device (pblk) target")
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> Reviewed-by: Javier González <javier@javigon.com>
> Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-rb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index 03c241b..3555014 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -799,8 +799,8 @@ int pblk_rb_tear_down_check(struct pblk_rb *rb)
>   	}
>   
>   out:
> -	spin_unlock(&rb->w_lock);
>   	spin_unlock_irq(&rb->s_lock);
> +	spin_unlock(&rb->w_lock);
>   
>   	return ret;
>   }
> 

Thanks, applied.
