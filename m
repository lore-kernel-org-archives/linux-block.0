Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C324AC77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 20:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbjEWUP7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 16:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjEWUP6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 16:15:58 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F2129
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 13:15:57 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-64d3491609fso163344b3a.3
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 13:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684872957; x=1687464957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vgyaza8IL9Y7OcUGpcvD/9vTAqVyU3t/7HCGDygR3A=;
        b=BiAR5cBw/OqllF+TgOUKx+hYpm0sbAlJRHMTSWXOJtZnHEKq0tlS1oXfvYeEyodgpa
         JMz5PkEYg7xhyRhIe8+uVKuNoChGLC9bqUk4rYYst6/63EfarEthhFAJKtFl+cVLtmWl
         2Njfh3+Nyrw/v+ZuxROvidblAgYdePAfdfvysNfNnsrvgMj16k+rmizu6nLC6GQNn1Tk
         aUxaWl3+TnxoBRDghyZ/Ufs9abTRwS724qGNtTW2zOtDGZ4VfquWkE9NMsTnIo7vOO97
         rHAcDd4ExK2H0wVBGJZvzf5cCCR83KXfzvJbCvlaWFjyhry0HTEdJQLYnIfQcHGxgy0+
         gZHQ==
X-Gm-Message-State: AC+VfDxnP3Gyqej03hYAxhmWsJc5DvCLDRgUWPwaZWhj9+8Dy3TCH0Qb
        LFx0JFOogE59m2BB1oAiPtw=
X-Google-Smtp-Source: ACHHUZ5tPSVI5tY1rGXW6UKxWpYOYnVtCPt9b69S1xESEHujhnfen/Lju6PDYFyZNGkjAUDRDm+aVw==
X-Received: by 2002:a05:6a00:1503:b0:64e:c85:4457 with SMTP id q3-20020a056a00150300b0064e0c854457mr356251pfu.8.1684872957115;
        Tue, 23 May 2023 13:15:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:24d2:69cd:ef9a:8f83? ([2620:15c:211:201:24d2:69cd:ef9a:8f83])
        by smtp.gmail.com with ESMTPSA id k4-20020aa78204000000b006439b7f755bsm6332446pfi.98.2023.05.23.13.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 13:15:56 -0700 (PDT)
Message-ID: <8b1d876b-fd37-5a0c-1e9d-253bf96e718f@acm.org>
Date:   Tue, 23 May 2023 13:15:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/7] block: Requeue requests if a CPU is unplugged
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-4-bvanassche@acm.org>
 <CAFj5m9+dhpqYSOVBQ+H0tCb1Y2i1wpFqn_anbDsfs=mYCTqgCg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAFj5m9+dhpqYSOVBQ+H0tCb1Y2i1wpFqn_anbDsfs=mYCTqgCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 01:17, Ming Lei wrote:
> On Tue, May 23, 2023 at 2:39 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> Requeue requests instead of sending these to the dispatch list if a CPU
>> is unplugged. This gives the I/O scheduler the chance to preserve the
>> order of zoned write requests.
> 
> But the affected code path is only for queue with none scheduler, do you
> think none can maintain the order for write requests?

Hi Ming,

Doesn't blk_mq_insert_requests() insert requests in ctx->rq_lists[type] 
whether or not an I/O scheduler is active?

I haven't found any code in blk_mq_hctx_notify_dead() that makes this 
function behave differently based on whether or not an I/O scheduler has 
been associated with the request queue. Did I perhaps overlook something?

Thanks,

Bart.
