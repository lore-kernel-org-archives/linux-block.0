Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BECC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 16:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiFNQj1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiFNQj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 12:39:27 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BD7167E0
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:39:21 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id h1so8174313plf.11
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8gfxpJvHcIjCg9eZ7VpKQJ9lwYv6reCJqVJnZWks3cE=;
        b=mBL9slbn7ELeu0x7oYMTmptUG8ZBj0vScy0IgMMiax7sMwH6ZAmy9XhhMXx1Vti5aA
         W3TpjtiAk36F68g8O2zJJ4R1HPay345fCGuFDLiN/cobN9osfFPVcxiwLYbtam7yiZkY
         9ialEUBrf3nMoBwRWGUubYMR5IepLk1EtfsD4ORd8u18Cfw3rYwHd6NFK+f6HUED/Hlh
         1GjMyANRQsqJI5EpQFBES8h+lRZGKcvQID8QdF8AMhkybC0MfcRlf2kxd4IWZmjWxCC0
         oPvLaKvcSJUB5DvmcO5ZEx3BIPs0/+iUE3Ff8VZ0/c/yLdxH1IaqjL/4YoDFbh0/u/gz
         lotw==
X-Gm-Message-State: AJIora/B10ZxHtASamKYZBY7+EBbouTQbMSVJrDgBJYzHb7nOgouMDS1
        OJSPpqc9+F9XG+gJ4QungsY=
X-Google-Smtp-Source: AGRyM1vmYNK+JN+7FV3Iy9BrVVtauHt15Mvwagcwi/WHAsUuZbIsqq5gugNNjIjt2hEv0WETxpOK9w==
X-Received: by 2002:a17:902:9b83:b0:164:59e:b189 with SMTP id y3-20020a1709029b8300b00164059eb189mr5016967plp.91.1655224760927;
        Tue, 14 Jun 2022 09:39:20 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902bd4a00b00168b7d639acsm7460789plx.170.2022.06.14.09.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:39:19 -0700 (PDT)
Message-ID: <126e6f2e-a8a9-872e-0efd-668dfaa660c4@acm.org>
Date:   Tue, 14 Jun 2022 09:39:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/6] block: factor out a chunk_size_left helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220614090934.570632-1-hch@lst.de>
 <20220614090934.570632-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220614090934.570632-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 02:09, Christoph Hellwig wrote:
> Factor out a helper from blk_max_size_offset so that it can be reused
> independently. 
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
