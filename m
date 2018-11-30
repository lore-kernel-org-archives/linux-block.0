Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC8C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6529A2145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hHgIlndy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6529A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeLACZp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:25:45 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39163 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeLACZp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 21:25:45 -0500
Received: by mail-io1-f68.google.com with SMTP id k7so4794016iob.6
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 07:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/3/PFvJlpazOJOWevQbL3evmM3qXWcTrnQLe28GLkY=;
        b=hHgIlndy1n34NSV5ZFpyy8kSDaaUOxFdjD+CasU2QWV55gnHIWpwDGLZvpGfU/xoss
         ueXVmmOhQDdoPd3rIZFdx2GB5bTs1tmF1SVBCJICzT0SQI4f8NYp3/REUkz2fOZb0r6R
         aTEa4gSI8T72c2k0hnlrPTuXNVqYb6zCv7D5oIRgSOaa9AowdmjRVP/3hWwobMwDFROn
         sIbVLPnCMzDWvMYlR/Ow4wQVLiUCLkF0P6o86GvkH8T206F/WjPPQjwZK/+aDvrJgqCp
         C/+M0ofkNaoHdFArLLpf9evI+30QR92Tz9kkrNPBpeb8TTQU4LKNq6JVmJmhRfJnLOz3
         mqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/3/PFvJlpazOJOWevQbL3evmM3qXWcTrnQLe28GLkY=;
        b=X13EmRXgSHcR6Lx/SlGNDRUS7kV4RGldcZeLL+PQ6z49p5WR1LPgQBg1g48R1rnfBT
         gsJbigT1Ur6FTHhqmiOn7CNuZKJZ8imy0XMfgQRc8Icb8+AFzE3xO8v2zY5XEvGbxKFr
         k0yEHsX8m492CwEfofIItwF37Q7xz1IGK/TetTiompEpjoLB0W7sFCovA5CUsOKIIYVU
         HaSLMQm6UxYZTE/4godRj7k5Nr4JPpfpfnmKBkh7k/BF5UzkhGnAwZMJxptBbRs5jSW1
         0c6tzPBaMU3//3Ku/8oSrIKOe42eevVnzOKBhf2pOOLYi9Rn6wj4FzIfUDG43QlVB/gW
         NV+w==
X-Gm-Message-State: AA+aEWYm8PpZizDMGlsGwTNKDcU1S3NMqScJS/g5AYAPY9FF8kOm7g5W
        0Sgbhhklh26E8PFsPmuiuRefZ5Q5tGc=
X-Google-Smtp-Source: AFSGD/Vt3PzHfBG9DzPOZ66UEQyEGJNPCw5hDwo8HjPLh67Ss5VRi6MGDrkBouh2jFZwokSpitLbwg==
X-Received: by 2002:a5d:8491:: with SMTP id t17mr2972390iom.11.1543590965415;
        Fri, 30 Nov 2018 07:16:05 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h16sm2572481ith.25.2018.11.30.07.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 07:16:04 -0800 (PST)
Subject: Re: [PATCH] block: avoid extra bio reference for async O_DIRECT
To:     Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <b890e540-fc63-13c1-bef0-1e6a39d1850e@kernel.dk>
 <e834208c-bb4b-820a-28c9-918e92afa295@kernel.dk>
 <20181130083815.GE18936@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d57407a6-f0a0-fc1d-9fc2-4ca721f0b61a@kernel.dk>
Date:   Fri, 30 Nov 2018 08:16:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130083815.GE18936@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 1:38 AM, Christoph Hellwig wrote:
> I like the idea, but I don't think it is correct as-is.  We can't just
> move the blkdev_bio_dirty_release for the last bio into the caller, as
> the completion order that decrements the refcount might have different
> ordering.

Ugh yeah, not sure why I forgot about the multi case for that one.

> Something like the simpler patch below might archive your goal, though:

That does look cleaner. Let me run it through some testing just to
ensure we don't leak or use-after-free.

-- 
Jens Axboe

