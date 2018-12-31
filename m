Return-Path: <SRS0=5hX+=PI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289FAC43387
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 17:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F7E20643
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 17:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cQxxOZCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeLaRUO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:20:14 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:35807 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeLaRUN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Dec 2018 12:20:13 -0500
Received: by mail-pf1-f178.google.com with SMTP id z9so13401532pfi.2
        for <linux-block@vger.kernel.org>; Mon, 31 Dec 2018 09:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CrRXlUXUMQ3PiwDJSYk8y5FlbmGKwKsCyEHZvxkLc2o=;
        b=cQxxOZCHgV6rA6r995YMSNVHFsSdK+D4CBfYvTCmqGXZuWPByTqbyyeeT1xMG+pDrS
         dWTNWFHkMu3BTl32bv08/pk3uiDi7Svu4l3Sme52SEQRjAuJZtKrzGslbtZj64cwXsnu
         yWYRSnmw9f+isme7NvdbBvyw9MonmDt/bRM8RpFOURNCVH2scRdd5Ce0U1LBUy0aFfNJ
         3l7HgeG/2l4TPFc+inWocHe3YwdtEzb+dKJPyFsfcUZ88tSOTeSTd4RNvccE9omimiOw
         DJU3cP3hDZ+XvlWkrNrc9xvbtfz1zS+VEp3IctIqyLiIN86KJo2q/UXpPsPswYx2Rc05
         l3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CrRXlUXUMQ3PiwDJSYk8y5FlbmGKwKsCyEHZvxkLc2o=;
        b=Xe/V9WAts49khyeATdVq5EOcTYdV6s3AQ07IQqgRpYlU0bK0gM+3/GKl4Zc561ICa9
         o5QLXLs0BkZ+zafXHNtHMA2oUoZnFZ/zf3P0RiqFCTMt9G6v7cQNzIXdpsxuYUZgOl/k
         GroF8IMjwzS1gBjMqRRYaSsAM3012B7uFofqTTtzrvpFMGfFClMh95D4XwKnYJO8KtVf
         QnNmJExLo63HW0rIT7FDTCkDSGMyREDetxexkuSxhGrJ/IK/xpo08kJn52jGNgHdkNVp
         oNJ5eCbCyh+U5jFUpZEjQ3j5ylUeh7C1T1XZega9UdT0pc3uEeii1mSzh4kLKpj+W/mQ
         eaDA==
X-Gm-Message-State: AJcUukfhzkhAn1FR+cir/MG+HB1h3z0qbS18WHz0i2EeDkJtoMyHp7jP
        hxuBCMhgO8aj2ioooQ5Rr0jXCw==
X-Google-Smtp-Source: ALg8bN48Oa3BqrebUL5lsXlr98IU7W7wUFwX4ylU3AMxbf7hDbUhCy3fa9njgk8XKsvJPgJDkHLmoQ==
X-Received: by 2002:a63:9e19:: with SMTP id s25mr8190242pgd.203.1546276813251;
        Mon, 31 Dec 2018 09:20:13 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p6sm66153028pfn.53.2018.12.31.09.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 09:20:12 -0800 (PST)
Subject: Re: [PATCH] block/swim3: Remove dead return statement
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f84a43669647c55b91c2a46e7876d8dd2a713c8a.1546235049.git.fthain@telegraphics.com.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7846fc4b-2cb4-bc07-4dc0-cc8c9ce2d00a@kernel.dk>
Date:   Mon, 31 Dec 2018 10:20:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f84a43669647c55b91c2a46e7876d8dd2a713c8a.1546235049.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/30/18 10:44 PM, Finn Thain wrote:
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Applied, thanks.

-- 
Jens Axboe

