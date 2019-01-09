Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D787C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 16:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B475206B7
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 16:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZWQq81pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfAIQ6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:58:04 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36237 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfAIQ6C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 11:58:02 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so11997432itj.1
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 08:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iiEdlpyX1InwFp0ae8xfA6H4djQfO5mTGxRBA5XCrzQ=;
        b=ZWQq81pd9XHXuLrznvyUeQg7m2MYzLw0gSdy6yLf9iuPtLXFmu30ll2R8QHEcvTdyD
         QOowi80mtl03EQPWWmpwt7wqe+TZ2gWJ9TkZYlFzEhhIPLumgCSHKEfxNhXiVhkd3mAC
         BKSrTwvl4oYTc+mtyZiJ+TxPh+aK32EC+oURFnwCJgC4wYShg95hrwCfGb5xbpae6kL9
         L/wwGhCwQO57zQrqWp3HhBr8Ckb4yPO1dcafkLxgAtqtvqNVH5xMMyUIZu4ftUBv8ZVz
         tsfCmQWRJ9J2zLEhpN1om75TCaVftzS4YLOdI7XRxrkUDGcCTD386tzkhkYE1qpEmKe6
         VsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iiEdlpyX1InwFp0ae8xfA6H4djQfO5mTGxRBA5XCrzQ=;
        b=PqbW5WpnkGO45vHbflrGmlPCrq1aOM86eCrgrF/TxS/fLk/v1qJC7huYVx9r1TDTno
         Q53ko5Npy++aRGUnQatrrUO+ofovbl4SmuDRf2dtmgY/PjAJfCuws6DNvny9DKZ/zx8U
         WCJLJP/Ma9wwCqbe9e6ubg1mkUQSRbJs1dg9ewEL2zT0tHlQB/3Nl/ci10fS59X3Bsnk
         JkR4O7FBIA8Ij/PFq8Ikupe2V9fw+tT8ALeS5+6LjM6OSTOLPrDfvtBeL4pRtEOUs2nR
         IMtyVKswu3vaLSeGTZu5UhB6XTp8tdATa6Vx3mzE/rNPnFjoaZ7T21jTemgewVWcBtdP
         Sb4A==
X-Gm-Message-State: AJcUukcz+L/voMY2O0rTQFlp5HbfaCqyqEzp3AGcPMjYyRFdeBsLCG6o
        j1O8o4t7wugufhuPlLkMfCnFsIqH6icIiQ==
X-Google-Smtp-Source: ALg8bN7uynniHiIHHpVm5XIBynQHmlaAGWAqhuKibZtQjODEPtmnmMQRqJn+SLNGbWwVcaAONt7uyQ==
X-Received: by 2002:a24:710:: with SMTP id f16mr4099893itf.121.1547053081837;
        Wed, 09 Jan 2019 08:58:01 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r15sm32669969ioh.12.2019.01.09.08.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 08:58:00 -0800 (PST)
Subject: Re: [PATCH 11/16] io_uring: batch io_kiocb allocation
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-12-axboe@kernel.dk> <20190109121340.GD13779@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0a91dd38-69b8-84ab-f96a-225f09a54ec9@kernel.dk>
Date:   Wed, 9 Jan 2019 09:57:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109121340.GD13779@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/19 5:13 AM, Christoph Hellwig wrote:
>> +	if (!state)
>> +		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
> 
> Just return an error here if kmem_cache_alloc fails.
> 
>> +	if (req)
>> +		io_req_init(ctx, req);
> 
> Because all the other ones can't reached this with a NULL req.

This is different in the current tree, since I properly fixed the
ctx ref issue.

-- 
Jens Axboe

