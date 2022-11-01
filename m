Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51384C433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 17:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKARXi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiKARXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 13:23:36 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53A16390
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 10:23:35 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id b185so14063647pfb.9
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 10:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlbtiP8HiyybwpV1KJjxxqYeazUDceDJBXJXnZJb2Lg=;
        b=lm4g1NpiYQn1XC3nvZfdum8NNsyxv60p85BosmqDFKuruNskVI4z+M4Qn4mTygv73R
         ed68TPB42WmCy46kKaUV1PoxqUFHxOCYXqOTxDd0wtuOornBLl2H6LedgrFNpCw5tZhy
         jW22w5jBFGpqePKVjmyjIi+42gA/RAX4lPvnMOMF9IdTH6aclzj1GzrCromiWAC4e0ap
         yeLQ/VIoBTiAT0N1K3JHCFYZ1LrjVzq1Eu4eMDBfVeA9Q2VgBU+fayuRDF8/XgSWqgYW
         E5o+8vp2SycEjmSNsD8EAEksATj/gp/HXEeCMvEudlC3+n3mom4dhT9wZDecENbux4Ur
         wpIw==
X-Gm-Message-State: ACrzQf0/ZsXUwH3CWyjwqSc28i2ODlwtLMTLP6YP3knqRcvpROZ0ySRW
        Jq/HVbs3YJdbQat/blV7rsQ=
X-Google-Smtp-Source: AMsMyM4hS1/QYrUBkfmnLy6TIjhxBwutI3ZhSfxB8K2MJfSkM30Vro1D69x4hr1YbDqw8HNOo1a80Q==
X-Received: by 2002:a65:6bd4:0:b0:443:94a1:429c with SMTP id e20-20020a656bd4000000b0044394a1429cmr18136371pgw.606.1667323415046;
        Tue, 01 Nov 2022 10:23:35 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8574:e82f:b860:3ad0? ([2620:15c:211:201:8574:e82f:b860:3ad0])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00179e1f08634sm6568418plp.222.2022.11.01.10.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 10:23:34 -0700 (PDT)
Message-ID: <934d8e30-8629-d598-0214-987580c349b8@acm.org>
Date:   Tue, 1 Nov 2022 10:23:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 06/10] block: Fix the number of segment calculations
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
References: <20221019222324.362705-1-bvanassche@acm.org>
 <20221019222324.362705-7-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221019222324.362705-7-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/22 15:23, Bart Van Assche wrote:
> Since multi-page bvecs are supported there can be multiple segments per
> bvec (see also bvec_split_segs()). Hence this patch that calculates the
> number of segments per bvec instead of assuming that there is only one
> segment per bvec.

(replying to my own email)

Hi Ming,

Do you agree that this patch fixes a bug introduced by the multi-page 
bvec code and also that it is required even if the segment size is 
larger than the page size?

Thanks,

Bart.
