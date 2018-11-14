Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0414C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7E12089F
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YWxoB08y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7E12089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbeKOBvs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:51:48 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35620 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbeKOBvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:51:47 -0500
Received: by mail-it1-f195.google.com with SMTP id v11so24547918itj.0
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 07:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6FnLQUKZxZTB70TbQl3lHk9AqJZYaS5Ypjb6E53I+Fo=;
        b=YWxoB08yobwEILs1R528GlaYFPK1bqgknTUqc0IBkr4vixpf+CUMm2cineao4Bx8C+
         bIaBREI69BaCMYy26tieXJQ02QtCNBragGVoS5jgQNQA3nnl/58SH+DiQH9Nrqph64Tl
         K9oJt5baemSF0RnWkVeodnyRXksJvXkV6ZJZcIGHqBR7qFk9dckjWsPzSe6T9M11BVBY
         boAGn5N+GLc8iUlx2E1/RRRnnnHE7TosaIWkI4kVrLquGhA46idyCHbx9neCQriSNwOs
         34pGwAh9TNa8fLv/aDxaKMbFG0YuWo+3NjbsNU2FlLLdZDJOHYf4fJqPsl9gSW0eYboB
         ZG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6FnLQUKZxZTB70TbQl3lHk9AqJZYaS5Ypjb6E53I+Fo=;
        b=Voqc5A1rxLbe3ALgW4rY8DZvwcvv7/rorLIEmrvpIpswJMlWQfC7yGxfwryMMbyRR6
         r4YcGriDgA1quJ/U34nDioFvEySPW2zHiohS3KByv+KSfbsVrbjd5ZRtFktHchDdfffa
         9tQGarT5brkYtOo0+Dos2gcGzjN9nlMKiBV/F51/yoYzAfzK3TukFGZJQYg7x3SoAZr/
         /ke8UCGn3Bh7rGgbD1a4xiaJY72XeBHVZC/khgqoYdhz/VnkKlywvhHsWlQpQSoz/Qn9
         1an7mWDAN02lDRbziGMii5VDG+RVpzv4e4kj/dyhkmyTYLrxLdxXtkXnqaS6OX6rarFt
         bzgA==
X-Gm-Message-State: AGRZ1gLpMiI8XRufqXgssNfMZxa/dPnyg6l0eTEuFFpGDQe+hft6TzKR
        FmocjfWpEP2B40RwaIn0h/KahRC3awo=
X-Google-Smtp-Source: AJdET5e/qnM4QYgATjHXm6TpP7pXTbTYcz+Ail1lg1yr0DpHRwSOkxRLDPRFGtn0hhNWTcxO8+9wUg==
X-Received: by 2002:a24:7b11:: with SMTP id q17-v6mr2417350itc.80.1542210480214;
        Wed, 14 Nov 2018 07:48:00 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o10-v6sm7648693iob.43.2018.11.14.07.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:47:59 -0800 (PST)
Subject: Re: [PATCH 3/6] blk-mq: embed blk_mq_ops directly in the request
 queue
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-4-axboe@kernel.dk>
 <20181114152053.GA22186@infradead.org>
 <130070cd-e0d1-e75e-4341-7c1b26d1531e@kernel.dk>
 <20181114153948.GA22811@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1bec98d9-c0b1-c14a-8717-59af2e746895@kernel.dk>
Date:   Wed, 14 Nov 2018 08:47:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114153948.GA22811@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 8:39 AM, Christoph Hellwig wrote:
> On Wed, Nov 14, 2018 at 08:33:06AM -0700, Jens Axboe wrote:
>> It's measurable. It doesn't defeat the const at all, the mq_ops
>> is still const and is never modified outside of when the queue
>> is allocated. The only difference is of course that it is no
>> longer residing in a read only mapped section, which is a shame.
> 
> And the separate section is very much the point of the const.
> 
> Without it attackers can easily overwrite the function pointer and
> use it for exploits, as the C const attribute by itself doesn't
> protect from that in any way.  But once it is in a read-only section
> it can't easily be modified.

Are we really worried about this as an attack surface? I get it
for other types of ops, but for mq_ops, I'd be more worried about
callers changing it inadvertently, and they still can't do that.

It's not a huge deal to me, I can drop this one for now and
revisit at a later time.

-- 
Jens Axboe

