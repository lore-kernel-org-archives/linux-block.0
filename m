Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89881C74A23
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 14:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7ED2087F
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 14:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yBfEFr7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfGJOAn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:00:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46974 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJOAn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 10:00:43 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so4836248iol.13
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uLDn6FoYIxeReECmo+TpeGDmidMAcbRcZrkscc5kAsA=;
        b=yBfEFr7yxFpc6DuLLhXX1DAnqM9459BahEd2QCdjUtR5LTkk0OkpSWz/fNDJPqZ4Eg
         2O4/HATSD/igFfddXASCAJVmsldwe8lNWqsG4hIrcHXjj/bwIQNoaI/EbRDHZs/qAIHn
         G1FGuLdmry9IhxGlnOHoqXumoDhViWnwqstnQuBBJ12fpcr88XR5UMkm1KEpBBbAp1JI
         xsZ7c6DcoArYJqldQY38wvwrnxUe9hdruIqxrAEUMgCSXGFcGoOFvcK8KnPAciKrOB0z
         AzPwRKYSRI70y3/eNOrDzmV936ihA+a11hwpyy1kfkjhTJPO/FSBfYuA/jiqpbVNU1gI
         IcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uLDn6FoYIxeReECmo+TpeGDmidMAcbRcZrkscc5kAsA=;
        b=rVtQSlplj83NqPk9ehRas9mq/29nbQHFqhZW12DT61e8bJE0djCHH8iPtzPBQc/4ZH
         JrzV+JXJgPKZztTfs3u7+9U6bU4vdMHUzU8aSEdO0oLgaNcMQ94cdaGJGNyXthx+shRl
         99HfBAX3uX+fnQJY8wLhtM9llWEqqrWTy6eQCZB2yM08x60ecbZ6zjhWh17LT274IKhV
         PKfejGm6iB+J9mI6raB+XDhJOIUFqcTjMthoLWTiYtgYiQS7atFHQ4Tx6iagpG42lhjT
         Ja0EIdAgEbXFtZTjScj7IGB6w7A1Ty0UsHg5j0qLFeIHuRKITRoRjgaUI5rJXBmfeSZ5
         CLZg==
X-Gm-Message-State: APjAAAUSC+x6brXa3qmFZaDWrvaiwW6KndAWrYuGfzZj7X/LNeEKsaQG
        WGsZhBXWgjHl7L25fojpQrxBUA==
X-Google-Smtp-Source: APXvYqy7gIMHIZKeU3ZjEjuVffpS1YJvkAOw7HV+TgJseYlld/VwQmsqw+3UihClAvATVA1ZPifRlw==
X-Received: by 2002:a6b:ed02:: with SMTP id n2mr18863623iog.131.1562767242821;
        Wed, 10 Jul 2019 07:00:42 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t133sm3887077iof.21.2019.07.10.07.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 07:00:41 -0700 (PDT)
Subject: Re: [PATCH] blk-throttle: fix zero wait time for iops throttled group
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Liu Bo <bo.liu@linux.alibaba.com>, stable@vger.kernel.org
References: <156259979778.2486.6296077059654653057.stgit@buzz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <30caacb5-4d45-016b-a97d-db8b37010218@kernel.dk>
Date:   Wed, 10 Jul 2019 08:00:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <156259979778.2486.6296077059654653057.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/19 9:29 AM, Konstantin Khlebnikov wrote:
> After commit 991f61fe7e1d ("Blk-throttle: reduce tail io latency when iops
> limit is enforced") wait time could be zero even if group is throttled and
> cannot issue requests right now. As a result throtl_select_dispatch() turns
> into busy-loop under irq-safe queue spinlock.
> 
> Fix is simple: always round up target time to the next throttle slice.

Applied, thanks. In the future, please break lines at 72 chars in
commit messages, I fixed it up.

-- 
Jens Axboe

