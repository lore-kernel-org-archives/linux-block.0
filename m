Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0AFC43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 19:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752F920872
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 19:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="qclQwNWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfCQT4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:56:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40987 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfCQT4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 15:56:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so9754878pfn.8
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2019 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XmN8trtNMcOZV0DzNrz35xUGpy2MLLxZR3bNF7qI1kE=;
        b=qclQwNWhC2YRDkBGGitxKFJFW1CAh/ZWskdRgLEL8S/+WlTBbFeOO1dUD0w23ETffw
         uBQFQDVyr6XkIz57VD25wLP29WYAyiwPCcOImW/odNEwgjAfmJW9PymmWnezR3lGgIIU
         5odocwVU5yZANOrwJdHVzwN0SCbnhpA4kWObASHwdiR+sIetUr7wNYxMo2TYnAfSPFOO
         1/Ih604poTxouxoOJBjdmRutDAdLvqc00K/cdJ+4CJxcLkwnf+dTVHlfpzG8TOC4NVYq
         tkNloytov6F37hfjaKtRyn3iWzhlumU3ZfKnz0HCJ/OGAwnVjIR2K2r3WW3ptvBhflZz
         5Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XmN8trtNMcOZV0DzNrz35xUGpy2MLLxZR3bNF7qI1kE=;
        b=gSRwJPTgoiQfeYtwvQ4ZMqx8gj3xDtkqqzMeaBohQZulNVRY/ZrwR3n2Clg7FkKa0s
         Dg7C2ie5JMck4Aa4tkA36KNqFlvT1MVTrRo3Xo4QUDvkZo5ZBX7N057Y+P6+4Q/CQa6M
         W9LclnH/CMaUSMVUKxan249UWsmcOdp3D8JmIFzi2ZGS2JMfAzFL2WOGvyu7kGfttNEy
         t1OLmUnapcluRj74AC/rhEhmnAdggkuxjD1y4ukdlkKKEFJKbBuA1v0zUnhVDPDG39CF
         9rKRXZJcidlFbDnI8/gIobjmkHGnFzr03p9wWCN/DW7+MT/glVq0X8O1S8BqHJ/YDV7w
         lz4w==
X-Gm-Message-State: APjAAAUL+8gMfVlRRoguwX/aB87IMf+uysYoXr7wq8mWDfLs3BnUP2c6
        e266bI610mFI3RL7Xkb6RXPfPttpao+a2g==
X-Google-Smtp-Source: APXvYqxODccr0rvq4Hvw4IV/K1RR6gVlr5ChOdvF3Tvr04swMVxU2SdniK+NuP458CAwC9vdu0XAWg==
X-Received: by 2002:a63:d509:: with SMTP id c9mr14430338pgg.2.1552852571218;
        Sun, 17 Mar 2019 12:56:11 -0700 (PDT)
Received: from [10.111.76.104] (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p5sm11730794pfn.154.2019.03.17.12.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:56:10 -0700 (PDT)
Subject: Re: [PATCH 12/18] lightnvm: pblk: do not read OOB from emeta region
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-13-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e26818ce-6d2e-e7d2-bfb4-da83c198952b@lightnvm.io>
Date:   Sun, 17 Mar 2019 12:56:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314160428.3559-13-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/19 9:04 AM, Igor Konopko wrote:
> Emeta does not have corresponding OOB metadata mapping valid, so there
> is no need to try to recover L2P mapping from it.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk-recovery.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 4764596..2132260 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -479,6 +479,14 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   		goto retry_rq;
>   	}
>   
> +	if (paddr >= line->emeta_ssec) {
> +		/*
> +		 * We reach emeta region and we don't want
> +		 * to recover oob from emeta region.
> +		 */
> +		goto completed;

The bio needs to be put before going to completed?

> +	}
> +
>   	pblk_get_packed_meta(pblk, rqd);
>   	bio_put(bio);
>   
> @@ -499,6 +507,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   	if (left_ppas > 0)
>   		goto next_rq;
>   
> +completed:
>   #ifdef CONFIG_NVM_PBLK_DEBUG
>   	WARN_ON(padded && !pblk_line_is_full(line));
>   #endif
> 

