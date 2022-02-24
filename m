Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AF6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 10:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiBXKMu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiBXKMq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 05:12:46 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46373C7D57
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 02:12:16 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so2679694wmb.1
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 02:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W6UvAYcgu5uXHnlHOC3xwyz4EMh6HHYhfd2PYJbD89c=;
        b=PgfnN7JAz2sVusTppByavHq0CkBtPjnDodz/atKmAXGx9auUt1SSZcAdEVVbN23WHF
         C50zRsk7EBZMk3SMkvXnW3Ndbgn+xGVwhABIWLXgco7tB++E9QpJdav9/G1DlkfhmNaT
         45zJZPw7SuV+GlNWdLIhV68QMUmY7llwrPrdF7Pdr7soVAJb+lXxx64Kls+XKeE6bVdZ
         4tyKIax8roWgfCEQux2dS3fCO2Z9GugE481LgHZnMvPlqX1bqos5JpF0MzWh8mGDKvCe
         ULQkenk21ntWYnHe+I0X/rbfsjLcXOzx5v5ijl+5vYB8x2QyjY0n5vrpvoifKgWm9zCD
         gFVw==
X-Gm-Message-State: AOAM5327auI6uSogP10XbEy3IoYvuF8yWgVPS0XqOMtyg0Nriq00j1X3
        yrb8GSAxaPiEpnxrDk2anpI=
X-Google-Smtp-Source: ABdhPJyXb7tPIa0yE3o+1KIfT1eyiGZ2bTkzdzRVlQrDEbi0YyKusf1SZ4jAkOgljHi37TMR624pxA==
X-Received: by 2002:a05:600c:8a9:b0:380:da47:a911 with SMTP id l41-20020a05600c08a900b00380da47a911mr9830894wmp.102.1645697534461;
        Thu, 24 Feb 2022 02:12:14 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z14sm2169743wrm.100.2022.02.24.02.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 02:12:14 -0800 (PST)
Message-ID: <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
Date:   Thu, 24 Feb 2022 12:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
 <87bkyyg4jc.fsf@collabora.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <87bkyyg4jc.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Actually, I'd rather have something like an 'inverse io_uring', where
>>> an application creates a memory region separated into several 'ring'
>>> for submission and completion.
>>> Then the kernel could write/map the incoming data onto the rings, and
>>> application can read from there.
>>> Maybe it'll be worthwhile to look at virtio here.
>>
>> There is lio loopback backed by tcmu... I'm assuming that nvmet can
>> hook into the same/similar interface. nvmet is pretty lean, and we
>> can probably help tcmu/equivalent scale better if that is a concern...
> 
> Sagi,
> 
> I looked at tcmu prior to starting this work.  Other than the tcmu
> overhead, one concern was the complexity of a scsi device interface
> versus sending block requests to userspace.

The complexity is understandable, though it can be viewed as a
capability as well. Note I do not have any desire to promote tcmu here,
just trying to understand if we need a brand new interface rather than
making the existing one better.

> What would be the advantage of doing it as a nvme target over delivering
> directly to userspace as a block driver?

Well, for starters you gain the features and tools that are extensively
used with nvme. Plus you get the ecosystem support (development,
features, capabilities and testing). There are clear advantages of
plugging into an established ecosystem.

> Also, when considering the case where userspace wants to just look at the IO
> descriptor, without actually sending data to userspace, I'm not sure
> that would be doable with tcmu?

Again, if tcmu is not a good starting point (never ran it myself) we can
think of starting with a clean slate.

> Another attempt to do the same thing here, now with device-mapper:
> 
> https://patchwork.kernel.org/project/dm-devel/patch/20201203215859.2719888-4-palmer@dabbelt.com/

I largely agree with the feedback given on this attempt.
