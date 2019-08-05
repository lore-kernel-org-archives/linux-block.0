Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B109C433FF
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 03:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352492070D
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 03:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="b94eJbBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfHEDm3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:42:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36772 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfHEDm3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Aug 2019 23:42:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so35921124plt.3
        for <linux-block@vger.kernel.org>; Sun, 04 Aug 2019 20:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TyxUsFy0g0AoyoXbyHa8cG3SKeSFUmzhTiNZ1jvQoMY=;
        b=b94eJbBllBeKjACUA7ZSo9nWNoeamDyyUJLzT5V6v2JKv/tL0pgq/kK9PjSqL7kVdG
         NRyIUFYJD9QLfNkDvHAKSWO4GdpQqnzN2cVDZvRKuPzztSkAmUQquyQ6GllHwmIzkm+u
         mdoRQiDfAdpO1Nb6kouGlS5XcrVWJ+Rg6l3PZJeBxvrBiJpwRVAJ8ps46Kv8ww45//Fj
         RTQhPKHbmhlRJEfz0d8Vvcr35cQoymlOc6gj7yKoS3vLu90eSPOVGu8fHrdKg0dmXOQf
         gu0Tekg9SDldJlVdFqtOyeiFy0/CAjRAysgOaYSgOnmvRC4AKJNKeb2GMEuN59RJm4xF
         HfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TyxUsFy0g0AoyoXbyHa8cG3SKeSFUmzhTiNZ1jvQoMY=;
        b=lyUOO6HzuwBlsrvx9KhLvli3CUd6sQLRywR6JDJ7o/KTBVjWNGluVyo4DToy6sbWP1
         aHu43tw5CWBluPXOj6WyATn7bOpfXWio3pHPMusq8S5DoFZKsrovnJ6e/cDBt2mqkIqt
         ijkdWIpqlR3iEW7NBf6h/1t6RL6SoBOq9Pla+spGJFmYsWg4bLzonKOhej0/3LarurWI
         wjclJ0xYBG6lZUO4E9gruM3FPt+WuQHs61sn+0bFomtWy2xS2wc4K7nSfW2lbkNhUJra
         0IPUGd+weulT1DgF/Uhww2lJTIhH3Q7iVLGyKGT1NX9/YdqTJ/c/OVRyEpexEEq9R7Lw
         NkBA==
X-Gm-Message-State: APjAAAUXWa5XLQTzmGuDdUHntelSLD9C4wsfL/Cd8Pn3cc/P2+jcg6l7
        nsxkj6mFMqzyXWd7K50TX+s=
X-Google-Smtp-Source: APXvYqwLmx/zPu6DfQ6/dzDHZTfJz/tMSWimusqin+r7kDygU7dS7M/pjBgVPVIyhYb8fBZ8W3K+7Q==
X-Received: by 2002:a17:902:ac87:: with SMTP id h7mr21880581plr.36.1564976548565;
        Sun, 04 Aug 2019 20:42:28 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:61e6:1197:7c18:827e? ([2605:e000:100e:83a1:61e6:1197:7c18:827e])
        by smtp.gmail.com with ESMTPSA id o3sm14505866pje.1.2019.08.04.20.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 20:42:27 -0700 (PDT)
Subject: Re: [PATCH V4 0/2] block/scsi/dm-rq: fix leak of request private data
 in dm-mpath
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, "Ewan D . Milne" <emilne@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        stable@vger.kernel.org
References: <20190725020500.4317-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c7bd89e5-6fa9-2b3c-94f5-ca7ff9004e6a@kernel.dk>
Date:   Sun, 4 Aug 2019 20:42:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725020500.4317-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/24/19 7:04 PM, Ming Lei wrote:
> Hi,
> 
> When one request is dispatched to LLD via dm-rq, if the result is
> BLK_STS_*RESOURCE, dm-rq will free the request. However, LLD may allocate
> private data for this request, so this way will cause memory leak.
> 
> Add .cleanup_rq() callback and implement it in SCSI for fixing the issue,
> since SCSI is the only driver which allocates private requst data in
> .queue_rq() path.
> 
> Another use case of this callback is to free the request and re-submit
> bios during cpu hotplug when the hctx is dead, see the following link:
> 
> https://lore.kernel.org/linux-block/f122e8f2-5ede-2d83-9ca0-bc713ce66d01@huawei.com/T/#t

Applied for 5.4, thanks.

-- 
Jens Axboe

