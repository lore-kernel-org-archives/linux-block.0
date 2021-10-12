Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A714C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 14:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454306052B
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 14:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbhJLO4U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbhJLO4U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 10:56:20 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81952C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 07:54:18 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id k3so13450606ilu.2
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yXzKK10Zizmq5VvDOg19F2ywe7K1er3n4VHylKXS3Zk=;
        b=LVHjdSfPmkVlqScrx1udINq2BMCkvP6g7CEet2tm+l/h3L9FAOW6z4FsQKQ0EP4fj5
         YSTgjP9VQVEapomu3V/NxdSO871eoDnlqOInXO7X2FdQEMg+eHLoPoVPoPay8Bo+EjTl
         Ay+ggBrbDh5QnHpsnrTIs6VHGhUT8ORHVhthQ5My7ZXGaIFwS0sBdyCwDpfBCBnv6Yw1
         WF0lTDn8PaooQxurREQ1tioScDWy/gds4a+ZKeUoqqfoDiCq0d4lzhe/B/A0j3yakdle
         RiXdbmV0UjPDzS2UZ3fqOVy9vm9TIxeq9EZ4eyxi+5kqB2TnBGctl8qk7q//xmcWkXhz
         J0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yXzKK10Zizmq5VvDOg19F2ywe7K1er3n4VHylKXS3Zk=;
        b=rt9s1cmwKMMZeWcGrXLbKRlzTza/V/gh7Ban9tqGz/X9zaP2ln8D+GeC0oEe3A023R
         kuTGPSE3MGgYREsI1Bpq3Fn1cREmUEn9M6w4b7F/jz4la5mH7qeskrXWjeAn2x1XhAvi
         6f78j7MByOr7gsqVti3CHYJBhY7DAR//zPKD1v5BWLzmsBAyvZ2HzCbty+XX3aEfjT1B
         Qakj57foXqEzlmt2GvVvP0W5g0QMRbS1fqOxAwumOKioIK3XWwH8VHz0yoBbg/D0N+p9
         agpLsZx705H+vJeo1fvjSZmJqAjsCMa3aPsjBeGtqiSNxNjfFgaaYQxJC7/RKQdCh2d/
         mXXA==
X-Gm-Message-State: AOAM530NJYquP+gBdXFs+71UK0MQ2r6V8BgGDw/dqYsJ0vr6pxadvesv
        PbmiLH8IfArj5ESeYRiYhqTvW0LcyrU3vg==
X-Google-Smtp-Source: ABdhPJxZHLkCe2qL9wGtWagAkhM+zDkO4aejm0q41kkqBswrGZJVUiIllfi1vpW1pt6moL/3ano2Gw==
X-Received: by 2002:a92:d2d1:: with SMTP id w17mr106079ilg.166.1634050457819;
        Tue, 12 Oct 2021 07:54:17 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d4sm2154077ilv.3.2021.10.12.07.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 07:54:17 -0700 (PDT)
Subject: Re: small block layer ioctl cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20211012104450.659013-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <027aaf61-2f85-8abb-4481-781ad7c1de36@kernel.dk>
Date:   Tue, 12 Oct 2021 08:54:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211012104450.659013-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 4:44 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up a few minors bits in the ioctl path.

Applied, thanks.

-- 
Jens Axboe

