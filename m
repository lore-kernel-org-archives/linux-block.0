Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C80C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFF22087C
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="r3JXvfKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFF22087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeKQBcH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:32:07 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:33819 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeKQBcH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 20:32:07 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so1353640itd.1
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 07:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZUhFwHcNzk8TjqZiCbhpWWxYquwJNWI1/vu7iIsZRQ0=;
        b=r3JXvfKceX7ALC2DXV4mn5ASq4SiaP4rEjXrx2lDrg1x4cnvANYgVd0FEVWJ9yH9pS
         Kxv1qLQ19QxBQh7DWICiXPdI8QOAecgA3RnrePudJ7Zvl/Di+BocwjnDvbg17E6OiB8z
         x2KFdsPW5Hm8eA3Mnj+NJ0RYrQS50RTmNbmlazpHGnjZ9k2vgLLTLzWEe6ubA5Cqq3lg
         fHBHbBRUXGNwxHhoVKJIdB8jMJkeXY6hXXV1TM/GkWbUo+hUgm/hdnCvFOZghvj4WefP
         V8vCzeYO7cvIosBvx+UUqfI8EyhM2hmQnXDSo10eud823FasLTb6UR0pxrQStNzhEJNJ
         jpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZUhFwHcNzk8TjqZiCbhpWWxYquwJNWI1/vu7iIsZRQ0=;
        b=GzOoMAEH1+NAwzZPV/ruA6lEgYlQaigRpfB3nmeoRlz/dPrvrUzhBatfXgrGhxHmce
         0u0cyjg4u1A4RuEVYmlOkj8xAaLU7C7hRuHec2f3nWN7iW0ZqwxW92NBQD3eAqX4JOB1
         tJicIWZHyH1j9SYrgJSEjJvPxu1beznqtRSmhVnuYwTUpIMLtI3PebEZje7uWk3oG/zk
         MwmZoAwRBVCsWSi359MmYRFwTrOLdQUBi3LqRf6ukLW1LBfbLSg0hxcqz3qLjQroQIZM
         r/cjhSviw/u8CUqlDxgez3MCBgGYVKNLGrXokZcfDSv4l3Jq/rEEqR4eJXyEEyK7FmXZ
         nZUA==
X-Gm-Message-State: AGRZ1gKYj6/tZETLWqOGjc01Gn4OwymsrCfnpUnHYJFcvRPyDpfeeY6j
        N8OhgklaK4kAD/rT7j/IhDLKWcwf+tg=
X-Google-Smtp-Source: AJdET5eVhmDwaNrOaF2q15XTxUR2Sx6BJtf+Pv3bXWvqZ5NzLDz5PgXPBv509eUXyJiPiTQo5Q4zjg==
X-Received: by 2002:a24:294a:: with SMTP id p71-v6mr8730806itp.52.1542381558851;
        Fri, 16 Nov 2018 07:19:18 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h137-v6sm10902296itb.39.2018.11.16.07.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 07:19:17 -0800 (PST)
Subject: Re: [PATCH 07/11] blk-mq: when polling for IO, look for any
 completion
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-8-axboe@kernel.dk>
 <20181116084351.GH9023@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9f7ae221-10f2-2b13-5d3e-c7ea291f012d@kernel.dk>
Date:   Fri, 16 Nov 2018 08:19:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116084351.GH9023@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/18 1:43 AM, Christoph Hellwig wrote:
> On Thu, Nov 15, 2018 at 12:51:31PM -0700, Jens Axboe wrote:
>> If we want to support async IO polling, then we have to allow
>> finding completions that aren't just for the one we are
>> looking for. Always pass in -1 to the mq_ops->poll() helper,
>> and have that return how many events were found in this poll
>> loop.
> 
> Well, if we always put -1 in we can as well remove the argument,
> especially given that you change the prototype in the patch before
> this one.
> 
> Still digesting the rest of this.

We can remove the argument for the mq_ops->poll, as long as we
retain it for the q->poll. For the latter, we need it for
destination lookup.

-- 
Jens Axboe

