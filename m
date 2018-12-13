Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC86C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 19:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E0C20811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 19:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="xeC6aVZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E0C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbeLMTwN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:52:13 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39924 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeLMTwN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 14:52:13 -0500
Received: by mail-yw1-f68.google.com with SMTP id j6so1318678ywj.6
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wG32gjmYR+a6LxqRxyUJWOp8mEIFyeCoi+kK4CZX3lI=;
        b=xeC6aVZvumVToIPgil8TGwOsN4gaAa9Y9qVaKadLoI7wlG/JBeTj4R6fOpqIB8ji0k
         EY1K40aDMqGQCHizT3YSF+RcWA6oMxCgFdni9RbgF6KuExXuFprkRkc/jbj9SFi/L8yw
         rYvqn1HHNRtftSIW4FzJYWr4vbi2Fje+yiljImbMfSfxhV/2qVWjsNdLQvb7uwCri4wB
         zacNQ9OTyB6rJIqIi1Z9/db7bDLRVFac+fWF8qv2NRtcC4Fy9LV/bJNNVKBx0mLVsQEL
         dKyMRA7jp6xjssBSCCLUwNPBQSXI2iBefF3jv3gQ+atP45R/7RLu92Olt56ar2CfY/Hi
         mxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wG32gjmYR+a6LxqRxyUJWOp8mEIFyeCoi+kK4CZX3lI=;
        b=hj/ZTuzyh5GSJJzVL6v0ABy9q6hEyPRP8+EY+kvLYV/cWwJHUjiZ9n/QJftvpmvmWR
         GGCC7wSBgLnfwtYhAeBL44FuHW68X5wlKKDNRwnzgbtyMTctwUzMKqt2tzEhh8RzESeC
         sMf7p9kQwhjS9Rc6Cv4/r5ikhFNQ2gRe/7SViAuLTfEdLLEJlFtdnqBWikxzMe/rXqcE
         d7MIVF4W0sEuktLUkIv5M1FXLFhqf4HFn+aKeswM9lY885Bd54hiOD4DocYyotM1r05F
         2mYj3cvCaNDL3ljBfTlxd84BfDqrBeeglPi7Wm/PIdM6394croT1yRzTYwdo9Wpojy1R
         7Wdg==
X-Gm-Message-State: AA+aEWaXcKErnjengA/p7xT0Cc+vQmxq3szAO3PTv+XgXAiej3Cvwe1J
        oH9H64prz0LJiftMHpeLPfo6BQ==
X-Google-Smtp-Source: AFSGD/XcqKJjCGWJ5141+Akf/oStAI4liHFOPUwkQY9hRAfkTVtJJqeiNHG+EN8ePig2K59jm1FAxg==
X-Received: by 2002:a81:b657:: with SMTP id h23mr152034ywk.378.1544730731463;
        Thu, 13 Dec 2018 11:52:11 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l9sm934943ywc.81.2018.12.13.11.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 11:52:10 -0800 (PST)
Date:   Thu, 13 Dec 2018 14:52:09 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: fix iolat timestamp and restore accounting
 semantics
Message-ID: <20181213195208.qgvfeb5ilbf3ttsf@MacBook-Pro-91.local>
References: <20181211230114.65967-1-dennis@kernel.org>
 <59500829-10f5-fa83-b2db-fcfa4a1cd11d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59500829-10f5-fa83-b2db-fcfa4a1cd11d@kernel.dk>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 12:48:11PM -0700, Jens Axboe wrote:
> On 12/11/18 4:01 PM, Dennis Zhou wrote:
> > The blk-iolatency controller measures the time from rq_qos_throttle() to
> > rq_qos_done_bio() and attributes this time to the first bio that needs
> > to create the request. This means if a bio is plug-mergeable or
> > bio-mergeable, it gets to bypass the blk-iolatency controller.
> > 
> > The recent series, to tag all bios w/ blkgs in [1] changed the timing
> > incorrectly as well. First, the iolatency controller was tagging bios
> > and using that information if it should process it in rq_qos_done_bio().
> > However, now that all bios are tagged, this caused the atomic_t for the
> > struct rq_wait inflight count to underflow resulting in a stall. Second,
> > now the timing was using the duration a bio from generic_make_request()
> > rather than the timing mentioned above.
> > 
> > This patch fixes these issues by reusing the BLK_QUEUE_ENTERED flag to
> > determine if a bio has entered the request layer and is responsible for
> > starting a request. Stacked drivers don't recurse through
> > blk_mq_make_request(), so the overhead of using time between
> > generic_make_request() and the blk_mq_get_request() should be minimal.
> > blk-iolatency now checks if this flag is set to determine if it should
> > process the bio in rq_qos_done_bio().
> 
> I'm having a hard time convincing myself that this is correct... Maybe
> we should just add a new flag for this specific use case? Or feel free
> to convince me otherwise.
>

I mean it'll work for now, but then when somebody else wants to do something
similar *cough*io.weight*cough* it'll need a new flag.  I kind of hate adding a
new flag for every controller, but then again it's not like there's thousands of
these things.  I'm having a hard time coming up with a solution other than a
per-tracker flag.  As for this specific version, I still think it needs to be in
iolatency itself, trying to make it generic just means it'll get fucked up again
later down the line.  Thanks,

Josef 
