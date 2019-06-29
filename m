Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24C1C4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF5E214AF
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vuZ4KbCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfF2Pgu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:36:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45125 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfF2Pgu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 11:36:50 -0400
Received: by mail-io1-f66.google.com with SMTP id e3so18962996ioc.12
        for <linux-block@vger.kernel.org>; Sat, 29 Jun 2019 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4a2LrRkHkavleTx6GhxpV4Qt3ppPSbenu2l2iYb+W78=;
        b=vuZ4KbCFAMR5Asv9rM5xJ4ZDsiHqzmaYyqSj//gUUIsoGnazrbPpCD6bU7zQH/S0AV
         oWwA7rBTsk9v41xFmFa8+BPJ54AbsEfHDl3mNyC31vBzISx0EQNI6oIGcV01dBlDQgUZ
         NV9HcleC4VXvTfqiitUyQXVXI/NONJ/TBwsCCPatAHUOZ3MIhoBNqnSgWilHZGyn6yjo
         5yHS7TTkgubR/DKYUBQD/9+VPZQfiyPHj50QWrpI9dNJdrDFhO5PSFTRu0JZPolAF95L
         K6lUW+IFFLl6JR7U7mbVebvezfzQp4o1uS1xdSC7ujLWPu+R/Jzn4Obj+W40b51BuQHD
         kTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4a2LrRkHkavleTx6GhxpV4Qt3ppPSbenu2l2iYb+W78=;
        b=g/fZsMrVRoPZ/ukuQphwhPzA9QFqfGIDOe8e0SONUintcMSpeu/ZE0e3FL0slELXTz
         Q+k2ifc2DkXdH7BwjLJR2BVonqF4w7OXZWR6+tG1Ty3b2Pf+EzQotGA2Tbulb0OoHQLF
         xdZSUlqVtuodQ0D4gKkiAaxDEb/D+AYlNXKIGtxd6uk2lNK8ela4fd0YtnycctgiNCR5
         8wA/4wYEThCcg4oRpHKKFsyqWvMaYUuR2Jen/L+zB2yWN1QrZHOCMauNd8yM0E250tgi
         9OlwHBrBdhHlh0nSx/kyxFSd63mcVRzBqS7WPVrqXcnzuvlNk7yovr8OJsy1kXpZWrYK
         GznQ==
X-Gm-Message-State: APjAAAXLBMpt4mKydVGqHuaJYD/+BJ2tNjKf252HG7nLrEtyJLcAkhHj
        ykCp2uIZI3SgIs6bBv45+7Y6hDt0M/6KYw==
X-Google-Smtp-Source: APXvYqzQGGUhGiiAJIocD7TBqnp0HRgf14qJzS8M2H2ktWc1OdRR6IhbXd6Vv7UlKrL5rF0MAzZDfA==
X-Received: by 2002:a02:ce50:: with SMTP id y16mr18404975jar.75.1561822609286;
        Sat, 29 Jun 2019 08:36:49 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v26sm4540165iom.88.2019.06.29.08.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:36:48 -0700 (PDT)
Subject: Re: [PATCH] null_blk: fix type mismatch null_handle_cmd()
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <20190628232904.31211-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <493c56e0-72d6-3e88-ec85-f03f833bcfc0@kernel.dk>
Date:   Sat, 29 Jun 2019 09:36:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628232904.31211-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/28/19 5:29 PM, Chaitanya Kulkarni wrote:
> In null_handle_cmd() when device is configured as zoned, variable op is
> decalred as an int, where it is used to hold values of type
> REQ_OP_XXX which is of type enum req_opf. Change the type from
> int to enum req_opf.

Applied, thanks.

-- 
Jens Axboe

