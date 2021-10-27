Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA63C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F5161052
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhJ0NAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 09:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbhJ0NAj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 09:00:39 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472CC061570
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:58:14 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l7so2811514iln.8
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=OAfWmTaRe7pHC3CPK7jHu1Q8nkOk9ofq4JEqSWOqlWU=;
        b=Nw8pR8eAjmZXk9/Wy1RCa/7DpxHQO0isSnErnvdwFrRa2JNbbH/WRI1by/8ephB1Gf
         YnZUE2wPfiOk3lGIeq4pRkhkNRV58O3w1tIujFMKC16oXm1KgO86qAhXg/eyoqSe9m9i
         hsriwoUsoFHzJWj/bA2towwtK0PiLrnuJ2lZccQpuAOfA/RBmsL0DaNOhBj2Yp9wcKaA
         Bf1wFkfBGmTYmOc0S/8ucVTVi9exPX+bfZQBby0TmHkMQa/voQ2wRjopqh/essDZkYtE
         CwW/hHfpepg2s6SK3Pig16B6a7Q+azCO9Tnj7+l9I/X681XK4pdqntQeHd5RfnqcOqIn
         8KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=OAfWmTaRe7pHC3CPK7jHu1Q8nkOk9ofq4JEqSWOqlWU=;
        b=yfUVTNkW+Q/cytBA+cVnaVXN+siYFbONoHgau2OMum7QLiIRUPA3NPNy1Pm7ifP5S1
         yAHWggCcBz0/JXJfs3j7Fs+RKfKH/EUIRPo7XTN5IdUpMcZHEaGbVGAveuLhtPk5X+cE
         9n2QC0roQ+yxswSiqgY9QtIc295Kzk1DBct1x3x3rqswUcAn+F+L/anrhxcWqPBMQqsw
         BxRxzK4rd02Zyy70whLsC8gujWc9uou6Y30J+CRrkF27nCBKBAQNUmDFVPQbCPuFWX7l
         cwjC7j7fQKK20xUPpUai6oRrl8F7RbuaRQ+nYptMgS+wZHIgBpMmarMNZxqD5X+ZabzY
         k7xA==
X-Gm-Message-State: AOAM53280zsuI/HV/A2b0qalFJGj2mJr9dVBO08fQt5slEH9TFLFT8yg
        /AHS2+BSCpid4FqwdWr2aNsILyyWBE4JGg==
X-Google-Smtp-Source: ABdhPJx98fLoa3a8Vzk5HS/NXtf+T2yWik5oX5SEM1utMMEzq1hKLilyta1uFAbLUtgjsZma8hA6CA==
X-Received: by 2002:a05:6e02:1a86:: with SMTP id k6mr19228229ilv.192.1635339493629;
        Wed, 27 Oct 2021 05:58:13 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z26sm11439326ioe.9.2021.10.27.05.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:58:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <20211026060115.753746-1-shinichiro.kawasaki@wdc.com>
References: <20211026060115.753746-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] block: Fix partition check for host-aware zoned block devices
Message-Id: <163533949070.284890.10151015414486229996.b4-ty@kernel.dk>
Date:   Wed, 27 Oct 2021 06:58:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Oct 2021 15:01:15 +0900, Shin'ichiro Kawasaki wrote:
> Commit a33df75c6328 ("block: use an xarray for disk->part_tbl") modified
> the method to check partition existence in host-aware zoned block
> devices from disk_has_partitions() helper function call to empty check
> of xarray disk->part_tbl. However, disk->part_tbl always has single
> entry for disk->part0 and never becomes empty. This resulted in the
> host-aware zoned devices always judged to have partitions, and it made
> the sysfs queue/zoned attribute to be "none" instead of "host-aware"
> regardless of partition existence in the devices.
> 
> [...]

Applied, thanks!

[1/1] block: Fix partition check for host-aware zoned block devices
      commit: e0c60d0102a5ad3475401e1a2faa3d3623eefce4

Best regards,
-- 
Jens Axboe


