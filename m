Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FC3C49EA5
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 18:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7B2613EA
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 18:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhFXSDC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhFXSDB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 14:03:01 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4C6C061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 11:00:42 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s17so8357427oij.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 11:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rJuIGN7GjB6L6XxSqlkXLwyOaDFsEJtbk2PuRc4pRSk=;
        b=kU31kCRAB3j+/ohsdn5GfD8wx7B1JcRHvE5U9Fuq5Adr27aewRSnFlSnWSuoRH13j4
         e0B9QfWDrImiPYd5AJGdq15xl9p2s0bIx+fx1FIrFTJgu5yGv1G/cx2s3tmftwOnLkY9
         5646+a/RXCXtLLaqPTmomcoagRj5VFEY+roFmjFpzczBjkpkJyNRB5QBKY6bQRJmpn1I
         EssjA5t3fmICKP9MNoNvZ2Jg4yMFTacned/zmA5GZ3bUArWM2SQKn46bpfc1od5fyQgO
         zJwlSnlUzmqBACFfXYSSwicTvxI/9RUSGs1UcdzcccfO9oTWv3vAXn7zz8PATrcn0DT2
         hQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJuIGN7GjB6L6XxSqlkXLwyOaDFsEJtbk2PuRc4pRSk=;
        b=mTAYJNCkdONTN51FZ7pZ/mD89fUe8yqSPSvoaxvxzrDq8tG2189yD+O591elwYWjMB
         uzZwHED3Yo2ff3pVcJaR5CcbIHklkkhdN/12viQM8+Qq8f0ZC4qa3KJv2yT3d++08uOk
         wsffewgwBIVHIbLwx4JiX3dCpmOfDR9AXJJHa3yc1BqYFomU5zHwhicPyqsd90GJOj6I
         WrxR3+MxaIuRV88wLa6317ssto9YWlH4uhoJXbO0Jd4JBwVlFZiSlosS4QoancNP2kub
         cRIuvqv3UO+4400R2nR/UawvEPQVrTgip1ZVTRdf9WtICHYqH+imZ1mW/y/lPREuiwvb
         u4fA==
X-Gm-Message-State: AOAM532yOjHSVp+HbkR32S8jN3YD5bJWC1VZrQubAItt0EyF7EaYSpdU
        2WyOGDpF7CYOUX3aBK2CmaEQ+yLrfNZWgw==
X-Google-Smtp-Source: ABdhPJxgtbo5Aj0XRlXlLPj1Qr7v75qtE7IUDjNFj0I+LKH96v59gzX1EfwzVVZUbRCJIVo1rFibQA==
X-Received: by 2002:aca:c60c:: with SMTP id w12mr8273512oif.46.1624557641336;
        Thu, 24 Jun 2021 11:00:41 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id q13sm738196oov.6.2021.06.24.11.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 11:00:40 -0700 (PDT)
Subject: Re: disk events cleanup
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
References: <20210624073843.251178-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <12615047-efe6-09df-9a93-441f918c28b1@kernel.dk>
Date:   Thu, 24 Jun 2021 12:00:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210624073843.251178-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/21 1:38 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series first moves the disk events code into its own file, as it
> clearly is pretty distinct from the main genhd.c code (Tejun, feel free
> to add a Copyright statement as there was none), and then switch the
> registeration of the disk event attributes away from sysfs_create_files
> in favor of just adding them to the main disk class.

Applied, thanks.

-- 
Jens Axboe

