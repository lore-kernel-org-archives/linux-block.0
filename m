Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64474C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 07:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E782613B6
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 07:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhE0HLM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 03:11:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53894 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhE0HLK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 03:11:10 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A47E1FD29;
        Thu, 27 May 2021 07:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622099376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ybioya41FXXuwpVmqGpdHn7gnwUeEwBtLhjVG19qoJE=;
        b=V/Bpiq0HsYKijL8prriQJGtqtTzfj7StThBNMnfS/uZ6FHIKbLeyFQy6OGZgyMqotuY3lS
        fD1sOxZ6R26LfBmy2UsLIM1KmB5JP0ckPizgaPkMe/ImcTyJyWiFdHKmEkv/ffugUxHLoZ
        VOH2xzxw5cpsFRhp9BAYd2u1sHxsAK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622099376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ybioya41FXXuwpVmqGpdHn7gnwUeEwBtLhjVG19qoJE=;
        b=U6wzGew2kbW6jDOBHdpQpgpaZnqBoEItvGOI1WsptqEhjKcJjatUQ3cm7kt0ePnUQGTeyM
        7CwhasyTI1oAApCw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 542D211A98;
        Thu, 27 May 2021 07:09:36 +0000 (UTC)
Subject: Re: [PATCH 9/9] block/mq-deadline: Add cgroup support
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-10-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <fa4bd879-87d0-bcbd-9637-2ae412da126d@suse.de>
Date:   Thu, 27 May 2021 09:09:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527010134.32448-10-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 3:01 AM, Bart Van Assche wrote:
> Add support for configuring I/O priority per block cgroup. Assign the lowest
> of the following two priorities to a request: rq->ioprio and blkcg->ioprio.
> Maintain statistics per cgroup and make these available in sysfs.
> 
> This patch has been tested as follows:
> 
> SHELL 1
> 
> modprobe scsi_debug ndelay=1000000 max_queue=16 &&
> while [ -z "$sd" ]; do sd=/dev/$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*); done &&
> cd /sys/fs/cgroup/blkio/ &&
> echo 2 >blkio.dd.prio &&
> mkdir -p hipri &&
> cd hipri &&
> echo 1 >blkio.dd.prio &&
> echo $$ >cgroup.procs &&
> max-iops -a1 -d32 -j1 -e mq-deadline $sd
> 
> SHELL 2
> 
> sd=/dev/$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*) &&
> max-iops -a1 -d32 -j1 -e mq-deadline $sd
> 
> Result:
> * 12000 IOPS in shell 1
> *  2000 IOPS in shell 2
> 
> The max-iops script is a script that runs fio with the following arguments:
> --bs=4K --gtod_reduce=1 --ioengine=libaio --ioscheduler=${arg_e} --runtime=60
> --norandommap --rw=read --thread --buffered=0 --numjobs=${arg_j}
> --iodepth=${arg_d}
> --iodepth_batch_submit=${arg_a} --iodepth_batch_complete=$((arg_d / 2))
> --name=${positional_argument_1} --filename=${positional_argument_1}
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/Kconfig.iosched      |   6 ++
>  block/Makefile             |   1 +
>  block/mq-deadline-cgroup.c | 206 +++++++++++++++++++++++++++++++++++++
>  block/mq-deadline-cgroup.h |  73 +++++++++++++
>  block/mq-deadline.c        |  96 ++++++++++++++---
>  5 files changed, 370 insertions(+), 12 deletions(-)
>  create mode 100644 block/mq-deadline-cgroup.c
>  create mode 100644 block/mq-deadline-cgroup.h
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
