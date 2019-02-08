Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA5C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 09:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CBF21916
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 09:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="mxTyWz+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfBHJAJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:00:09 -0500
Received: from forward500j.mail.yandex.net ([5.45.198.250]:54692 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfBHI7z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 03:59:55 -0500
Received: from mxback13j.mail.yandex.net (mxback13j.mail.yandex.net [IPv6:2a02:6b8:0:1619::88])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id B96CA11C1A9E;
        Fri,  8 Feb 2019 11:59:51 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback13j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id fBzecXUxYj-xoQCkbvs;
        Fri, 08 Feb 2019 11:59:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1549616390;
        bh=GEBOrbozNpnuRboefBZzuZPFh8elWwjdCYv6rL1ElRk=;
        h=From:To:In-Reply-To:References:Subject:Date:Message-Id;
        b=mxTyWz+cGdLGywcZc+GWyCqHiKtIx6Rl722ey5wDGBzDSiQYOACmNBCBksar2ejq1
         p6Va8UDnQoJJc2rqY2g93unYwYIIbY0vsXvChDFYJ3GojwhB4q3SWRZ30DzfyX0pmm
         vvydFojbmmY7Psq/cHDiqZDS3ufJB6yPgiQQhNIY=
Authentication-Results: mxback13j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva4-406defa25fee.qloud-c.yandex.net with HTTP;
        Fri, 08 Feb 2019 11:59:50 +0300
From:   Aleksei Zakharov <zakharov.a.g@yandex.ru>
Envelope-From: zakharov-a-g@yandex.ru
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
In-Reply-To: <5f9f63e6-6f9c-22fe-7ff9-6b88b0c3fda4@kernel.dk>
References: <10641611549543442@iva4-f774db2b5297.qloud-c.yandex.net> <5f9f63e6-6f9c-22fe-7ff9-6b88b0c3fda4@kernel.dk>
Subject: Re: generic_make_requests() latency spikes while changing queue settings
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 08 Feb 2019 11:59:50 +0300
Message-Id: <32677921549616390@iva4-406defa25fee.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



07.02.2019, 18:25, "Jens Axboe" <axboe@kernel.dk>:
> On 2/7/19 5:44 AM, Aleksei Zakharov wrote:
>>  Hi all,
>>
>>  I've found that changing some block queue settings leads to generic_make_request() latency spike.
>>  It is reproducable in linux-4.10 - linux-4.20.6.
>>  ~# /usr/share/bcc/tools/funclatency generic_make_request -i 1 -m
>>  Tracing 1 functions for "generic_make_request"... Hit Ctrl-C to end.
>>
>>       msecs : count distribution
>>           0 -> 1 : 156 |****************************************|
>>
>>       msecs : count distribution
>>           0 -> 1 : 153 |****************************************|
>>           2 -> 3 : 0 | |
>>           4 -> 7 : 1 | |
>>
>>       msecs : count distribution
>>           0 -> 1 : 162 |****************************************|
>>           2 -> 3 : 0 | |
>>           4 -> 7 : 0 | |
>>           8 -> 15 : 0 | |
>>          16 -> 31 : 1 | |
>>
>>  There're at least two settings with the same problem:
>>  queue/nr_requests
>>  queue/scheduler
>>
>>  How to reproduce:
>>  1. Run fio:
>>  fio --name=test --rw=randwrite --direct=1 --filename=/dev/sdt --iodepth=1 --fsync=1 --ioengine=libaio --write_lat_log loglat
>>  2. While fio is writing to the device, change nr_requests setting:
>>  echo 256 > /sys/block/sdt/queue/nr_requests
>>  or
>>  echo none > /sys/block/sdt/queue/scheduler
>>  3. Stop fio and check slat log:
>>  ...
>>  3980, 16, 1, 4096
>>  3999, 17, 1, 4096
>>  4010, 19, 1, 4096
>>  4020, 18, 1, 4096
>>  4045, 10821, 1, 4096
>>  4054, 25, 1, 4096
>>  4070, 12, 1, 4096
>>  4083, 17, 1, 4096
>>  4094, 16, 1, 4096
>>  4111, 17, 1, 4096
>>  ...
>>
>>  I've tried to find the reason, using bcc-tools/funclatency.
>>  I used fio as in previous example and echo 256 > /sys/block/sdt/queue/nr_requests.
>>  It looks like, the problem is caused by waiting in blk_mq_freeze_queue_wait()
>>  which is called from blk_freeze_queue():
>>  ~# /usr/share/bcc/tools/funclatency blk_mq_freeze_queue_wait -i 1 -m
>>  Tracing 1 functions for "blk_mq_freeze_queue_wait"... Hit Ctrl-C to end.
>>
>>       msecs : count distribution
>>           0 -> 1 : 0 | |
>>           2 -> 3 : 0 | |
>>           4 -> 7 : 0 | |
>>           8 -> 15 : 1 |****************************************|
>>
>>  At the same time generic_make_request() latency spikes, because it's waiting
>>  for freezed request_queue in blk_queue_enter():
>>                  wait_event(q->mq_freeze_wq,
>>                             (atomic_read(&q->mq_freeze_depth) == 0 &&
>>                              (pm || (blk_pm_request_resume(q),
>>                                      !blk_queue_pm_only(q)))) ||
>>                             blk_queue_dying(q));
>>
>>  It could be found whith funclatency too:
>>  ~# /usr/share/bcc/tools/funclatency blk_queue_enter -i 1 -m
>>  Tracing 1 functions for "blk_queue_enter"... Hit Ctrl-C to end.
>>
>>       msecs : count distribution
>>           0 -> 1 : 341 |****************************************|
>>
>>       msecs : count distribution
>>           0 -> 1 : 316 |****************************************|
>>
>>       msecs : count distribution
>>           0 -> 1 : 255 |****************************************|
>>           2 -> 3 : 0 | |
>>           4 -> 7 : 0 | |
>>           8 -> 15 : 1 | |
>>
>>  Behavior of blk_mq_update_nr_requests() was chaned
>>  due to commit 70f36b6001bf596eb411c4b302e84c4824ae8730
>>  Reverting this commit on 4.20.6 fixed described problem with queue/nr_requests.
>>  Changing queue/scheduler causes same blk_mq_freeze_queue_wait() latency spike.
>>
>>  This affects production environments, beacuse some utilitis
>>  (arcconf for example) trigger uevents generating. It leads to settings change
>>  due to udev rules for device, so latency spike occurs.
>>
>>  Does blk_mq_freeze_queue_wait() waits for disk I/O to be completed?
>>
>>  Is it expected behaviour and won't be fixed?
>>
>>  If it is expected, could current settings be checked, before freezing queue,
>>  or at least before blk_mq_freeze_queue_wait call?
>>  It could probably help at least when no changes are needed.
>
> Yes, it's expected and unavoidable. Why are you changing settings on the
> fly? That's usually something you'd do when setting up the device. It's
> impossible to avoid since the operations you mentioned require all IO to
> be done, and no new IO started. This creates a bubble in the IO
> pipeline.
>
> I'd be fine with a patch that doesn't do anything if the settings are
> the same.
>
> --
> Jens Axboe

Thanks for the answer!
> Why are you changing settings on the fly?
We don't want to change them, but some software triggers uevents.
For example - arcconf tool, which is used for Adaptec HBA adapters.
Even command 'arcconf help' results in change uevents for every
block device.

I'll prepare few patches to avoid queue freeze if no changes required.

-- 
Regards,
Aleksei Zakharov

