Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA04EC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1AF20675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 14:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ASN2Sw13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393523AbfAPO23 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:28:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34905 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393522AbfAPO23 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 09:28:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so3156401pfi.2
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 06:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HxJrmZEqYJSGMznVn6AhTeuGriIjx4tKwmtke7E595I=;
        b=ASN2Sw13n8QcZXBOavpfQ2NECX+kdiaECwaNtfl67tvDhQfyLzx56Z0u/7X/6I7v5i
         fKmjOPW4nHGv6J286/C4blbgwLAx9UzAnbIQs2+fw6998qdBzfl4O2/vIN64rj6/pASG
         V5Y3x+WqolSloyzQPYefZOcpA4TGwN5NZCevyYdicET8mzMThu/Mr9OTSPlMput7L21o
         uLLIAWP0J7k8a1djhUZNw8OvR8dH4qPlURbQG8aQQBLBf4IHdNTtSEgTPZDlieItg1ZE
         t+t5QMJbqFucV3wJU3ESHc9kR5RFd6zubBnSLy9Cmqkp13k/6FuYcgEEO4l31UT6/aAA
         vSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HxJrmZEqYJSGMznVn6AhTeuGriIjx4tKwmtke7E595I=;
        b=ffRj5M3RQEHPBlt2RmsfI2nNmSfxE/fIi8oXymepPva7fUN7h4CFfMlGDZJVMwusSn
         UXt1PT7wpG4XS/VH3Sq7VJKcDcKzw9jS7oyYll6pqqY0XHZTI8yZUaBxva/WJbqIFWFB
         a1C+PV6yO+/AqVlGBTxgmqVOpoN9USmnCjVRsDaNVqw8Einq9/zricMr7kKARZSlPkHO
         ln6MvG55alWAUYr7tTobi86OndnsyZX7wJPWcl8d2NGJv1wWiFdbbfNyCfFQf2qQ0+vM
         N9tQQAxbtPUdebIGzdQyJQUfjgJBHQ/aowCZRS7uyruDypgPWClhffHHIo7lsn/54aOE
         3ctA==
X-Gm-Message-State: AJcUukf4CS87p6Q4NgmNlU6w07Q2ebSWZaZ5mrOb+eLfly0YRd6N3gsY
        0QXNBxYgV9uUhPZEqnWkE3V+rh/aC+FH4A==
X-Google-Smtp-Source: ALg8bN4vAKvJvCaWa4z5IBh5oHhRmrVgc3TCZcjycJkRhIJyL1nnw0fFHqpY1NsKO37hROz9Jz9rkw==
X-Received: by 2002:a63:5026:: with SMTP id e38mr9136153pgb.123.1547648908393;
        Wed, 16 Jan 2019 06:28:28 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m20sm6081407pgv.93.2019.01.16.06.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 06:28:25 -0800 (PST)
Subject: Re: [PATCH] block: don't lose track of REQ_INTEGRITY flag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>
References: <20190116110815.9557-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <227a8053-8dce-db6a-dd9a-e443ca27f394@kernel.dk>
Date:   Wed, 16 Jan 2019 07:28:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116110815.9557-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 4:08 AM, Ming Lei wrote:
> We need to pass bio->bi_opf after bio intergrity preparing, otherwise
> the flag of REQ_INTEGRITY may not be set on the allocated request, then
> breaks block integrity.

Thanks, applied.

-- 
Jens Axboe

