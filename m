Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4518C5B578
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 05:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994F221880
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 05:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VokoY6Cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfGCFXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 01:23:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35109 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfGCFXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 01:23:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so581840pgl.2
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 22:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wbJLJr+LftNrRMBmtB6L1VUb3NewH8a2FnxM6TW6xYE=;
        b=VokoY6CvK9PFyIEjkpHMV6SvwB2OF6rLhDiR1Ev6ejZantw06C6Qp8pq5hxr5ZgCB6
         dbj/Wy6E9lhPXM8DviXjiGqH0L3cwZJvOQIrHLx19NJZWBT8CKb+UylqSXVlZTB8j9a0
         Z3Nu0r1pO+0DidaB2Uy5g4Lk8RAH2csjj7iMFyN76DDO33PQJ4stzoBC4vWLvPlP1gLQ
         CO9TKK8fXEieP7XpLt5xqe12C37NoXBg1SZatvOLteieDzhp2PhBQccUWx9M5kIanPXE
         2LvEBFnZdZMEHVbFPjwe0ZG9SkewTO6tx/ADKyyfJjiG3T7wRosWt+f9wOnZgk+FI+b4
         1u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wbJLJr+LftNrRMBmtB6L1VUb3NewH8a2FnxM6TW6xYE=;
        b=MG1KjsPvEPyX8R8Ybpsx0tuM2IHsLwYyS8HuQ+QYjnOOtYlLC2Pqe56TbDv/A5r9yP
         CTXuLtIddcvR6EOWiSSiXQhLPqUfE4ff0jrhS5ifmiL+vUFBbRWaiPIR5G1tZC0tJOFT
         44+RR1kaBShRyNB8+nlMX/2FVHDW8/NpTHZyKijADNyn11WWHrQV36MX+rxoSu3MTvbv
         4sneNUubWbcII+QOAQd/vl9OyACcw2S1Y1CD/HL2YwrkOVtN2sxLa0uokVJ+kD0VwZph
         ex9wHcFzlQgPmR5fWyPDbJk17h2VcUTJ8bv/HsfHrm/aXu4BWS2Dusc9CX773LZQEWsY
         nzRA==
X-Gm-Message-State: APjAAAUTqNJX2S4Rl3vpkf4e0bnevESgyZrcFM0nEKsIr6wiOu22UC9f
        yVSU7D6m3Lv6eLyQsPV8t0k=
X-Google-Smtp-Source: APXvYqw5i9KlT/XMHEJyF4p6kf1AqnQzLuHbE+dnWOGLibkxFyFkhJfNJ6kMGjNGZqLMBnA9qzm7KQ==
X-Received: by 2002:a63:fd0d:: with SMTP id d13mr35948215pgh.423.1562131414153;
        Tue, 02 Jul 2019 22:23:34 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id b6sm825419pgd.5.2019.07.02.22.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 22:23:33 -0700 (PDT)
Date:   Wed, 3 Jul 2019 14:23:30 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] null_blk: use SECTOR_SHIFT consistently
Message-ID: <20190703052330.GA21258@minwoo-desktop>
References: <20190702202857.4433-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190702202857.4433-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-02 13:28:57, Chaitanya Kulkarni wrote:
> This is a pure cleanup patch and doesn't change any functionality.
> In null_blk_main.c we use mixed style of the code SECTOR_SHIFT and
> >> 9. Get rid of the >> 9 and use SECTOR_SHIFT everywhere.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
