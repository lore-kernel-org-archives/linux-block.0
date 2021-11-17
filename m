Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE4FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 04:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3815361B5F
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 04:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhKQEJ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 23:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhKQEJ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 23:09:26 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFFAC061570
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 20:06:28 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id z26so1344588iod.10
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 20:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O4gB9ISHe7WB4lEh4tu18p+zHFQPGjgi+dJE4KcVRE8=;
        b=3o+YU659Sl6qUXixhxhp1A/tx/Xe1JAnEo/LoztHMC7ah3cYd8om/rvc80gfkR68od
         ZCH5Fcm7YWALrGF0YG8k76uo7R9Q2mTSeMDhXLPWvK4b6MvmtUpI25Gzd17dNqpCs6ZR
         wWgTJIizxiTuPhFTPGkKorYxrVDJqTsDWGtsz6sMi7KEfKk/euNzgNJjzZpQESGu+hEj
         dpJ+SgBROnfIFivH3qfVkMwuNxZ5eiX/F5FIFoKYPopYeYZ+AdF/e/Ipzq+Zx+lv4L5a
         qkeaDdiLJ9bNc2AsxCrL8E8xQNcsHV/dpY1ova0st7dMJzAUScNVsQSXAiHrnGw6Rapg
         wV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O4gB9ISHe7WB4lEh4tu18p+zHFQPGjgi+dJE4KcVRE8=;
        b=XvOo2Z/CCyNGd93cgNei40OWnwBaiRynZNiuGk4rf5s3bGGwSfb9v6JA/kQZOa9nZ4
         ir1cvtwn68wOG8Hy3d+Cb0B5u73TuSMnIj+12JsbA/zTWkLn5HfB0Q2KX8ydcuajUcb4
         NwTcNMWCt9EsVyZ+drvJXidXbiENTLPKxF4n07tASk1eU28/n7sCSwv7v8P1lyLsrjmo
         CiMRBZbs2Pz37P3XZ7k2GrDolpLWn9C7E8JUnS0uKcoGVynwBJSAJLk/1qjZZ2PFepkU
         QVoX37zQcvRqxsrycoUeBztEsHsRo19pfDHxVURs5ZpkjHoYk4wX+f8sDkuAv/epp6W+
         rJUA==
X-Gm-Message-State: AOAM532qcP2X0C1pxlxTEoQHeuSmwGN5CBFemsEAvNq6R/5L/w+hTby4
        7GaZaB3JntmgOr0ZicwxPmsG7TUIRZONR2Zk
X-Google-Smtp-Source: ABdhPJzChHXy7S97e4hOisiJDPxUqdJslqiPWo3jmyme2kgSxWmvvUI3/hERa7Pibn7tK/sIb/ONLA==
X-Received: by 2002:a05:6638:260d:: with SMTP id m13mr10299338jat.99.1637121988368;
        Tue, 16 Nov 2021 20:06:28 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l4sm14035263ilv.46.2021.11.16.20.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 20:06:28 -0800 (PST)
Subject: Re: Hang in blk_mq_freeze_queue_wait()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <2f79a604-592e-a4b9-48df-020a5923311f@acm.org>
 <fb109032-3926-98ce-41c0-0670c0037bd9@kernel.dk>
 <7b7f78d1-b37a-4588-c127-27210b7dad74@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a523ead-dc7d-9e4b-8c34-c3c872572deb@kernel.dk>
Date:   Tue, 16 Nov 2021 21:06:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7b7f78d1-b37a-4588-c127-27210b7dad74@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/21 9:04 PM, Bart Van Assche wrote:
> On 11/16/21 16:21, Jens Axboe wrote:
>> Can you try with:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.16&id=95febeb61bf87ca803a1270498cd4cd61554a68f
> 
> With that patch applied all SRP tests pass. Feel free to add:
> 
> Tested-by: Bart Van Assche <bvanassche@acm.org>

Thanks for testing! I already pushed this out yesterday morning, so not
going to amend the commit at this point. But at least this conversation
is in the archives.

-- 
Jens Axboe

