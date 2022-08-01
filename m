Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC2CC00140
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 02:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbiHACsG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 22:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiHACsF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 22:48:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BCECE1E
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 19:48:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso13747499pjo.1
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 19:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=OVfBp98HTTyktc8jgsdJCtTZ1qy/5LsjC+BDL442KqE=;
        b=i9RFpvirK8mNvVIHC5X6aA5pJMZWP+px4UzMkUfLYsgdD7lB/6rBnfGx0tKlbbcJc3
         ESZ4hjZ4JtOMZCY9lg5s5T2Hfj49ru0wcuo4+DlVe2XBUvPYSftO2vgz25QLFXTX+GJa
         PcocRy8JNX9FtKT/ncMsvLQokBRVyeBJWEWHWJLCkwdZGvyQeSitR0vRycFEZnh0kN1w
         MW09gyxo0JFnzK3KwAgQ5b0J6QvKVzfMcq0G73/XjSltt4zPDLs45838sLFfeIhDkNam
         47Iuqo6FGnqWsUsVuuhmda7wNFni/ALJTCAUVTvjme5RsbzDPHf+cVEHvOq0ccwqkogP
         cASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=OVfBp98HTTyktc8jgsdJCtTZ1qy/5LsjC+BDL442KqE=;
        b=3LgnvIKxIwLBIQR4suz/wQU5o1Rz0rW0imJouagOteQChSAPTwki8oy/5cKnHsNcMk
         5uaJ9GAsvbx8Xssco0mR35wQ8Q3KzEz017reUiyT5PH9FoY/O4b/w+xbl2YqnSXEcK4B
         E9pc+CvbGUbEV/SNNEug9F4mdm6TI1tv0wNr0/NcL0rcdokpCGIaWzPKrxurOx6WWXXa
         dflw1R9ToBhH8Pr8gQL6mvpiv0HMD2nW8NiXDkOf2REPJBTRQq+9BRKou+8i/tl9vt+H
         SXPm9VT/72hNBZ0G066htUEmiKLZ8Swrm5q9CZHr5jbrzRsFf2yJ2OkMeZKrnRYCSKoN
         8Ucg==
X-Gm-Message-State: ACgBeo0Xm7ABfDK8mVaMXMY/G729GpauXdlzSthPq1zZkYQ4kyE4kuTE
        DFI5p0oOPci0NYMvUq73azDSFw==
X-Google-Smtp-Source: AA6agR70haRvUu5YzMxObKmGBDYu/VeswMG23VRbloTyq9TMYbc8EgM/wqFV6iyZV9Mkwi6OhKsCcw==
X-Received: by 2002:a17:90b:1e4d:b0:1f0:462b:b573 with SMTP id pi13-20020a17090b1e4d00b001f0462bb573mr17137317pjb.164.1659322084146;
        Sun, 31 Jul 2022 19:48:04 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f144-20020a623896000000b0052d52de6726sm1699042pfa.124.2022.07.31.19.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 19:48:03 -0700 (PDT)
Message-ID: <19236388-4ee0-28ee-c2f8-7fe88f445872@kernel.dk>
Date:   Sun, 31 Jul 2022 20:48:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 0/2] ublk: add support for UBLK_IO_NEED_GET_DATA
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com
References: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
 <4c6f7d83-183a-da98-a41a-5363db6f3297@linux.alibaba.com>
 <Yuc3dq50YoU3CVzP@T590> <70d3dc55-a877-c4c9-cafc-feebf150fbb7@kernel.dk>
In-Reply-To: <70d3dc55-a877-c4c9-cafc-feebf150fbb7@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/31/22 8:43 PM, Jens Axboe wrote:
> On 7/31/22 8:16 PM, Ming Lei wrote:
>> On Sun, Jul 31, 2022 at 04:03:30PM +0800, Ziyang Zhang wrote:
>>> Hi Jens,
>>>
>>> Please queue this patchset up for the 5.20 merge window.
>>>
>>> UBLK_IO_NEED_GET_DATA is an important feature designed for Ming Lei's
>>> ublk_drv. All the patches have been reviewed by Ming and all test cases
>>> in his ublksrv[1] have been passed.
>>
>> Hi Jens,
>>
>> This feature is helpful for existed projects to switch to ublk from similar
>> tech, so IMO the change makes sense.
> 
> Can we get this resent against for-5.20/block? It doesn't apply anymore.
> Then we can still make the next release.

Turns it out was just a trivial reject, I fixed it up.

-- 
Jens Axboe

