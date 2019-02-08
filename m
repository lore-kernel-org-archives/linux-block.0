Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF22C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 19:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3ED21841
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 19:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Hg/N1PLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBHTvt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:51:49 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40849 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfBHTvt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 14:51:49 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so11882492ita.5
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 11:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GWVppPOEhGOVkE9N5iXJ57tNN87KWELCEZAs4rg1ih8=;
        b=Hg/N1PLbp9z3oRPEMlGv2eHv519osEoOQvoRJrh2fdDV9C1otaVM1xSUlZkK5iScDn
         Hh82ApHzFsbQPvQUiRYjgFELYQIGUsQQpYQxQ8UYFtNkxrA6NHhPZkTH40/63duaqBZa
         bk8GbYa8KPzk+nIebA+7m5DdMxhhVQLBUWJSpdQhCha3oBUZxUAsK6eGzcwhTHmwr0co
         RFVPDF/QZr7GqatwTtjqwDBi/bW9EVXT1VlcNZCMexc4EQdYJfrwJnIH3sIk0h6acQmb
         2QaaWIoaxQkHbZwVjYF3Rsf7j0ujVoAjvPKzpgv+NoB0ti75Qo9dpq+v5Ayu7UZ1IjQn
         qRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GWVppPOEhGOVkE9N5iXJ57tNN87KWELCEZAs4rg1ih8=;
        b=ZUffsaAgfec63uSG2wHRrHSH8p3auVXHmxZSCrblqovyW6w67sz9HKEpJjug7JxX3L
         d41C54lMXHfSWEo8gseBEv/WjniVZznlS/yRqBtaKjjSEgEyg30AlpK3foYQ4z57eoj8
         RXZTR8v2OgVVqDZhAq9l0zz6DrnjljukwXLDkYLtdRCKdA1XsBD/UZ6KFXhpbWux8puX
         hnTHKPHXInAfj8PpZUTvjJH3O8V5gzv7dVAo+cEXOqkXIrpCOziTZLSLfKyt/7n5Irwl
         9gSYCRJF3ds0IWmRd6V+vd/QN/bEhdnExpDv4pwP91qhcPHIAQagBZu9iFCy7WrJgbLK
         ol9Q==
X-Gm-Message-State: AHQUAuYH+vLTxZihvvknR6YPVG+rr9Mvk0vWpG6LvYsWr28YKmsCIj4S
        mohWSh2C4bVOr/HrEsZ9vs08Og==
X-Google-Smtp-Source: AHgI3IbSWAxKw/Q+d2Doo7nFmeXEs9T4hhDyV3CzuxxqX/2ZcZQex/YtzuzOERyRpeR7bhGNDZ7fLA==
X-Received: by 2002:a24:10cb:: with SMTP id 194mr108017ity.173.1549655508287;
        Fri, 08 Feb 2019 11:51:48 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x6sm1255046iol.19.2019.02.08.11.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:51:47 -0800 (PST)
Subject: Re: [PATCH 13/19] net: split out functions related to registering
 inflight socket files
To:     David Miller <davem@davemloft.net>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, jannh@google.com, viro@ZenIV.linux.org.uk,
        netdev@vger.kernel.org
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-14-axboe@kernel.dk>
 <20190208.114909.2274258441884310233.davem@davemloft.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <234470b5-ab86-a526-84bd-1b81254c3c14@kernel.dk>
Date:   Fri, 8 Feb 2019 12:51:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208.114909.2274258441884310233.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 12:49 PM, David Miller wrote:
> From: Jens Axboe <axboe@kernel.dk>
> Date: Fri,  8 Feb 2019 10:34:17 -0700
> 
>> We need this functionality for the io_uring file registration, but
>> we cannot rely on it since CONFIG_UNIX can be modular. Move the helpers
>> to a separate file, that's always builtin to the kernel if CONFIG_UNIX is
>> m/y.
>>
>> No functional changes in this patch, just moving code around.
>>
>> Cc: netdev@vger.kernel.org
>> Cc: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> No objections on my end, feel free to merge this in with your series.
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Great, thanks Dave! I'll add your ack.

-- 
Jens Axboe

