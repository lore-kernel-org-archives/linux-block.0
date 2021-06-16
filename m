Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264D0C48BE6
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 12:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086A660FE9
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 12:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhFPM4Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 08:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhFPM4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 08:56:25 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E34C06175F
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 05:54:18 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q10so2417266oij.5
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 05:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YB3pjjNfM6DUhDAh8HsvfuIyKaF971bcuxCBmO5eGDk=;
        b=VGTAimeUNZDbunljUP1ospFBiBuaC1pCVTe07qZxO9jF4uSnJhj2/AGSe4cNuap/2y
         15nLlXNlV33OxBM6ZLvYjXh2b0OyX/ZdVoNd+7kh8EqbxLOkNU0BSWCHbJCKrRhPH0EY
         H7vqB+bDg1lYrKvqDBXmoZtu2Cox8fafX/FUbpR+nqZI2nE5dCeCVwDLozZtbodoV8fu
         WDGeL+Mc0hxl986xttNB7tMjc8O7Co5UAVEBxGDSk9cnXfYqCxUqSXnsf/K5fVTlOEfZ
         8vdPfpiTdrawESfZCND6Rda35AWqS0oku1BjSSLlL66axhTSMHnqdVvS02AVZXYdC2dy
         1vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YB3pjjNfM6DUhDAh8HsvfuIyKaF971bcuxCBmO5eGDk=;
        b=ZZBRFJgaRabp0LcTukFjWDVoVBbCvF01jdj8drUfnNDf2ErTGBSlZe7eD6J2KgTvnz
         gLNAzRGiEJai3eTF0eWjmKvaapWNTecGwGSlsaFuxu4qvEUvb0ZZ/cL6h1LSKz4sdnVZ
         t/iS+0+3LYea2vMrZWAFvYHDZGp78aAM6FrbSYN+NdATY+kc6qlX+40SgxXkQtXRyS+7
         n3yW4TSzXk3H2/JgzJNmdvymYVzZcwD4kNafmTMxh8fsdshmsqS9qSfF0673PY/bcvfh
         S5KFkS4eQUzCIuT4pv/5ChFYNQwaQITqQfTNXuxRFay7IR4I7womuIjlIASdX0zaDNul
         UZQQ==
X-Gm-Message-State: AOAM531GLHZtUm7KftoA1QIytW+Aci8eEG7RXv6aKhh1I/PpU1jm0op7
        gsaq6bGm/k0Mf+u6bKMxgLrguw==
X-Google-Smtp-Source: ABdhPJwvdB85GphtIS3Lk0Mk25kuW4GgYhAcl7Qy3tLm457Z8+fTqnbf4RbJ0r9tISe/LQwMzpJSnA==
X-Received: by 2002:a54:4093:: with SMTP id i19mr2984392oii.143.1623848057925;
        Wed, 16 Jun 2021 05:54:17 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id l24sm405226oii.45.2021.06.16.05.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 05:54:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] mtd_blkdevs: initialze new->rq in
 add_mtd_blktrans_dev
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, bgoncalv@redhat.com,
        m.szyprowski@samsung.com
References: <20210616071547.1156283-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3c5c4c28-2b4e-b6ae-aaa5-edf8551a2952@kernel.dk>
Date:   Wed, 16 Jun 2021 06:54:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210616071547.1156283-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/21 1:15 AM, Christoph Hellwig wrote:
> Various places expect the request_queue in ->rq.  Initialize it to
> avoid NULL pointer derefences.

Applied 1-2, thanks.

-- 
Jens Axboe

