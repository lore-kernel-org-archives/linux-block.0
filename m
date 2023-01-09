Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9886DC5479D
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjAIXAO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjAIXAL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:00:11 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453991C930
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:00:11 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jl4so11236630plb.8
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfjdNbo/a5wmInQAWo7oYpvbLlD6TTieiLl61R7A90U=;
        b=eC3r8cWCQvhArgMEaUrZdKTgzA87hw+p8m6Y36mvbxA0E//+40mxIxzLabHVc+utRg
         +q6VDHUOOkbBXhKWvN9WqJ5ie08DWiqllo3gDSTlik+R8QuPPXjhlYUe/fSqI37N8ytf
         hcO5k6OmQ/7SaBshjISCjlfzmrZPkOBHAAQdFh9t4lD0e2eEU/0dY8UPc4iswrwo9b7Q
         yuZw14nSgU4kZSKWc4HZdCn0W2zNe0Hln5yq5s1VlzD7dWywoBV9yQJLiJT/J9vc8d64
         01qgpSc4jXjVyxRc8wuipr8fJK7opbBSGavZfW93ZP23beHhksjfczFAACtwIpd5OXH3
         8J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfjdNbo/a5wmInQAWo7oYpvbLlD6TTieiLl61R7A90U=;
        b=Dd+GX3T4h6/7bVZhpta84isZvdEuYhfpJVr0iv1HbHtIO6Jz8YgSbhxGp5vDkM18TD
         Mdk+OeTnvfX7Ga7/Rt0PedSJaAGcXTnh7MBixnqkYNiRSq3bFp1YQMo/qrtxTroqbMoH
         AgWiAUcijcfRfD0lai4e+1ogkPHuVJR+38tMDBYWaiKtnJHEMR/NieJ0n7pWKkr8PYCK
         03IB9OtZl8FhQgDmB9CgXPSxf50E6XVtOGHtezdb25M9vOJGIJbr4NOwrRLdOx7hCLW5
         +nNHqfD3RaLzm9VnwrHyM9oeRW7t0q/0gWEBkzSMUA5qg4vfJMpJzTFQQJvEapZZbO1+
         FypQ==
X-Gm-Message-State: AFqh2kqb+J9dfUwkMLjsSddS1KhHwoyj/65YgSYkhv674F2/qvPVY/ak
        P0zIK+JxCFLWAbWwD5BHvgKKQg==
X-Google-Smtp-Source: AMrXdXtwjdC1Q2CROWQZPqhM9noHle29NLrBmP4R6D+/tZ+LLN/Nwwh60rHXhVU5AWHg2svpe8NIgQ==
X-Received: by 2002:a05:6a21:3288:b0:af:a896:850c with SMTP id yt8-20020a056a21328800b000afa896850cmr22584855pzb.5.1673305210731;
        Mon, 09 Jan 2023 15:00:10 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t9-20020a6549c9000000b00478e7f87f3bsm5566423pgs.67.2023.01.09.15.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 15:00:10 -0800 (PST)
Message-ID: <ca30360e-ab51-6282-bd3c-208399e5a552@kernel.dk>
Date:   Mon, 9 Jan 2023 16:00:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <CGME20230107015641eucas1p13c2b37b5ca7a5b64eb520b79316d5186@eucas1p1.samsung.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
 <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
 <AF3750AD-1B66-4F8A-936F-A14EC17DAC16@bytedance.com>
 <04cc803e-0246-bf8a-c083-f556a373ae4f@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <04cc803e-0246-bf8a-c083-f556a373ae4f@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> My point here that we could summarize:
>> (1) what features already implemented and supported,
>> (2) what features are under implementation and what is progress,
>> (3) what features need to be implemented yet.
>>
>> Have we implemented everything already? :)
> 
> Standards are full of features that are not useful in a general purpose
> system. So we likely never will implement everything. We never did for
> SCSI and ATA and never will either.
Indeed, and that's a very important point. Some people read specs and
find things that aren't in the Linux driver (any spec, not a specific
one), and think they need to be added. No. We only add them if they make
sense, both in terms of use cases, but also as long as they can get
implemented cleanly. Parts of basically any spec is garbage and don't
necessarily fit within the given subsystem either.

The above would make me worried about patches coming from anyone with
that mindset.

-- 
Jens Axboe


