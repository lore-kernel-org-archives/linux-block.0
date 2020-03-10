Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB590C10DCE
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 20:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F1E215A4
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 20:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GOqnAI/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCJULx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:11:53 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34334 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJULw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 16:11:52 -0400
Received: by mail-il1-f196.google.com with SMTP id c8so12843741ilm.1
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2020 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XCqf40GUhK/TZ0i/ss/XymrIME6RYC2/9jBGUr6tadQ=;
        b=GOqnAI/TKiv7VDWSuouVJiN3pz8paQm95zjfldi79U6wK9ec8bwf4xR4P1qPu4JIMc
         78OByHxZQi/jjjg5QHMxvA3GsdCzeEPiaABuF5agJawfOVAoZ75RFd3czGTiqQr9icvG
         SfxX8Qjr7xDOl1C9UIXvcptcvDxZrpwDMbbwbXJcsno8q1eeUJQBIzBAZCsiiPcL3zjT
         VCkAhjwbpYfylNlY++pQqZgc9ClwQ/cgR5cYBo9QiqtNTrpqQj8ta7uhovNxGwV/GBwE
         ub+/LrnXLK4TFPfPu1JcSVKcrqQ9tGmrCas3YkxxquYmNIRC1iVG4v4THRgi+URcoDK7
         gakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XCqf40GUhK/TZ0i/ss/XymrIME6RYC2/9jBGUr6tadQ=;
        b=HgHg/7HLpXanvT+rwmukaE2uarPm+xEVT8Fr1sE+0vua+/TuWjqPP2uEJU/UV/W02Z
         SzG8mrv6THfHMWimMd1/9AvB8wMGZiu4cC/0QyopD7IltN2Bd7Sh843II79eQn8J9cN2
         /ZkMFavq+Opr87ywkv2wfgaaYub3R5fcbnb4cQ/MB3NmE4139jd+/HYThrRSnGe/rVVF
         iWPxd7M8GknRniGcjntKNM26nD7iHPO8YGpX4HbpvjBVReF9bGnP2EiNBNxzb6gypILO
         lc16u6gok4TI9tS6ZeeOxA8vDkp8l808RuWuXl6PrdM+WNgfNtEESqzVpfQdHdG9+btJ
         TYWQ==
X-Gm-Message-State: ANhLgQ2K6B8PkI8Cw/YmZkIT3T9cWKaXFwXbFYlgx/MQW978Fzd1MUbZ
        vf3Vv7sDP+RSaD5Bc8bc8Zew1A==
X-Google-Smtp-Source: ADFU+vv8bm/Ll9GDrFmKUaFxorGsol1kTk+OiVKDb35jovd/4Q9fWSF6bR62R/8r9sLXtLSdp8Wsqg==
X-Received: by 2002:a92:111:: with SMTP id 17mr20596998ilb.158.1583871110589;
        Tue, 10 Mar 2020 13:11:50 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t24sm3887552ill.63.2020.03.10.13.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 13:11:47 -0700 (PDT)
Subject: Re: [PATCH] loop: Only freeze block queue when needed.
To:     Martijn Coenen <maco@android.com>, hch@lst.de
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20200310130654.92205-1-maco@android.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd6af0cd-24b9-4c46-01fd-aa78f7714350@kernel.dk>
Date:   Tue, 10 Mar 2020 14:11:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310130654.92205-1-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/20 7:06 AM, Martijn Coenen wrote:
> __loop_update_dio() can be called as a part of loop_set_fd(), when the
> block queue is not yet up and running; avoid freezing the block queue in
> that case, since that is an expensive operation.

Applied, thanks.

-- 
Jens Axboe

