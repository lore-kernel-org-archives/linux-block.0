Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35611C04AA7
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 16:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C84208CA
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 16:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbVunv1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfEMQzU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 12:55:20 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:35443 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfEMQzT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 12:55:19 -0400
Received: by mail-pl1-f177.google.com with SMTP id g5so6772696plt.2
        for <linux-block@vger.kernel.org>; Mon, 13 May 2019 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w1WPg5IFBg1nbfNIGkaz5hGNB1drBDudctIx7vYPDlM=;
        b=cbVunv1NJle9cSlyULwQtLo3ZHSvrrOHtSDxbHTWhlNyd+7b3zpYgTh0Oj4BZYnVo0
         /m2VoHQJbyRFszGrOJ+Wzrham1q5Nmx68U19BnES5Vg2ygOrsVCjWcRwamIugviygTng
         zxnlxgMfr41GuyVaZ4lPZkZNLe6ZuJqC779gyIJXvsh885nzpDmw8JQUgg7A+3hiNMhe
         mBPBhZkccpGQKT6ePk4rBYdH2EE5SsHUmfT7cfr10kBxgohd1SIq7RxORVQhCvl7Uz+W
         9gClUddLmqR+wx7SSvzcbUrHI0SuyM8Q29P5Jyss6d+YbVzJ+assIHyGdX44Lsjys4tL
         nv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w1WPg5IFBg1nbfNIGkaz5hGNB1drBDudctIx7vYPDlM=;
        b=XjYJ4tv1rnP30DotY8Zuxls5gaWmwkDGjUy0KYlHjBOZDHZH9OIzDs0IIvGehr//GM
         6HswdX5j6UFv8zBLAFdinIXsCIng2nH2KaKovtYUGMKLeVKFWiLy5qfTX7flz6q5kZHU
         T7mURYcQYeSodWhTkwxsdGl1zOMMvOtNDo3dkUqH4wvlStys0fsV8RGqy5Wp2HxxFCT6
         mYBYkVA0NCITiYRgW00O46VTSW0iKCatHEB/FmXMvHbuzOVjCzBsE9RDRfQD4s+zDlMP
         4ppZ5fQfNpytUOOYx1Xc1J/QhUobW0MM9xtOlDl+SnoodLTfm8hIy8rRkcpW3HV9rU8Y
         1wsQ==
X-Gm-Message-State: APjAAAVtuEnbT9GksM9Wj6DwrvuFO0pgBbqJD8fk0PcMzK4+i1qGvPqk
        yPptP0L4rxSefIY0XQ6jzdoQXarVtZQ=
X-Google-Smtp-Source: APXvYqxwJCuaPhlw5qE3PcdsXxNYSwr640B7X8t0WF++WMZ25A02xrO89fkEtwRavTsGpPhni37d6g==
X-Received: by 2002:a17:902:2beb:: with SMTP id l98mr30159498plb.290.1557766518629;
        Mon, 13 May 2019 09:55:18 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id j12sm17130740pff.148.2019.05.13.09.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 09:55:17 -0700 (PDT)
Date:   Tue, 14 May 2019 01:55:15 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Move tag field position in struct request
Message-ID: <20190513165514.GA7792@minwooim-desktop>
References: <20190428074803.19484-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190428074803.19484-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-04-28 16:48:03, Minwoo Im wrote:
> __data_len and __sector are internal fields which should not be accessed
> directly in driver-level like the comment above it. But, tag field can
> be accessed by driver level directly so that we need to make the comment
> right by moving it to some other place.
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>

Ping here :)
