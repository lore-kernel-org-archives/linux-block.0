Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B32C433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 02:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829C322BEF
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 02:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbhAYCTg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 21:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbhAYCAQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 21:00:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D6CC061574
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 17:58:53 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id jx18so2078417pjb.5
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 17:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=91281cUbpRUSz4u3H6AZl6FqTb9jBLHCSsmx4sm3+ZE=;
        b=ebWH9BgFwO2wmb/cezHbCyAIf+34C1N5gC23I/PViWaU38L/Amo/c15t/H646UN0n1
         vDs7lauKZEjXomq5w/N5uNtyVDpy6uhB1/keJ1+xC3Lw4jLITfbhTBDk7Ii7xWKbT/oc
         y84Mbo6u1CHnLWp1zi9amvi6ZH4foA2Q/GYpFh5rYsEfqu5Vs2yC3uD4wWOnP5f8LdXv
         W34DRrkPJryAGxJJw01tFyyn5Ygv8vsI+MFsg/et7qEmKvqkNgb1xFEaHTMTEkWDbJQK
         LJmFOqDvWxkofzJmMUY7/1iNFf753yL41OmPcaGis8krWuwIIzRMIv85xzUfgF0g9dYZ
         2YOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=91281cUbpRUSz4u3H6AZl6FqTb9jBLHCSsmx4sm3+ZE=;
        b=C/Ts00SQ560YRboMZ5GHWh8q3mGApZqR0Gr6yO2rC9wx+j8giFan+Gu2o+onzb0R2K
         YhfXzue+l8C2XDfneXJYClBtFO9ptLDGi7JrxAEjvMAh0l2Fh7JMaoqGmcksRkd3020I
         OTsFMFMNyrOHf3CVUhnP6Oki7tr8thPa6dUqYK7ha69FncBpCmvIwqnkXfzgnCsdJGKR
         CQ7Y64cvyno2eavcG78a47pyIoND5N9bwQFmwiwYSJcE1zrMfcqSOUXoJFdlnOeBFfus
         Z8tcy/TlkkQKhcedX8/FSqRc/PKvd40vIjNwfYY8hg/aaXlcGh0R1rDs7+AQ3C16dHue
         VQJw==
X-Gm-Message-State: AOAM533UTgBXX3uG0xoRWKUQK2SPkdJOG4JaEAYffMJoBbD6A/Gwq+32
        GLklaXneyPeGcdxi40ej5oyGlw==
X-Google-Smtp-Source: ABdhPJy3fIaNU7wcqZWs6Bytqm1PzUM1P+6ZbcRWB/ZhQCu7HowmoYOmOle5I88PFPlhlw5yXUPrjQ==
X-Received: by 2002:a17:90a:f28d:: with SMTP id fs13mr2409880pjb.22.1611539932864;
        Sun, 24 Jan 2021 17:58:52 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x26sm8307865pfi.176.2021.01.24.17.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 17:58:52 -0800 (PST)
Subject: Re: [PATCH] fio: add hipri option to sg engine
To:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        kashyap.desai@broadcom.com
References: <20210125013751.269675-1-dgilbert@interlog.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fef432a4-29ed-c560-1d91-b05bd239b9c9@kernel.dk>
Date:   Sun, 24 Jan 2021 18:58:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125013751.269675-1-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/21 6:37 PM, Douglas Gilbert wrote:
> Adds hipri option to the Linux sg driver engine. This turns on the
> SGV4_FLAG_HIPRI flag in recent sg drivers (January 2021) on READ
> and WRITE commands (and not on UNMAP (trim), VERIFY, etc). Uses
> blk_poll() and the mq_poll() callback in SCSI LLDs. The mechanism
> is also called "iopoll".
> 
> The Linux sg engine in fio uses the struct sg_io_hdr based interface
> known as the sg driver "v3" interface.
> Linux sg drivers in the kernel prior to January 2021 (sg version
> 4.0.12) will just ignore the SGV4_FLAG_HIPRI flag and do normal
> completions where LLDs indicate command completion with a (software)
> interrupt or similar mechanism.

Looks fine, and is consistent with eg io_uring. Can you add the
engine specific option to the HOWTO and fio.1 as well?

-- 
Jens Axboe

