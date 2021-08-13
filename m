Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7321C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 17:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DAC61106
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 17:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhHMRPj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 13:15:39 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:56261 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhHMRPi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 13:15:38 -0400
Received: by mail-pj1-f53.google.com with SMTP id w14so16211642pjh.5
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 10:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=knupFeZ6BWBN1RN1GGvJguQGIC26+5WY/3FnpNEXvvc=;
        b=Bkluryv9Nm9oYYmJf204OqzQe5FyV5CZWWtztnY/mQRuUZ9/9MjHARKtK65Vy35e8/
         w8kmtRPmHkhIyvuiXwlcQUh7gbnTKctSN668ZiJLZiBcNP4XralejSy/aakpieuCJrHI
         aheqiW8jmnlLxVSqAOkSEr4/9M9ucuS/fy/mo/NfDPSI9VnOYLpZI93ZKI8bYckzRGpU
         GDaR8R/5j7o3dN+LbFhWOgQCxCc0rMYJFP/VOUdEE4aXxYi+nurMG5a7OzFN41OlbRmB
         0ZNi5CDplfXAwsnaKOTz9zlgZHH5iUsl8I596UOzYejD1AQCnlg2ACXi0CR4ZAOtr4NJ
         mPpg==
X-Gm-Message-State: AOAM533+byR1zS+g31/rENSGqa3CQzXlMJD4D0LbHqtr+1/xhLNXIEtU
        y33OIW1vnc3f1JHUtushcQenPlm2dS1vUpUr
X-Google-Smtp-Source: ABdhPJxKRRhLiacDZp94IKirK+0cFkxbNG5Apb2RPs8N266H/EmK9tqMlL8fNpW+zBP+YvyWPgsFAQ==
X-Received: by 2002:a05:6a00:2490:b029:3bb:2cb3:25dc with SMTP id c16-20020a056a002490b02903bb2cb325dcmr3498815pfv.48.1628874910416;
        Fri, 13 Aug 2021 10:15:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:b745:b195:ae3f:f02d])
        by smtp.gmail.com with ESMTPSA id i13sm3006376pfr.79.2021.08.13.10.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 10:15:09 -0700 (PDT)
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
 <YRQhlPBqAlkJdowG@mtj.duckdns.org>
 <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
 <YRVfmWnOyPYl/okx@mtj.duckdns.org>
 <631e7e18-52ca-9bec-0150-bac755e0ff24@acm.org>
 <YRV1JkkxozEb4YO6@mtj.duckdns.org>
 <DM6PR04MB7081F2D0E8579489175DF363E7FA9@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9699c8e8-ef8f-ef37-1f99-0c446ff9d9a0@acm.org>
Date:   Fri, 13 Aug 2021 10:15:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081F2D0E8579489175DF363E7FA9@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 7:18 PM, Damien Le Moal wrote:
> Let me throw in more information related to this.
> 
> Command duration limits (CDL) and Sequestered commands features are being
> drafted in SPC/SBC and ACS to give the device better hints than just a on/off
> high priority bit. I am currently prototyping these features and I am reusing
> the ioprio interface for that. Here is how this works:
> 1) The drives exposes a set of command duration limits descriptors (up to 7 for
> reads and 7 for writes) that define duration limits for a command execution:
> overall processing time, queuing time and execution time. Each duration time has
> a policy associated with it that is applied if a command processing exceeds one
> of the defined time limit: continue, continue but signal limit exceeded, abort.
> 2) Users can change the drive command duration limits to whatever they need
> (e.g. change the policies for the limits to get a fast-fail behavior for
> commands instead of having the drive retry for a long time)
> 3) When issuing IOs, users (or FSes) can apply a command duration limit
> descriptor by specifying the IOPRIO_CLASS_DL priority class. The priority level
> for that class indicates the descriptor to apply to the command.
> 4) At SCSI/ATA level, read and write commands have 3 bits defined to specify the
> command descriptor to apply to the command (1 to 7 or 0 for no limit)
> 
> With that in place, the disk firmware can now make more intelligent decisions on
> command scheduling to keep performance high at high queue depth without
> increasing latency for commands that have low duration limits. And based on the
> policy defined for a limit, this can be a "soft" best-effort optimization by the
> disk, or a hard one with aborts if the drive decides that what the user is
> asking for is not possible.
> 
> CDL can completely replace the existing binary on/off NCQ priority in a more
> flexible manner as the user can set different duration limits for high vs low
> priority. E.g. high priority is equivalent to a very short limit while low
> priority is equivalent to longer or no limits.
> 
> I think that CDL has the potential for better interactions with cgroups as
> cgroup controllers can install a set of limits on the drive that fits the
> controller target policy. E.g., the latency controller can set duration limits
> and use the IOPRIO_CLASS_DL class to tell the drive the exact latency target to use.
> 
> In my implementation, I have not yet looked into cgroups integration for CDL
> though. I am still wondering what the best approach is: defining a new
> controller or integrating into existing controllers. The former is likely easier
> than the latter, but having hardware support for existing controllers has the
> potential to improve them seamlessly without forcing the user to change anything
> to there application setup.
> 
> CDL is still in draft state in the specs though. So I will not be sending this yet.

Thanks Damien for having provided this additional information. This is 
very helpful. I see this as a welcome evolution since the disk firmware 
has more information than the CPU (e.g. about the disk head position) 
and hence can make a better decision than an I/O scheduler or cgroup policy.

For the cloud use case, are all disks used to implement disaggregated 
storage? I'm asking this because in a disaggregated storage setup the 
I/O submitter runs on another server than the server to which the disks 
are connected. In such a setup I expect that the I/O priority will be 
provided from user space instead of being provided by a cgroup.

Bart.
