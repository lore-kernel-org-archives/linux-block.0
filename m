Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04928C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 20:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8DA60F70
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 20:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhKBUpy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 16:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhKBUpy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 16:45:54 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4FCC061203
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 13:43:19 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h23so363214ila.4
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=q/I1Sk2IxvDmfoHEeC0nu9tkcTqWWiv240FRva14CKI=;
        b=h25U366ThhYy725+VDg8rLC/eJ34+DG6PXzmltpph5FfMb4iT7Y8458CfIK66iXKWP
         zcQXxN6Dcw1Zw8VXiidGMk8Rhb/kn4gtlcDftS4a+VYOXKo2m/mPa4Wj8iRHtm6wpQY1
         Z8mGR4OLEvzNkd+0aGNZr9GUL3/ezBJEmHde1dOpdp8rrAJUu62E584tKWQYIv8ssXd3
         Hw1Y3wCP1qxxLS6lmm88wrozszQVwEu6NJhBnJGg8vEYo2Jhz68M2Zhuzmc8iIhR83qb
         Y+ca21TbPravNpoEaniYJoNyxSoRWACR5SJVFKf3lPtuBGd9N3aQ7K8lM6It2sCfvoXo
         YdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=q/I1Sk2IxvDmfoHEeC0nu9tkcTqWWiv240FRva14CKI=;
        b=vrTBaGYdrtRajKm8ntAd7nAkJrmcumncaDooK/56E0yscPDNP3FHSrhKdQy/KtOmco
         Q+b94PS7QLjiuD4M6y4VE1m5gTzsvcH5xshhCoigJ0lV0gfJqVUHj25Q3iprD4S8MqdF
         A3LXgnkeR1oG/8DU6jelHRSDu9mejMv8LnOuLK1Vpr+wQCT0iMwJEZ31BNQ/nZ6/OgaU
         TDUvrS33hR73x9lopMTBEJPfHMsbUIhLhTgCGwBRNr+FuGsWY9cFkl0/tN5B1R9wWTcQ
         dVsRczH2qZrLgpl+cvjHr/0m+k7X3xx9rib5u5F0F3+Fl7+RzR6EwTAHdZwZ21xktD5X
         gv/Q==
X-Gm-Message-State: AOAM532wwKOVoHfbcDjFevMoIMAPzTYfgs4OpaknHZGw0ssWdFs9JQZJ
        TTo+2L8TMzGLFNfLPA/pg7qP4Q==
X-Google-Smtp-Source: ABdhPJzRUrElk8dBMAntZ0VZrz/nFiOwIX9zKybo5+XQ85yAodI7z/JF1YJ1Lgluj9C4wUQd6TH80g==
X-Received: by 2002:a05:6e02:d4c:: with SMTP id h12mr11646641ilj.179.1635885798728;
        Tue, 02 Nov 2021 13:43:18 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k11sm68674ilv.66.2021.11.02.13.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 13:43:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>
In-Reply-To: <20211025025426.2815424-1-ming.lei@redhat.com>
References: <20211025025426.2815424-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3 0/4] zram: fix two races and one zram leak
Message-Id: <163588579818.463158.2226638042064253158.b4-ty@kernel.dk>
Date:   Tue, 02 Nov 2021 14:43:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 25 Oct 2021 10:54:22 +0800, Ming Lei wrote:
> Fixes three issues reported by Luis Chamberlain with one simpler approach:
> 
> - race between between zram_reset_device() and disksize_store() (1/4)
> 
> - zram leak during unloading module, which is one race between resetting
> and removing device (2/4)
> 
> [...]

Applied, thanks!

[1/4] zram: fix race between zram_reset_device() and disksize_store()
      commit: 6f1637795f2827d36aec9e0246487f5852e8abf7
[2/4] zram: don't fail to remove zram during unloading module
      commit: 8c54499a59b026a3dc2afccf6e1b36d5700d2fef
[3/4] zram: avoid race between zram_remove and disksize_store
      commit: 5a4b653655d554b5f51a5d2252882708c56a6f7e
[4/4] zram: replace fsync_bdev with sync_blockdev
      commit: 00c5495c54f785beb0f6a34f7a3674d3ea0997d5

Best regards,
-- 
Jens Axboe


