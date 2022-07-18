Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56137C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 08:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiGRI4G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiGRI4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 04:56:06 -0400
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE3AAE4F
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 01:56:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VJglAm9_1658134558;
Received: from 30.97.56.227(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VJglAm9_1658134558)
          by smtp.aliyun-inc.com;
          Mon, 18 Jul 2022 16:55:58 +0800
Message-ID: <bcd9ac30-9961-5607-e40d-41915af5cd88@linux.alibaba.com>
Date:   Mon, 18 Jul 2022 16:55:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: use of the system work queue in ublk
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <YtT/4Y387f/6pxZH@infradead.org> <YtUNX2l2xkWXQwYA@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YtUNX2l2xkWXQwYA@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/18 15:35, Ming Lei wrote:
> Hi Christoph,
> 
> On Sun, Jul 17, 2022 at 11:38:25PM -0700, Christoph Hellwig wrote:
>> Hi Ming,
>>
>> it seems like ublk uses schedule_work to stop the device, which
>> includes a del_gendisk.  I'm a little fearful this will gets us into
>> lockdep chains of death once syzbot or Tetsu notice it.
> 
> ublksrv has two built-in tests(generic/001, generic/002) for covering
> heavy io with device removal and killing ubq_daemon, not see lockdep
> warning when running the two tests with lockdep enabled.
> 
> Could you or Tetsu provide a bit more info about the warning?
> 
>>
>> That being said, I don't reall understand the design of
>> ublk_daemon_monitor_work, which is only used to kick off other
>> work to start with.
> 
> If the ubq daemon becomes dead, ublk_daemon_monitor_work will be
> scheduled for handling the error: abort pending io requests, and
> start to delete disk.
> 
> It has to be triggered when del_gendisk() is in-progress for making
> forward progress.
> 
> 
> Thanks,
> Ming

Hi Ming,

Just to make sure I understand usage of ublk_daemon_monitor_work correctly.

1) For a dying ubq daemon, ublk_daemon_monitor_work schedule stop work first.

2) The stop work calls del_gendisk() and it is blocked because there are
   pending blk-mq requests(maybe handling in ublksrv target).

3) Meanwhile, the monitor work aborts all pending blk-mq IOs
   (with UBLK_IO_FLAG_ACTIVE unset) by blk_mq_end_request(req, BLK_STS_IOERR).

4) After all pending blk-mq reqs are aborted,
   del_gendisk() in stop work returns and /dev/ublkbX is removed.
   No more blk-mq reqs.

5) In stop work, cancel all queued(with UBLK_IO_FLAG_ACTIVE set) ublk IOs
   by io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0) and ublksrv won't
   issue sqes again.


Hope I am correct and all of these works looks good to me.
Besides, the tests(generic/001, generic/002) run successfully for me.

Regards,
Ziyang Zhang


