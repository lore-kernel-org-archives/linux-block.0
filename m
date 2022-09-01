Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E99ECAAD1
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 03:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiIADEb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 23:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIADEa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 23:04:30 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F8CB2CC0
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 20:04:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VNu9fMt_1662001464;
Received: from 30.97.56.214(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNu9fMt_1662001464)
          by smtp.aliyun-inc.com;
          Thu, 01 Sep 2022 11:04:26 +0800
Message-ID: <0dc0e0ac-75cd-81e5-e54b-1b0436090f4c@linux.alibaba.com>
Date:   Thu, 1 Sep 2022 11:04:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V2 1/1] Docs: ublk: add ublk document
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220901023008.669893-1-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220901023008.669893-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/9/1 10:30, Ming Lei wrote:
> +
> +- ``UBLK_IO_NEED_GET_DATA``
> +
> +  ublk server pre-allocates IO buffer for each IO by default. Any new projects
> +  should use this buffer to communicate with ublk driver. However, existing
> +  projects may break or not able to consume the new buffer interface; that's
> +  why this command is added for backwards compatibility so that existing
> +  projects can still consume existing buffers.

Hi, Ming.

Could you please add more information on UBLK_IO_NEED_GET_DATA. stefanha
found it hard to understand.

Myabe we should write like this:

With UBLK_F_NEED_GET_DATA enabled, the WRITE request will be firstly issued to
ublksrv without data copy. Then, IO backend receives the request and it can allocate
data buffer and embed its addr inside a new ioucmd. After the kernel driver gets the
ioucmd, the data copy happens(from biovecs to backend's buffer). Finally,
the backend receives the request again with data to be written and it can truly
handle the request.

UBLK_IO_NEED_GET_DATA add one additional round-trip in ublk_drv and one
io_uring_enter() syscall. Any user thinks that it may lower performance
should not enable UBLK_F_NEED_GET_DATA. ublk server pre-allocates IO buffer
for each IO by default. Any new projects should use this buffer to communicate
with ublk driver. However, existing projects may break or not able to consume
the new buffer interface; that's why this command is added for backwards
compatibility so that existing projects can still consume existing buffers.

Regards,
Zhang.
