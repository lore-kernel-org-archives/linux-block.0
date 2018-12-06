Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C198C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634FF20868
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sFWIIjNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634FF20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbeLFSMg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:12:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36067 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeLFSMg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 13:12:36 -0500
Received: by mail-io1-f68.google.com with SMTP id m19so1139675ioh.3
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XTFz/AuyG/TDnb+nK6vrWhCqLCclUj1JhRFLz7GlaIA=;
        b=sFWIIjNMLCHJZnSSMYhCiL+FNPcn9B5tZNJp9fhH+Y/h4Bo8FMdd1gtlwhBvTdn4TF
         uZfyGI8hK1CUm0iBH008OwrGpz1B+BI7RwUk3wDvhIHC3VQritxNjA7zMzmshzhAwSMX
         g7p1mvIkliS2XGK+FgKxk3YhbmfpKpu/v+u8+XVFwWV9PAEVlZ0Gjsz4a2gCtK/RDJOO
         b6wblDa6WC0/ZIh46jBrSZ6eUEtTneJbBJrOpjC9hZM2NfwPgks73YEiM5/kaXlA6PTO
         fi/tz+wztj30VAzy2NeZgQEGrZL5NQkK1i+Bccz3K7SlIICvq5tW7qqRhaw5VTzOsXIw
         Xc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XTFz/AuyG/TDnb+nK6vrWhCqLCclUj1JhRFLz7GlaIA=;
        b=oPf147aoQVTdY/me3Yy5xwOgp46+pDam7tmuZGt9+NstYaCRik/6GN9OtYXp1Zwykd
         PuHak2ZlTCYU4Pl8XxVIc/TAXEVEFGRgCR2UF9584aT0ynGAVuFJIrQLS8h9CahmAmw6
         QAi1t/rs55MwooZ/F9ALZ5+a9T2+93Dl6b/5Kmm0hwW7MSnlZ/TEgUwohcxFJ/TZf6Nz
         Kx+K32EGSPEw9PtmmDgvM87SoC6yBGcPq3kYbeV9Lv1+BG7WlprWtHKzu66s9Z72uZE8
         nhz3Kcp4vTWX5GTQwVyh2WaMkhQHNBQO7tPAu6FEFE30xB6YgZ9NJogtj6Ew04ERTE2c
         nKMg==
X-Gm-Message-State: AA+aEWasDAu8AUFdyZEF65JL+ns5G29ZhftlAebj/dmX+wBT7msqbKd8
        RE87IBTZpEiI2K9GAFc/VWwD7WS7wyU=
X-Google-Smtp-Source: AFSGD/V98R5d8P5qpBHr0L8PFiTA8s7PN1ZQppCHgX/ep9YqAtwMqWz6+xkvIicZSiS4uhJ83l7VAw==
X-Received: by 2002:a6b:c992:: with SMTP id z140mr25588058iof.13.1544119955496;
        Thu, 06 Dec 2018 10:12:35 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y9sm347631ioj.63.2018.12.06.10.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:12:34 -0800 (PST)
Subject: Re: for-next branch and blktests/srp
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <1544114872.185366.250.camel@acm.org>
 <41bbac1e-7461-4378-a18d-531b625d6784@kernel.dk>
 <1544116771.185366.261.camel@acm.org>
 <707b709c-547f-b330-bd37-29b8fc427827@kernel.dk>
 <a73ef579-e4e8-f245-b203-1b52eb41af78@kernel.dk>
 <1544119321.185366.277.camel@acm.org> <1544119805.185366.279.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a6388520-5037-7a77-4e90-679419d16dbd@kernel.dk>
Date:   Thu, 6 Dec 2018 11:12:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544119805.185366.279.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 11:10 AM, Bart Van Assche wrote:
> On Thu, 2018-12-06 at 10:02 -0800, Bart Van Assche wrote:
>> On Thu, 2018-12-06 at 10:48 -0700, Jens Axboe wrote:
>>> which would result in a non-zero exit, which should be expected for this
>>> test?
>>
>> Test srp/002 simulates network failures while running fio on top of dm-mpath.
>> Since queue_if_no_path is enabled in multipath.conf dm-mpath will keep retrying
>> the block layer requests it receives if these requests fail due to path removal.
>> If fio reports "io_u error" for this test then that means that the test failed.
>> I haven't seen fio reporting any I/O errors for this test with any upstream
>> kernel that I tested in the past year or so.
> 
> Hi Jens,
> 
> Please also verify that the version of multipath-tools that you are running includes
> the following patch:

I installed from apt... Says this:

# apt show multipath-tools
Package: multipath-tools
Version: 0.6.4-5+deb9u1

I can run a self-compiled one, if this one doesn't work.

-- 
Jens Axboe

