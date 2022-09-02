Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37D0C6FA85
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 06:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiIBGCA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 02:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiIBGB6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 02:01:58 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E01CFDC;
        Thu,  1 Sep 2022 23:01:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VO4ysm2_1662098511;
Received: from 30.97.56.174(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VO4ysm2_1662098511)
          by smtp.aliyun-inc.com;
          Fri, 02 Sep 2022 14:01:52 +0800
Message-ID: <5c4de01f-49ef-166f-e625-d9d67b2378a1@linux.alibaba.com>
Date:   Fri, 2 Sep 2022 14:01:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V3 1/1] Docs: ublk: add ublk document
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <20220901133022.698343-1-ming.lei@redhat.com>
Content-Language: en-US
In-Reply-To: <20220901133022.698343-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/9/1 21:30, Ming Lei wrote:
> Add documentation for ublk subsystem. It was supposed to be documented when
> merging the driver, but missing at that time.
> 
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> Cc: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V3:
>     - add more words on UBLK_IO_NEED_GET_DATA, from Ziyang
>     - improve grammar & fix warning on 'make htmldocs', from Bagas Sanjaya
>     - other trivial change, suggested by Richard W.M. Jones
> V2:
>     - integrate all kinds of cleanup from Bagas Sanjaya
>     - add 'why useful' paragraph from Stefan
>     - replace ublksrv with ublksrv for representing generic ublk
>       userspace for convenience of reference, as suggested by Stefan
>     - add entry to block/index.rst for removing ktest waring
>     - add MAINTAINER entry
>     - add more references, such as zero copy and nbdublk
>     - thanks review/suggestion from Bagas Sanjaya, Richard W.M. Jones, Stefan Hajnoczi
>     and ZiyangZhang
>

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

