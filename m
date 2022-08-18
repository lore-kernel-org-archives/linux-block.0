Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCE7C32774
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 20:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244802AbiHRULm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 16:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346256AbiHRULL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 16:11:11 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76288D8B31
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 13:06:33 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id l64so2124642pge.0
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 13:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=90Jq3SgnPkseyP4ra33crS1/8d+KMSz0AnMDProa17I=;
        b=j0OY3E8sYSm7PDOnELwDrfqKNBcdTe55uMffE8KeXL8WAUSKt2DXnXsKEYHVwAXPri
         B4dtfV7HJ5EUctPg/h+qTFwDnKNll9tUGsN5Lvd38tKsFseu99ctGtD1B/LL71heB/Lj
         jqNmb62ITs+AbZbtcLy6RWG321y7BHOclIma78GihAPh+7+K5USyEFJRqsOQnYFAOx5k
         nXDaRLLRjmGzEedf2CGZ2IbR03KG7dbjsOJVsMdV8y2nrQCR9Xdk8e7faplO8fKKjX4E
         x3bibQknMLKVNDJF3WJJYlkKRf1GhHR6hwAyFsNi2yhmjuqKBUMwvF//t2nZeDTHonUI
         d8dQ==
X-Gm-Message-State: ACgBeo1SGuPeFebLRtZ5tKhi2rLuU8EL2KPty1UWPXLzIJV/gYKCXdcu
        eV8fxe65tmW9MtwmkIIxXYE=
X-Google-Smtp-Source: AA6agR44QKDxqsIf3hJ4HURlBTUUQpVtheGRXhUSOr+XiSgGRyu1zM/XQOlEJGRo3cdC9Ua7VBJe2w==
X-Received: by 2002:a63:2148:0:b0:427:17f6:7c05 with SMTP id s8-20020a632148000000b0042717f67c05mr3569473pgm.200.1660853175776;
        Thu, 18 Aug 2022 13:06:15 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id nb16-20020a17090b35d000b001f516895294sm1903775pjb.40.2022.08.18.13.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 13:06:14 -0700 (PDT)
Message-ID: <2ff71856-f2ec-523c-6053-9dbbc693a78a@acm.org>
Date:   Thu, 18 Aug 2022 13:06:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests v2 3/6] common/rc: ensure modules are loadable in
 _have_modules()
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
 <20220818012624.71544-4-shinichiro.kawasaki@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220818012624.71544-4-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/17/22 18:26, Shin'ichiro Kawasaki wrote:
> +	count=$(find "$libpath" -name "$ko_underscore" -or \
> +		     -name "$ko_hyphen" | wc -l)

Do all Linux find executables support -or? It's probably safer to use -o 
instead of -or.

Thanks,

Bart.
