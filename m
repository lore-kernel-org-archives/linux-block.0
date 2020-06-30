Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD89CC433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 14:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F5C206BE
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 14:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yInapZvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbgF3ODE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgF3ODD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 10:03:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87526C061755
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 07:03:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i4so9523414pjd.0
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BEfZkeUSkOMlr5ICokEqJ2PIKF3eWMH3bVbkXAU2YC4=;
        b=yInapZvVO2E0MIx5Esj0QuCd+w5slp7G6BxcyeFFH0I+zISUzFk9pYhkGp1VvfHf/g
         0zEJck/3N2TUVBOZvPpyE6B2robv2Pf7NjfcC+T4eYVgSgLxcXCtTLIG9f+Kz5U0VAKH
         w2fNTacbqtUmbNZ4h9bbCYoCq7mEWeZjlFXv0SBmjc0hGJUY1sjxk+t1r92lnjHxh9y4
         Qt/j7Db0Nl8Sg9NNKOXTt251iyJJRKgd43JKYqfGPfIXAnxXYxmg9OS3nuduECCh2kqC
         2bjKgWmvnaqaL7W7eU5PURB7vpvdXsVmn9BWqBGm3eK1GL2sYN3evxpA1YAXFHequmkI
         Q6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BEfZkeUSkOMlr5ICokEqJ2PIKF3eWMH3bVbkXAU2YC4=;
        b=teMnjuDkLdhvYu2bydSoxhznM1MOYhrbe5SQ9q19wBmBJj+G+90AHQ82zjJ9KFvSif
         BPdnwplYyu45uft0nSLMmsx82Oc6Q2v6ZQwPThBNsdH1HTV5iipHO6WlBjDa1Y1/UVhb
         6CWVwPMuTcbv5CVej/N/BfHKUi0XkmGfL3z/GIUJIPB+wu9VQjaAZL2No8vpRjCDq4NJ
         W7jZfKUfnjlyBmrOGuf3jBwIviXFWYyGne8++9sm9HmFHOFFcbgIuAlIxH7ljkIiQFrh
         TmEaBsc6lvzqanmwYjpbmxaDGGaagumdu1NX+6WSMVLYqek7LtFJ7IsQYX290al3d8Vb
         GHxg==
X-Gm-Message-State: AOAM531nWJs8lMHK3YKfHZN2tNptpP5W/s08CygupyjrP+8XTRIgjGhm
        71MfZwT5jVsdQCH/wc3FM1yddQ3rUjlJFA==
X-Google-Smtp-Source: ABdhPJytDKzhZEmBf3wKd0ZvwqfsfHgqb5dba88qxR4mfvUzJJZ0n5s/I+xhTZYgNP5BvWm/RSNVrQ==
X-Received: by 2002:a17:90a:2d7:: with SMTP id d23mr1492555pjd.57.1593525782872;
        Tue, 30 Jun 2020 07:03:02 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b? ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
        by smtp.gmail.com with ESMTPSA id t1sm2974128pgq.66.2020.06.30.07.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 07:03:02 -0700 (PDT)
Subject: Re: [PATCH V7 0/6] blk-mq: support batching dispatch from scheduler
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20200630102501.2238972-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6dc23dec-aad3-b2a3-3e11-71c186ddbc0b@kernel.dk>
Date:   Tue, 30 Jun 2020 08:03:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630102501.2238972-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/20 4:24 AM, Ming Lei wrote:
> Hi Jens,
> 
> More and more drivers want to get batching requests queued from
> block layer, such as mmc[1], and tcp based storage drivers[2]. Also
> current in-tree users have virtio-scsi, virtio-blk and nvme.
> 
> For none, we already support batching dispatch.
> 
> But for io scheduler, every time we just take one request from scheduler
> and pass the single request to blk_mq_dispatch_rq_list(). This way makes
> batching dispatch not possible when io scheduler is applied. One reason
> is that we don't want to hurt sequential IO performance, becasue IO
> merge chance is reduced if more requests are dequeued from scheduler
> queue.
> 
> Tries to start the support by dequeuing more requests from scheduler
> if budget is enough and device isn't busy.
> 
> Simple fio test over virtio-scsi shows IO can get improved by 5~10%.
> 
> Baolin has tested previous versions and found performance on MMC can be improved.
> 
> Patch 1 ~ 4 are improvement and cleanup, which can't applied without
> supporting batching dispatch.
> 
> Patch 5 ~ 6 starts to support batching dispatch from scheduler.

Thanks Ming, applied for 5.9.

-- 
Jens Axboe

