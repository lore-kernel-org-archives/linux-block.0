Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F0FECAAD5
	for <linux-block@archiver.kernel.org>; Fri, 26 Aug 2022 16:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbiHZQGv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiHZQGq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Aug 2022 12:06:46 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD28D41A5
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 09:06:43 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso252480pjv.0
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 09:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HstNGJfk5Arqm9BrcEVg2a/rhvyFyXDTLuukw7Xd4tg=;
        b=B34QrmRBcBeE8tvXgMKkp9dbzhYbDSyt25IoPz5kpOP5xGmbAh4FMn0ohQgIQBXLjI
         Gzi4RYe0G4oyAPqBm57mMrElPy23A+Y/H9wL4T46qfh6AgQlIPoUCMa7Nwx0WEiM8YEa
         Tn8ruJ0O9lt0whW6Dh2qhWcgrQ+T9RdUapZnxiZgbiW2DPcceCXU9gy1YiaL4j36g5Xd
         ehqdrzg+EmFLxzWC+V6Io76+VkkfXWZYt/a+ttqVUMUfXo1gPfe92SQPCE3upBUUePCm
         BAeg54ccrGBh+cSs/jGZkPACCB2hUamxjOJ2o4YvmWEb77R0ZFrgO8OtPMhwe/7G/ZBg
         rTtg==
X-Gm-Message-State: ACgBeo3yIqvvGwcKfZkUIbcIiNExDYVX9tl5dkh1aqam1MNXnHU9uv/+
        9Vi3e62AXviiBqDdNs5kK60=
X-Google-Smtp-Source: AA6agR4+NFIEYmAmMTeW3wqMJUuuNWOLJdNBOirtX6ZcyfR5fx4hWbeaKFnuNsqSQ7yCnybTRnHUqA==
X-Received: by 2002:a17:90b:1e53:b0:1fb:3aba:372e with SMTP id pi19-20020a17090b1e5300b001fb3aba372emr5237099pjb.34.1661530002677;
        Fri, 26 Aug 2022 09:06:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a12:b4b9:f1b3:ec63? ([2620:15c:211:201:a12:b4b9:f1b3:ec63])
        by smtp.gmail.com with ESMTPSA id o1-20020a62cd01000000b0052d432b4cc0sm1914409pfg.33.2022.08.26.09.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 09:06:41 -0700 (PDT)
Message-ID: <f95bf278-e999-2068-01bd-c01f363e66a5@acm.org>
Date:   Fri, 26 Aug 2022 09:06:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] block: I/O error occurs during SATA disk stress test
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, gumi@linux.alibaba.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org
References: <000a01d8b8fb$7b4a7950$71df6bf0$@linux.alibaba.com>
 <81c70a13-0317-49b7-c3b6-61f6aaa21c10@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <81c70a13-0317-49b7-c3b6-61f6aaa21c10@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/22 06:36, Jens Axboe wrote:
> That aside, I think there's a misunderstanding here. v1 has some
> parts and v2 has others. Please post a v3 that has the hunk
> that guarantees that deadline always has the lowest bit set if
> assigned, and the !deadline check as well.

Hi Jens,

Would it be considered acceptable to store the request state (rq->state) 
in the lowest two bits of rq->deadline? This would reduce the deadline 
resolution a little bit but I think that's acceptable. Except for 
blk_abort_request(), all changes of rq->state and rq->deadline are 
already serialized. So with this approach only blk_abort_request() would 
have to use an atomic-compare-exchange loop.

Thanks,

Bart.


