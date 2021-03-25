Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B98C433C1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8381061A41
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCYVvs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 17:51:48 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:41584 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhCYVve (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 17:51:34 -0400
Received: by mail-pj1-f49.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so1521678pjb.0;
        Thu, 25 Mar 2021 14:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1zlx7U8zMxFMkzfA5vorsSxNONk+fwIqBOsm+WJihPg=;
        b=K2p7OaLNES7ysHOV9EiD1OySRUBom5Qnq4S625kSHdBZbOB2BT8MTkznZrAcHe3dmq
         H6Gs/NKdC7WFSUo5FlPryIw705We8BvG8w38lkumnqs05c4GFPHx1a/q7D6DfgJUK6Vv
         Yq7SVYM1UYsH5a7xYH2DV5dNSC4Chmt+C7jyB6jTNsVb4nsV1OSe7JBtQ9/5+17OGwEE
         9R1Djcpg88uAxTnvBp2tEF2tNgwpq2nrstHiBgvAZ2u7dN7YIQ1Q4En4h76Vtdks/xnU
         cPgzFp/6sWarIUaUJTkKHTHdywnS9wnaxzW+euQcewOK1uyOd9v6GLWb68Y15/wL1V1z
         FXHQ==
X-Gm-Message-State: AOAM530nhIWGYmuPU5qnsq8QQSAzWIgPY/OCL0oPE+ITjafZXI0pJoPC
        7Mr6IpG8KKoOGUOfvoWTjW8=
X-Google-Smtp-Source: ABdhPJznDSZthWmbnsJAFrBGlFNhVvQtF5BmGswKFtsmyQpJntQg/FdFYUaEoqmBK2DEJVkGjJZ3hA==
X-Received: by 2002:a17:90a:3809:: with SMTP id w9mr10481793pjb.79.1616709093981;
        Thu, 25 Mar 2021 14:51:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c5af:7b7c:edac:ee67? ([2601:647:4000:d7:c5af:7b7c:edac:ee67])
        by smtp.gmail.com with ESMTPSA id z25sm6685401pfn.37.2021.03.25.14.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 14:51:33 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] ensure bios aren't split in middle of crypto data
 unit
To:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>
References: <20210325212609.492188-1-satyat@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e0248d93-e880-6a6d-92d6-dfcfb6f9d661@acm.org>
Date:   Thu, 25 Mar 2021 14:51:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/21 2:26 PM, Satya Tangirala wrote:
> When a bio has an encryption context, its size must be aligned to its
> crypto data unit size. A bio must not be split in the middle of a data
> unit. Currently, bios are split at logical block boundaries [...]

Hi Satya,

Are you sure that the block layer core splits bios at logical block
boundaries? Commit 9cc5169cd478 ("block: Improve physical block
alignment of split bios") should have changed the behavior from
splitting at logical block boundaries into splitting at physical block
boundaries. Without having looked at this patch series, can the same
effect be achieved by reporting the crypto data unit size as the
physical block size?

Thanks,

Bart.
