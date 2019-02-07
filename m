Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAD2C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 15:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C638B2175B
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 15:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uoxEcaoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfBGPZc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:25:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44458 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGPZc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 10:25:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so64469plq.11
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 07:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NZowT7GX9yB3jHkuz+dEavmGmCUEtOWXtF7tVQ//VwQ=;
        b=uoxEcaoii5wJeIT3D7uEB4vYU1pXOhKbgwkeJDYXYzR/zE9O1PsW0B5rD5ni3x8mal
         qLR6d7zk84RrKppoC9MI7sOYvvBMbVeD2wxzZYlq2H3B1if8mT5bbUfSvz0xTPrAky9o
         gMsTP/G/d1O8k2B1cW+mCmpVZqVOo/0Tr/XNZNsaPvlTsbSuv9Kg/HsPm/6FRY4DROK2
         qbWivtXKj7J8Aagvhh8nhqJlqUkLvI33lpGqio7LnhHygcZ9l1Bb4aEdwiktSrDoLOLw
         XUYrHOxuL82yIIv88aQrz+E4bSOqIsh/Fgjv3K2j7MfO6sWIxyu2c0pIew5Sk4HuYEpj
         0XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZowT7GX9yB3jHkuz+dEavmGmCUEtOWXtF7tVQ//VwQ=;
        b=diZF4llT+ZptLPP1Oa4Z5BaAGEX2prLMvXQ7tXWai7p2VWWGFRR8ductAnwJCd02fm
         RwnDLjuL5yZmAR0yrPYHjPtfmLf4/rLjTCAyE4Nqn1IkVlgN65vVV4H78z5dBU/VLf23
         yaSrjAwAHPN6p56erTJ0xH7NS3K5i66F/JRJFxQqKy7e2sEId4cq70DNmIAeRB1F/bIQ
         6gzxW7W/e/woybHPDUeyoqk1uu79zgnvWUZlBqzTyhg0bdLSJZmCHjsdFmXTmSFthFi6
         BgzUZ28RuHPt4LeZcFXksiTWt3SMsyFgLW/SABIOraf5HMftkAdjaZVKLqweZkHt0buX
         4dzw==
X-Gm-Message-State: AHQUAuY+c04ULd2+k5HrsafqkTTooWNDybE9AIzaT+diddA/0aA2DA+2
        /7Ky7tASn0JA+d8cTl+kEFAHxIxbEdQ=
X-Google-Smtp-Source: AHgI3IYfB7TAIkKwbxoInhhL/IVtGGam1FCz1kWEhUwS0ZaaqnSwCjN4tP0IybwGmtSxXoMSdmZDHQ==
X-Received: by 2002:a17:902:887:: with SMTP id 7mr16870659pll.164.1549553131307;
        Thu, 07 Feb 2019 07:25:31 -0800 (PST)
Received: from ?IPv6:2600:380:7712:367d:9d7:f8fb:d4f4:2531? ([2600:380:7712:367d:9d7:f8fb:d4f4:2531])
        by smtp.gmail.com with ESMTPSA id b7sm12881046pfa.52.2019.02.07.07.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 07:25:30 -0800 (PST)
Subject: Re: generic_make_requests() latency spikes while changing queue
 settings
To:     Aleksei Zakharov <zakharov.a.g@yandex.ru>,
        linux-block@vger.kernel.org
References: <10641611549543442@iva4-f774db2b5297.qloud-c.yandex.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f9f63e6-6f9c-22fe-7ff9-6b88b0c3fda4@kernel.dk>
Date:   Thu, 7 Feb 2019 08:25:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <10641611549543442@iva4-f774db2b5297.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/7/19 5:44 AM, Aleksei Zakharov wrote:
> Hi all,
> 
> I've found that changing some block queue settings leads to generic_make_request() latency spike.
> It is reproducable in linux-4.10 - linux-4.20.6.
> ~# /usr/share/bcc/tools/funclatency  generic_make_request -i 1 -m
> Tracing 1 functions for "generic_make_request"... Hit Ctrl-C to end.
> 
>      msecs               : count     distribution
>          0 -> 1          : 156      |****************************************|
> 
>      msecs               : count     distribution
>          0 -> 1          : 153      |****************************************|
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 1        |                                        |
> 
>      msecs               : count     distribution
>          0 -> 1          : 162      |****************************************|
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |
>         16 -> 31         : 1        |                                        |
> 
> There're at least two settings with the same problem:
> queue/nr_requests
> queue/scheduler
> 
> How to reproduce:
> 1. Run fio:
> fio --name=test --rw=randwrite --direct=1 --filename=/dev/sdt --iodepth=1 --fsync=1 --ioengine=libaio --write_lat_log loglat
> 2. While fio is writing to the device, change nr_requests setting:
> echo 256 > /sys/block/sdt/queue/nr_requests
> or
> echo none > /sys/block/sdt/queue/scheduler
> 3. Stop fio and check slat log:
> ...
> 3980, 16, 1, 4096
> 3999, 17, 1, 4096
> 4010, 19, 1, 4096
> 4020, 18, 1, 4096
> 4045, 10821, 1, 4096
> 4054, 25, 1, 4096
> 4070, 12, 1, 4096
> 4083, 17, 1, 4096
> 4094, 16, 1, 4096
> 4111, 17, 1, 4096
> ...
> 
> I've tried to find the reason, using bcc-tools/funclatency.
> I used fio as in previous example and echo 256 > /sys/block/sdt/queue/nr_requests.
> It looks like, the problem is caused by waiting in blk_mq_freeze_queue_wait()
> which is called from blk_freeze_queue():
> ~# /usr/share/bcc/tools/funclatency  blk_mq_freeze_queue_wait -i 1 -m               
> Tracing 1 functions for "blk_mq_freeze_queue_wait"... Hit Ctrl-C to end.
> 
> 
>      msecs               : count     distribution
>          0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 1        |****************************************|
> 
> At the same time generic_make_request() latency spikes, because it's waiting
> for freezed request_queue in blk_queue_enter():
> 		wait_event(q->mq_freeze_wq,
> 			   (atomic_read(&q->mq_freeze_depth) == 0 &&
> 			    (pm || (blk_pm_request_resume(q),
> 				    !blk_queue_pm_only(q)))) ||
> 			   blk_queue_dying(q));
> 
> It could be found whith funclatency too:
> ~# /usr/share/bcc/tools/funclatency  blk_queue_enter -i 1 -m                    
> Tracing 1 functions for "blk_queue_enter"... Hit Ctrl-C to end.
> 
>      msecs               : count     distribution
>          0 -> 1          : 341      |****************************************|
> 
>      msecs               : count     distribution
>          0 -> 1          : 316      |****************************************|
> 
>      msecs               : count     distribution
>          0 -> 1          : 255      |****************************************|
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 1        |                                        |
> 
> Behavior of blk_mq_update_nr_requests() was chaned
> due to commit 70f36b6001bf596eb411c4b302e84c4824ae8730
> Reverting this commit on 4.20.6 fixed described problem with queue/nr_requests.
> Changing queue/scheduler causes same blk_mq_freeze_queue_wait() latency spike.
> 
> This affects production environments, beacuse some utilitis
> (arcconf for example) trigger uevents generating. It leads to settings change
> due to udev rules for device, so latency spike occurs.
> 
> Does blk_mq_freeze_queue_wait() waits for disk I/O to be completed?
> 
> Is it expected behaviour and won't be fixed?
> 
> If it is expected, could current settings be checked, before freezing queue,
> or at least before blk_mq_freeze_queue_wait call?
> It could probably help at least when no changes are needed.

Yes, it's expected and unavoidable. Why are you changing settings on the
fly? That's usually something you'd do when setting up the device. It's
impossible to avoid since the operations you mentioned require all IO to
be done, and no new IO started. This creates a bubble in the IO
pipeline.

I'd be fine with a patch that doesn't do anything if the settings are
the same.

-- 
Jens Axboe

