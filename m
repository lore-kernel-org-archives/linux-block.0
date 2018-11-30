Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C59C04EB9
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 02:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10CE2086B
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 02:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1ky3aLh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10CE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeK3NRf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:17:35 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:38370 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3NRf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 08:17:35 -0500
Received: by mail-pl1-f169.google.com with SMTP id e5so1991005plb.5
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 18:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=d86IAlfhR+YMzqT/RjG1Ttt2JYdSJhgP7tt7ijMQb/8=;
        b=1ky3aLh/bfnvWr/T+zbZ8jivL0TnyGh5BvuASaqUXxkkcIxCBuoNuJ9Mf3QxWWJNRl
         ohiSzD0N0OUPVLzkweBtb0KyRtHeZdUJ0NLyKeDOVrktpjZrrmC94diaqyPmCoAiQnzz
         Jx1uyuCfmkI9/uJuIlXTsnV+KeVDzdHYHFnhFmL3+u5XpJA4Tw27BCLBXOA/pCCZ9/iK
         CAiuKlsD3KanwHHA2yUnnJQZq+6iK5IrwFQO+Y7owa7e6tfbTxNDa32hCW1dYkWfv3Xn
         uwO6D5sFtpV38suyn8SMeO/8yKeLse285au01KHOcfWnr5gOmJMte44X45Byc1nG9lp+
         aL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d86IAlfhR+YMzqT/RjG1Ttt2JYdSJhgP7tt7ijMQb/8=;
        b=gMHKxbAhOg6RvPgIsyTNtpqG8K6gkZ2khI7NbaJGfGQojNmLE0h3AMC3D/H8kB7IAn
         yWKptIA2DIGZJqxTFMOIWKhnABBQQ4qQCenjZ5wIw6tCtnWuA5g6PZ8s3BgVVc0MWI1t
         /Ylok2HgjnzscpFJ70uMDei3v9yITJKDIOZwQzpixDD+sjHebs2xIbWtedyUX37YhPMI
         6+XAgHHOXoGcJzX/3waAXaSow9uSggHVorR2eODAn6bGU4zx5E91sryPY2/QYzKdsALy
         HzV/uOn17m8LE9OtsdjBGYdAl2sbZu4uG7jI4cgNld40yUdoPGD2EXRP1SLi/RLIK42S
         k22g==
X-Gm-Message-State: AA+aEWbh10gJDHohfpUp4U5Xf/fojcs1ODqPGoX1tATxJmIRRnNpYHIG
        sVvjkSS/z/6Ak+4hPkleVVDjuA==
X-Google-Smtp-Source: AFSGD/WMFT/BPk3WSpHLXGtBFPIqTCqhAqR3MqxMKtd9sk7UsdRb5ifuawrRrK6uZSF6QZNvT3y4TQ==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10mr3865988plx.232.1543543797776;
        Thu, 29 Nov 2018 18:09:57 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 125sm4927082pfx.159.2018.11.29.18.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 18:09:56 -0800 (PST)
Subject: Re:
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, osandov@osandov.com
References: <20181130011234.32674-1-axboe@kernel.dk>
Message-ID: <894545b1-69f9-b60b-8ad9-8373b6d12b2e@kernel.dk>
Date:   Thu, 29 Nov 2018 19:09:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130011234.32674-1-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 6:12 PM, Jens Axboe wrote:
> Three patches here:
> 
> 1) Ensure that we align ->map properly
> 
> 2) v2 of the sbitmap clear cost ammortization. Updated to do a wakeup
>    check AFTER we're done swapping free/cleared masks. Kept the
>    separate alignment for ->word, as it is faster in testing.
> 
> 3) Cost reduction of having to do wait queue checks.

Ignore this one, see v3 posted.

-- 
Jens Axboe

