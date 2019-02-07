Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A6AC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA5620823
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 12:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ZgBhalMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfBGMui (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:50:38 -0500
Received: from forward102j.mail.yandex.net ([5.45.198.243]:37838 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbfBGMui (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 07:50:38 -0500
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2019 07:50:35 EST
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id BBD81F22180
        for <linux-block@vger.kernel.org>; Thu,  7 Feb 2019 15:44:03 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id dvm0sYNozZ-i22qQH2P;
        Thu, 07 Feb 2019 15:44:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1549543442;
        bh=Mn08+REM4LWeGZ5/lGA4iwc2Id380bV/V85VbR0ST1I=;
        h=From:To:Subject:Date:Message-Id;
        b=ZgBhalMtGt77ogvDdCvqSCehBSq7SUmxstCdURYBjr5TShy4saWjRRkn/NDhXXqjB
         RR5m+oQEsYnxdyakM50I0bgQtlPU/Zw6AY63B1vu6eHQTQhA2zmXH+lnmL73zWugZi
         Mum08F3B88xkDpSaDcolGG30THEIf1qJyEo+OfjM=
Authentication-Results: mxback15j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva4-f774db2b5297.qloud-c.yandex.net with HTTP;
        Thu, 07 Feb 2019 15:44:02 +0300
From:   Aleksei Zakharov <zakharov.a.g@yandex.ru>
Envelope-From: zakharov-a-g@yandex.ru
To:     linux-block@vger.kernel.org
Subject: generic_make_requests() latency spikes while changing queue settings
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 07 Feb 2019 15:44:02 +0300
Message-Id: <10641611549543442@iva4-f774db2b5297.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

I've found that changing some block queue settings leads to generic_make_request() latency spike.
It is reproducable in linux-4.10 - linux-4.20.6.
~# /usr/share/bcc/tools/funclatency  generic_make_request -i 1 -m
Tracing 1 functions for "generic_make_request"... Hit Ctrl-C to end.

     msecs               : count     distribution
         0 -> 1          : 156      |****************************************|

     msecs               : count     distribution
         0 -> 1          : 153      |****************************************|
         2 -> 3          : 0        |                                        |
         4 -> 7          : 1        |                                        |

     msecs               : count     distribution
         0 -> 1          : 162      |****************************************|
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |
        16 -> 31         : 1        |                                        |

There're at least two settings with the same problem:
queue/nr_requests
queue/scheduler

How to reproduce:
1. Run fio:
fio --name=test --rw=randwrite --direct=1 --filename=/dev/sdt --iodepth=1 --fsync=1 --ioengine=libaio --write_lat_log loglat
2. While fio is writing to the device, change nr_requests setting:
echo 256 > /sys/block/sdt/queue/nr_requests
or
echo none > /sys/block/sdt/queue/scheduler
3. Stop fio and check slat log:
...
3980, 16, 1, 4096
3999, 17, 1, 4096
4010, 19, 1, 4096
4020, 18, 1, 4096
4045, 10821, 1, 4096
4054, 25, 1, 4096
4070, 12, 1, 4096
4083, 17, 1, 4096
4094, 16, 1, 4096
4111, 17, 1, 4096
...

I've tried to find the reason, using bcc-tools/funclatency.
I used fio as in previous example and echo 256 > /sys/block/sdt/queue/nr_requests.
It looks like, the problem is caused by waiting in blk_mq_freeze_queue_wait()
which is called from blk_freeze_queue():
~# /usr/share/bcc/tools/funclatency  blk_mq_freeze_queue_wait -i 1 -m               
Tracing 1 functions for "blk_mq_freeze_queue_wait"... Hit Ctrl-C to end.


     msecs               : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 1        |****************************************|

At the same time generic_make_request() latency spikes, because it's waiting
for freezed request_queue in blk_queue_enter():
		wait_event(q->mq_freeze_wq,
			   (atomic_read(&q->mq_freeze_depth) == 0 &&
			    (pm || (blk_pm_request_resume(q),
				    !blk_queue_pm_only(q)))) ||
			   blk_queue_dying(q));

It could be found whith funclatency too:
~# /usr/share/bcc/tools/funclatency  blk_queue_enter -i 1 -m                    
Tracing 1 functions for "blk_queue_enter"... Hit Ctrl-C to end.

     msecs               : count     distribution
         0 -> 1          : 341      |****************************************|

     msecs               : count     distribution
         0 -> 1          : 316      |****************************************|

     msecs               : count     distribution
         0 -> 1          : 255      |****************************************|
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 1        |                                        |

Behavior of blk_mq_update_nr_requests() was chaned
due to commit 70f36b6001bf596eb411c4b302e84c4824ae8730
Reverting this commit on 4.20.6 fixed described problem with queue/nr_requests.
Changing queue/scheduler causes same blk_mq_freeze_queue_wait() latency spike.

This affects production environments, beacuse some utilitis
(arcconf for example) trigger uevents generating. It leads to settings change
due to udev rules for device, so latency spike occurs.

Does blk_mq_freeze_queue_wait() waits for disk I/O to be completed?

Is it expected behaviour and won't be fixed?

If it is expected, could current settings be checked, before freezing queue,
or at least before blk_mq_freeze_queue_wait call?
It could probably help at least when no changes are needed.

-- 
Regards,
Aleksei Zakharov

