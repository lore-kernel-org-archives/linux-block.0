Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943FDC433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 02:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5011320B7C
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 02:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tZeaK+Fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfHACpY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 22:45:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41874 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfHACpY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 22:45:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so22831837pgg.8
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 19:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WmYyY/zhwaALiUwxBG9Lhlp7lYGriDF7EmsazFZGY5k=;
        b=tZeaK+Fin9OugidlqNuaDg7lN9X+Qwb34fxcdexlhnsnKdWNzNJwvWmhKLht3YIHst
         C2GQvRvU3EYnKi9IV9EihHmknayeGw0RoPXVn2z1Ibs5yrUhEzQXW7L1RbW7LoTSTmXj
         bTvHKBON6fj/qCs6J7QL1N5fFgcP+K6OEAIV+1sjRBxGqwhGmIayTLk2CpHGY6DR4xmb
         wMVytHb8/pAWcE1HP5OagE0EHhiSKIL54zc+bko4LVeK3MVcaznKSP/H7xr7Keob+kFk
         rx5b53HI4h9jFpN28BbrFrKWKTXQX9ugBFh+qCYvVAWjfBzCTibOa7wPTVSKQDuHyTzb
         l7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WmYyY/zhwaALiUwxBG9Lhlp7lYGriDF7EmsazFZGY5k=;
        b=Cg8NpIjOm/4+cavZz2V2CS1yASJ4XZbxBRC7ICesPEHidlSoIIgBQ0VEYEL/LYyeC7
         9eTvRxAi3EhCv6sfxf6uLCqIH+8zvWFHX1eF2gxJ6H1LVyX5OBxaSyjCF7yKiSD2ENS/
         mRiy+coK/HRC8hr1p9f8YGO917B7tkFUCUTarxjNQquQ4rNu0TBXizV0mDA64DsX5RQq
         +rBUuhFsGz48pTNX2UjtKXz4tYC+0Grce8Scuk2J55xY8AOMZp+r2ZLkAEdLE48glqg/
         l/hiRB3yvO4w10T7UoC4La+w7TpYzizXs81dSj29rHwsTa/9hXEYbjzCP1SHeNuy/GDG
         rYfA==
X-Gm-Message-State: APjAAAXKZI7j+scnJgT53SfQnCpcntX6P80okpiw/lAApbwozQnUfyl7
        6uzaq6+03OUwxu/XB2GeqSY=
X-Google-Smtp-Source: APXvYqyrboRuSQT9Osy6AvPNKcL+fL8O9a1+4Eu7xAh4hLPP2nbg4XdZwtcTMLzzPtahzYjjGDfV8w==
X-Received: by 2002:a65:50c8:: with SMTP id s8mr76934074pgp.339.1564627523613;
        Wed, 31 Jul 2019 19:45:23 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id n17sm73694301pfq.182.2019.07.31.19.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 19:45:22 -0700 (PDT)
Subject: Re: [PATCH V2 0/5] blk-mq: wait until completed req's complete fn is
 run
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190724034843.10879-1-ming.lei@redhat.com>
 <20190730004525.GB28708@ming.t460p>
 <7eeb2e89-a056-456a-8be3-6edbda83b7bc@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <944c6735-f03e-c055-33d8-fe7f9a760b8a@kernel.dk>
Date:   Wed, 31 Jul 2019 20:45:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7eeb2e89-a056-456a-8be3-6edbda83b7bc@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/31/19 7:15 PM, Sagi Grimberg wrote:
> 
>> Hello Jens, Chritoph and Guys,
>>
>> Ping on this fix.
> 
> Given that this is nvme related, we could feed
> it to jens from the nvme tree.
> Applying to nvme-5.4 tree for now, if Jens picks
> it up, we'll drop it.

It's on my top of list to review, I'd like to take it through
the block tree though. I think that makes the most sense.

-- 
Jens Axboe

