Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08057C7EE2E
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 18:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFLSkd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238103AbjFLSk3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 14:40:29 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B322102
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 11:40:28 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b1806264e9so28663375ad.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 11:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686595227; x=1689187227;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vw4pkDrOYi5uqGMAbarHch433HMaxyugmnYTDtOcJs8=;
        b=bIub5Q9hE3BMaUXb79Nhb3IAWJRKSQE5P4KiqKfk4Cd+NLwNNNF/raoJYiJBXj3R6R
         J2yh5/JcwR8GlytuXP65rPG9Ghw1hxuUy0r6sFCHdjQOOC9Gk0RVNXV+qvSe7UEBKZdZ
         1U23Icm2g7jNLARl4xagxElS5Aa5Mm9dNyn6+6SnJmuTkqHB0AwssT0DWWzi0VkdcyXR
         r4x5uy9CNnrjcHkFeELLkivcj1NZwMsNzNhHHvHMNUIbyQnSAJqMtmA71aWKdwKjZXGp
         OjcvwrY0c2iUnnNI8Ce8KZcH/tZVluhGP57iOQHbHVpfnuCc+IJ7HQNyivEWKE4JLTgl
         lWgA==
X-Gm-Message-State: AC+VfDxy44nMD848takaImYrtMAnEIoi5IawcpWVRqXhPkIBYFNbcEkx
        S9xqebzY62QRCgNOKYUr+sUxhDDDmE7KJA==
X-Google-Smtp-Source: ACHHUZ7gSDhFqP0VkD6BvCkJm49AN+z0r/YJfJbb7KbNrti3Ih389OZ+mwu96K3Ri5f6vj8z9sKNhg==
X-Received: by 2002:a17:902:da81:b0:1ae:6cf0:94eb with SMTP id j1-20020a170902da8100b001ae6cf094ebmr8951971plx.5.1686595227487;
        Mon, 12 Jun 2023 11:40:27 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b001b04a6707d3sm8555983plk.141.2023.06.12.11.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 11:40:26 -0700 (PDT)
Message-ID: <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
Date:   Mon, 12 Jun 2023 11:40:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: LVM kernel lockup scenario during lvcreate
To:     Jaco Kroon <jaco@uls.co.za>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
Content-Language: en-US
In-Reply-To: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/23 00:29, Jaco Kroon wrote:
> I'm attaching dmesg -T and ps axf.  dmesg in particular may provide
> clues as it provides a number of stack traces indicating stalling at
> IO time.
> 
> Once this has triggered, even commands such as "lvs" goes into
> uninterruptable wait, I unfortunately didn't test "dmsetup ls" now
> and triggered a reboot already (system needs to be up).

To me the call traces suggest that an I/O request got stuck. 
Unfortunately call traces are not sufficient to identify the root cause 
in case I/O gets stuck. Has debugfs been mounted? If so, how about 
dumping the contents of /sys/kernel/debug/block/ into a tar file after 
the lockup has been reproduced and sharing that information?

tar -czf- -C /sys/kernel/debug/block . >block.tgz

Thanks,

Bart.
