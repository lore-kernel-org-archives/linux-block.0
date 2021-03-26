Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321FDC433DB
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 03:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6B761A14
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 03:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhCZDsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 23:48:16 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:51028 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhCZDrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 23:47:45 -0400
Received: by mail-pj1-f51.google.com with SMTP id gb6so1957362pjb.0;
        Thu, 25 Mar 2021 20:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IvqEKjsOSXSVCaBU4hAjrkCMB1tDIaiTiUI6N7j8CrE=;
        b=ZIBgo8G7SGaNV745Y68pWQTUOAQJYwZP3ZMJJLnx2NbE+xAZdB5qfp6kB16BV55Kb+
         O4hpKhXNmcVRQVLcj5uzQHxvC/J1XzksF/PsqB5uQydWu6z+Twxpu+QcQhqaBuG2v2nO
         +n35INQYYjnge8C67WHXyi50IIpJmGtzp2Y8E/AGMXYtdud2uLwBA1VxDn4RwJKTn//Q
         abGlWRID/wBoU5i0+jLMmkR8CBAACAnw3mtDKamhRZDCwJu46OJT9l3Yj+5LxRXS3pac
         YlwN+LuDa4zzFzlaovLRzQVOIlLhw05L3ZZPe0E9NduouJw0giw7BrG5tx9MICNGjHtg
         5IKw==
X-Gm-Message-State: AOAM530XuG1XxkziQ2tmfcZHrA12eK9jqWK3poCx0Vtuk49X45jaZ+dO
        sqO0i2z5tgp39vGbUyANzpM=
X-Google-Smtp-Source: ABdhPJw4PcY53X/F96izvuQ740s4czxpb8Mui4wxLAAFykHoq2IuLU6VpLdeuWqbHVlLBdEo7aoR/w==
X-Received: by 2002:a17:90a:ab91:: with SMTP id n17mr12179184pjq.4.1616730465440;
        Thu, 25 Mar 2021 20:47:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c5af:7b7c:edac:ee67? ([2601:647:4000:d7:c5af:7b7c:edac:ee67])
        by smtp.gmail.com with ESMTPSA id t19sm7482900pfg.38.2021.03.25.20.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 20:47:44 -0700 (PDT)
Subject: Re: [PATCH v2 8/8] block: add WARN() in bio_split() for sector
 alignment
To:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>
References: <20210325212609.492188-1-satyat@google.com>
 <20210325212609.492188-9-satyat@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a31c67fa-0731-898a-e8d2-b7203d116405@acm.org>
Date:   Thu, 25 Mar 2021 20:47:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325212609.492188-9-satyat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/21 2:26 PM, Satya Tangirala wrote:
> @@ -1458,6 +1458,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
>  
>  	BUG_ON(sectors <= 0);
>  	BUG_ON(sectors >= bio_sectors(bio));
> +	WARN_ON(!IS_ALIGNED(sectors, bio_required_sector_alignment(bio)));

Please change this WARN_ON() into WARN_ON_ONCE() to prevent a storm of
call traces in the kernel log if this warning statement would be hit
repeatedly.

Thanks,

Bart.
