Return-Path: <linux-block-owner@vger.kernel.org>
Received: from othala.iewc.co.za ([154.73.34.12]:54072 "EHLO othala.uls.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbeBWJ7B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Feb 2018 04:59:01 -0500
Subject: Re: disk-io lockup in 4.14.13 kernel
To: Bart Van Assche <bart.vanassche@wdc.com>,
        linux-block@vger.kernel.org
Cc: Pieter Kruger <pieterk@uls.co.za>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
 <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
From: Jaco Kroon <jaco@uls.co.za>
Message-ID: <1071d2e4-f56f-ad5b-289c-c7fada6a166e@uls.co.za>
Date: Fri, 23 Feb 2018 11:58:52 +0200
MIME-Version: 1.0
In-Reply-To: <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

Thank you for your response.

On 22/02/2018 18:46, Bart Van Assche wrote:
> On 02/22/18 02:58, Jaco Kroon wrote:
>> We've been seeing sporadic IO lockups on recent kernels.
>
> Are you using the legacy I/O stack or blk-mq? If you are not yet using
> blk-mq, can you switch to blk-mq + scsi-mq + dm-mq? If the lockup is
> reproducible with blk-mq, can you share the output of the following
> command:
crowsnest ~ # zgrep MQ /proc/config.gz

CONFIG_SCSI_MQ_DEFAULT=y
# CONFIG_DM_MQ_DEFAULT is not set

... oi, so that's a very valid question.

blk-mq is thus off by default, I've now enabled it on the "live" system
with "echo 1 > /sys/module/dm_mod/parameters/use_blk_mq".

I've also modified the kernel config to set CONFIG_DM_MQ_DEFAULT (I know
I can just set this on cmdline too).

The only immediately visible effect is that I seem to be more
consistently get >300MB/s (and more frequently >400MB) off the array in
terms of read speed, where normally I'd expect 200MB consistent with
spikes just over 300MB and very infrequently over 400MB.  This is a very
simple spot check with iotop over approximately a minute.

I am seeing I/O errors in dmesg from time to time, this to me hints that
potentially it may be something related to some error path that's
causing problems.

Just so we're clear, we're seeing this happen approximately once a
month, so if switching on dm_mod.use_blk_mq solves it then I won't
really know beyond a shadow of a doubt, and the only way of "knowing" is
if we can get to an uptime of three months or so ...

>
> (cd /sys/kernel/debug/block && find . -type f -exec grep -aH . {} \;)
I don't have a /sys/kernel/debug folder - I've enabled CONFIG_DEBUG_FS
and BLK_DEBUG_FS, will reboot at the first opportunity.  As a general
rule - is there additional overhead to having debugfs enabled?  Any
other risks that I should be aware of?  In essence, are there any
disadvantages to just enabling DEBUG_FS as a general rule?  I did note
that a few extra DEBUG options pop up for other modules ... so my gut is
towards leaving this disabled as a general rule and enabling when needed.

>
> Thanks,
Thank you!

Kind Regards,
Jaco
