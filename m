Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BBEC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 16:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64782084A
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 16:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Cficg7Pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeLSQLQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:11:16 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53464 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeLSQLP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 11:11:15 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so10445366ita.3
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 08:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HioSU+cN5bVn7zGZPVdN/gJcXSydatW3oGYc8CzVHHQ=;
        b=Cficg7PlUUDHJfYJkyA3yxGVsOjSiifJH5IC6Y/cOZADKu4WS4UheRTc41jKoFnO5k
         QpHuLafFR2nJ+M3IGNejSeJBkbFhrpaIiPycQXuWQ64UrWUwvQ3ocnT146iPW3oJAHl9
         5+3WzKWZh6mVv6e67rHKoEg1ytw5EFPK+z5oSmB2RQHpAF5AiYt/JMWxWJbe7I2uiCCv
         A4P2jHM3i6v0yhSm65flXbByvcivlZevpXogEK1o7AhW9V3ECrbagsPoQHiReKcqgy+C
         LGQyqPeknIBe+7NVUHzPEUAlzV9YrtkYD5wuDPk54Ze6WyWburC52YY3ssrOK/rH1/lq
         H/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HioSU+cN5bVn7zGZPVdN/gJcXSydatW3oGYc8CzVHHQ=;
        b=uCVhC+l2JyzUinan/osBhoP5i0pcGG4nI5OmQ5L0VOQXqcWXak9iWm/7Bz47r2N3c3
         g8AJFDkhOrhVEowbdy9aU3WIIOD5cNqDTdyHuqFCPEqD6o8oQdDKRaqk8Xd0C9s/v/Fl
         M7g+9Ux+kzIEXarlRdkYu9DFVSNqOAr1NujZz08nSF99rwNnOPCAyWBzYY/GfHH7a9yh
         7VvddE0XPb/+iBaQ7nxrlpJD5PzpTmSPwR3c2XONXtGazw15BZeuUpex1yVgz+CT3/7M
         gf8/KLyruLc0KtiXXrj6UHqqCze1tSTMPdoW8p4yJ+10l9H4bQg+H9hxxS6gulEunquD
         vm0g==
X-Gm-Message-State: AA+aEWYhHAhh4+4ZfkAeUhTS4VUclbEwQ+dfMtjQgRG0BFK0WgXWpCNv
        99OXcA2HH16jOKMXxsU2g+b1JXA2DlfsAw==
X-Google-Smtp-Source: AFSGD/WZQWJoF8NBML0TeYpYCK01toX/AzYCAb0yDYqfWR+KN/BcnbkYXFOIHkykkALgAvGfnS8RPQ==
X-Received: by 2002:a05:660c:20c:: with SMTP id y12mr5737277itj.88.1545235874599;
        Wed, 19 Dec 2018 08:11:14 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l3sm3824272itb.43.2018.12.19.08.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:11:13 -0800 (PST)
Subject: Re: [PATCH] dm: don't reuse bio for flushes
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Dennis Zhou <dennis@kernel.org>
References: <a7e97e4b-0dd8-3a54-23b7-a0f27b17fde8@kernel.dk>
 <20181219160657.GD17457@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ecf1ec49-da49-37d4-78a5-3ceb119f9b7d@kernel.dk>
Date:   Wed, 19 Dec 2018 09:11:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219160657.GD17457@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/18 9:06 AM, Ming Lei wrote:
> On Wed, Dec 19, 2018 at 08:50:09AM -0700, Jens Axboe wrote:
>> DM currently has a statically allocated bio that it uses to issue empty
>> flushes. It doesn't submit this bio, it just uses it for maintaining
>> state while setting up clones. Multiple users can access this bio at the
>> same time. This wasn't previously an issue, even if it was a bit iffy,
>> but with the blkg associations it can become one.
>>
>> We setup the blkg association, then clone bio's and submit, then remove
>> the blkg assocation again. But since we can have multiple tasks doing
>> this at the same time, against multiple blkg's, then we can either lose
>> references to a blkg, or put it twice. The latter causes complaints on
>> the percpu ref being <= 0 when released, and can cause use-after-free as
>> well. Ming reports that xfstest generic/475 triggers this:
>>
>> ------------[ cut here ]------------
>> percpu ref (blkg_release) <= 0 (0) after switching to atomic
>> WARNING: CPU: 13 PID: 0 at lib/percpu-refcount.c:155 percpu_ref_switch_to_atomic_rcu+0x2c9/0x4a0
>>
>> Switch to just using an on-stack bio for this, and get rid of the
>> embedded bio.
>>
>> Fixes: 5cdf2e3fea5e ("blkcg: associate blkg when associating a device")
>> Reported-by: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> Only other use case like this I could find is raid5-cache, which
>> serializes access to its embedded bio (and actually submits it, too).
>> That one looks fine.
> 
> With this patch, xfstests(generic/475) won't trigger the warning of
> 'percpu ref (blkg_release) <= 0 (0) after switching to atomic' any more.
> 
> Tested-by: Ming Lei <ming.lei@redhat.com>

Great, thanks Ming. I think this was somewhat of a ticking time bomb,
so good to have it fixed even if we could have done without a bug. And
thanks for all the testing!

-- 
Jens Axboe

