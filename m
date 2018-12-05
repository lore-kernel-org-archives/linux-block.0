Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBDDC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 19:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E621F20850
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 19:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sG2soLk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E621F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeLETJw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:09:52 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:46310 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLETJw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 14:09:52 -0500
Received: by mail-pg1-f182.google.com with SMTP id w7so9432688pgp.13
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 11:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xjjm2RU7Q087Sab0iKT4dc2Jla5ZXHJpbB60VAucxDk=;
        b=sG2soLk3RemQgCVb/Xh8lc6NCYbKOF20QlDQ+3wRYssg6Vrus1lQaLU/ER1h3qKqBQ
         PZ3A04ZPnzEhTPEXVttELHo7hfcHNGQiI9lHVpf2cDnzW/YmlfiDjq1KZ2rkhfnq4B0n
         aMqenH1gJhiN8dAd5gBmkmIX4WGyyQfzW7GTN5BWuYRf/ayegckcoJdu9NXsLHnWAN4g
         Q6kEnM2n6aGdVuJSQYH+QcEYBobxMSomS814x0gBaRBQL5fjt4SVQRUH/hPioQgUG6h7
         kRB/fP7gy4h9JLMIA6cS7xMhIvllwj/TfatquUrHxLA4dW0iUiSBdUPLmeN5j56dOZHB
         Z2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xjjm2RU7Q087Sab0iKT4dc2Jla5ZXHJpbB60VAucxDk=;
        b=hwL8R6p5zVK+xmqSnLXCk/lltBvq47wWlEHBeXfVRXA0fPYI+gIE/8L9ONMjgQa/E7
         ACjZnxGwRRzAAN3G+liKOiis9G4M+TCmuG5mHve5HkGfu4zBsxB7E/JRM1Yqbal/dW/Q
         dLKs4QGM5rwdDNu832qDp87EgHMuykrCqDdUwzEKyzWDuGdEJINoilEoOiug1WkXVpeY
         6nCY/irfxU+vmHBe7FR07Lg60GvC2wyfBefJiod+Bq9QqpVa47R/+0fCd+uDXLQ8HYZP
         2Grdsxp+lnCq8i7R1yxJMmxmypWJOay1weaN3ByUUUlXXuyMGRRYbeXA+lGoaiwKLdRM
         KSGA==
X-Gm-Message-State: AA+aEWbLLMuSX2sx1yxLUGWR7zajisxwAFQGiiesBLBYpuFy/Rql28Aa
        VcCyn/GJU4YYN32toaTTfTdnrtXZ
X-Google-Smtp-Source: AFSGD/VqMVNWbTVIMvjarFtlA0N4zIQf2g/SSTzWvJsmyDbmeaZ5kF5HTwgvrHqwu/NgPpG9XlbdMw==
X-Received: by 2002:a62:e201:: with SMTP id a1mr25038656pfi.75.1544036991775;
        Wed, 05 Dec 2018 11:09:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y1sm28164406pfe.9.2018.12.05.11.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:09:50 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:09:50 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
Message-ID: <20181205190950.GA22671@roeck-us.net>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205013821.GA19605@roeck-us.net>
 <7aa746ff-58ab-e0e9-7058-3086a7f19c47@kernel.dk>
 <20181205175554.GA1810@roeck-us.net>
 <82d71778-c89d-7b95-7ebd-addfd0b5fe8c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82d71778-c89d-7b95-7ebd-addfd0b5fe8c@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 05, 2018 at 10:59:21AM -0700, Jens Axboe wrote:
[ ... ]
> 
> > Also, it seems to me that even with this problem fixed, blk-mq may not
> > be ready for primetime after all. With that in mind, maybe commit
> > d5038a13eca72 ("scsi: core: switch to scsi-mq by default") was a
> > bit premature. Should that be reverted ?
> 
> I have to strongly disagree with that, the timing is just unfortunate.
> There are literally millions of machines running blk-mq/scsi-mq, and
> this is the only hickup we've had. So I want to put this one to rest
> once and for all, there's absolutely no reason not to continue with
> what we've planned.
> 

Guess we have to agree to disagree. In my opinion, for infrastructure as
critical as this, a single hickup is one hickup too many. Not that I would
describe this as hickup in the first place; I would describe it as major
disaster. I also don't think the timing is unfortunate. If anything,
it proves my point.

Thanks,
Guenter
