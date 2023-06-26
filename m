Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260AAEB64DA
	for <linux-block@archiver.kernel.org>; Mon, 26 Jun 2023 16:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjFZQmO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjFZQmN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2023 12:42:13 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1783BE53
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 09:42:12 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b80f2e6c17so5328765ad.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 09:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797731; x=1690389731;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHowUz5w3dj3xWyT5r80vaKVlMHOpZgiSFUnNqtTRR4=;
        b=BZZrr1O7Zsg4ZitA1HY3WBQLb7KUEIAOY/uuFQQIin/e6ehpCoo3K3+Vn1QAl1o0gx
         iN3v2SwxiBEiDYUYFJxBThpmv67VYnb4IcgJcgY4bvt1mPwqM+APjr0q9e02cb/pxwc1
         6/4Zt+ZchM5A7GTiWWHoxCIKB4Xi0p7IwtyM+cSeA6TG46G32ZEeh1h4NuXpQF5Rjyap
         XI8SoNrdH4UUkE2m+kCrVb5Db3eJfMdCvlZCH0Q6t+n71GZPTVgft1r9fflGmdjkPS1g
         LvXPd0aumRvP+CTCFptMsBq/oGq5jvd5VuepQQIJkC0Fy3/4bH2Urc7eTf05UBWpJ6A4
         XFHQ==
X-Gm-Message-State: AC+VfDy2zf58OgdUR0Z3ppuxKiQ043s111c8IoZnBV6umWDQhsJhJCN/
        +KpPA1/l6IOx9Mo+lA5GqltkjK39msc=
X-Google-Smtp-Source: ACHHUZ5HrhtJfdQjT4PBlKgxBmOf489w1Z3kvbhDmTQW5xNF1OipBIE9nDsQ95td8Kb/AbqhbHoP6Q==
X-Received: by 2002:a17:902:e5c1:b0:1b6:b4e5:23a with SMTP id u1-20020a170902e5c100b001b6b4e5023amr9137194plf.26.1687797731049;
        Mon, 26 Jun 2023 09:42:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ed06:6565:a250:4b59? ([2620:15c:211:201:ed06:6565:a250:4b59])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902aa8700b001b0358848b0sm4423719plr.161.2023.06.26.09.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:42:10 -0700 (PDT)
Message-ID: <a6d73e89-7a0c-3173-5f70-cd12cc7ef158@acm.org>
Date:   Mon, 26 Jun 2023 09:42:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-US
To:     Jaco Kroon <jaco@uls.co.za>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <102b1994-74ff-c099-292c-f5429ce768c3@uls.co.za>
 <6b066ab5-7806-5a23-72a5-073153259116@acm.org>
 <544f4434-a32a-1824-b57a-9f7ff12dbb4f@uls.co.za>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <544f4434-a32a-1824-b57a-9f7ff12dbb4f@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/26/23 01:30, Jaco Kroon wrote:
> Please find attached updated ps and dmesg too, diskinfo wasn't regenerated but this doesn't generally change.
> 
> Not sure how this all works, according to what I can see the only disk with pending activity (queued) is sdw?  Yet, a large number of processes is blocking on IO, and yet again the stack traces in dmesg points at __schedule.  For a change we do not have lvcreate in the 
> process list! This time that particular script's got a fsck in uninterruptable wait ...

Hi Jaco,

I see pending commands for five different SCSI disks:

$ zgrep /busy: block.gz
./sdh/hctx0/busy:00000000affe2ba0 {.op=WRITE, .cmd_flags=SYNC|FUA, .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, .state=in_flight, .tag=2055, .internal_tag=214, .cmd=Write(16) 8a 08 00 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
.flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.000 s ago}
./sda/hctx0/busy:00000000987bb7c7 {.op=WRITE, .cmd_flags=SYNC|FUA, .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, .state=in_flight, .tag=2050, .internal_tag=167, .cmd=Write(16) 8a 08 00 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
.flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.010 s ago}
./sdw/hctx0/busy:00000000aec61b17 {.op=READ, .cmd_flags=META|PRIO, .rq_flags=STARTED|MQ_INFLIGHT|DONTPREP|ELVPRIV|IO_STAT|ELV, .state=in_flight, .tag=2056, .internal_tag=8, .cmd=Read(16) 88 00 00 00 00 00 00 1c 01 a8 00 00 00 08 00 00, .retries=0, .result = 0x0, 
.flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.000 s ago}
./sdw/hctx0/busy:0000000087e9a58e {.op=WRITE, .cmd_flags=SYNC|FUA, .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, .state=in_flight, .tag=2058, .internal_tag=102, .cmd=Write(16) 8a 08 00 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
.flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.000 s ago}
./sdaf/hctx0/busy:00000000d8751601 {.op=WRITE, .cmd_flags=SYNC|FUA, .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, .state=in_flight, .tag=2057, .internal_tag=51, .cmd=Write(16) 8a 08 00 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
.flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.010 s ago}

All requests have the flag "ELV". So my follow-up questions are:
* Which I/O scheduler has been configured? If it is BFQ, please try whether
   mq-deadline or "none" work better.
* Have any of the cgroup I/O controllers been activated?
* Are the disks directly connected to the motherboard of the server or are
   the disks perhaps controlled by a HBA? If so, which HBA? There are multiple
   lines in dmesg that start with "mpt3sas". Is the firmware of this HBA
   up-to-date?

Thanks,

Bart.
