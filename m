Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3877C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 03:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjDSDeN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjDSDeI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 23:34:08 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C9140FE
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 20:34:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VgT.5CP_1681875242;
Received: from 30.97.56.214(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VgT.5CP_1681875242)
          by smtp.aliyun-inc.com;
          Wed, 19 Apr 2023 11:34:03 +0800
Message-ID: <7cd829ae-b7a3-8024-5dfc-e9af458d11f8@linux.alibaba.com>
Date:   Wed, 19 Apr 2023 11:34:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: Question about ublk and NEED_GET_DATA
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        "Harris, James R" <james.r.harris@intel.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0D50EEFA-BCFE-4D5F-8653-99656A8C49F8@intel.com>
 <ZD9SjEd7D2AXQypp@ovpn-8-18.pek2.redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <ZD9SjEd7D2AXQypp@ovpn-8-18.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/4/19 10:31, Ming Lei wrote:
> On Wed, Apr 19, 2023 at 12:03:40AM +0000, Harris, James R wrote:
>> Hi,
>>
>> I’m working on adding NEED_GET_DATA support to the SPDK ublk server, to avoid allocating I/O buffers until they are actually needed.
>>
>> It is very clear how this works for write commands with NEED_GET_DATA.  We wait to allocate the buffer until we get UBLK_IO_RES_NEED_GET_DATA completion and submit again using UBLK_IO_NEED_GET_DATA.  After we get the UBLK_IO_RES_OK completion from ublk, we submit the block request to the SPDK bdev layer.  After it completes, we submit using UBLK_IO_COMMIT_AND_FETCH_REQ and can free the I/O buffer because the data has been committed.
>>
>> But how does this work for the read path?  On a read, I can wait to allocate the buffer until I get the UBLK_IO_RES_OK completion.  But after the read operation is completed and SPDK submits the UBLK_IO_COMMIT_AND_FETCH_REQ, how do I know when ublk has finished copying data out of the buffer so that I can reuse that buffer?
>>
>> I’m sure I’m missing something obvious, if anyone can provide a pointer I would appreciate it.
> 
> Yeah, it is one known issue.
> 
> But the buffer is guaranteed to be ready for reuse after io_uring_enter()
> returns.
> 
> Also the patch[1] exposes read/write interface to /dev/ublkcN,
> then NEED_GET_DATA becomes not necessary any more. The initial
> motivation is for zero-copy, but it can be used for non-zc too, such as
> don't do any copy in driver side, and simply let userspace cover
> everything:
> 
> 1) ublk server gets one io command, allocate buffer and handle this
> command
> 
> 2) if it is WRITE command, read buffer data via read() from
> /dev/ublkcN, then handle the write by this buffer 
> 
> 3) if it is READ command, handle the read using the allocated buffer,
> and after the data is ready in this buffer, write data in buffer to
> /dev/ublkcN.
> 
> This approach could be cleaner for both sides, but add one extra cost
> of read/write /dev/ublkcN in userspace, and it can be done via io_uring
> too.
> 
> What do you think of this approach?
> 
> [1] https://lore.kernel.org/linux-block/20230330113630.1388860-16-ming.lei@redhat.com/

This idea is good, IMO.

Regards,
Zhang

> 
> 
> Thanks,
> Ming
