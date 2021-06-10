Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E2C48BCD
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FF1613F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhFJGpR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:45:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFJGpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 02:45:16 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD1E7219A3;
        Thu, 10 Jun 2021 06:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623307399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYHy0SXauBqEcUKEmfbx82VNKzuoYTGiN4oj6trW1EI=;
        b=DtvIApBlVCctaou450sRX+CCaYkSnB3m15gL8ChsWdm6eZK7Fj/5fSe3xD/KOun8Pbn8yp
        3U2oUKtG0ysai+ez7vSSFv9qRiv2cMPrLd6ixamwnLWqT0ZG3tZh+TfVLLuH/eO1fuveIh
        5KbCQaOfpATCvX9rO0eOR55HogOZObA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623307399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYHy0SXauBqEcUKEmfbx82VNKzuoYTGiN4oj6trW1EI=;
        b=D/KMm7xPk05r9bRfItK50Y2rOGYwOL8/BEAwxM8NDuCOwcS9q3TtC3EEaSOapIlbHMLuqH
        rPJsPCxSehmfadAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 947A5118DD;
        Thu, 10 Jun 2021 06:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623307399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYHy0SXauBqEcUKEmfbx82VNKzuoYTGiN4oj6trW1EI=;
        b=DtvIApBlVCctaou450sRX+CCaYkSnB3m15gL8ChsWdm6eZK7Fj/5fSe3xD/KOun8Pbn8yp
        3U2oUKtG0ysai+ez7vSSFv9qRiv2cMPrLd6ixamwnLWqT0ZG3tZh+TfVLLuH/eO1fuveIh
        5KbCQaOfpATCvX9rO0eOR55HogOZObA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623307399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYHy0SXauBqEcUKEmfbx82VNKzuoYTGiN4oj6trW1EI=;
        b=D/KMm7xPk05r9bRfItK50Y2rOGYwOL8/BEAwxM8NDuCOwcS9q3TtC3EEaSOapIlbHMLuqH
        rPJsPCxSehmfadAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id tK8FI4e0wWCIYgAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 06:43:19 +0000
Subject: Re: [PATCH 14/14] block/mq-deadline: Prioritize high-priority
 requests
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-15-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <2435bac3-0d5b-9e2a-bbe4-c6a02ece2395@suse.de>
Date:   Thu, 10 Jun 2021 08:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608230703.19510-15-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 1:07 AM, Bart Van Assche wrote:
> While one or more requests with a certain I/O priority are pending, do not
> dispatch lower priority requests. Dispatch lower priority requests anyway
> after the "aging" time has expired.
> 
> This patch has been tested as follows:
> 
> modprobe scsi_debug ndelay=1000000 max_queue=16 &&
> sd='' &&
> while [ -z "$sd" ]; do
>   sd=/dev/$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*)
> done &&
> echo $((100*1000)) > /sys/block/$sd/queue/iosched/aging_expire &&
> cd /sys/fs/cgroup/blkio/ &&
> echo $$ >cgroup.procs &&
> echo 2 >blkio.prio.class &&
> mkdir -p hipri &&
> cd hipri &&
> echo 1 >blkio.prio.class &&
> { max-iops -a1 -d32 -j1 -e mq-deadline $sd >& ~/low-pri.txt & } &&
> echo $$ >cgroup.procs &&
> max-iops -a1 -d32 -j1 -e mq-deadline $sd >& ~/hi-pri.txt
> 
> Result:
> * 11000 IOPS for the high-priority job
> *   400 IOPS for the low-priority job
> 
> If the aging expiry time is changed from 100s into 0, the IOPS results change
> into 6712 and 6796 IOPS.
> 
> The max-iops script is a script that runs fio with the following arguments:
> --bs=4K --gtod_reduce=1 --ioengine=libaio --ioscheduler=${arg_e} --runtime=60
> --norandommap --rw=read --thread --buffered=0 --numjobs=${arg_j}
> --iodepth=${arg_d} --iodepth_batch_submit=${arg_a}
> --iodepth_batch_complete=$((arg_d / 2)) --name=${positional_argument_1}
> --filename=${positional_argument_1}
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline-main.c | 42 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
