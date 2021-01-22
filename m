Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C01C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 04:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C439238D7
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 04:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbhAVEnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 23:43:43 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:35751 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbhAVEnm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 23:43:42 -0500
Received: by mail-pj1-f48.google.com with SMTP id b5so3073536pjl.0
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 20:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QLFXY8tdiigAj+EhvoY8oqr1lpb8jqzHnycFCWyS6ww=;
        b=htx7R1+TrrpB1vtuR06K4h3vcbha/iAgAY61pPsCEzBY51B/ecV43NzEszZMDAaqaY
         3yfwypXdA/23fHqSRnB8wXEc7M8XgodZOCPgMSMfQy7SknYLgsl9i0jC/cdIYgfpWw7c
         wyHt6aHy/ZIK1vWguXeDx7yydTQuee4+UwCriXX/atY80986vyQAXvFKdAVVa4WMg9kj
         HvKhiOJE9D2kmNWRtUEENthJyml/m43RN7IARoxZJv/0YV9bT9v+rxq1T6fNmAO6HLy0
         Ltv75umJ/spFK/w5Mg/QYYQBds+kO+rh1jIvzYpcNL1AwDL3XgBfgUk6nVoNqZDItytd
         q+tg==
X-Gm-Message-State: AOAM533d8bS1+j7eOZP5YTg3+NwtIM+8p9Wpc3kmpv/P3NQoNffYqfIH
        eEs7qS5xIm5nM0iw6bzskQ8=
X-Google-Smtp-Source: ABdhPJyoZ7yQ02Gnfthcb2XB2slcV2xQSwskEtLxsXiTteHarLBwUoj8X4o/uNY2AyLApnsCT0q+9A==
X-Received: by 2002:a17:902:7881:b029:df:de74:e333 with SMTP id q1-20020a1709027881b02900dfde74e333mr539489pll.34.1611290581456;
        Thu, 21 Jan 2021 20:43:01 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:ca83:1207:86f7:dfa? ([2601:647:4000:d7:ca83:1207:86f7:dfa])
        by smtp.gmail.com with ESMTPSA id b18sm7299405pfi.173.2021.01.21.20.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 20:43:00 -0800 (PST)
Subject: Re: [PATCH blktests] rdma: Use rdma link instead of
 /sys/class/infiniband/*/parent
To:     Yi Zhang <yi.zhang@redhat.com>, Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20210121035954.7245-1-bvanassche@acm.org>
 <be50e09c-393d-2ee1-1128-1149baac0da2@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <96108378-b0b9-8be9-4f4e-e26a78a2ba9f@acm.org>
Date:   Thu, 21 Jan 2021 20:42:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <be50e09c-393d-2ee1-1128-1149baac0da2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/20/21 10:58 PM, Yi Zhang wrote:
> On 1/21/21 11:59 AM, Bart Van Assche wrote:
>>   rdma_network_interfaces() {
>> -    (
>> -        cd /sys/class/net &&
>> -            for i in *; do
>> -                [ -e "$i" ] || continue
>> -                # Skip IPoIB (ARPHRD_INFINIBAND) network
>> -                # interfaces.
>> -                [ "$(<"$i"/type)" = 32 ] && continue
>> -                [ -L "$i/device" ] || continue
>> -                d=$(readlink "$i/device" 2>/dev/null)
>> -                if [ -n "$d" ] && is_rdma_device "$i/$d"; then
>> -                    echo "$i"
>> -                fi
>> -            done
>> -    )
>> +    rdma link show | sed -n 's,^link[[:blank:]]*\([^/]*\)/.*,\1,p' |
>> sort -u
>
> We should list the network interface here(like eno1), rxe/siw interfaces
> will not work for function get_ipv4_addr

Thanks for the feedback. I will fix this and repost this patch.

Bart.
