Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5F0C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6D02085A
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fneiHGqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfEAMuO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 08:50:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40587 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfEAMuO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 08:50:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so8152363plr.7
        for <linux-block@vger.kernel.org>; Wed, 01 May 2019 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/YwK+YB1GFMTGIiBGHEWXgljt4JGSWuOs4TQjsIRwgs=;
        b=fneiHGqzRREb94cnU/bS7NeA3dXSXOkzM88BHZ8rGL9h0KXXxdvNM9JM/hd6J9J+4M
         zRi9DzpwDmhX137vxLYx4lH4U0Df0SjuLfXkGh6yaYSN38xcPcZRasQ8LO3h30sigO+Z
         JM8vmX6Y3oPtdLVSuNh2NyxKPQGrU+Mh9IoB6EfRIyThVSCifhRHAt6ZSI6Aj3qos7s/
         XBHZrk6FyF6h2S3spAGYFuIGFS61MHg3qYd0KYbnzvikB6Var89SfAxhbk0ZpumS4i5s
         s+eW3jc2CDPDwFhoMjxv7Zraf6EBtGCVPwbU+gB+8TDOibIgRuZ6ckwegKLQ2sEWTOm2
         udxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/YwK+YB1GFMTGIiBGHEWXgljt4JGSWuOs4TQjsIRwgs=;
        b=ee210VR3Mb187QwCgE63wj7gLmm8nPIGWof+Xncv+c2iDSJUX5lPJD4J3jys1yHsZr
         IdtzwNHRH+BlGBl5wBdbwNtO+lleOxxcD3Rug6WlS7QK19J6yln7jsnaTKwKDJZGoVZd
         w7C1ID9t++vjjJqlGYPizBHG1ThZCl8csSiwZyH4bpJU0+EmHPabESe5tUuygOjS5b3d
         +zvI9YXWD25reOmvWBYouhzq/4VDwKYHl+bNatw3IT75iwH1cS8QUUficYodaGnibodJ
         pMfxqLuVywpjMpptg/46N1a42uJdbRaILhn4Lb+XuBgcKHD727ZOoRrn7UsNbYr7Oh7R
         EUCw==
X-Gm-Message-State: APjAAAU5RCmtiAEfV7CLiVax2FNj2LXPKOUG9cYYVbhHXtDjJzQr85z1
        HMXxwNbBpaNhTAW79UrPMRnmnNf6RVZoJQ==
X-Google-Smtp-Source: APXvYqwILGw06h33GwQRwlrScbE3q9QGQXzvrHnXq6zZuIOiri1CxYhgZbn8UU5b/gsVrEJW/BUwpQ==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6mr36058863plb.4.1556715012698;
        Wed, 01 May 2019 05:50:12 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 6sm25564497pfd.85.2019.05.01.05.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 05:50:11 -0700 (PDT)
Subject: Re: [PATCH 0/2] block/iov_iter: fix two issues related with
 BIO_NO_PAGE_REF
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20190426104521.30602-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b7bf859-81a3-659b-d155-e561f187692c@kernel.dk>
Date:   Wed, 1 May 2019 06:50:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426104521.30602-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/19 4:45 AM, Ming Lei wrote:
> Hi,
> 
> Fix two issues related with BIO_NO_PAGE_REF, both are introduced
> recently in for-5.2/block.

Applied, thanks.

-- 
Jens Axboe

