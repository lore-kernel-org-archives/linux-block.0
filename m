Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C870DC433F5
	for <linux-block@archiver.kernel.org>; Fri,  4 Mar 2022 20:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiCDUB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiCDUBt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 15:01:49 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8028670E
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 11:55:04 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso10586338oop.13
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 11:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cD1ZoJibPx8a6ZYW0ir6GwlMwbk0v99dWXm7GlqXJtc=;
        b=yzTBVOHnh2/lw1WEi4Ftyjn9MmKcO9GR999iIl8QDIZ8f473bfhyN+JaqsqzCf6i8+
         KfnqV8aXwP3PhTehm3xjxJL0WmXoo80zbuwPhuaD00i9czLxTl8fFoQmI6ceYGlJB3JU
         uuI51gvQCE0Q916NvdJ4VvdTe8ukIxYdkEG2gUrn7dr94mWE+WPc6+k6Xiz64DyxZFyQ
         20ui0jlVJi8XEJpnblrxChpqSRsV9XHvbxv8F7PpND2WsXtGXeL4CJtb4oszPVY8TSaR
         4nJdXt7Q1nL3y0Iy+yZTxfMtychsLFmirQVMdDLaNAuJMadAednHVU0vTGCUWqK2H2BX
         NMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cD1ZoJibPx8a6ZYW0ir6GwlMwbk0v99dWXm7GlqXJtc=;
        b=vapBaE1ZK524WCUYV0wrP3n3C2WshWkqaMhhcZeXu5eZIUfJBmZxU3MY3GV/mjmvGR
         YEnRtHA0JdBzumaOkr2AxyOrazOr6I5xU73LHCa6ln8/Me6bN8Ue23Mvke8CQLf5J6se
         ZHZ/BKUs2Kdf03GlM6KXhkT8FH1jt0g6adnbFwrMmQ+p3AVDTdGUR4O1VwRopg/TEA9s
         PmMpj36wQ0wexYpNxVengZOnXlo1nLtD+CDSNkJq0KMHObZA8NOMTy8VSrjQPtWcVp+J
         wyes8xhSYxj8TzCa28niU6m0dPjeqpDAWZWFkObJtcTgPiZthlkduaR39Om/I5HSuNo9
         CBiA==
X-Gm-Message-State: AOAM531UdOsKS0/i3GZsaiLZ+eN4F0PDPseMlYrNqaSjQu2aDpMdbQA5
        wuoj2zSkidc0ILHHUK0zOO8Ijfm9z6X5Gg==
X-Google-Smtp-Source: ABdhPJxaPNpPdHGtkzBqxR/AbybSNjglxB1qWnG9jsxe0tCA2gjxU9n2s98hohxcBA0drNnu+IBOcw==
X-Received: by 2002:a17:90b:3802:b0:1be:f687:7875 with SMTP id mq2-20020a17090b380200b001bef6877875mr161792pjb.109.1646421866217;
        Fri, 04 Mar 2022 11:24:26 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm6813168pfj.112.2022.03.04.11.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 11:24:25 -0800 (PST)
Message-ID: <62cc1a9e-6259-d409-1bcb-11c760b0c691@kernel.dk>
Date:   Fri, 4 Mar 2022 12:24:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     sagi@grimberg.me, kbusch@kernel.org, song@kernel.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220304175556.407719-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/22 10:55 AM, Christoph Hellwig wrote:
> With the NVMe support for this gone, there are no consumers of these hints
> left, so remove them.

Looks good to me, didn't find any missed spots.

-- 
Jens Axboe

