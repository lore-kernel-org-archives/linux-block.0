Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F578C433DB
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 17:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC18224DF
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 17:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhADRXn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 12:23:43 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:37357 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbhADRXn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jan 2021 12:23:43 -0500
Received: by mail-pj1-f49.google.com with SMTP id b5so11287166pjk.2;
        Mon, 04 Jan 2021 09:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aaCze6rOG6V8xW6QgrG1xAQcbBBXMOXnWQjQZEaeHTc=;
        b=TR/qJFeXJBBzXhFAkxxtKOkzS0UIkcx9vBTezoLvOwFbvyYlwbGTdz1GKtei3KnYQ5
         6lydX8MbkIbOjVuAka6h82gL+a/7cJORpXlO3hK7gbjHDs+o6H05kBiPH8SDJBznk1sF
         qwaQ40SwPEOc8r47PxrBbR0rCrried4ozwhZSnOTAyzk8OziMISz6gma6UpMipGG6GVL
         VIj2MAC7/t1u8Olx8XSW5ittDYilJzhJOvatWy1BPa+vk9Y0rRakPd/Z6+xnL6UORfOh
         VQlggI+kX7l0pfToWGDTwxoV+BU/EnxoUEQjMoAWCRtPf89BpLBqbixIk1iDDnns3vaO
         FOrA==
X-Gm-Message-State: AOAM533A33wcN6hGiTIgF4LGQiz1z4Pm8tCq/BpkGBivqR01nTR+FxVL
        ORXXH4/jEqFhoMw/i2MFm3w=
X-Google-Smtp-Source: ABdhPJyik6y4UjjCKaIYS/0ox0YBh5IUwGyRXO8LkwUcB64qa6cVUeXgTv1dJJxYjxhkXYhlrkLTbg==
X-Received: by 2002:a17:902:fe07:b029:dc:43e4:fcbf with SMTP id g7-20020a170902fe07b02900dc43e4fcbfmr49981957plj.63.1609780982301;
        Mon, 04 Jan 2021 09:23:02 -0800 (PST)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id z125sm53314933pfz.121.2021.01.04.09.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 09:23:01 -0800 (PST)
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, hare@suse.de, kashyap.desai@broadcom.com,
        linuxarm@huawei.com
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
 <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
 <31de2806-bbc1-dcc3-b9eb-ce9257420432@acm.org>
 <b2edab2b-8af7-816d-9da2-4720d19b96f8@huawei.com>
 <e97a0603-f9e3-1b00-4a09-c569d4f73d7b@acm.org>
 <f98fd31e-89d4-523f-df70-4bd5f39ccbd5@huawei.com>
 <33e41110-b3b2-ac16-f131-de1679ce8238@acm.org>
 <7bdd562d-b258-43a2-0de0-966091086cff@huawei.com>
 <e56e8831-4a74-8411-6c04-3a65aff855f4@huawei.com>
 <0ab85ab8-c5c7-01aa-6b39-da731b3db829@acm.org>
 <d22efcd3-274a-15c5-9e4a-248037789c4d@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c0d127a9-9320-6e1c-4e8d-412aa9ea9ca6@acm.org>
Date:   Mon, 4 Jan 2021 09:22:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <d22efcd3-274a-15c5-9e4a-248037789c4d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/4/21 7:33 AM, John Garry wrote:
> On 23/12/2020 15:47, Bart Van Assche wrote:
>> I propose to change the order in which blk_mq_sched_free_requests(q) and
>> blk_mq_debugfs_unregister(q) are called. Today blk_mq_sched_free_requests(q)
>> is called by blk_cleanup_queue() before blk_put_queue() is called.
>> blk_put_queue() calls blk_release_queue() if the last reference is dropped.
>> blk_release_queue() calls blk_mq_debugfs_unregister(). I prefer removing the
>> debugfs attributes earlier over modifying the tag iteration functions
>> because I think removing the debugfs attributes earlier is less risky.
> 
> But don't we already have this following path to remove the per-hctx debugfs
> dir earlier than blk_mq_sched_free_requests() or blk_release_queue():
> 
> blk_cleanup_queue() -> blk_mq_exit_queue() -> blk_mq_exit_hw_queues() ->
> blk_mq_debugfs_unregister_hctx() ->
> blk_mq_debugfs_unregister_hctx(hctx->debugfs_dir)
> 
> Having said that, I am not sure how this is related directly to the problem
> I mentioned. In that problem, above, we trigger the
> blk_mq_tagset_busy_iter() from the SCSI host sysfs file, and the
> use-after-free comes about from disabling the elevator (and freeing the
> sched requests) in parallel.

Hi John,

Right, what I proposed is unrelated to the use-after-free triggered by
disabling I/O scheduling.

Regarding the races triggered by disabling I/O scheduling: can these be
fixed by quiescing all request queues associated with a tag set before
changing the I/O scheduler instead of only the request queue for which the
I/O scheduler is changed? I think we already do this before updating the
number of hardware queues.

Thanks,

Bart.
