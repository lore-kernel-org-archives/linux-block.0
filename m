Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B1C7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 16:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEA020880
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 16:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j6LlEfPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfGPQG4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:06:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33352 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGPQG4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 12:06:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so9345222pfq.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u7Jne9Q47nVrWz4TP/HRx+zyw2bqjnPLiRJA58wxBSc=;
        b=j6LlEfPlZaJkswdh3CNoocUKsHhBuzharTmPy44mXWvswWx0VUz0t3ModwJHkAo5ZC
         dGAYrqYLOLEeNs3wmlVg7GguiDrX1hvqg/y14nxQRK+GGCvoG+VzDtZ2hwOs5y2ZgwaO
         rBxu07ZfqHMYAYy9RAWbNdTnOYb5t2Za/6LjhUkA4J/utbO6b6wTRWIYmkeOWI1lDbKF
         tLXIVPHqGyKT6SpjusWHSMMWd2Fkle/H2BkwplrFF3DBk21ngqvwZ3joiBZhys96spbB
         nA79zopXpJx9ow8Cg1H6OZNtKcnoC/nJsaD6z6diVmdVGB35IBs2oivnHBcjRTje3Rft
         eF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u7Jne9Q47nVrWz4TP/HRx+zyw2bqjnPLiRJA58wxBSc=;
        b=uI5G60bGDuOrj5VlKgR3PErv7SXaIf1efypSv1ckail3U378kN4TRRD2XRPXaKYOMw
         XjFT0KSv5AcJd/VcBLH7qYJ/4hkAhRkZ95gYhBLo0K3NhUQAgRe3VO10UqtKcmJI7EEd
         0qgsWWat34zKfbryzbu7aVdwzedR0QURAizGxV+aMelowgkYPrkd4DF3cGtT05kg77hN
         I6C43F7p6bJFfLTnxeT4UY4qdaC1/nvDmblVeC/Ovw+L3VyLKbsX5NjWn+TbYVVuWQvm
         BUNd61iaF0pDjxk2mjJ0ESe26n7SXlPXu6Qbq34e3/1t4akfRjopudAKQYpuNes3N/A4
         1LvQ==
X-Gm-Message-State: APjAAAVOWhNyEJH4sC7Pbn76Mg4IaAaK93vU+p8OPMrLz9H7f93Mieqt
        QojA8DxjxBhyZvCBM1p8W/0=
X-Google-Smtp-Source: APXvYqzZEHBcJBQImE+MN8epzusmvGWxzBljoySzUhUhW3SvZz6HFxvRHP4sC8GOmqWanvyI9qT+TQ==
X-Received: by 2002:a63:d756:: with SMTP id w22mr34233100pgi.156.1563293215324;
        Tue, 16 Jul 2019 09:06:55 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id q13sm20170598pgq.90.2019.07.16.09.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 09:06:54 -0700 (PDT)
Subject: Re: [PATCH block/for-linus] blkcg: allow blkcg_policy->pd_stat() to
 print non-debug info too
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org
References: <20190716145749.GB680549@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f0b11b1-275f-fdc8-51c6-452a727d5885@kernel.dk>
Date:   Tue, 16 Jul 2019 10:06:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716145749.GB680549@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/16/19 8:58 AM, Tejun Heo wrote:
> Currently, ->pd_stat() is called only when moduleparam
> blkcg_debug_stats is set which prevents it from printing non-debug
> policy-specific statistics.  Let's move debug testing down so that
> ->pd_stat() can print non-debug stat too.  This patch doesn't cause
> any visible behavior change.

Applied, thanks Tejun.

-- 
Jens Axboe

