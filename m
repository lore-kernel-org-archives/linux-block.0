Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF080C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5A120811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="TKPU2U4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5A120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbeLMUED (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:04:03 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39579 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeLMUEC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:04:02 -0500
Received: by mail-yb1-f193.google.com with SMTP id h10so1317043ybp.6
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 12:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LsQvDYNVvVMADQnhj4E0GjqXnzhDyYwi5QAqBPP7YcU=;
        b=TKPU2U4hFtZTybA1n01ULvZDtRuf0PkZYMFN6SZyRsIShTGwulSIaV3NM3yI7QlZEL
         Dpxsra1UpGYtHGvnVpPMLEFPL6bHrsSRUeSSn4qn+OcoKJeNmtXnEYET9BbCIT1toB1V
         RdOk5HhiAkkmgcrdUNFm1JKRyf/q1BaoGm5CUCYL0DkXPJoCCG1BLS6olrjnYRQBbZI1
         Ey2GSqtjBRcyzhTC4oas8IO9PUZrGTVzQ3nSwAvfvNMOYSfiJ7TQz5z48UBVy2+tQoYr
         k1IRnw5GBn4nI1PWKu5YQwqscpfXkJHR9by6CgPDnAEyiAvYRMxquS/3txzUJ+3K7zMs
         X8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LsQvDYNVvVMADQnhj4E0GjqXnzhDyYwi5QAqBPP7YcU=;
        b=VyuRcD2Wy5VA++pUiJKefjVfY0JdG2XnLrdnwRJBRIAZ/ujbLpEYlI+Uaaz51g+uVM
         8wRawyc8AlEINAk214S6HzgUD4mYx+ZTTdJ+u1zrZhkj9w1oVB5SjiEfwP0CZHZUsgG5
         SGoJP/ofwod6+k0NzPUYqZGQoL1lUagXgg7KuZt5nLSr61LxLrsyNxvYtg4iorftfkRO
         ixfuJHx03gfIjqsyiWcZiw41/2fgxYVKJc+bLFJSe4phbma6K1Er+aJLIaEOnjqVG7tS
         sy0trUZSZhcnFMpUm1sEJReagmr3DMLKTXivU2aFuzs2pWNonUN4BFB40aedtDDOZEBt
         cYSg==
X-Gm-Message-State: AA+aEWa0/a5rd6aj50XJOTw1wNqSuM8U89e5l/r9dcuLogEr/oMdhKxA
        T9sPPbs1bkY7aQSAJib/gVU9mg==
X-Google-Smtp-Source: AFSGD/V2PonXI1fupj6R6mIwOzi6bM2ECEUtfLMPHTfr4aEC05XXNMbxx7fl0E7bnFADuhZMTBgx4Q==
X-Received: by 2002:a25:a349:: with SMTP id d67-v6mr185919ybi.334.1544731441486;
        Thu, 13 Dec 2018 12:04:01 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l35sm1296088ywh.48.2018.12.13.12.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 12:04:00 -0800 (PST)
Date:   Thu, 13 Dec 2018 15:03:59 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: fix iolat timestamp and restore accounting
 semantics
Message-ID: <20181213200358.e5zxe4tacrwylg32@MacBook-Pro-91.local>
References: <20181211230114.65967-1-dennis@kernel.org>
 <59500829-10f5-fa83-b2db-fcfa4a1cd11d@kernel.dk>
 <20181213195208.qgvfeb5ilbf3ttsf@MacBook-Pro-91.local>
 <cbf1ca87-6a47-6c98-0c41-5cf495d6508b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf1ca87-6a47-6c98-0c41-5cf495d6508b@kernel.dk>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 12:59:03PM -0700, Jens Axboe wrote:
> On 12/13/18 12:52 PM, Josef Bacik wrote:
> > On Thu, Dec 13, 2018 at 12:48:11PM -0700, Jens Axboe wrote:
> >> On 12/11/18 4:01 PM, Dennis Zhou wrote:
> >>> The blk-iolatency controller measures the time from
> >>> rq_qos_throttle() to rq_qos_done_bio() and attributes this time to
> >>> the first bio that needs to create the request. This means if a bio
> >>> is plug-mergeable or bio-mergeable, it gets to bypass the
> >>> blk-iolatency controller.
> >>>
> >>> The recent series, to tag all bios w/ blkgs in [1] changed the
> >>> timing incorrectly as well. First, the iolatency controller was
> >>> tagging bios and using that information if it should process it in
> >>> rq_qos_done_bio().  However, now that all bios are tagged, this
> >>> caused the atomic_t for the struct rq_wait inflight count to
> >>> underflow resulting in a stall. Second, now the timing was using the
> >>> duration a bio from generic_make_request() rather than the timing
> >>> mentioned above.
> >>>
> >>> This patch fixes these issues by reusing the BLK_QUEUE_ENTERED flag
> >>> to determine if a bio has entered the request layer and is
> >>> responsible for starting a request. Stacked drivers don't recurse
> >>> through blk_mq_make_request(), so the overhead of using time between
> >>> generic_make_request() and the blk_mq_get_request() should be
> >>> minimal.  blk-iolatency now checks if this flag is set to determine
> >>> if it should process the bio in rq_qos_done_bio().
> >>
> >> I'm having a hard time convincing myself that this is correct...
> >> Maybe we should just add a new flag for this specific use case? Or
> >> feel free to convince me otherwise.
> >>
> > 
> > I mean it'll work for now, but then when somebody else wants to do
> > something similar *cough*io.weight*cough* it'll need a new flag.  I
> > kind of hate adding a new flag for every controller, but then again
> > it's not like there's thousands of these things.  I'm having a hard
> > time coming up with a solution other than a per-tracker flag.  As for
> > this specific version, I still think it needs to be in iolatency
> > itself, trying to make it generic just means it'll get fucked up again
> > later down the line.  Thanks,
> 
> We definitely don't have that many flags, and I'd hate to add a
> per-whatever flag for this.
> 
> But do we need that? We really just need single flag for this, my main
> worry was overloading ENTERED. Especially since we're adding different
> clearing and setting for it. If we had a specific one, if it's set, we
> would need to disallow merging for it, I guess.
> 
> And there's already BIO_THROTTLED...
> 

Oh well I guess we only really want to know if we saw the BIO, which should be
able to be shared by all the rq_qos implementations.  I think I'd rather just
have a BIO_TRACKED to indicate it went through the normal rq_qos path.  Thanks,

Josef
