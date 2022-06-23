Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29BEC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 13:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiFWNoM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 09:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiFWNoM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 09:44:12 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1542263
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 06:44:10 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h5so11644510ili.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=POgT05wM42hBLTc+NksssttlaUWlhKOkLi32+nH5MUA=;
        b=LqT+L49PT3urDtzqdiAjCmeWHPWxeUeLUrMno1wQER54DeyWdKLjiJU/0cm4KcCD5R
         6YN0T8weshpuIVqLu6Se+VTirg8aDKKBQpfgyIy4W5tTtz477MEMyv9RQwRak2a/U5bP
         nR2cPhhS/f4eBARJuS7XSck2aM5pi5SU50/XKySFdJUiB22chyV0eIBfS9CDRp5ckbbn
         06ZIp/MtyqMIo1y+USIbBRL7D+0B7DQONHC+PpkB6ssvc6Bfov5S6moSAyQabD7sSMwC
         rfW/9R7Gslm7MDMGA8Mk32RO29DqoevchI7MTbfXFPGAAWCrSwZr8Vz0vn3C8UoQ4Xxw
         V73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=POgT05wM42hBLTc+NksssttlaUWlhKOkLi32+nH5MUA=;
        b=3EqXyjAOWArQAxBZLhsYqhVWx+xTnEpzZU6sGyGeVuyH9gd9KdxbwaDnekEolgrVEF
         HljDOzlmpBOI6XlVjGwV2aFn8mGPDP6EaevhsKhyVm+q0uvV25lEytKW7dgfEYV/hYBF
         qjRmkN6tH6L+u3h1HrSJFEEe8B9RvbtZR9i5XYWH9pOP7Ng7UhCnOrwGiffbXfSeijtu
         bsRg5iPbaDFE+RzZqkUx6DepMSErth3NPl92N7d5+epeRMOsJEfvHotjis1j0XcnaKfR
         4eMEgzbEZy2LOqU0gNuQCWIevszn2M8hsIcna87rJU+rfEo+GpDvcgxdcEgOEajGuLwT
         106A==
X-Gm-Message-State: AJIora8v2lujawUPGBSX0rOdCIUJtZbGTSArCMmpTWihEZGiW1/3Gmge
        EsijAgd4yNQcrljtZMHZDxp3zg==
X-Google-Smtp-Source: AGRyM1ua8L2T3z8C21vx8QfT/rpIV/U6cTgN7AXoTVVJRBdxGrpID0+DqzEaZGsUe6RGErw8msoGmA==
X-Received: by 2002:a05:6e02:154a:b0:2d1:d151:3c26 with SMTP id j10-20020a056e02154a00b002d1d1513c26mr5122360ilu.24.1655991850162;
        Thu, 23 Jun 2022 06:44:10 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u135-20020a02238d000000b00332044db2aasm9856481jau.95.2022.06.23.06.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 06:44:09 -0700 (PDT)
Message-ID: <49f60048-1307-6860-794a-82020c9f2ffd@kernel.dk>
Date:   Thu, 23 Jun 2022 07:44:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YrRpb4LlxotvjCML@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YrRpb4LlxotvjCML@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 7:23 AM, Christoph Hellwig wrote:
> The following changes since commit 2645672ffe21f0a1c139bfbc05ad30fd4e4f2583:
> 
>   block: pop cached rq before potentially blocking rq_qos_throttle() (2022-06-21 10:59:58 -0600)
> 
> are available in the Git repository at:
> 
>   ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.19

Usually I'd just turn that into the right git://, but it seems it's
missing the signed tag this time too. Can you generate one?

-- 
Jens Axboe

