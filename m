Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E95DC64ED8
	for <linux-block@archiver.kernel.org>; Fri, 24 Feb 2023 07:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBXHwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Feb 2023 02:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBXHwe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2023 02:52:34 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1B4DE3E
        for <linux-block@vger.kernel.org>; Thu, 23 Feb 2023 23:52:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VcNBPph_1677225149;
Received: from 30.221.148.141(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VcNBPph_1677225149)
          by smtp.aliyun-inc.com;
          Fri, 24 Feb 2023 15:52:30 +0800
Message-ID: <a20a449a-73c1-c7dd-b100-89e346c35828@linux.alibaba.com>
Date:   Fri, 24 Feb 2023 15:52:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH blktests v3 1/2] src: add mini ublk source code
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230220034649.1522978-1-ming.lei@redhat.com>
 <20230220034649.1522978-2-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230220034649.1522978-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/2/20 11:46, Ming Lei wrote:

[...]

> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  src/.gitignore |    1 +
>  src/Makefile   |   18 +
>  src/miniublk.c | 1376 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1395 insertions(+)
>  create mode 100644 src/miniublk.c
> 
> diff --git a/src/.gitignore b/src/.gitignore
> index 355bed3..df7aff5 100644
> --- a/src/.gitignore
> +++ b/src/.gitignore
> @@ -8,3 +8,4 @@
>  /sg/dxfer-from-dev
>  /sg/syzkaller1
>  /zbdioctl
> +/miniublk
> diff --git a/src/Makefile b/src/Makefile
> index 3b587f6..81c6541 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -2,6 +2,10 @@ HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
>  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
>  		else echo "$(3)"; fi)
>  
> +HAVE_C_MACRO = $(shell if echo "#include <$(1)>" |	\
Hi Ming,

It should be "\#include", not "#include". You miss a "\".

Regards,
Zhang
