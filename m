Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C230AC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 12:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF8520989
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 12:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="PBpkgkdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF8520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLGMAQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:00:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42715 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeLGMAQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 07:00:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so3310952lja.9
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 04:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2NjzXhJt1ttBLZM8TBDtDQIeEB79QnFD6oDvC4rG7+4=;
        b=PBpkgkdSlNogR7Z0zxBlJaFmmyMlj0T7hm1YFw0umNgEfahzNyTseIihzUs6r3WPNr
         L5yGm3h6k2Q01uXt0paaG7jfj6pNXavzbnFPV89m7szxnMPIBNoMWrZko0WurJ+AjAi7
         r+MH4jlMATtchptKeQ16NA8xiTShdaESW8h9dZfvkPRtgk4Tji2jf2S15G3GaQTfmxlO
         j3IyDBW8jS9S7oIUx3cgbYATvcF6dToOSNOiPDaov6cjQHsiiJ3R8G+2sbt5xHZUMT9o
         R3aeRK8dE3/tTI3Vajugj3XAP6P0njW2EbMZmVSFQJyqOE/adl9C0jBbKYdAX+7ppOSz
         U2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2NjzXhJt1ttBLZM8TBDtDQIeEB79QnFD6oDvC4rG7+4=;
        b=cqHpjLnuEU0TWzeSd5qokQ/ebZRR061IcSdK2UNd3eWRKqOrHJFeKw8HhGYQyQdFVi
         oKA/1JEt6mPHnRXozmvMuUpizxs/kSC/eKsR7BPaxocT9d9eQpaWgJaanyFX0znaAFyd
         /bYYRlGTA2OjvEObcOmKloknrOygsutg5/TasI9Xhu2T3QHEX+ZD/8cBlQxxBCn44+Qu
         GQq9i7+SS1rFYIX7Heu6ntBIYAMDvKtCqTcz4EYWnvT4GzU3CYPzOjQxMFhhh5wwL05z
         ZmCBztzZEua2FtQXjHWMKO5Vz+sFHcZY+itqdE4m/jgvNh/bFhsKt/R544o23Uxu6rcv
         4RHw==
X-Gm-Message-State: AA+aEWbw3wGwT4s/KijPiQovh1ixEYWuGLnKSAaW+cBfzgYNIkVnGXvY
        YOdKxXytzeZFUkeO0FrtZZtC5w==
X-Google-Smtp-Source: AFSGD/WdKoXQT/1RTBn5mt8j8fBcOFMrrm5s3WfdgtYtywWbIQlwdYxbEDQewwe43trtG5qjyotOzw==
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr1167656ljg.64.1544184013838;
        Fri, 07 Dec 2018 04:00:13 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id h3sm565234lfj.25.2018.12.07.04.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:00:12 -0800 (PST)
Subject: Re: [PATCH v2 1/2] lightnvm: pblk: Do not overwrite ppa list with
 meta list
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com
References: <20181207082550.10409-1-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <981ad6d5-31e2-1412-99c7-727abb266887@lightnvm.io>
Date:   Fri, 7 Dec 2018 13:00:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181207082550.10409-1-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/07/2018 09:25 AM, Igor Konopko wrote:
> Currently when using PBLK with 0 sized metadata both ppa list
> and meta list points to the same memory since pblk_dma_meta_size()
> returns 0 in that case.
> 
> This commit fix that issue by ensuring that pblk_dma_meta_size()
> always returns space equal to sizeof(struct pblk_sec_meta) and thus
> ppa list and meta list points to different memory address.
> 
> Even that in that case drive does not really care about meta_list
> pointer, this is the easiest way to fix that issue without introducing
> changes in many places in the code just for 0 sized metadata case.
> 
> The same approach needs to be also done for pblk_get_sec_meta()
> since we also cannot point to the same memory address in meta buffer
> when we are using it for pblk recovery process
> 
> Reported-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk.h | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index bc40b1381ff6..85e38ed62f85 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -1388,12 +1388,15 @@ static inline unsigned int pblk_get_min_chks(struct pblk *pblk)
>   static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
>   							 void *meta, int index)
>   {
> -	return meta + pblk->oob_meta_size * index;
> +	return meta +
> +	       max_t(int, sizeof(struct pblk_sec_meta), pblk->oob_meta_size)
> +	       * index;
>   }
>   
>   static inline int pblk_dma_meta_size(struct pblk *pblk)
>   {
> -	return pblk->oob_meta_size * NVM_MAX_VLBA;
> +	return max_t(int, sizeof(struct pblk_sec_meta), pblk->oob_meta_size)
> +	       * NVM_MAX_VLBA;
>   }
>   
>   static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
> 

Thanks Igor. It's applied for 4.21. I've updated the description a bit
