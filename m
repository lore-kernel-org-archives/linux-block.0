Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7269C47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 18:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A11C611ED
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 18:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFCSEm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 14:04:42 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:34393 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFCSEm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 14:04:42 -0400
Received: by mail-il1-f176.google.com with SMTP id r6so6436365ilj.1
        for <linux-block@vger.kernel.org>; Thu, 03 Jun 2021 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vSk7oDzVGZPIMNLtrjabRi6+5dh7rHyveq8exb+pfRk=;
        b=jGpP9xeVAn9F1UZ+/Bo8ztBmSPdgiSaYXkiClC0MjFffnAOK6STVIGdXEGrLxFXbIl
         oHe94bkGewn03n7xDWT8GEw1TNiXZa2rCgqZZCcyE6x2U+wxs3wJ5oChG81wMPn/Iwqs
         Zq2/n70TwOTKOK8OBYoQGAqe27K5/zW4O3SNtCbvrPhv5e1U7XCF16GIcFEQze7cAxAl
         ATYgdDXk1dksh67NU8ZmkQVzKsbmKiV4eefn5iM/IaDP7YvCsc3flGNiUa79jUQJMh6A
         bmymrsPV5xmjXeh3w7yTKPkqaWIXRdS5rMb55sMM40Hn8XWiDTKJvNwqZF9BWsFcgeKl
         v4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vSk7oDzVGZPIMNLtrjabRi6+5dh7rHyveq8exb+pfRk=;
        b=GO4fqjLKkR7kMWL//AqFTD2kOD/LvlPJh+J8LmIqEGuuip07RSR6HJDc4FPKmSCwbQ
         p8mV43zeF0NOgmfw3NDt246Kk/fTMQtisQNxjfwDKy83tgXCAAy043mJxUHSNTti6MB/
         fyz4arhOVQomawE+cYpKf/kDJXRgrf4k/HO3mtJLIP8bT3CxpOgCBXTcA7rDj2MONng5
         DtF3QRsGWWdl/G/6Vysg5bszbd7d4WMz36KmdP2JmSf+G1/GStLUmzOZZvAEvuGJ96UN
         ILGxNv45QBPk75AElSkV2TQURzCWn+SbSMo1clb0f9P2hpILX5bM8ZDsmKu3EjdgUqsD
         IMAw==
X-Gm-Message-State: AOAM533Tgp1xwcf6xLZhL/1mPnUgqJlIxLARd6rLQyfD3SyFzweOYUy7
        sGIPi8Wf8B34HPu93iTI1WPhmA==
X-Google-Smtp-Source: ABdhPJw/ePE9ieUPVw6nHS3wjcIbgcjVU0Agz6SQfTPjnzwC3aj0clFd2HbjGuul9ythQ8Tc8Y0Sfg==
X-Received: by 2002:a92:c808:: with SMTP id v8mr474826iln.280.1622743317252;
        Thu, 03 Jun 2021 11:01:57 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w11sm2230576ilc.8.2021.06.03.11.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 11:01:56 -0700 (PDT)
Subject: Re: [PATCH v2] block: Do not pull requests from the scheduler when we
 cannot dispatch them
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>
References: <20210603104721.6309-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8dc3c313-e2cf-ed45-b299-809c332458ea@kernel.dk>
Date:   Thu, 3 Jun 2021 12:01:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210603104721.6309-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/3/21 4:47 AM, Jan Kara wrote:
> Provided the device driver does not implement dispatch budget accounting
> (which only SCSI does) the loop in __blk_mq_do_dispatch_sched() pulls
> requests from the IO scheduler as long as it is willing to give out any.
> That defeats scheduling heuristics inside the scheduler by creating
> false impression that the device can take more IO when it in fact
> cannot.
> 
> For example with BFQ IO scheduler on top of virtio-blk device setting
> blkio cgroup weight has barely any impact on observed throughput of
> async IO because __blk_mq_do_dispatch_sched() always sucks out all the
> IO queued in BFQ. BFQ first submits IO from higher weight cgroups but
> when that is all dispatched, it will give out IO of lower weight cgroups
> as well. And then we have to wait for all this IO to be dispatched to
> the disk (which means lot of it actually has to complete) before the
> IO scheduler is queried again for dispatching more requests. This
> completely destroys any service differentiation.
> 
> So grab request tag for a request pulled out of the IO scheduler already
> in __blk_mq_do_dispatch_sched() and do not pull any more requests if we
> cannot get it because we are unlikely to be able to dispatch it. That
> way only single request is going to wait in the dispatch list for some
> tag to free.

Applied to for-5.14/block, thanks.

-- 
Jens Axboe

