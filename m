Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882DAC433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E03610A3
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhIGOh6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhIGOh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:37:58 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DEBC061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 07:36:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f6so13185935iox.0
        for <linux-block@vger.kernel.org>; Tue, 07 Sep 2021 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SruVr+U0/ZU+9t7XIBWrNzVvwLEsEgetqnj4R5a9Ojw=;
        b=xupl/ukNNH3AcTsoRgTp9NA6Rx9NTK8OuwmHkbPFfkxFnDZl5LNPaDkmjvl/wsSflc
         DL2gmMcPOVXNAPTtwFPtfmvre1Z3XOr73VUm6NIq04ZjHTVtGTaLnaUCvMPx8X3wIFII
         X7X32GGvQ4JM3kY0uPtbs0zrdrHIUMLNq1hvhAM8tjzLljpCVFHE/BMlaTQOZ8xBrxr6
         qdmQF2px4sbfr/r515hnH9I+JxHVXB+bZlLia1jhkAnV/l/CzGgeTswXWBh2zoSF3yR/
         mIoYM1gDY3droB5m5WI7A7ahZhqc8wjkgyQ/rYveWiY1QnW51kpuCmmIWUxCS5KJc8kT
         CatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SruVr+U0/ZU+9t7XIBWrNzVvwLEsEgetqnj4R5a9Ojw=;
        b=JCOI29NkFVZnCYnm5Xtwp08R4Cy0i6ZyU37hLRfTEq3fcO3Ey3sJeUnI1Mooihb5Ay
         QmOFfxyeDfwwMtTp0tJvrigPQ+/G/UfwHKXAcd/QmBthbgCdthmMZtybzu7fhJVwIzjB
         cmUX/Lt+Tlmp1iO6V+syrhtDV2xdEfXBB/TpyBzORJEQyin22H8eYZp2PPbyxZPnipsv
         WQBb0qmbR9DOWr6Dt1JC0u5dEH9PsIURdQzL3eVUYwkoflJ9sXLD7sTL0tOX092AnDM1
         UxSL8VKggZbJidRNhwYkzMgAE03Tdy/fuv9yZUTbsg2Z0sZhbzZCtY4GHRflDXRG4/IJ
         2a2g==
X-Gm-Message-State: AOAM530QL8daD8Fm/y18QaGRHgke2EgVKY0FtRZKsl14OqNrrV4j3OQK
        68j1JJXDF/+zFz+8BOYD4aJgVeAWBdgcHA==
X-Google-Smtp-Source: ABdhPJztNthpV0r8mJ8UrwlwPI3s3c/+Ktsr1VpF4u4WQvOvLeV+9X+uzLACW6MxQ5gXUOQdw6eRUw==
X-Received: by 2002:a05:6638:150c:: with SMTP id b12mr15955323jat.110.1631025411120;
        Tue, 07 Sep 2021 07:36:51 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r18sm6872216ioa.13.2021.09.07.07.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 07:36:49 -0700 (PDT)
Subject: Re: [PATCH] block: genhd: don't call blkdev_show() with
 major_names_lock held
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
References: <18a02da2-0bf3-550e-b071-2b4ab13c49f0@i-love.sakura.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75efddd1-726c-4065-709c-0c88c03c38ed@kernel.dk>
Date:   Tue, 7 Sep 2021 08:36:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <18a02da2-0bf3-550e-b071-2b4ab13c49f0@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/21 5:52 AM, Tetsuo Handa wrote:
> The simplest fix is to call probe function without holding
> major_names_lock [1], but Christoph Hellwig does not like such idea.
> Therefore, instead of holding major_names_lock in blkdev_show(),
> introduce a different lock for blkdev_show() in order to break
> "sb_writers#$N => &p->lock => major_names_lock" dependency chain.

Agree, that's probably the easiest fix here. Applied, thanks.

-- 
Jens Axboe

