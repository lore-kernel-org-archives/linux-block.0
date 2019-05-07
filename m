Return-Path: <SRS0=61bd=TH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC6EC004C9
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 14:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AD120825
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 14:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c9xaZQpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfEGOj2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 10:39:28 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33585 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfEGOj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 May 2019 10:39:27 -0400
Received: by mail-it1-f196.google.com with SMTP id u16so12426349itc.0
        for <linux-block@vger.kernel.org>; Tue, 07 May 2019 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x5Fko6HiVlIQb9DPGKSesbmDeWCk7V4xMBBezPIzv2w=;
        b=c9xaZQppx2kwi7qudO45vxsctBfhFq1s7gI7Cr26MHHrFweV6K3R84PtPDt0lbvzip
         VaibCXIQJRVOpisKNce24y0PfSLNIrLNcZTkRT7/4BWG57FNzPCEUvMj4l8FZaUefklz
         SoOknEU0E9toKyOCFHceMWxaM1OCHQnfuBGuz3P5ja2UpsTILSKXmxXMfGN1v44JzRz6
         +OlWIKwirkY/58WyNZZMgeB0xH0Q4aPj7DWmga0koGTCW0zXQaEymagG1UmMg8UBPsdH
         C6LZd5mKarcNWe2hurlOBMPhKAJora90xVH4qZg86sVqMmnbEgnK35XWbjQ4x0btSRKo
         cn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x5Fko6HiVlIQb9DPGKSesbmDeWCk7V4xMBBezPIzv2w=;
        b=O/2Y5TQ4u0nI0FN9BLUvksavPI+F+SUe7G3kyTmhpcAv3Kj9CWaEsMcVYu1X7msXtl
         7Q4l9WFacuLs3O5MtUXjy5KrSSNi71UU2bRmoxEDILDHY1QqJWejQK8RzqylIh8T3C3w
         KWsGL0Zg00ZVoEdhj5Nw8w79Vc5gTl1qciqypEcynyS3hV1QLQU8H/CmlIJbIQYcRUbj
         CzQo4rFy2tTYe1vMvUd/o9sa7jUEHbzxmaAryBcK6uL+XzMMIyMxFrKE1yEa+d8BUZjP
         u3T1Hsp8/3NKFqCj8nxW+EFs9pc+gpNUwG6UCzMa8wBQGF3IJng/rg8ri5ORj8jyJZDd
         svEQ==
X-Gm-Message-State: APjAAAVhyMLSbzhNArJMWeKYOPKJ3+baWuCwyk2jvMSSgPcQeNUobMyh
        bYc5cnFhg0m1VnkaS9/Imyyl+MlLV0rsYQ==
X-Google-Smtp-Source: APXvYqydMjtVkfkKR9Z1eT5733D7O3teSuCYC6AB3FTnwg6K1IrAOWr9Cz17ADnpMBl+T39W+jaHvA==
X-Received: by 2002:a24:2901:: with SMTP id p1mr13789510itp.54.1557239966503;
        Tue, 07 May 2019 07:39:26 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o199sm6372115ito.25.2019.05.07.07.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 07:39:25 -0700 (PDT)
Subject: Re: [PATCH] block: fix mismerge in bvec_advance
To:     Christoph Hellwig <hch@lst.de>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
References: <20190507065335.8138-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9663e019-694d-0557-0454-0c9fa7ddf69c@kernel.dk>
Date:   Tue, 7 May 2019 08:39:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507065335.8138-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/7/19 12:53 AM, Christoph Hellwig wrote:
> When Jens merged my commit to only allow contiguous page structs in a
> bio_vec with Ming's 5.1 fix to ensue the bvec length didn't overflow
> we failed to keep the removal of the expensive nth_page calls.  This
> commits adds them back as intended.

Thanks applied, that's my mistake.

-- 
Jens Axboe

