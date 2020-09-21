Return-Path: <SRS0=nPog=C6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396B3C4363C
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 18:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B4E2193E
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 18:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="da+XH/qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgIUSEV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUSEV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 14:04:21 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C90C061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 11:04:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g3so13185303qtq.10
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pKTrFbirGmMhlMPaE3qlluEedF8FF8FARN5U5oI/yts=;
        b=da+XH/qwmtb8WAjxG5dCcuccvCfFtoSSeEEsClvefHSxKutsn/xkZ/hhCKIzjldp/4
         pOwY3fQE4hDbSOMu7+hCecdPCs5XT9RPQ7KqPIOcFQy2mS5IWyptRgjcXdll8wzZ6DtC
         dK57tYHqsRNMcCDY4mJqaCTuvLTXLbofUnONFu/d+SD2f3YV24R3J3Zl+Mc/4huwe+eb
         pBQExgLl3pQV3K2z0QVyvyazP8Y+341w4k5Z5+kPEFuOF1OMz0T2Awa6coQh0aSNmtnO
         h6TaCh64tGNnuiU68d5eTds39PqO4iMH/nVRFtcRws0IYhX4jn5u24otxqYwfjtmYV/f
         YIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pKTrFbirGmMhlMPaE3qlluEedF8FF8FARN5U5oI/yts=;
        b=RTI/ChIkRrL5nOIR4B7tvbe+cAbySjY4XUAADcLQ3h4C19lUTA/8NCRXqCzy6x1yMF
         JnOcFj9On3gGHWsGxxt5ZOSAAfFRQ3cBQeDDMZKk8FzBVZMXEKWO/nsFQjSYh937P0KW
         qNcB4CO6/n5UuQnw8QGYrovg6DtOrOGpEz4X/Y4UEg3s7v2GlRUk+/jwyjdAthJmNSIG
         YZ3IK5b1lECuD1uRyWbYH+fXGXtpMi35kCxyvkCk7MaBkxJ1k7pKwoZ6GExMQYeXTwUR
         F86jyvo1kqgMiu+uq7sGkoH/I4+pnWlUIcWyCOLLvpU0D5/xn1C+W+P7SR0JiQV+3khp
         Bkgg==
X-Gm-Message-State: AOAM530U4CgykFqq4WdHkq5dwLKFjU2qlWf4s3f2Hb2tLJX/XpO+2UAD
        MUqJZNxCpy2r1CuS+ZCzj0F/Jg==
X-Google-Smtp-Source: ABdhPJx1v2LZEu/bjdlV8ckzvZHsmfXvcS3cjnqnGXVjyCPfrc1pjWK0iM9w+T5ROxx2kuw82jZiRw==
X-Received: by 2002:ac8:7744:: with SMTP id g4mr787970qtu.306.1600711460217;
        Mon, 21 Sep 2020 11:04:20 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v18sm10335803qtq.15.2020.09.21.11.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:04:19 -0700 (PDT)
Subject: Re: [PATCH 1/3] nbd: return -ETIMEDOUT when NBD_DO_IT ioctl returns
To:     Hou Pu <houpu@bytedance.com>, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20200921105718.29006-1-houpu@bytedance.com>
 <20200921105718.29006-2-houpu@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <cf90de57-986e-8e96-0ea9-9a593cbd4c16@toxicpanda.com>
Date:   Mon, 21 Sep 2020 14:04:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921105718.29006-2-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/20 6:57 AM, Hou Pu wrote:
> We used to return -ETIMEDOUT if io timeout happened. But since
> commit d970958b2d24 ("nbd: enable replace socket if only one
> connection is configured"), user space would not get -ETIMEDOUT.
> This commit fixes this. Only return -ETIMEDOUT if only one socket
> is configured by ioctl and the user specified a non-zero timeout
> value.
> 
> Signed-off-by: Hou Pu <houpu@bytedance.com>

This is fine, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to this one, thanks,

Josef
