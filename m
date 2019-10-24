Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF88ACA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B59720659
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390239AbfJXRzK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:55:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41433 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388235AbfJXRzJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 13:55:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7so15599530pfh.8
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 10:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HSc2JE5O54dMAlqai+43MwM6g0w9t30GBY2Pk/3uerk=;
        b=Y7aRSykb/4d6/L2aJw935yQ2hVy+9SbW4/WdKyaYyDlIjeAeaFgucCID7MgD3SizjR
         XdPLsYJarKXQDWkNQzkraYUdB6LuDl4FbjqBHszmWRlC78+1BPyK3uD2utr88DwG9L6Y
         B9CvplhVuEdDUn5/HlahLfYZXUfJqIjpp1sI0URDCrHta5XB4VQ2kMhoxxaBAOwBYWIg
         /Jsfcmn2SrhGDsSbjAIp8yXN+I7h0fu0+6FBeCNxsNB8NXOjGzzF40QCY3iI0BIs+DL+
         3InrgHXvQ403MQxvKY5c+ZCasP3ONv3tNys/5PzwW64j4no+OlvdEuJOAjtrzjWXbug7
         PkQw==
X-Gm-Message-State: APjAAAXKo/tl2zVtoUdHGh7Apg3KS0XRfayF+yhPIFvNboyZF9cZpr8A
        PQCHNC+5zo58/nA8s2rUh98J6ubLgqk=
X-Google-Smtp-Source: APXvYqyicZubFEez6mmJq8dYP8qXYrmJIiC0RWdGlTpphcxD2vPbriZymXw1gGXWNc0IgMGHbY6kAA==
X-Received: by 2002:a65:6119:: with SMTP id z25mr12130929pgu.332.1571939708948;
        Thu, 24 Oct 2019 10:55:08 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z23sm26368314pgu.16.2019.10.24.10.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:55:07 -0700 (PDT)
Subject: Re: [PATCH blktests 2/2] Add a test that triggers
 blk_mq_update_nr_hw_queues()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20191021225719.211651-1-bvanassche@acm.org>
 <20191021225719.211651-3-bvanassche@acm.org> <20191024174242.GB137052@vader>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <03e57c18-83b0-2b53-48b9-84d56b216553@acm.org>
Date:   Thu, 24 Oct 2019 10:55:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024174242.GB137052@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/19 10:42 AM, Omar Sandoval wrote:
> On Mon, Oct 21, 2019 at 03:57:19PM -0700, Bart Van Assche wrote:
>> +# Configure one null_blk instance.
>> +configure_null_blk() {
>> +	(
>> +		cd /sys/kernel/config/nullb || return $?
>> +		(
>> +			mkdir -p nullb0 &&
>> +				cd nullb0 &&
>> +				echo 0 > completion_nsec &&
>> +				echo 512 > blocksize &&
>> +				echo 16 > size &&
>> +				echo 1 > memory_backed &&
>> +				echo 1 > power
>> +		)
>> +	) &&
>> +	ls -l /dev/nullb* &>>"$FULL"
> 
> What's the point of these nested subshells? Can't this just be:
> 
> configure_null_blk() {
> 	cd /sys/kernel/config/nullb &&
> 	mkdir -p nullb0 &&
> 	cd nullb0 &&
> 	echo 0 > completion_nsec &&
> 	echo 512 > blocksize &&
> 	echo 16 > size &&
> 	echo 1 > memory_backed &&
> 	echo 1 > power &&
> 	ls -l /dev/nullb* &>>"$FULL"
> }

The above code is not equivalent to the original code because it does 
not restore the original working directory.

When using 'cd' inside a subshell, the working directory that was 
effective before the 'cd' command is restored automatically when exiting 
from the subshell. I prefer using 'cd' in a subshell instead of using 
pushd / popd because with the former approach the old working directory 
is restored no matter how the exit from the subshell happens.

>> +modify_nr_hw_queues() {
>> +	local deadline num_cpus
>> +
>> +	deadline=$(($(_uptime_s) + TIMEOUT))
>> +	num_cpus=$(find /sys/devices/system/cpu -maxdepth 1 -name 'cpu[0-9]*' |
>> +			   wc -l)
> 
> Please just use nproc. Or even better, can you just read the original
> value of /sys/kernel/config/nullb/nullb0/submit_queues? Or does that
> start at 1?

I will have a closer look and see which alternative works best.

Bart.
