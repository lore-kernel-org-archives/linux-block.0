Return-Path: <SRS0=mx3V=TD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16045C43219
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 17:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D091920B7C
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 17:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zLVqL4Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfECRwH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 May 2019 13:52:07 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:42402 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbfECRwH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 May 2019 13:52:07 -0400
Received: by mail-io1-f46.google.com with SMTP id c24so5827760iom.9
        for <linux-block@vger.kernel.org>; Fri, 03 May 2019 10:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5tLf9LDYioK554+ON8w3YzbwQ/QFKLjlpCLcePoWfbA=;
        b=zLVqL4QsJx+g2NU0yqtft0Al6ojqusPb/pwgoDS2FhXG+ca/mDErQWsAzILysRBap6
         nhhu0p7n5bGh0Wrq5z/8Y3lWi+QImZsDtweHggTyaUo+JkRu6cqn8XxtPEZiBkY8c2An
         BOEjO4Gs613a5TkX/HvkajJjAfUtOiQ7+b2Je/tU5qeyA7RLNhsQNBNHvlhVVUAniBO0
         8u+WPgiZNWV45QFZqIaSWYk1IvXHJL7MQnyeWcxP1MKQacPPj8OUpkaa6nfm1MRseUNe
         vPeBoduYax+g9xPA5gb2edbI02AkxRYcj3h9AG/oXOvjMmiP9ZHd4UDiihsTjJ1k3PSN
         zkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5tLf9LDYioK554+ON8w3YzbwQ/QFKLjlpCLcePoWfbA=;
        b=You+5Yg3Ry5387YxvW9RBc35jAkDHn3ncDOVxm8EuP1yc9a0Go28Mji1DwD6bL0S4q
         4F0Rlx+n9Te7N8H8L9SwhYt7DbKw6rCxlKF/HZjNSWPo1G2HdBmsEGllCwEydaDdniy3
         xuwWjOPDZOcvo8vhijup9xVEu2R92ltW49eOKXrQ0iNexkNx10C5g9b3/bUYwoKpQKh0
         UU6BQEzZfisDnYMdM53mhTuyoSIB6ln6tPJb3C+kPtNS+NcYyTzM5s76NB0elUv+rO5L
         X6kUBpcz3bDCBuuKpDMR8rC6tEGOTf7Gvif6dm5WC407WAxebeMYg7SFtVhGfN1TNrPI
         oKvA==
X-Gm-Message-State: APjAAAXxF/jexLE0yxsVWHn6k/1xGr9MmsDnPaMrnghaBvcVJ4gEUBLX
        JyxPg7fbh1t9FOH40TMKkwkfpdVNc8BUjQ==
X-Google-Smtp-Source: APXvYqz2r96Luv70UQxR72wspsED0ZScZETkaVS4/yEGsuH/iZOxZ9/kWKHKJPyNOi2K2IfRv2vH7g==
X-Received: by 2002:a5d:930b:: with SMTP id l11mr8060743ion.216.1556905925244;
        Fri, 03 May 2019 10:52:05 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id p132sm1654042ita.2.2019.05.03.10.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 10:52:04 -0700 (PDT)
Subject: Re: cleanup bio page releasing and fix a page leak
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20190502233332.28720-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1a412fc8-0996-912b-2121-9427f91c29db@kernel.dk>
Date:   Fri, 3 May 2019 11:52:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502233332.28720-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/2/19 5:33 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the various direct I/O and pass through
> routines by switching them over to common bio helpers.  For
> the block device simple case this also fixes a page leak
> if we were using bvec iters.
> 
> The last page just unconditionally applies the no page ref
> behavior for bvec iters.  I looked at all the callers, and
> there is none that drops the pre-required references before
> completing the request.  Probably not suitable for so late
> in the merge, but I wanted to get it out.

I'm guessing you'll spin a v2 of this due to the issue that Nikolay
pointed out. I'd suggest we then just queue it up for later in the merge
window inclusion.

-- 
Jens Axboe

