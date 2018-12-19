Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E86C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 16:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C7E2084A
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 16:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Lk84V+qZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeLSQO2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:14:28 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:50872 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeLSQO2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 11:14:28 -0500
Received: by mail-it1-f169.google.com with SMTP id z7so10482339iti.0
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 08:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CWpI5Nla/ZIExcSBqjHo+gG/bcMHDdSUTPkMprlmG8Y=;
        b=Lk84V+qZ0zaVVOP94LrgxErqiuKGHy9AxtYkSeam4MZdmOl8ZO/ZYT8is5PZZDKX88
         /9/swcm3p3GSAMVc8ibnS7tqAxPjYfYvpHLJsd/gff+Gxubd8IY2efI09zTeK3/RkVJf
         pYteKRQofgjNdqDGZm6e86TtfENZE37GbrhAiL0KDlzHs2rehElXfVQO+tPdAdbKY8rV
         7Tqvv7f6pSxVicy0EOZxXdc8XEeyxTf8gtWxp1X/zDF9NT6rPJ85tipGgEnm1QWHOUa/
         i3jg7v43bU/FEDCRKKAZSz2S4idLnRNV0mFF3qEPGTYdXdMR1xz2Xm0NolUk3Ocb65ho
         EWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CWpI5Nla/ZIExcSBqjHo+gG/bcMHDdSUTPkMprlmG8Y=;
        b=VlH7dHQiSwmqdxWFHkECN7K+WRHxlpG7QG+2KnpSpCTpKdtRYPltzygqXGVM7pkWgj
         z65ObuYdHmW35C6werpaXjR98IBBdVc0pILMI/5h+NKWeKYcjol5IB7IYMK8IetgZyFn
         dnK4NwZw7/w9+sDXqC30m7+YZl7my7QJnponD8nL6ywSPAb/ZVuvcGL9R8HjlyRpB6a0
         PCoSHJnB+3177AdcbrxWNEHjOr0hDoSXwTyQY46bZJhBWpzQ16rMpuM9M/DiLfRGc+NV
         TjOP6w80MFVef+U4UES4AzIzgJWKrqjQ0VFWNCLFWo1lw2pawJOapUnb2jNrLT6p03PN
         yrrw==
X-Gm-Message-State: AA+aEWZ3LUgd6OnIyLheGNzx9M4pYekPQoC945J6szYHeJapOF1ayTDd
        hg9jjQopkKRziELeEjv+v4LP/w==
X-Google-Smtp-Source: AFSGD/USmwMGKpJphX//iFNeUCWNJStAJcmBbw2Jro7Y95uxl1z4X+QcHQ9/fIAuZSMcfG8Qu4Qn3g==
X-Received: by 2002:a24:6192:: with SMTP id s140mr6858557itc.97.1545236067285;
        Wed, 19 Dec 2018 08:14:27 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e141sm4049023itc.40.2018.12.19.08.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:14:26 -0800 (PST)
Subject: Re: dm: don't reuse bio for flushes
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Dennis Zhou <dennis@kernel.org>
References: <a7e97e4b-0dd8-3a54-23b7-a0f27b17fde8@kernel.dk>
 <20181219161157.GA29426@redhat.com> <20181219161347.GB29426@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0f27031a-fcc1-c308-1127-7fa1404643b8@kernel.dk>
Date:   Wed, 19 Dec 2018 09:14:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219161347.GB29426@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/18 9:13 AM, Mike Snitzer wrote:
> On Wed, Dec 19 2018 at 11:11am -0500,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
>> On Wed, Dec 19 2018 at 10:50am -0500,
>> Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> DM currently has a statically allocated bio that it uses to issue empty
>>> flushes. It doesn't submit this bio, it just uses it for maintaining
>>> state while setting up clones. Multiple users can access this bio at the
>>> same time. This wasn't previously an issue, even if it was a bit iffy,
>>> but with the blkg associations it can become one.
>>>
>>> We setup the blkg association, then clone bio's and submit, then remove
>>> the blkg assocation again. But since we can have multiple tasks doing
>>> this at the same time, against multiple blkg's, then we can either lose
>>> references to a blkg, or put it twice. The latter causes complaints on
>>> the percpu ref being <= 0 when released, and can cause use-after-free as
>>> well. Ming reports that xfstest generic/475 triggers this:
>>>
>>> ------------[ cut here ]------------
>>> percpu ref (blkg_release) <= 0 (0) after switching to atomic
>>> WARNING: CPU: 13 PID: 0 at lib/percpu-refcount.c:155 percpu_ref_switch_to_atomic_rcu+0x2c9/0x4a0
>>>
>>> Switch to just using an on-stack bio for this, and get rid of the
>>> embedded bio.
>>>
>>> Fixes: 5cdf2e3fea5e ("blkcg: associate blkg when associating a device")
>>> Reported-by: Ming Lei <ming.lei@redhat.com>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> Thanks for sorting this one out, definitely wasn't happy with how
>> exposed DM was left with the recent blkg changes.  This is clearly
>> better.
>>
>> Acked-by: Mike Snitzer <snitzer@redhat.com>
> 
> Please upgrade this to:
> 
> Reviewed-by: Mike Snitzer <snitzer@redhat.com>

Done, thanks Mike.

-- 
Jens Axboe

