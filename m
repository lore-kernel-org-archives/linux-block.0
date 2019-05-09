Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ECFC04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA50F20656
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 16:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hKHWMXxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEIQ4O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 12:56:14 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53672 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfEIQ4N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 May 2019 12:56:13 -0400
Received: by mail-it1-f196.google.com with SMTP id m141so3364858ita.3
        for <linux-block@vger.kernel.org>; Thu, 09 May 2019 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9eabGGW8g/HVj6uA/eHHbr/dDRSlyoJ8bwmYRSJaJx0=;
        b=hKHWMXxRgOkmLfhxGAAOuVuis8vC76C0AkMnmvByWpCXHAVJ4r8VyxJrA4fD1I2oT4
         F9WZJFHs+Tij53IblPl+Og4kPHz4Nn5pXeqeGmViK7+cZ6FCno8fEAJkNmBxznEJjtei
         6qTgHBnEosVafIfVtPxrBn0P4oUCdtAvt/nzthvfvPPFqpASrzkvW7pBQmksT+pvL1P5
         tY4lsFFxt/5mGxPW/80kAR0JebsIsowVzQGJpYyM+5aXEAfYaF8qpP3XQZj9RAfrJLeP
         aK+dxIperJRo10iiA4PtcQwZafEh8OkAGdhLscYJxbOJd0SDTrC/dI1xFDW/zsEgw9+s
         yOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9eabGGW8g/HVj6uA/eHHbr/dDRSlyoJ8bwmYRSJaJx0=;
        b=XYCo0OVFMiIlhf7eotCp/i9FD8pTdWExQ9lS3xS7vvbtFB2Blnoe6w42/mslu8y+SA
         qgZhN4fsNC2/Wx3gKHN96dogA1ir1Kcoh4NhC6haiaP9NLAK41SEijlSmWe+btfZhI/B
         I1sRAFDVfOxIVPm8/uh2/17TU3UzcelYaDixFvM+UEPPLQjyvf04DuP/UMheycDLyKyc
         1vbCbYvgTXdng2GtIZoY8eMhs7wK4hLzIsY+iT8cGF/C9OYNiTafZyh5ZjF18xCSNcF2
         HreKFAig46g9LmKTv5xUUsHViyrVa5KTWcfscSyq1uFfBlPN72IMkwL+5AzeV0NPvkfX
         txKQ==
X-Gm-Message-State: APjAAAWNRY/DZ2vxXcqTCMsLUOQdgz2ZaG0veF7HB97iQn40CY6H0YuW
        T+TfJXUX6Pjm3reNzNxMphMGcnO4dBV5kQ==
X-Google-Smtp-Source: APXvYqyyS3UCRG3CzSkcGt5p9JNdLZ6uyJPNMwbCdYJK5j4ir7keCEVumQU4PWdJ3h+F/GzPCE+QpA==
X-Received: by 2002:a05:660c:746:: with SMTP id a6mr3823712itl.134.1557420972624;
        Thu, 09 May 2019 09:56:12 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q16sm1162570itb.37.2019.05.09.09.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:56:11 -0700 (PDT)
Subject: Re: [PATCH] brd: add cond_resched to brd_free_pages
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <alpine.LRH.2.02.1905091252300.19234@file01.intranet.prod.int.rdu2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <64c82900-aa9b-9093-82cb-30f179eda803@kernel.dk>
Date:   Thu, 9 May 2019 10:56:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1905091252300.19234@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/9/19 10:54 AM, Mikulas Patocka wrote:
> The loop that frees all the pages can take unbounded amount of time, so
> add cond_resched() to it.

Looks fine to me, would be nice with a comment on why the cond_resched()
is needed though.

-- 
Jens Axboe

