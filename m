Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2D0C433FF
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 15:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06ACB208C2
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 15:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHNP3x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:29:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42613 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfHNP3x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 11:29:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id y1so475551plp.9;
        Wed, 14 Aug 2019 08:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z0MSIiaazH9n7y7CjJIuJYZjOBI8O+Eixsa8yK04afk=;
        b=DxhHyYorrFq464afg13l8v1x1ObZHZg+aLoaFmrI7JEOE1OpRWhhkOR4q9hAsMLsFJ
         8/McjeGm5SjviNaFStnnU8Fe7PYFm3RJgSauPva4PyO/nnbC9G60bhq6O20WuCCj5BuI
         gK0ofaHkihrYpI5/tguMYHj+OFEW/NMal64I4patefMVTj8CcJxlvd3UZuXKxXdErCIB
         o5RTm8lnjc5LfBTvBhmrWwZjDHzefC7bdWBo6/U1mkHHcObm9UTkYq/VQCOGqV2/jgxl
         vTRxGKC+8G9c6KLvvy2YqtY36jNxVKSYERpjyi+hQfkujB/OA70Oqa3xaYZkXVglty9f
         n2rw==
X-Gm-Message-State: APjAAAX236z8N4GwAeXU6OFibC7owjir/dacqhIeLw2YQXpnrbG486By
        4NRdnMtVeSSPjALGYKpnbhE7C8Nz
X-Google-Smtp-Source: APXvYqyBcsaRNq53NqWG4y44GJZwnDO3p5ZWxzkVNewTfu1WFnt5wQuXPgiVE5Ekgev7iAsC+xfD6Q==
X-Received: by 2002:a17:902:8489:: with SMTP id c9mr43796601plo.327.1565796592611;
        Wed, 14 Aug 2019 08:29:52 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y128sm45301pgy.41.2019.08.14.08.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2019 08:29:51 -0700 (PDT)
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when
 possible.
To:     Martijn Coenen <maco@android.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@android.com,
        narayan@google.com, dariofreni@google.com, ioffe@google.com,
        jiyong@google.com, maco@google.com
References: <20190814103244.92518-1-maco@android.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <29990045-b05e-1411-a5c2-32e735265a04@acm.org>
Date:   Wed, 14 Aug 2019 08:29:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814103244.92518-1-maco@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/14/19 3:32 AM, Martijn Coenen wrote:
> Since Android Q, the creation and configuration of loop devices is in
> the critical path of device boot. We found that the configuration of
> loop devices is pretty slow, because many ioctl()'s involve freezing the
> block queue, which in turn needs to wait for an RCU grace period. On
> Android devices we've observed up to 60ms for the creation and
> configuration of a single loop device; as we anticipate creating many
> more in the future, we'd like to avoid this delay.
> 
> This allows LOOP_SET_BLOCK_SIZE to be called before the loop device has
> been bound; since the block queue is not running at that point, we can
> avoid the expensive freezing of the queue.
> 
> On a recent x86, this patch yields the following results:
> 
> ===
> Call LOOP_SET_BLOCK_SIZE on /dev/loop0 before being bound
> ===
> ~# time ./set_block_size
> 
> real 0m0.002s
> user 0m0.000s
> sys  0m0.002s
> 
> ===
> Call LOOP_SET_BLOCK_SIZE on /dev/loop0 after being bound
> ===
> ~# losetup /dev/loop0 fs.img
> ~# time ./set_block_size
> 
> real 0m0.008s
> user 0m0.000s
> sys  0m0.002s
> 
> Over many runs, this is a 4x improvement.
> 
> This is RFC because technically it is a change in behavior; before,
> calling LOOP_SET_BLOCK_SIZE on an unbound device would return ENXIO, and
> userspace programs that left it in their code despite the returned
> error, would now suddenly see the requested value effectuated. I'm not
> sure whether this is acceptable.
> 
> An alternative might be a CONFIG option to set the default block size to
> another value than 512. Another alternative I considered is allowing the
> block device to be created with a "frozen" queue, where we can manually
> unfreeze the queue when all the configuration is done. This would be a
> much larger code change, though.

Hi Martijn,

Is the loop driver used in Android Q to make a file on a filesystem 
visible as a block device or rather to make a subset of a block device 
visible as a block device? In the latter case, have you considered to 
use the dm-linear driver instead? I expect that the overhead per I/O of 
dm-linear will be lower than that of the loop driver.

Bart.
