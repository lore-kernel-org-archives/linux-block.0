Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A5FC3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A78C24654
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 18:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1V8CEMS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbgCDSmm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:42:42 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35018 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388203AbgCDSmm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 13:42:42 -0500
Received: by mail-io1-f65.google.com with SMTP id h8so3579269iob.2
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 10:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aowmqH+jxIIMHfi6cwVjuOMBAQUGZOtVBythXJlq3wg=;
        b=1V8CEMS2GN8MJvUzIknKJZighpn0smIcGnGnvbOS0TIHXyZ56NJcxHzYemcc3pfQke
         IhWQa/jjgQJA0iN+8Pi3PmbvC0xibsjBFGVarOG6kgTFTfLtTiFST6bIFH7dtpdPEiMr
         PXDLO25Kyz34aDn88pu35XYZOSINx5EOUFgM6coZ1+YOaOup55jp1+zqVY3kEZxqNvze
         t+OU1lT3pEb5gk4PpPF+ZkqZAWpI6INeHxbf89go8rQ2DYwVWgd7l4+C+DXMidklJQGj
         NcmU+khDtpifCoXjr2XzIcS+yW3r/CeLCWA0jHPG30hrLQxEF7Ne0KLt8lkity9Bc5KS
         q30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aowmqH+jxIIMHfi6cwVjuOMBAQUGZOtVBythXJlq3wg=;
        b=YHJiowyZtAhU72ky7jTm18roInGDNyESPVIxOxBsskbmV/nX6ErmBwhbpeOs1HapDm
         vITUjU5nAl/289jCd06K80/LNy6KX/TJyGf+vlFgXWE8XzhLxIefU9OldpC/exY+Zpm5
         CwFOhdyTg3SDSvVq3/cCpH8uzmqasg/3STrb8LuYejIMn2OgQGaE+Nm1XWJq7UeOB6DA
         sEnPMPbOB5p1JBbPGfo1b9MCu6mJGkKkjhCe1lUaCZ2sVO7K27McP45Sea2qo+46XTiP
         sA8t7xiZt0VaWGRHCRySy7vsS/Bl8uViEurztsLqNpR2vkkvC5UFWIWV+dm8xqicYbid
         5EwQ==
X-Gm-Message-State: ANhLgQ1yCqtHtwmchtLywJIyc6YtSC/y5XvRQU3fYy3OjIrNTO1V+Tt4
        sjJwzS8orOUzbE9Tw9VFUpEmnw==
X-Google-Smtp-Source: ADFU+vtNXdELHZMcZy9b77s22L7Z+lfjHm6Swz0+NNeBTzLXUJ1tqb7ebPuKv66GC+EtaS0Ndiyweg==
X-Received: by 2002:a02:6a10:: with SMTP id l16mr3894513jac.77.1583347361774;
        Wed, 04 Mar 2020 10:42:41 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l18sm7105635ild.51.2020.03.04.10.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:42:41 -0800 (PST)
Subject: Re: [PATCH 1/2] bcache: ignore pending signals in
 bcache_device_init()
To:     Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, hare@suse.de, mkoutny@suse.com
References: <20200302093450.48016-1-colyli@suse.de>
 <20200302093450.48016-2-colyli@suse.de>
 <20200302122748.GH4380@dhcp22.suse.cz> <20200302134919.GB9769@redhat.com>
 <20200303080544.GW4380@dhcp22.suse.cz> <20200303121918.GA27520@redhat.com>
 <20200303160307.GI4380@dhcp22.suse.cz> <20200304113613.GA13170@redhat.com>
 <20200304115330.GB13170@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <239a316b-3c43-019a-bef0-409110284789@kernel.dk>
Date:   Wed, 4 Mar 2020 11:42:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304115330.GB13170@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/20 4:53 AM, Oleg Nesterov wrote:
> On 03/04, Oleg Nesterov wrote:
>>
>> arch/arm/common/bL_switcher.c:bL_switcher_thread(). Why does it do
>> flush_signals() ? signal_pending() must not be possible. It seems that
>> people think that wait_event_interruptible() or even schedule() in
>> TASK_INTERRUPTIBLE state can lead to a pending signal but this is not
>> true. Of course, I could miss allow_signal() in bL_switch_to() paths...
> 
> Jens, could you explain flush_signals() in io_sq_thread() ?

I actually don't think that one is needed - the only one that io_uring
needs, and which is valid, is flushing signals for the io-wq worker as
we use that for cancelation.

In any case, both are kthreads.

-- 
Jens Axboe

