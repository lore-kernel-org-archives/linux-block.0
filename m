Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A82C0015E
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 13:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjGGNv0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jul 2023 09:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjGGNvT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 09:51:19 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07F72125
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 06:51:02 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b8ad907ba4so10395955ad.0
        for <linux-block@vger.kernel.org>; Fri, 07 Jul 2023 06:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737862; x=1691329862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9TGMnbVU46dYlG5KhJ+u7QZlHzQ05hV9wom/7jXbyE=;
        b=ltz6Q5Kli8GQYaM23ZsRq/w9InXiaSVaMjBegzsTvgVbo+F6dLE/bYdEB3dYL3NU6V
         1dM8Ktt3MkVq9SDHGJKzCUIhWbdvxyQg1ZCgG/X8Wq3u375pGSD6jQ8LX5a5tR+Fk9yj
         WVKEGB+DEtQnkM4GT/ocHpeBpPwCUEpa6Dk70KzxFTT68iQy9wrhctpdnK4TJbrRVYdT
         Ta2FzqeREDBTym4CwGajDAXnsDQ/ZVz9YowMEzKglL8NUt9uaB1o2TKtidRUqZUkRvtm
         ey1/+6YsmpcuyjloCA7YUAiqtPIK6n1KDkXlRvFt1Wmi9S6tLlrD4wxTtAq1NGzl4C6J
         TqHw==
X-Gm-Message-State: ABy/qLZwnZ9fuXqTizZZ77JlTjFKkn/xROUNpsuBpNg9hZQp/qAtRVoc
        anElyODFdO4PBrUJofLrLXAbkhq68I0=
X-Google-Smtp-Source: APBJJlHaAMV2hwTIZE/6OJW4LsibYyPYmKCzcylx4cThLVA9hHkV5VtqjVXZTrWDjwKjMwvm6DAmIQ==
X-Received: by 2002:a17:902:bc85:b0:1b8:839c:12ea with SMTP id bb5-20020a170902bc8500b001b8839c12eamr4328061plb.48.1688737862097;
        Fri, 07 Jul 2023 06:51:02 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b001b54d064a4bsm3256425plr.259.2023.07.07.06.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 06:51:01 -0700 (PDT)
Message-ID: <cd79cb6c-8bd1-8289-5e96-24003a3159b0@acm.org>
Date:   Fri, 7 Jul 2023 06:50:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Do not merge if merging is disabled
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230706201433.3987617-1-bvanassche@acm.org>
 <ZKdebT5VRdr0qxxv@ovpn-8-34.pek2.redhat.com>
 <06034722-621b-e06c-53e6-d2151cc07a64@acm.org>
 <30620d8b-066f-7357-1d4c-2657d445e286@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <30620d8b-066f-7357-1d4c-2657d445e286@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/6/23 20:34, Damien Le Moal wrote:
> Ming's point still stands I think: blk_queue_nomerges(q) is the first
> thing checked in elv_attempt_insert_merge(). So your patch should be a
> no-op and disabling merging through sysfs should still be effective. Why
> is your patch changing anything ?
> 
> Moving blk_mq_sched_try_insert_merge() call to rq_mergeable(rq) inside
> elv_attempt_insert_merge() would also make a lot of sense I think. With
> that, blk_mq_sched_try_insert_merge() would be reduced to calling only
> elv_attempt_insert_merge(), which means that elv_attempt_insert_merge()
> could go away.

Let's drop this patch. Since this patch was developed against an older
kernel version, let me check whether this patch is perhaps only needed
for the kernel version it was developed against.

Thanks,

Bart.


