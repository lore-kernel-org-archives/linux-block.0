Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5F9C282DD
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3669B2067D
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Q2qZAhDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgAIO5Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:57:16 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:39066 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgAIO5Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jan 2020 09:57:16 -0500
Received: by mail-pg1-f169.google.com with SMTP id b137so3336083pga.6
        for <linux-block@vger.kernel.org>; Thu, 09 Jan 2020 06:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OLZ8zpoL3yKEaow0R2WCA+SOd8MDP5RNXXpGYoprVL0=;
        b=Q2qZAhDacPm100CQkCI+tdEOBrAYsGkZc6Wx6yzRQcKD2qnbXroA5b0ABgRWS+wNCV
         NGoRTJdx7XhFNppcDzEfRQ1DrSUGGTz13iIN7o4lWPYjjhKrZCV3xirK2GqBlUV6dCP0
         55UAtoB2rizMFnnaedXW62dofnuyNZmHB6BaPhUXUDtZe9Q2kFSqf7fdEcIi+DilR48B
         hZDgRkmEsCeJPuhQ0NB97Tfgt0peAemP0VJBsDF3UHJnZRyjmLV0ZfWgBEb8bR0vZUDH
         RfYYCu7WGaVqGx5gwu0CX2ATLIOewCDvkveUB4RJy3+TKr572MNSSNYlVRLmn9NrrwWI
         aI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OLZ8zpoL3yKEaow0R2WCA+SOd8MDP5RNXXpGYoprVL0=;
        b=Fi3S3B+ezENDu1VcePX5R9lWia4tPQQmPgQh39UEHKyrHXBB93zQy435+wghyJD/1P
         9+tlcFFUwnesR2W0NIFdYLfypoIATfhF21WHdZfxNr5YaktBusKz+Lm5V6aGFlbOMYLE
         1as+sUKH7foaR+fjlqF8U9/pjli/S3nBPfJss5cPF2UnIkUai5vG20KYZDVamGuqnC04
         td1DnnTQkB+JE1rzmUC+fofdngAARuQuO+0e1BqwrCInYwGZX1NrN2/TP/2a2Rxdw189
         JknvYjS5GtYiyqGH5X4E/vUEkFGcn8DAM9NQhN5saMGGO/blNSSQ99yJGIAx4K7URvrz
         Z6ZA==
X-Gm-Message-State: APjAAAWFb0ixW4ll43O6O3xOORZp9HiwI2Q9foYJmgiFKf/dxLr9rXvN
        hSHamZC4OErKBWYCQHQtOPDNli1L2TI=
X-Google-Smtp-Source: APXvYqwF20PFx/hSB4pvuAn2hKbjslSzrrOpzcBuTOXpvaPx6a1jIySh4+It/KMV1hPdXOK1eA3DPw==
X-Received: by 2002:a62:e908:: with SMTP id j8mr11481942pfh.55.1578581835547;
        Thu, 09 Jan 2020 06:57:15 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g9sm8395554pfm.150.2020.01.09.06.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 06:57:15 -0800 (PST)
Subject: Re: [PATCH] block: only zero page for bio of REQ_OP_READ in
 bio_truncate
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20200109085640.14589-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <903757cc-3166-7a8c-cd69-518f9e02a593@kernel.dk>
Date:   Thu, 9 Jan 2020 07:57:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109085640.14589-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/20 1:56 AM, Ming Lei wrote:
> Commit 85a8ce62c2ea ("block: add bio_truncate to fix guard_bio_eod") adds
> bio_truncate() which changes to zero the truncated pages for any bio which
> direction is READ. This way may change the behavior of guard_bio_eod(), so
> change back to orginal behavior of just zeroing bio of REQ_OP_READ.
> 
> Meantime add kerneldoc for bio_truncate() as suggested by Christoph.

I'm going to fold this with the previous. Applied, thanks.

-- 
Jens Axboe

