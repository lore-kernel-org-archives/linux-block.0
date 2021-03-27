Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E78C433C1
	for <linux-block@archiver.kernel.org>; Sat, 27 Mar 2021 14:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431D3619AB
	for <linux-block@archiver.kernel.org>; Sat, 27 Mar 2021 14:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhC0O42 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Mar 2021 10:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0O41 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Mar 2021 10:56:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D6DC0613B1
        for <linux-block@vger.kernel.org>; Sat, 27 Mar 2021 07:56:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o2so2313056plg.1
        for <linux-block@vger.kernel.org>; Sat, 27 Mar 2021 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sDws0mTDO6d8Auvc7v5WRRGX6+6WGAxk8awK/MY4TMA=;
        b=XPKZpW/FhEyuNCJAcByzeiDSMhJxPOLPY+GkkfV8KesuioLizyk+tH58ffgL29uqwf
         8X9EAhCZU4VMOZ4mXj/Jro72v4P3/pkjjbzokHnBAW9yCIOVGJVwylYzOKJ4fpFAWOTM
         DZANQNeLn/qo4sJpfYs5Ymx3wEATBdNzdxj9O3XRgZa33EWtCvdg8nAeX/jPuliUOXbP
         YJt/OFdYIcm050T0PgbtXecLecqlAnncSzSj/Iyc2uB9UynqLayReGWcyFMph7rSDv7X
         DIbl67LViS7oa5Ys8uhcuyt1CcBDdGQPZVSnu7nEmpR9PBL3hnaar4rSideOvMXyL/Eg
         nJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDws0mTDO6d8Auvc7v5WRRGX6+6WGAxk8awK/MY4TMA=;
        b=gnNRouPSA6Fb311iM41dsDkvEuKs8O/EX3tinYlHMHg8u+nkHyyFaz+/GLeuXwkF6j
         GIbaH7DVuSzMKRbRTcEpWC7euCZzqA9WZYRTmSPadrILi6KUhqL7cLCfjtlizMf0ZzbV
         eGkDaEedDrpQYniOI0r1RJYWmS2WiWSv2oBxJG52bAwlxAV/iX7PGz9Xkm9FO69ZVRrK
         WSQT8CxaLA9ATryhbI5XytGxcLZaO5ZgJJ88FdHEK6O3T/5r5s8/ysMlDWiwRXfyMQFn
         VcRhM/3VTlkr8LcvSibl1FrIxQ8eWKdtVtJX96VyqF28O8cHaFqJWRJY/nrkLh6o1/LG
         voWg==
X-Gm-Message-State: AOAM533bNPvSIOrLkWNZIkYF81S1pPDwbvPklup9Eq+mezxeswTDqu96
        fD0c90MnT3FbBHiPj2wUaFJnSA==
X-Google-Smtp-Source: ABdhPJwKhSFyX3WrYazvCB3yVr1OPG21+LWW2715Hz/IKffUn5GrKWg9nzHlELvrVzShq0oD7i7yVw==
X-Received: by 2002:a17:902:74c4:b029:e4:9e16:18d9 with SMTP id f4-20020a17090274c4b02900e49e1618d9mr20109281plt.21.1616856986799;
        Sat, 27 Mar 2021 07:56:26 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r10sm12092083pfq.216.2021.03.27.07.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 07:56:26 -0700 (PDT)
Subject: Re: [PATCH V2] block: not create too many partitions
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com
References: <20210327071309.553557-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <07bc20fa-69f8-a827-cc04-487507cddf8e@kernel.dk>
Date:   Sat, 27 Mar 2021 08:56:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210327071309.553557-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/21 1:13 AM, Ming Lei wrote:
> Commit a33df75c6328 ("block: use an xarray for disk->part_tbl") drops
> check on max supported partitions number, and allows partition with
> bigger partition number to be added. However, ->bd_partno is defined
> as u8, so partition index of xarray table may not match with ->bd_partno.
> Then delete_partition() may delete one unmatched partition, and caused
> use-after-free.

Applied, thanks for nailing this one down, Ming.

-- 
Jens Axboe

