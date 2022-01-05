Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F966C433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 19:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbiAET2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 14:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiAET20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jan 2022 14:28:26 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35147C061201
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 11:28:26 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e8so305488ilm.13
        for <linux-block@vger.kernel.org>; Wed, 05 Jan 2022 11:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=qnPSvaXhWMxjQ74hplnccXSTlLN2N/ubhChG+ptPHa4=;
        b=jyxD1uHRxTRV4QDq1nDmGvyqfJG1PLzoDjLEwIYlT3VUa7zaSGva6Rp2XLIl0AMheQ
         MdPtEyYKcUYJz3C7VE6RGTZn42V2TuumBrslFnXgcght/Q9ECdaapoTupAhoioXRAipq
         +zzlFmMbErr5KzdrW61Mcx2l/o6IkTILvnWMRowxXeFtf9rrafdHiCTo1E9U3TcJGKvv
         9VmwILazCy7g0Tp0y7bf2jvhgVgMhwb7/maMuQxxjPXg3+YyUbICXlTGp35OCgajFk6N
         A2Bywzo15hHzIu4pc7GacaAPjQF4ix91W95klNkv0uMba0MmLsWqMTYzN3q+krGsL/zz
         tOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=qnPSvaXhWMxjQ74hplnccXSTlLN2N/ubhChG+ptPHa4=;
        b=f2oj9fy6HcgNpHQVCQK+QEWc/RceZncTT6BtIQFG2K+yBfSU+trnzrTHSy2nci38tF
         gSh7PovWPdy44B5zNf10wyEKaJ2tRKQqlE8lDF1I9euixs4ZaRIb29N0lvTwRP6HUeiy
         MmiUF6o9PfKLiGp/UrK4nGWSe089d0/ugonwa1Yc2Lzogr+rvyfbAdP48mEc5S1QFPKe
         Wu1KtwTXHinzLAYiFzuBnlCemAmA0lGsKXNojY8rZsL9QW5DXQP0filSkqnm7rdqiOQF
         cNwflLEA3ctHO3zA8p0kFVX2zYjzeyz/R7Qn1D26ojZrKsykLzfWHdrEHkB36rWg1rG+
         kVMg==
X-Gm-Message-State: AOAM5310PdTjZPWPsC/J8RgmPgRV45luSYqe7P3CX6ZE8t8PZT+U/sZF
        /Bf0hXhzwJJPfaf2jYUQo/TJDQ==
X-Google-Smtp-Source: ABdhPJy/IvlhNzu0sViPTQcIz68vdHn2MySBd9y7zXAI/yXlMFQN1L+qOTP4sM4ICSmA7u7RUFEuLQ==
X-Received: by 2002:a05:6e02:1aa3:: with SMTP id l3mr26680283ilv.251.1641410905465;
        Wed, 05 Jan 2022 11:28:25 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm229481iov.32.2022.01.05.11.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 11:28:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20220104162947.1320936-1-gregkh@linuxfoundation.org>
References: <20220104162947.1320936-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] block/rnbd-clt-sysfs: use default_groups in kobj_type
Message-Id: <164141090490.316016.4253885398568107482.b4-ty@kernel.dk>
Date:   Wed, 05 Jan 2022 12:28:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 4 Jan 2022 17:29:47 +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the rnbd controller sysfs code to use default_groups field
> which has been the preferred way since aa30f47cf666 ("kobject: Add
> support for default attribute groups to kobj_type") so that we can soon
> get rid of the obsolete default_attrs field.
> 
> [...]

Applied, thanks!

[1/1] block/rnbd-clt-sysfs: use default_groups in kobj_type
      commit: 050f461e28c5d13f327353d660ffad2603ce7ac1

Best regards,
-- 
Jens Axboe


