Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A73E732D9
	for <linux-block@archiver.kernel.org>; Thu, 28 Sep 2023 13:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjI1Nnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Sep 2023 09:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjI1Nnm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Sep 2023 09:43:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB7194
        for <linux-block@vger.kernel.org>; Thu, 28 Sep 2023 06:43:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533c71c5f37so2499573a12.0
        for <linux-block@vger.kernel.org>; Thu, 28 Sep 2023 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695908619; x=1696513419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2V6UMsz3keE8Oc0msyB57V0fmGycw/8zbKI2stLuJgg=;
        b=sStF/aG6Ih8bRLwenR4sAKiFJAMDgRTnvkYiSRp9RuNC2C1vUXYvHeWiUqBmZ3PKkU
         PeXchaMBjR+BSzCm1lFFFs7UuJauTOMGauKWerUfh7pNu9chGg5v64DH9R+/pB6A2coe
         YTg+up83Yj1IJ4b8p+PORJmxnQmYoVHZJaDlMaaW78tRXKm4Y3avNHrlC1t18xpLCtp7
         znMTpdzzE4FYRjy01YR7nhizfVjI8Jv2mBSvSDD0QewaMartdiAeMv2AGOZzbPLq+YZp
         xkB/9S6xcZiHKXDFUV1rTaivY4JMtHKtAXXRZCtqtykDn6J2bFs2GzI/75dlZV2p3FwQ
         BT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695908619; x=1696513419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2V6UMsz3keE8Oc0msyB57V0fmGycw/8zbKI2stLuJgg=;
        b=vqTiFmlQjLoFGZ9AbGk3xkWZW3bSgoyUkY6JzOPW8tIbxan3vbdm1SKWa27O7z/SJs
         jNe4eUKXqsZXkNMnOXj+9lzVl4M6sFIU5qrhV4pt5U/DA5ynLrMN51rFanQBkqCA0lXk
         W6Rq33cv3AM9AYAEjc2i8Dvh5lDy80U4GRI8IVOzktPMoafN8Keuejj5vSsd+jhjYb6h
         S5ks5oX//coNsrvNXTz40jG7JUoU6arMcRbbwkQ6A1Jy54uVOHw0XCVABvDlKnfL+QSc
         lRDjaP+MxaAgecY4pZrbC9+1ztxnfs51syuzmdXJU2h14u4UeKk2jlxQiceXpWPan9l5
         owRg==
X-Gm-Message-State: AOJu0Yyv+O1OZ47UkpGjEOye0LiiN07gLNUTUAv/LHJl1KU6Olgvm4qx
        HKUhv9KWncvJjfvokDFx4z+e3g==
X-Google-Smtp-Source: AGHT+IEe0HVRjv7+vBRClK2A8/+5EMfjUlX3w0JUU3/0ND5kAuorq6ON/gHKKymaLh6pZnnn7oYP1g==
X-Received: by 2002:a05:6402:5243:b0:51d:cfeb:fc3b with SMTP id t3-20020a056402524300b0051dcfebfc3bmr1094319edd.1.1695908619132;
        Thu, 28 Sep 2023 06:43:39 -0700 (PDT)
Received: from [172.20.13.88] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id q19-20020a056402041300b005330e1e7da0sm9587296edv.92.2023.09.28.06.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 06:43:38 -0700 (PDT)
Message-ID: <d4d952cb-b045-46b6-ba45-e78cd257dd6e@kernel.dk>
Date:   Thu, 28 Sep 2023 07:43:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/2] io_uring: cancelable uring_cmd
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>,
        Anuj Gupta <anuj20.g@samsung.com>
References: <20230928124327.135679-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230928124327.135679-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/23 6:43 AM, Ming Lei wrote:
> Hello,
> 
> Patch 1 retains top 8bits of  uring_cmd flags for kernel internal use.
> 
> Patch 2 implements cancelable uring_cmd.

Applied, thanks. Had to hand apply as it doesn't apply to
for-6.7/io_uring due to the waitid addition, but trivial stuff.

-- 
Jens Axboe

