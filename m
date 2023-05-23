Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E80C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 20:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbjEWUE6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 16:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjEWUEr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 16:04:47 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D122E119
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 13:04:46 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso214581b3a.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 13:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684872286; x=1687464286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ROx5C155uFfS+qd1DnouWLX9r7Es6rVF4WSGKW8GB0=;
        b=hsXGaf3gRKApFIUphdyOF+cb4mEiXcN44oAV29kI63zx0oNfB8iyOqHoW7bPrVPgMw
         Rzok7rCvXbKBDL/rypUKLlcUzyhLflv+EhtpS7MsbXO85xZI7YSnuTLJFx+4ZCfHLqXC
         9kG0M6hNnvM7chZth7hz/4KSAqChEJiGGC7N5qUORCs/IgORrD5e0j8V9AF1U7gNbmOU
         xjiRqPzW9SoO8WACyhIdXzl9XwcFneQ1pOYN0249Yj8PEirHDlck/2ijD+s9nalJM6ae
         ePiCmhzQ9ag01QZLnBe0a0ajywYbEJd7FMxrV+W87yQlld/0YRyx5m187uRIOIqE0Iv+
         EHMA==
X-Gm-Message-State: AC+VfDxdsHg6y156ce5c3zM4KfhLAOteuI1ovL/fGD6Pcv/1mQjl5b88
        fCWzKPrs6sdOgU0//3nHz7CTh8732M0=
X-Google-Smtp-Source: ACHHUZ43FCLON9MRX1XxdCJMCPwW1CLPPL/iVx2yUjvNruhnijDVGk6xR+N1JjJsXbbQ9L+1PqYKBw==
X-Received: by 2002:a05:6a20:1590:b0:101:8b:43a5 with SMTP id h16-20020a056a20159000b00101008b43a5mr17446140pzj.8.1684872286199;
        Tue, 23 May 2023 13:04:46 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:24d2:69cd:ef9a:8f83? ([2620:15c:211:201:24d2:69cd:ef9a:8f83])
        by smtp.gmail.com with ESMTPSA id f14-20020a63554e000000b0050927cb606asm6139080pgm.13.2023.05.23.13.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 13:04:45 -0700 (PDT)
Message-ID: <d372a3b8-f5ef-f281-bb3d-315030504d4f@acm.org>
Date:   Tue, 23 May 2023 13:04:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/7] Submit zoned writes in order
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230523072216.GE8758@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230523072216.GE8758@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 00:22, Christoph Hellwig wrote:
> On Mon, May 22, 2023 at 11:38:35AM -0700, Bart Van Assche wrote:
>> - Changed the approach from one requeue list per hctx into preserving one
>>    requeue list per request queue.
> 
> Can you explain why?  The resulting code looks rather odd to me as we
> now reach out to a global list from the per-hctx run_queue helper,
> which seems a bit awkward.

Hi Christoph,

This change is based on the assumption that requeuing and flushing are 
relatively rare events. Do you perhaps want me to change the approach 
back to one requeue list and one flush list per hctx?

Thanks,

Bart.
