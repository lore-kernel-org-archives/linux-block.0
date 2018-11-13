Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DB4C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 13:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC24223CB
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 13:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ErZvdhMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC24223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbeKMXnA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:43:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38801 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387489AbeKMXnA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 18:43:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4-v6so6044005plo.5
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 05:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U/7udZF3O8/9rQwYXBkKAnb5GW1nh1BLbomwogVDr9A=;
        b=ErZvdhMMSQUcimeZzK76STOAuU6GxZZWtHOMTdwfcyM1uOleVyZl5b7SGzI+kEXjq9
         ZhCF2j0MKuFx1gsFZ+nM5dl9o8bhOCnKZjPP6xxqqNY4DYk6q/edRKa2vMTDHceXX8P4
         KZigKH9acwAED4bcwHUGS1p0Rvd/FzV0h+1rz3PJdE0dSraYmzFn7JoC44QMpNsmIvWq
         Se2xvcFNzEfIVIx7a59U7nqkrKj91AH6IZxT0fBaRyKBqrr2mET3BTGWWgtdCOB22cTi
         rgFuTByC5iQtRyxfOhFrJSHq3DBIFF9h4GJ6Wn4aRIiGO6ixX9343V83xTzDsWwiOWm7
         +e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U/7udZF3O8/9rQwYXBkKAnb5GW1nh1BLbomwogVDr9A=;
        b=KxbeEjKvKNXdIcVxejFLQZtLhpZCWNUKAl7bxJliQo4wjvIvf1IYdmNnRQv4z8vkqe
         H2VsMMKX7cJmoX9l11UwypUZXJcABMhiZPkw5INd9rZrD7zx3cehvMZI8JkrGaXyu9NK
         VSEMtoi7o6SgRo9i466vUBRGWGKAKZR+AM72AURBTFVoSOUFmYlb9W+4Tv9bTxPO5fqz
         wFaRcoo6BPZl0pxc2o2FubnjhO5pXzMZGu1XGMalCMztTXL+21iNIRKOQkAnebt6jGwR
         /Cpuqodn9/ys2XIAlzO4iA2HZwKBJznedC2TRHY2bsu5L3jl3pFyA7WRtBqb47lt/g08
         +nQg==
X-Gm-Message-State: AGRZ1gJ1lseTPGxyuw7xgXQYJIqU7ScHRcgR6GrtUbn0uX01798PqLPK
        QvuwrmWgyqFnNvZ2qvJuksIprw==
X-Google-Smtp-Source: AJdET5dsdlPCLcBPtzC1tWcSOjW6eLG0siomcF4dmbrv1eeMfe1Gha53UxJUnxmJggR8l6LCKxTgpA==
X-Received: by 2002:a17:902:b103:: with SMTP id q3-v6mr5166334plr.83.1542116688688;
        Tue, 13 Nov 2018 05:44:48 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o4-v6sm23172594pfi.172.2018.11.13.05.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 05:44:47 -0800 (PST)
Subject: Re: [PATCH V6 3/5] blk-mq: ensure hctx to be ran on mapped cpu when
 issue directly
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542103016-21037-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542103016-21037-4-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d8d88eff-e3eb-542d-d4fa-06b6aff97ba0@kernel.dk>
Date:   Tue, 13 Nov 2018 06:44:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542103016-21037-4-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/13/18 2:56 AM, Jianchao Wang wrote:
> When issue request directly and the task is migrated out of the
> original cpu where it allocates request, hctx could be ran on
> the cpu where it is not mapped.
> To fix this,
>  - insert the request forcibly if BLK_MQ_F_BLOCKING is set.
>  - check whether the current is mapped to the hctx, if not, insert
>    forcibly.
>  - invoke __blk_mq_issue_directly under preemption disabled.

I'm not too crazy about this one, adding a get/put_cpu() in the hot
path, and a cpumask test. The fact is that most/no drivers care
about strict placement. We always try to do so, if convenient,
since it's faster, but this seems to be doing the opposite.

I'd be more inclined to have a driver flag if it needs guaranteed
placement, using one an ops BLK_MQ_F_STRICT_CPU flag or similar.

What do you think?

-- 
Jens Axboe

