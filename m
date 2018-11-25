Return-Path: <SRS0=TDIO=OE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A75C43441
	for <linux-block@archiver.kernel.org>; Sun, 25 Nov 2018 13:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9140820865
	for <linux-block@archiver.kernel.org>; Sun, 25 Nov 2018 13:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pXtJvxIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9140820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeKZAcz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Nov 2018 19:32:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35074 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeKZAcy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Nov 2018 19:32:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so5284379pfi.2
        for <linux-block@vger.kernel.org>; Sun, 25 Nov 2018 05:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6IIIFCeugfM03tG2yXJ+2ofqdegbEgJgn3BbrAAb5+M=;
        b=pXtJvxIKSWaFD8nVJKe3ndYmvOLp0c2bP/QqW5Nz75c/9GELGeYTwCMGZMm7XBghfX
         RzVhVOoR2H8Wi5eBDUiYdBrBx/Be9rWYYrFrh574vVE5Lj/monwqNgoa3neOGmZK6cjI
         NoEcwbBplGW6Tr2tJD5/9YsXv0Wq0mpc0MVWiZsmvq/Hz7RUVlSycB/n1Mp09GoHaXF9
         uM2D/x10ZmuFxY/d+dblERfeUU6aJRC6aRZpGBVsZMMZHEXbOFoIQYbtsW5wlFg4Dmte
         EHn1qVJrIgZ2s/LHpoPjBlTRC4ojTkTmH38dXk1H47Da0Tc0eQ+4CjSPbth0DkeIN74d
         wnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6IIIFCeugfM03tG2yXJ+2ofqdegbEgJgn3BbrAAb5+M=;
        b=GwVnTmE1w0jgvSx5ZnBfUJtJPDIBtWMmh2cFEyLgqjYRqJ4qaQiPuezU1rIx2lBZ7Y
         g36rP6FnfgLuaniE+EiXflX90aQfqbXkNanMdHv8mM08m5H3Yqi4ZQpLH6j4E5ZITG3v
         CHtR8WKtqCrZOSKR/+oQ0yYjBxXtq6z2Prwi4h+nR7yt+mPxRePloc2f+L2XLJJYMftB
         dQt1M5aZqPFtDw6lrjFdmeBr/5cmVpSNc7UqM/s3HNA/r3JJkfC7neKkrn4Td7sUWdfD
         9pGITkJy8meRLC3hFW7UNwaJZ5mQbfl5D4QQiQOj80LKXeOH/wsla0rAjj1TVG01DS7k
         JVTA==
X-Gm-Message-State: AA+aEWa3TH8Wp/75B02r722Y6NwqduZ9N9/RMHjg9rIDClch+exLvAEn
        uW2QcQ+t/NkgDt83uHiz9NMZww==
X-Google-Smtp-Source: AFSGD/U8T37HaYe5iSGrxLeYeOF3rFrvfVW7QNffjjTfL1AoY0mkmRuhqgP71zY3bKhNF33QW7gqxA==
X-Received: by 2002:a63:5518:: with SMTP id j24mr20656139pgb.208.1543153307793;
        Sun, 25 Nov 2018 05:41:47 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g190sm60552775pgc.28.2018.11.25.05.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 05:41:46 -0800 (PST)
Subject: Re: [PATCH 2/7] block: have ->poll_fn() return number of entries
 polled
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-3-axboe@kernel.dk>
 <fb1200ad-35ef-1c2e-25cf-d8a71bc505b5@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba2d191c-cf9d-07f1-5875-6a07ef043949@kernel.dk>
Date:   Sun, 25 Nov 2018 06:41:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fb1200ad-35ef-1c2e-25cf-d8a71bc505b5@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/25/18 3:52 AM, Sagi Grimberg wrote:
>> We currently only really support sync poll, ie poll with 1
>> IO in flight. This prepares us for supporting async poll.
> 
> Hey Jens,
> 
> So are we sure that this is fine to simply replace the
> poll functionality? you say that that we support poll
> with only 1 I/O inflight but is it entirely true?
> semantically speaking?

It is, unless you have multiple threads all doing polling.  Which is
pretty inefficient, as I'm sure you know.

> The interface is selective polling, which means that
> the user can have more than a single I/O inflight but wants
> to poll for a specific one that it really cares about.
> 
> Would this introduce a regression for users that rely
> on preadv2 to basically "complete *this* IO as fast as possible"?

No, it'll be exactly the same, and believe me, I've done plenty of
performance testing to ensure that it works well.  In fact, with the
changes queued up and this on top, polling is both faster and more
efficient than it ever has been before, for both the classic
preadv2/pwritev2 and the async polled IO.

> Note that I like the proposed direction, I'm merely questioning
> if it is OK to simply change how selective polling worked until
> today instead of introducing a separate blk_poll_all(q) (but with
> a better name) which would be wired up to aio polling and friends.

I think that would be useless. For SYNC type polling with one thread, it
doesn't matter if we're looking for a particular IO, or just any IO.
Once your into two threads, you're already wasting huge amounts of CPU,
just to get to QD=2. The poll loop handles finding each others IOs just
fine, so there's no worry on that side.

Polling was originally designed for the strictly SYNC interfaces, and
since we had the cookie anyway, it was tempting to look for a specific
IO. I think that was a mistake, as it assumed that we'd never do async
polling.

-- 
Jens Axboe

