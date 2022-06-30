Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A74C43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 15:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiF3Pno (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiF3Pno (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 11:43:44 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCF7B83
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 08:43:42 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id o18so17381964plg.2
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 08:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BjqJumHAhn5ihQXhyr+dts1a5LaV4XHNuzC2JQfwlGg=;
        b=ho0HatsWCBmTWxMgS5/y4/dbqwP1W+DvZLExuPOcZWDq+S3aU4n2loBA7FZ3Gqsov5
         xfkW12QNSFjjfVM7XA2l1tRkD6PXBNc1dkY/1s51UTOso21jVtn4IEUNFd5HSGyqEjqD
         Bu0gkJdVE7F4GPYIXAX1Cj632KhWKzIxt2miCHv0FDII46mKXzyr4qPiR+Y0Hcgig9qR
         oDY7p2uW8tI941XhPKI4foMK2vrI2H+79zRvLnH2HGxEz6g31G88Y3bi7GkWMzz5B5/G
         CapaCSvVsR/s3jsXxDUoj+DXnFZLS4Y4bGIpkps1sp2qGlHe3nTc56NXvo1EZZ52Lp86
         6woQ==
X-Gm-Message-State: AJIora+W067vWH5SUM61sYFLIIjjBDCNW2ou/Csmqo1PKW6743A+Ltcc
        0OqtC4ILsBy1ewlCPxJFLaA=
X-Google-Smtp-Source: AGRyM1u7wQLZSJdWwze079VKlkQB3CARiRlHEcgrqXqs353mpoxmg8NSqQWCkydnrrRpqoRFE2QFWw==
X-Received: by 2002:a17:90b:1d0c:b0:1ed:54c3:dcaf with SMTP id on12-20020a17090b1d0c00b001ed54c3dcafmr10702699pjb.217.1656603822103;
        Thu, 30 Jun 2022 08:43:42 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b0016362da9a03sm13570070pli.245.2022.06.30.08.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 08:43:41 -0700 (PDT)
Message-ID: <de001cb0-38f4-14c6-d032-1f1a05308adf@acm.org>
Date:   Thu, 30 Jun 2022 08:43:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH blktests] common/multipath-over-rdma: skip NO-CARRIER NIC
 when start_soft_rdma
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org
Cc:     shinichiro.kawasaki@wdc.com, yangx.jy@fujitsu.com
References: <20220630095625.2705173-1-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220630095625.2705173-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/22 02:56, Yi Zhang wrote:
> The rxe/siw driver will be bind to NO-CARRIER interface which lead
> nvmeof-mp/001 failed.
> For example, nvmeof-mp/001 with two NICs, if will output
> count_devices(): 1 <> 2 when the second NIC has NO-CARRIER

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
