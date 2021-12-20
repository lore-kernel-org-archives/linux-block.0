Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A82C433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 21:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhLTVEd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 16:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhLTVEc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 16:04:32 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BA9C06173E
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 13:04:32 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z18so15043573iof.5
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 13:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uN4SjbUe9YF6qwO01cTR7g2tsoIAy6OXOzJPrRc0+O4=;
        b=2TekNM0IYjI8+XvKFfKPGkmP9MoJ6OIX1Shl91Ol0TNhmWSzic9Pf7E/lICK5Jg5Jx
         al0037LMTHUWJuOpg70iSanEpS8Kwc6KmpXwCy3cj+v8xmU1Ve4MgPsB6y8+QJ7QXOb7
         qHlDRCSWXKOH8z7v1Kd3gpmra0tafPo4hS8qGDWIRufeRoC79rNW9poCLK8QIfz8HICc
         rerUIgdG1HTyd1KSgnr/veZBI/6JvpZou1DFI3ncfTLPI9JJtx0kReA0O7MfBT98TOkY
         EfpGeKq2h8PUpqEES5d6M29XZuVlJz1kC28Dwcg4QK0TQ5KjKm9gvHsxYV9FCSfwIFlx
         tRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uN4SjbUe9YF6qwO01cTR7g2tsoIAy6OXOzJPrRc0+O4=;
        b=GLCbCHTUqH/9SlRSgzOoeB/TIlEgRL0U7llikvf2DHDGbHq4QuRW2xd984i+YSTcrM
         qsaeeZk6Lv9pCKolKcygwHB/TEfmQj+R8xfqcIGmzxrc1BUumtxsDo4Ie26eOb1gU6q+
         pFmlZbSCtxNSxwKDwU63qBzp7xGnxhcUTQ+9Xvsyegs3Zljv+vio1zWikXgPLA8cUWC6
         kuNFFyCuTeFFLIdMf/RuxJMJwI4QuciWIs3P9pcbZBwag4EHj99S8sruusoT/uIAgvEV
         49BosLUrGW7dHG9VfhBJRCXxnbJzbSyg2kcBRP29D2r+8De7zu7eOAbroqP8t8SgkbRp
         8qSQ==
X-Gm-Message-State: AOAM532vN+th4NgMIyuuKzT+DOAzpfqiEBlk8955DFRmmy0XkjURIM/w
        lzov3uxQnrHu3fvbqA7JtcjKGFXZjtcflQ==
X-Google-Smtp-Source: ABdhPJxosG4NkIDiyj1/oK8h2uAHhUXaucnnwMnmwkpe9vOHbQ/VdVOPMuVHCzan2T1kZOk64/cXFQ==
X-Received: by 2002:a05:6638:3183:: with SMTP id z3mr19722jak.108.1640034271509;
        Mon, 20 Dec 2021 13:04:31 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f10sm9809253iob.7.2021.12.20.13.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 13:04:31 -0800 (PST)
Subject: Re: [PATCHv2] blk-mq: blk-mq: check quiesce state before queue_rqs
To:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org
References: <20211220205919.180191-1-kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cdc3370c-dc05-2765-ecd5-1e001015400d@kernel.dk>
Date:   Mon, 20 Dec 2021 14:04:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211220205919.180191-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/21 1:59 PM, Keith Busch wrote:
> The low level drivers don't expect to see new requests after a
> successful quiesce completes. Check the queue quiesce state within the
> rcu protected area prior to calling the driver's queue_rqs().

Thanks, applied - I added a Fixes tag as well.

-- 
Jens Axboe

