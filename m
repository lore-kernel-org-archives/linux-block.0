Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5571FC282CE
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 16:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A3A20862
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 16:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="siFv7tto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfEVQtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 12:49:19 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:35159 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfEVQtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 12:49:19 -0400
Received: by mail-io1-f49.google.com with SMTP id p2so2433360iol.2
        for <linux-block@vger.kernel.org>; Wed, 22 May 2019 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wqvHroNFT1gOZ3Zyfegi5iTs0FDqPzcDe+bySanTD08=;
        b=siFv7ttoTiOxI6+mmiqV7/jCQeh/O2EKIYpvFXjM4NG0V6qxKScpoH6sK3u8Pw6CXw
         fCRol220RSti6/HNpj6rKNU2LGPaRBaqzVV5iltmtmhLteXx3rlEDnyR+Lw7vtQQtHpf
         0Sf6M1IM8GzG1vtn3oNDiRhsKyZb7eBtyh8BOiHYFVdpz6vxJvGgYJMp8GwB/qLN7NtH
         1TsGd52Ngmi/GAxsypK88dz+dH3uLtn4Vp3Uq3ra+weLG1S3X1nHF2sUBR9cM8mE1Y4Y
         ebIISwGu4zIGSRkSZWSf4JaiTpqLZsqvN3UJiW9R+oDE/twCEKi5ZzJ28xG3Jq3fxRQ7
         T/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wqvHroNFT1gOZ3Zyfegi5iTs0FDqPzcDe+bySanTD08=;
        b=S3CphDTqVhaS2H2CX2DyqQbElCPTN5uAUyN4YQDMdF2gUJz35AW0+2bBFtEVLjctR+
         WikEsdo2xA28M+ubNRDXhOjOS4K6cO7jfKA8G43wcqrLd7HdzLhQ0bDHH821yTVTTF+1
         mw0px71XEaeOMS4KDWpJgvRA4e2Ybrg2o/qYspl4kRcrUwjQu/PsZzKPriJ7Gm2JDvZ6
         XfpcoT2EZaZ9YoDXvdRjin9pvAbtGlb4BNWxjz19FFCXJr8/eHo+rqq5n7ur1jHkCvHS
         QLF4BWreQbBSSKzaaBWLkHqonl/p2Xm0raZL81ftV82pwbuM9CAMpreQkXdKKB5C/8q1
         lQqw==
X-Gm-Message-State: APjAAAXanV62KlibqIhUKm3pZk498P2Ox7NrvS6ZaDIUdRcvuwFb9nm2
        o/11cdqOPIYM+cdrsruh7J6m6p83Rxm64w==
X-Google-Smtp-Source: APXvYqz/YVQtZHP5dO+j+VRPGz0FoxW8zh1HmC4KgQTZbl3raYGN+D++sYjHCHYrCYlcLMp12gUgnA==
X-Received: by 2002:a6b:18a:: with SMTP id 132mr11602379iob.225.1558543758403;
        Wed, 22 May 2019 09:49:18 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w139sm3512487ita.43.2019.05.22.09.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 09:49:17 -0700 (PDT)
Subject: Re: [PATCHSET 0/3] io_uring: support for linked SQEs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
References: <20190517214131.5925-1-axboe@kernel.dk>
 <20190522163405.GA27743@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <96221d93-9428-cf68-8837-2f2b40e0c89e@kernel.dk>
Date:   Wed, 22 May 2019 10:49:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522163405.GA27743@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/22/19 10:34 AM, Christoph Hellwig wrote:
> This just apparead in your for-linus tree.  I don't think queueing
> up unreviewed features after -rc1 is acceptable..

I'm not pushing it for 5.2, nor was it my intent. I think I messed
up the branching, those bits will end up in for-5.3/io_uring.

-- 
Jens Axboe

