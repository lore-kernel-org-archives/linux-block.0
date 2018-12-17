Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F8C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E182145D
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qekO68pY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeLQM6p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:58:45 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:41603 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeLQM6p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 07:58:45 -0500
Received: by mail-pf1-f170.google.com with SMTP id b7so6334362pfi.8
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AZbzCBY2g7dZZxDUBLS5x1vFTU3kOXD0y95olAujMNk=;
        b=qekO68pYJh0N/BNvL3LD6/PspLLQHBABg2DoMNl0JkyNHVquhJ9ZKINKdd56BrvTqO
         0+SLduD0jI2K8/V3z9XrOXcqV/UFE6bAw9ge9WFEdwPmuIYeFNDkHLLGDhMyvyzw2xKG
         k8Wa1+aPLQZBT4IMc4KCF2WrgSqAOAmK2y2lFaQv8VUP4jGM+Hxm220m9G6OmOVzQNKD
         VTa35yB/3t2WorQED430CBNiuKsrjgKfZAbbjlVblAx2YxDupPEGupHc+MX0j5qyCYOT
         0b5j5lmC5ApDoMH2yKQFCZ7O8D0Az/6MdXDG6WIp6g/uhyKUam1TO27UqUPprl0s2O7H
         P3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AZbzCBY2g7dZZxDUBLS5x1vFTU3kOXD0y95olAujMNk=;
        b=aKGmUw1DnRfbwWvbHgDeSwWcyfScX57Sq3NwgMRmhU/BdFmnrciTfQ1FUnZDCnZKjM
         8HKGyVjmHX2XgmXdUBRG1sXCwSLRaeeayHVFzBttkzYOd/pXdXuhxNDf2TUePCX67Kc8
         2HaBjZswRPuXtCGjn1I2i2oc3boN8pHlkIQfu9hCfSiFcwqR4bGwrCwfVSowywbiCq4/
         VwzoZUa56czZYp/8IwdZPqYrxNzvqMKNY+W2C97vg4kT3RfJEfuAIEZ9QVbWrHNdy3/q
         UQyKapoOsNbGMCWtdenZupuBevv9e/MdzNn2u4tRslC2Lqrp/+GMCKuCrGBubby3nejz
         LWew==
X-Gm-Message-State: AA+aEWarlFDiRC47HZE478upiNN4b+v2K4drV7MBGArkIJx+RTGG7xq6
        h7Hg4h2VJD0nzYVjlLUa/6s7WwVz0RSnOA==
X-Google-Smtp-Source: AFSGD/VudTlykESfcGoFZeDH8/YN8hpJxcR8/RvMq6WCG1E4Wb6jLswOGtGRomSfeQtc+GbGO3eItQ==
X-Received: by 2002:a63:1e56:: with SMTP id p22mr11991032pgm.126.1545051523659;
        Mon, 17 Dec 2018 04:58:43 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v89sm18512325pfk.12.2018.12.17.04.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 04:58:42 -0800 (PST)
Subject: Re: [PATCH] block: mq-deadline: Fix write completion handling
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20181217061405.11681-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <68f8a4d3-d8c4-ef89-1b69-4c3d7f0f45c6@kernel.dk>
Date:   Mon, 17 Dec 2018 05:58:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217061405.11681-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 11:14 PM, Damien Le Moal wrote:
> For a zoned block device using mq-deadline, if a write request for a
> zone is received while another write was already dispatched for the same
> zone, dd_dispatch_request() will return NULL and the newly inserted
> write request is kept in the scheduler queue waiting for the ongoing
> zone write to complete. With this behavior, when no other request has
> been dispatched, rq_list in blk_mq_sched_dispatch_requests() is empty
> and blk_mq_sched_mark_restart_hctx() not called. This in turn leads to
> __blk_mq_free_request() call of blk_mq_sched_restart() to not run the
> queue when the already dispatched write request completes. The newly
> dispatched request stays stuck in the scheduler queue until eventually
> another request is submitted.
> 
> This problem does not affect SCSI disk as the SCSI stack handles queue
> restart on request completion. However, this problem is can be triggered
> the nullblk driver with zoned mode enabled.
> 
> Fix this by always requesting a queue restart in dd_dispatch_request()
> if no request was dispatched while WRITE requests are queued.

Applied, thanks.

-- 
Jens Axboe

