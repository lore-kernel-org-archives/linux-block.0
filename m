Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C589C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22988208E7
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uWPBgLNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22988208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeLEULh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:11:37 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:46780 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLEULh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 15:11:37 -0500
Received: by mail-io1-f50.google.com with SMTP id v10so17711811ios.13
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 12:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BXEfM7BnvKQq16L7ALMfZMO2cqJOcceB/9dFNXgLrMI=;
        b=uWPBgLNlzZb8LhQImUhOlBlwdVjwTVPxF76M556d0vxEg/jM+VXRsoyaWUDvgwxKSu
         0HMftwtXF3W3RMcOYR1ia49YSiMVWdUxZXBuV0rrAIjvvp5+AbdlitEoVpuuEtcfIGKT
         LqxknAZrJcQT2cag21k1IlvmGkUueYYZPwPJZ5eGoxQMfokpgI26x3/aXc4L0m/wgdB6
         1gVMp75jkQ+nI0jwpip3c5XXgj7nPkmXqPu0gtTlHxSzeG2w/gbcRnB4n1AalJXuU5G2
         hPDV+UdAv5DojJbUVWpPyRe/Qo5Jj67dz2ICJrO+l3GoeYXsbjb++E7WmrSdBx2KtxoZ
         Lt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BXEfM7BnvKQq16L7ALMfZMO2cqJOcceB/9dFNXgLrMI=;
        b=eouv+f3K9sHmNZH8RjWDTqM7gr2PRWPfzwhhZCyKlXCyYhor2KY1zad32kS1virBNl
         En+/3hgJCJ2p9Cho380h868mpI24xFOUuBybHL/RQR0QXkkptU7j+1p0xnOuXJEBl6s/
         97C7N+pWuFHSZw7j70laP/0tzSKhU6ze3ZCWfpiq2BQasBxLTYKM1Sww0uXEqOzODClR
         iSDaMW+KooCOyezdSLUcqJlAHZTQCd235eldCNb0mGN+xhTLHOeC6CySPy/eXRgFheiO
         hNRrVqgWtmZohf3EOpVcfmO6Ens+e35ljtRJpLHK+dGVR0uHBF1nuvpyy1exouwYRKeR
         J5Tw==
X-Gm-Message-State: AA+aEWbcAWT0OBeApdjsA865Of5HL6O1S9mi7MIMmi4Cg1F/UST9+/kt
        eTlvTGWwWpRmjPBD0J4iPKiA/0gytM4=
X-Google-Smtp-Source: AFSGD/VmzwHEIIV+pTmVr/Ru97aiMy/N/iC3Ry+htjx1v61SCdE4nU8SN2aplReTBfry1iZe7GTMIQ==
X-Received: by 2002:a6b:b717:: with SMTP id h23mr20968416iof.14.1544040695779;
        Wed, 05 Dec 2018 12:11:35 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e189sm7416095ite.17.2018.12.05.12.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:11:34 -0800 (PST)
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205013821.GA19605@roeck-us.net>
 <7aa746ff-58ab-e0e9-7058-3086a7f19c47@kernel.dk>
 <20181205175554.GA1810@roeck-us.net>
 <82d71778-c89d-7b95-7ebd-addfd0b5fe8c@kernel.dk>
 <20181205190950.GA22671@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <43e9c9ef-840b-bf15-6784-cd0b9d943ad5@kernel.dk>
Date:   Wed, 5 Dec 2018 13:11:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205190950.GA22671@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 12:09 PM, Guenter Roeck wrote:
> On Wed, Dec 05, 2018 at 10:59:21AM -0700, Jens Axboe wrote:
> [ ... ]
>>
>>> Also, it seems to me that even with this problem fixed, blk-mq may not
>>> be ready for primetime after all. With that in mind, maybe commit
>>> d5038a13eca72 ("scsi: core: switch to scsi-mq by default") was a
>>> bit premature. Should that be reverted ?
>>
>> I have to strongly disagree with that, the timing is just unfortunate.
>> There are literally millions of machines running blk-mq/scsi-mq, and
>> this is the only hickup we've had. So I want to put this one to rest
>> once and for all, there's absolutely no reason not to continue with
>> what we've planned.
>>
> 
> Guess we have to agree to disagree. In my opinion, for infrastructure
> as critical as this, a single hickup is one hickup too many. Not that
> I would describe this as hickup in the first place; I would describe
> it as major disaster.

Don't get me wrong, I don't mean to use hickup in a diminishing fashion,
this was by all means a disaster for the ones hit by it. But if you look
at the scope of how many folks are using blk-mq/scsi-mq and have been
for years, we're really talking about a tiny tiny percentage here. This
could just as easily have happened with the old IO stack. The bug was a
freak accident, and even with full knowledge of why it happened, I'm
still having an extraordinarily hard time triggering it at will on my
test boxes. As with any disaster, it's usually a combination of multiple
things that go wrong, and this one is no different. The folks that hit
this generally hit it pretty easily, and (by far) the majority would
never hit it.

Bugs happen, whether you like it or not. They happen in file systems,
memory management, and they happen in storage. Things are continually
developed, and that sometimes introduces bugs. We do our best to ensure
that doesn't happen, but sometimes freak accidents like this happen. I
think my track record of decades of work speaks for itself there, it's
not like this is a frequent occurence. And if this particular issue
wasn't well understood and instead just reverted the offending commits,
then I would agree with you. But that's not the case. I'm very confident
in the stability, among other things, of blk-mq and the drivers that
utilize it. Most of the storage drivers are using it today, and have
been for a long time.

-- 
Jens Axboe

