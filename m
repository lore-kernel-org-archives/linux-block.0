Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1191FC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 15:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E1421841
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 15:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TNFYPcW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeLSPJt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:09:49 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:36500 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbeLSPJs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 10:09:48 -0500
Received: by mail-it1-f179.google.com with SMTP id c9so9818929itj.1
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ftgEI4X2pIcRIyP3SkQg5VPCWQO7yMqJ7Y+rmAab5c=;
        b=TNFYPcW0ouzyHVmuuWJt7eo9XLGKk/8CA/4igjBhECKvj13JKHWYBFe70K6o+ExHjD
         lV3/dVe9NHQEtuTstCYrb1qWlZlhZqSttNik6GWm689MF6Jbn6kr634dAnhsvqiTSK66
         GzoDiuBJQeFzZsDKnBv5vgdLUMrhEfKviZ82yabhSxCIRNwUw+odJ+W7hC/yMlUNq6K0
         brK8ExR5ctIObvI5SZZ+VFjlJI7ntxg2OugZpaRRw+4vqv2h2mUzL2nfYJg0e2WFxun5
         ft8navCPSlI2lX8acdMdT9MX35yK9+00MmtrU34OgLlua3bHKHrceSSYjP00AAtZWKQv
         ja5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ftgEI4X2pIcRIyP3SkQg5VPCWQO7yMqJ7Y+rmAab5c=;
        b=Tqts427tefBRvJ8w9fiNtvJ7H5T8CnVQ/c2YzJHopQxpTBKSvwlPmX84vwb1mLjCvr
         XacPIZElOn3A+5//ytdDl6eu2p5BSZHv9CTxLrVvW7hNgQDyafA+jVYoLvCbg95YHQci
         VnHVOcTSPZcxm+R6Z7eJ1z9njpRUZjDw028/G3+xi7i0UvhpiB18paDMpAzW/bWdHkdf
         Y9tHtKw+r8MxBVWZ5tpw/0Up25mYrNv4HNUulv0YAO7LQKQ4M8ZaiykBGeGY3bxbkj06
         J6pLU3Gzzbhe4Y8nRkkhK5+7xCM4haw4yYKVyg1Lzk/0/KdOgCywW6Md5CPFdi7TAkN9
         j20A==
X-Gm-Message-State: AA+aEWY1jBNS9LnD2kuteJP8ftv2bBMIOmTWYX90jttYuDJRCqygFr6/
        wMMKOqREsiKZ7X/CgZi5433KJA==
X-Google-Smtp-Source: AFSGD/WwjKE1WtZtBu++hNWHYGZ9V+EOR9V21ouqU1J69fg2XhNAL6UXDypSGUkeldiw8CjXQnsa+A==
X-Received: by 2002:a02:7696:: with SMTP id z144mr19388968jab.102.1545232187883;
        Wed, 19 Dec 2018 07:09:47 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e141sm3948571itc.40.2018.12.19.07.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 07:09:47 -0800 (PST)
Subject: Re: [GIT PULL] third batch of nvme updates for 4.21
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20181219142015.GA960@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a5c3333d-816c-352b-8950-5e5bdeff517b@kernel.dk>
Date:   Wed, 19 Dec 2018 08:09:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219142015.GA960@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/18 7:20 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> the remaining nvme updates for this merge window below.  This contains
> a series from Sagi to restore poll support for nvme-rdma, a new
> tracepoint from yupeng and various fixes.

Pulled, thanks.

-- 
Jens Axboe

