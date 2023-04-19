Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E8FC6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 03:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjDSDXU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDSDXT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 23:23:19 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346C3D2
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 20:23:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VgT.0cM_1681874593;
Received: from 30.97.56.214(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VgT.0cM_1681874593)
          by smtp.aliyun-inc.com;
          Wed, 19 Apr 2023 11:23:14 +0800
Message-ID: <116d8a56-0881-56d3-9bcc-78ff3e1dc4e5@linux.alibaba.com>
Date:   Wed, 19 Apr 2023 11:23:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: Question about ublk and NEED_GET_DATA
Content-Language: en-US
To:     "Harris, James R" <james.r.harris@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <0D50EEFA-BCFE-4D5F-8653-99656A8C49F8@intel.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <0D50EEFA-BCFE-4D5F-8653-99656A8C49F8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/4/19 08:03, Harris, James R wrote:

Hi,

Thanks for using the NEED_GET_DATA feature. 

> Hi,
> 
> I’m working on adding NEED_GET_DATA support to the SPDK ublk server, to avoid allocating I/O buffers until they are actually needed.

Yes, with NEED_GET_DATA, you don't have to preallocate I/O buffers for WRITE requests.

> 
> It is very clear how this works for write commands with NEED_GET_DATA.  We wait to allocate the buffer until we get UBLK_IO_RES_NEED_GET_DATA completion and submit again using UBLK_IO_NEED_GET_DATA.  After we get the UBLK_IO_RES_OK completion from ublk, we submit the block request to the SPDK bdev layer.  After it completes, we submit using UBLK_IO_COMMIT_AND_FETCH_REQ and can free the I/O buffer because the data has been committed.

Yes, you are right.

> 
> But how does this work for the read path?  On a read, I can wait to allocate the buffer until I get the UBLK_IO_RES_OK completion.  But after the read operation is completed and SPDK submits the UBLK_IO_COMMIT_AND_FETCH_REQ, how do I know when ublk has finished copying data out of the buffer so that I can reuse that buffer?
> 
> I’m sure I’m missing something obvious, if anyone can provide a pointer I would appreciate it.

In the WRITE path, data copy happens before the backend gets UBLK_IO_RES_OK.

In the READ path, data copy happens after the backend submits UBLK_IO_COMMIT_AND_FETCH_REQ,
but unfortunately we cannot know the time data copy happens because ublk driver does not notify
the backend until next request(on this tag) comes.

Regards,
Zhang

> 
> Thanks,
> 
> Jim Harris
> 


