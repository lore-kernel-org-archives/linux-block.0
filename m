Return-Path: <SRS0=fNpn=NX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57D4C43441
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 15:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8924620815
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 15:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U7aBUq2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8924620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeKMBXF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:23:05 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37294 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeKMBXF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Nov 2018 20:23:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id p6-v6so4523558pll.4
        for <linux-block@vger.kernel.org>; Mon, 12 Nov 2018 07:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j8r0KczbHo4iyYzh/SvemXOiJhpeCRZvUkvetVtR6DQ=;
        b=U7aBUq2xJNlX0D122a93kiPQ79uwav1vZm4sGa29VqRV3EOSx8fVcvYm34QXZwLxot
         +BoaXWqCwwTleR6xLIE/5L8fvuNuZNHQ2FjE4zEPb6hklGpSes5CE0TNSK2NtzQ0qaxb
         KHl1QNI2B1kEJ9P65i80DAOmrhVboHqsJWWpHNTE9bbmV/J/s+UsSKFJVoy4M9KcKqxu
         8Yc8BDJqaFA7zp84mYtMaa+9zqlOreLPA2S9uh8B1dmG1Ni/Ez9KHP10ZblISVAfjxRu
         w9EpAIb0KFFbdqLdGGyypr+kis5Vts9dPfjHzjxNGrKF/Bb8CSnglQdVnoQQIHW6j1GE
         prWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j8r0KczbHo4iyYzh/SvemXOiJhpeCRZvUkvetVtR6DQ=;
        b=LUelubk9u5TLJhJ8UXou67rmhqoaKZ9jXghZBKDAsCpMOjwCi7IOc5gSUohGaV8kNu
         4NjccbQ2jawdEPMeRfLqp6ImUacS0Tw/6kCYC8ddFZj9TOeQLk3Mrg1RgzBWiyOmb6BI
         ySk1SMn+eIwAHFzlmFAKGJT9EZO7eAThlahwHXK2muwx8uhuEvSMeW4wncyukK8tS8Ic
         sKIsSvY4WNnZ2PUu/gUykR8y3tphj8Ie6VbK2NWBFgLooPdoc5UNFaE1DzpyTcdtqUyQ
         Utie67mJnmwUus2GrLbpzfIxj/ZWIQ5O1uDkjR9Wpj/AvfPyhvoPi348nHn6K6lzHO/Y
         X1RA==
X-Gm-Message-State: AGRZ1gLXqVBKTuZ9H2iOpUxPzqCPrnnqiiNZ0EUV/I3+WdmyNHCRDXi8
        RJUeOH3UtLc1KMpImotsXbB21w==
X-Google-Smtp-Source: AJdET5fFZ6alXaHkOz1PQxHe4y/BMhkvVpwfo3urKEwo5ZXjfUFXIOZ70KuOKM4SDtlQ0PIuzC4YZA==
X-Received: by 2002:a17:902:7603:: with SMTP id k3-v6mr1363745pll.98.1542036561984;
        Mon, 12 Nov 2018 07:29:21 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e23sm8313871pfh.68.2018.11.12.07.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:29:20 -0800 (PST)
Subject: Re: [PATCH v2] kyber: fix wrong strlcpy() size in
 trace_kyber_latency()
To:     Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Jordan Glover <Golden_Miller83@protonmail.ch>,
        Bart Van Assche <bvanassche@acm.org>
References: <7cd2a3c7ceed5dea16bc4ccf8edad77e90a49e7a.1542010053.git.osandov@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <81f37068-4e6b-0d76-d547-932e4ea4a916@kernel.dk>
Date:   Mon, 12 Nov 2018 08:29:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7cd2a3c7ceed5dea16bc4ccf8edad77e90a49e7a.1542010053.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20181112152917.w74rzqU6CulQOtVKxmtx3CKiYuDk39lJueFP2Fv_fvg@z>

On 11/12/18 1:08 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> When copying to the latency type, we should be passing LATENCY_TYPE_LEN,
> not DOMAIN_LEN (this isn't a problem in practice because we only pass
> "total" or "I/O"). Fix it by changing all of the strlcpy() calls to use
> sizeof().

Applied, thanks.

-- 
Jens Axboe

