Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7E5C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 12:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4FF2086B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 12:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nrpQicIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4FF2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeK1Xzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:55:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41735 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeK1Xzl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 18:55:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so10126511pfi.8
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 04:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qpbQxXk5432qjly/w67qOP7Z+Z9jIc9fXmvAbXc61Do=;
        b=nrpQicIWpGL1OvE2JdV44DeWQ/2B8Vqq0a1r7dnmjJJKL17jImhw+OS6UGEt4narqW
         CYD7svWWbitmVPgT0Qdd8SpkakkGFNNxortu42UUhrU8oPv7Cquy1taGTFgogDJpCNkU
         fP0mLerf5LMpcO5ptd2H2go+7MqdGAJ+IZH5th+Wiy8YTjZWNxkgERaQDBJ27qBjipPH
         oqIt2P9Ld/+pG0/LkxqHdNtmCNkwyzEcPre8Ht4MCDRefjSFOjNW9nZjhJml1zeDczi0
         NuesDchRzZX/dwyCBocyAMcYUeJTH41BpqG4/8VRWUgHcLAX8xMLmiviruoKquZceI2e
         vcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qpbQxXk5432qjly/w67qOP7Z+Z9jIc9fXmvAbXc61Do=;
        b=ILt+Mi+2s+KjV4kLbp8BoN58r9PRlhXzKbvmO2KSKGte27A5VRknRziB1FHVO2u3RD
         9YS/YJ10bdnY9l8QDtH5EFzwuWRJUlp7iUPm0NyYR1h7wwCwS3/RM2YrfAzrC+a9Hq74
         +5WmX3+mPxgKe+os4A6HAOvdNK6toQGE9Q8DlSTa6J7N9g6qPzc4fltAc5g11lWuoNx+
         FcUCR+gMIE68ZrIene1+iDUuDWUd5pO4xik0VUZ/jbkYoSoxyTwGqi0LQZA+3H6gwfGT
         MW0Otk1XhX/CzSqIaDcBxXecCvUeLq7NO5GwRKQsPgKBrbatnBs3G0GMMG2ZbDHWq3Od
         4vxg==
X-Gm-Message-State: AA+aEWYox+rvvuVxTzND6xED7rr0r95DwP8I7ZX4IqboUmjSInkOT7x5
        A99/nVlnhoPWHn0GOF5UcPRI7w==
X-Google-Smtp-Source: AFSGD/XTG0I1s7KK0l0Bo4xb/VHJ73mCmfDaq4wR35UWeGWWCXYJoWDyOoxuorcmby5+vpNtFuiHCA==
X-Received: by 2002:a62:44d8:: with SMTP id m85mr18584159pfi.164.1543409646965;
        Wed, 28 Nov 2018 04:54:06 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id h134sm9513067pfe.27.2018.11.28.04.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 04:54:06 -0800 (PST)
Subject: Re: [PATCH 3/8] blk-mq: add mq_ops->commit_rqs()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-4-axboe@kernel.dk>
 <20181128071601.GA11774@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dd6bf846-c5f4-8aea-64fa-bf613d5079d2@kernel.dk>
Date:   Wed, 28 Nov 2018 05:54:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128071601.GA11774@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 12:16 AM, Christoph Hellwig wrote:
> On Mon, Nov 26, 2018 at 09:35:51AM -0700, Jens Axboe wrote:
>> blk-mq passes information to the hardware about any given request being
>> the last that we will issue in this sequence. The point is that hardware
>> can defer costly doorbell type writes to the last request. But if we run
>> into errors issuing a sequence of requests, we may never send the request
>> with bd->last == true set. For that case, we need a hook that tells the
>> hardware that nothing else is coming right now.
>>
>> For failures returned by the drivers ->queue_rq() hook, the driver is
>> responsible for flushing pending requests, if it uses bd->last to
>> optimize that part. This works like before, no changes there.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> This looks fine, but normally I would only add the method together with
> the actual user..

I included the two hunks from patch 7 in this one, so there's a real
use (and fix) with it.

-- 
Jens Axboe

