Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20391C47247
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 17:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A2B20731
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 17:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ws43m6Sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgD3R3q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD3R3q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 13:29:46 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6CAC035494
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 10:29:44 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w6so2150237ilg.1
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2FNMsoI0t8cNRc6BJKQCtXktGYOvHxE9G4hAVYvfeXw=;
        b=ws43m6Sf2oAtP7jjm+FS0LNry9cuvg9A24j0ckNw4IySckQgMVIhCxv6NMZjgo8xRI
         9LU/OO3bXn5HQfwQoNrEpLMFH7ZkgUt7AbdP3Ib3sh+grXzcmGUOlc675NQcicnsyeNu
         bbFKrWXYUaI+6ihHtqxS5WWGtbjJ773EvUrk/g/FLO92PMpum9qP1F6zZmadxNlBoN8F
         nUKcnhsl5y4bcszjohNdWAnOWja4b61E1pbYZI+9QwQzb5/HywDZKlmex8DRcUTxs0Hb
         UGMV7Hv4TrGUjipkPDMnXvqTOhrXR5n6+GkigBbvuY3UpSF8kLwDxK6kC0R1OPbKiA2/
         W/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2FNMsoI0t8cNRc6BJKQCtXktGYOvHxE9G4hAVYvfeXw=;
        b=DLZR8CsI1srP+m/7YFNqwIqErUa/4p4mfDWt5woJ/0JnoTIdhbmzVHYDWS5gg/dbWQ
         574VdFVbA+vTEno30ezhsxmGRKkzxhsfkVG2k/b77bckcb5q0rYJI9RzOvWTkxMKYRVl
         6tQVONWBDDYGTzUu6nMdV2BfE4NpuY5lJpA6Dt8GlLi4EEvf2MzMGJiY6Ck4T07giWPD
         CmG6aeD/2fXMeoH/TS4+jFTJVwg8BM0BzlP2wLNRklibsIDBi4Cb7zwLeFMTMYS0IXhl
         d7kt8F0VXpcxJwhixB8pvKB9lAFv3t7FjBo3x1DFIbMTOPex3cf5smLhkgTEbXuxaOdp
         mh8g==
X-Gm-Message-State: AGi0Pubd4tYRb6TLXAhnZlc4YJ4FdYGTDYQx13ZhYH3hLdfXmAOJhByJ
        TianJsEcxx4R8e/kv2kuQO29uqDkkZgfiA==
X-Google-Smtp-Source: APiQypKkUQs5lnOeOgMs1taivf+eDgyDDnEQm/aw9jRg/k2Jltuf/w7a2gTcaaje4U2PjuyDNWPiIA==
X-Received: by 2002:a92:1b91:: with SMTP id f17mr3085153ill.142.1588267779540;
        Thu, 30 Apr 2020 10:29:39 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w7sm56075ior.51.2020.04.30.10.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 10:29:39 -0700 (PDT)
Subject: Re: Commit 35fe6d7632 breaks blktrace API
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org
References: <20200430114711.GA6576@quack2.suse.cz>
 <7ae4a13a-2f03-a902-5bb5-3dcd20cf1fad@kernel.dk>
 <20200430155911.GA15637@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <981ba2e7-b3e2-5f78-5a23-125439eecbbe@kernel.dk>
Date:   Thu, 30 Apr 2020 11:29:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430155911.GA15637@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/30/20 9:59 AM, Jan Kara wrote:
> On Thu 30-04-20 07:10:47, Jens Axboe wrote:
>> On 4/30/20 5:47 AM, Jan Kara wrote:
>>> Hello,
>>>
>>> I was investigating a performance issue with BFQ IO scheduler and I was
>>> pondering why I'm not seeing informational messages from BFQ. After quite
>>> some debugging I have found out that commit 35fe6d763229 "block: use
>>> standard blktrace API to output cgroup info for debug notes" broke standard
>>> blktrace API - namely the informational messages logged by bfq_log_bfqq()
>>> are no longer displayed by blkparse(8) tool. This is because these messages
>>> have now __BLK_TA_CGROUP bit set and that breaks flags checking in
>>> blkparse(8). It isn't that hard to fix blkparse once you know what the
>>> problem is but I've wasted couple hours on this...
>>>
>>> Also apparently nobody tested the patch with blkparse(8) since 4.14
>>> days? Admittedly this requires CONFIG_BFQ_GROUP_IOSCHED and having cgroups
>>> set up for the cgroup info to get emitted which probably is not that common
>>> with non-production machines.
>>>
>>> Anyway, what to do now? Update blkparse(8) and hope nobody else is using
>>> the blktrace API (likely I'd say)? Revert the change?
>>
>> It's been this long and nobody has complained, I think we should just update
>> blkparse.
> 
> Fine by me although I would note that e.g. most of our customer are running
> on 4.4 or 4.12-based kernels so if any of them has their custom scripting
> using blktrace API (I seriously doubt that though), they'll probably notice
> the problem only in couple of years... But as I said I doubt there's
> anybody doing this and blktrace is a debugging API so I'm fine with just
> fixing blkparse and crossing my fingers ;) I'll send the patch after some
> polishing (I just quickly hacked it up so that I can proceed with my
> analysis).

In any case, much easier to push a blktrace/blkparse update! Thanks, I'll
keep an eye out for your patch.

-- 
Jens Axboe

