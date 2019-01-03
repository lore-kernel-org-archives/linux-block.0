Return-Path: <SRS0=Dd+4=PL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C041C43387
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 15:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FA22070D
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 15:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YmzVeyDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfACPWG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:22:06 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:34976 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfACPWG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jan 2019 10:22:06 -0500
Received: by mail-it1-f179.google.com with SMTP id p197so43079145itp.0
        for <linux-block@vger.kernel.org>; Thu, 03 Jan 2019 07:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pni8uuj9u9ybHx1rc+aTRhSS8TZOSY9aKCjPyslsE+Q=;
        b=YmzVeyDdWSSMLhmIe4TSOSP6KFw5yOlTseZuHMsv12PRzOcgg/aPmLCAkWVNwq+aTQ
         IzxB3darFsC1V5ZR36hx+JTpa2th/gcVxlqgQ9Gx6Dcrv0hEISyYruRVz2LvAN3jt0Ha
         e1LrrtBnYVJxf8lul4haNT+T5O+atzLDHVdxbCFq62seY/9EYZNz5ikvk9xqggPSPeEG
         YNOF/hbitPNwqW4cJ/5DFcxBfqj7eJlPwo2ckeHhCre06rfsNy++m82jo3XE5+2xm5WT
         XKTK6Yuplr+D/suJ107+A7utszCoe9jYX79OQ2hnCdkeVHE+5oRlNwtLab2l2/ueK8Dt
         RvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pni8uuj9u9ybHx1rc+aTRhSS8TZOSY9aKCjPyslsE+Q=;
        b=iW7GrzGZY1Fmbcz2m+2OMzXwXWVWU1MuH+rtBXIdFQS3AGf2oUKO1SGZy6Zw8BwNQq
         JZEKXuNDZ5eTpsWaPgoOIwICFYhxMjULDnSzAqXXzGf0DaBzDw/lt6DDB18viiakQuUI
         WZ1tB6F7NjbNHp+fs2SJt/8EAzyc0H2SYSB+iISX2u1DE4U/Qe64VuRHDfLSRtIXmOBe
         VWeNcOj+Zqw5gvo58X91QXQ4Qdn+ztwg8Z5PB6qQadXXN/v71il9hxVAUkKcNsXmF2gI
         Q3couDpXBGFQuRSWmF3qDVM8EK+FJTbgKdlevjmmtzI4AoCEVkA97C2fSg4atks+94NX
         tTqw==
X-Gm-Message-State: AA+aEWbdKfSMZnvTW6y9XqKKguxeFUYRPS4OeoXo4H8eyEqknYsFKwoG
        SuneRf/RzyA9008XbJr4qwynzw==
X-Google-Smtp-Source: AFSGD/Vc5bnfJ3HV1ShnDhydYybB27onVku6+J5ch0u9MDbA+lz8WQy7K9vv7yeU3rgEeAx+4rAuKQ==
X-Received: by 2002:a24:9686:: with SMTP id z128mr30877809itd.97.1546528925253;
        Thu, 03 Jan 2019 07:22:05 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 14sm21484031itm.3.2019.01.03.07.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 07:22:04 -0800 (PST)
Subject: Re: [PATCH] block: sunvdc: don't run hw queue synchronously from irq
 context
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
References: <20190103011948.25706-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fbaa1e6f-71d5-0696-a873-20bc1b6a5a7d@kernel.dk>
Date:   Thu, 3 Jan 2019 08:22:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190103011948.25706-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/2/19 6:19 PM, Ming Lei wrote:
> vdc_blk_queue_start() may be called from irq context, so we can't run
> queue via blk_mq_start_hw_queues() since we never allow to run queue
> from irq context. Use blk_mq_start_stopped_hw_queues(q, true) to fix
> this issue.

Thanks Ming, applied.

-- 
Jens Axboe

