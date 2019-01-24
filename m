Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC53C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8774C218AF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="kaqWJg6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfAXSSk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:18:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33592 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfAXSSj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 13:18:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so5061957lfc.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 10:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZeNLyK2suhR8uGJ46yXF2M0sU1AiT8sEDg9A7TcTNvY=;
        b=kaqWJg6NrO5ba27YvADuuywV4rBvY9Zej5bJroVK29M2h8UA5sGaX41EzuIDbG1Kxt
         +hXmt4f7LfTt/30Aa1JT1rWDt8H0kNtn4D+7sFStNEPAm9JE9l75QuF8mekNyT/Ydt9X
         w7P59yIMDkIG8yTrIpEhSxUKJj/0tCOlUuOT6SyFr6qJH72PZ+p+89tbsQofeRJayz9K
         MQNbc6I6JSBqvaCD5fBp+Tf1CeCJWHPkoqeA6LhjNx8J3QnSfNdH7A0F4xxXH8KV8FBt
         h4u6QIFghRWvDXgoHRriiv9aP0/kaw7guBJVAQMMCJ+CvzHvryrlBsl5tIILAE4RybsL
         DR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZeNLyK2suhR8uGJ46yXF2M0sU1AiT8sEDg9A7TcTNvY=;
        b=ML5YpaMejdmAV9ipt9g+R9JJUK4B2MfOQ6PIdI3YT7SWYbFYpeQfd7JDelIapJ72yG
         TXDzPo5lfG4EZ1qLr7cF6kI7jdjOm/o/bbif1hnSiAvNVd9S+qgQsRYrNP0uBZbUchWi
         Lobi9vDvMvopKXC+zI0tFirNMxE9WGv8XPmCFI4mh8Crd1kNu5WrMPP3LPtfAjM+tkVs
         6yyTzohFoFWa0TPzAm1Z6qSSM3nn1FXpHR8qpS+d99uV8ZZnzWqvQtBoNBOcAOl8iB5l
         eAAJXlVPuor/27jUf80YZ4bKXPrFna1er0eh4232KGNv+l8zTWT/H7OaR6LuGPVlz7SM
         uMnA==
X-Gm-Message-State: AJcUukec+W5bvAvT7BM31QExWk1KLzBW6uLhIrUZUexNQ2KWSC+Y0vYl
        z9DwDm39V/F2TKTgAWuNmyCKMzpJ7Rs=
X-Google-Smtp-Source: ALg8bN5dK5brSDn3qCn8wrGcBLqS00IzF94sM5lts7E2v24qzwynerJjNHotdjLqv2wBVCnyU8nwDw==
X-Received: by 2002:a19:c345:: with SMTP id t66mr3757315lff.55.1548353917291;
        Thu, 24 Jan 2019 10:18:37 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm1115629lje.89.2019.01.24.10.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:18:36 -0800 (PST)
Subject: Re: [PATCH v1] lightnvm: Use u64 instead of __le64 for CPU visible
 side
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org
References: <20190124142207.9060-1-andriy.shevchenko@linux.intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5a9eb4ce-8ea8-d9b8-5e7f-291301725e63@lightnvm.io>
Date:   Thu, 24 Jan 2019 19:18:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124142207.9060-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/19 3:22 PM, Andy Shevchenko wrote:
> Sparse complains about using strict data types:
> 
> drivers/lightnvm/pblk-read.c:254:43: warning: incorrect type in assignment (different base types)
> drivers/lightnvm/pblk-read.c:254:43:    expected restricted __le64 <noident>
> drivers/lightnvm/pblk-read.c:254:43:    got unsigned long long [unsigned] [usertype] <noident>
> drivers/lightnvm/pblk-read.c:255:29: warning: cast from restricted __le64
> drivers/lightnvm/pblk-read.c:268:29: warning: cast from restricted __le64
> drivers/lightnvm/pblk-read.c:328:41: warning: incorrect type in assignment (different base types)
> drivers/lightnvm/pblk-read.c:328:41:    expected restricted __le64 <noident>
> drivers/lightnvm/pblk-read.c:328:41:    got unsigned long long [unsigned] [usertype] <noident>
> 
> In the code it seems explicit that lba_list_mem and lba_list_media members of
> struct pblk_pr_ctx are used on CPU side, which means they should not be of
> strict types.
> 
> Change types of lba_list_mem and lba_list_media members to be u64.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/lightnvm/pblk.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 12bf02df4204..72ae8755764e 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -131,8 +131,8 @@ struct pblk_pr_ctx {
>   	unsigned int bio_init_idx;
>   	void *ppa_ptr;
>   	dma_addr_t dma_ppa_list;
> -	__le64 lba_list_mem[NVM_MAX_VLBA];
> -	__le64 lba_list_media[NVM_MAX_VLBA];
> +	u64 lba_list_mem[NVM_MAX_VLBA];
> +	u64 lba_list_media[NVM_MAX_VLBA];
>   };
>   
>   /* Pad context */
> 

Thanks Andy. I've applied it for 5.1.

