Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B3CECAAD8
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 14:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiITOZc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiITOZK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 10:25:10 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922A123159
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 07:24:57 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id g8so2429208iob.0
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=uenAuVOT/bxl/fI76I4SywNVzY4isahU1hZb5TGGMXY=;
        b=jgVZZyDkXlgWHUcb959Gt/mzoSIgd5HJHHHT0+8BZ79ZoQuPSW+VCaFJcoLM/kziQL
         RvaXZLfOGvCzcBpZpHolGIEuQpkBMPYmxidLfDqj1XfR8MRfpzWahCFUEYbEauWrbFG8
         R7mWxDmBeNhXZh2i0exNMPrz6bdtB5OYQSKR+jIbFrB7HwIzLuDN9GOLy0cqSOx/2LHt
         MQSsehhQlQUjmUtjy2j8Iw/yjWb334Lb8OEGc237u6tZZsh7TQulJxsJwUJUk7EHVRRI
         OeLNubFAKaSffiYvLkkZ0yKJt5HonlUQz19B3h7o8y4lmleALJeGAvybyxiMJZs+3wno
         VMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uenAuVOT/bxl/fI76I4SywNVzY4isahU1hZb5TGGMXY=;
        b=WZSk9GjMWFtmLW7vSput3b8B+vGhtXKhnq6JIYHWZCMGKVFSiM7Vo/2pmXN1OxbZJm
         6EoZCdAivf4pg3+W8174gYy23X/Xfyhdkds4qlAKxIoO5Mrmx+W1YyOKyhzprdI1IyIn
         M1xFxtcyVZ65eu4nZ6Wu2UkRo+rhTnicpHtJdObBsyZ9oMD1N0RSj8MfHZOUp9rDELTO
         eN5I3kkj6AGzxTDMNv9QylCNSSc5Gz+GaOXWrShPqhWgtdQj96REZwrM8aqQNMOaKu6p
         S45RgXvdOf3y/5IL77/JV3b5cW/HmKqi70tb2WTg2HA+VF7AOK1f2Zj70YsON2J7kpIV
         gD2A==
X-Gm-Message-State: ACrzQf25OMMhYMo6Q3N9CNBSl7PPP1jTU3mqWd8lJI+1WqbTjjnNkr0I
        iN/nXRlUqJGp3E8eNdncEBGMcw==
X-Google-Smtp-Source: AMsMyM56Qwgef9hgA3SpBySSBsh988NQptBHEJi5k+oAdQCKLE1yN0oYh5I0o3ff/MYGA2nDT5dPSw==
X-Received: by 2002:a05:6638:130a:b0:35a:b44d:f8c3 with SMTP id r10-20020a056638130a00b0035ab44df8c3mr6636933jad.59.1663683896654;
        Tue, 20 Sep 2022 07:24:56 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e8-20020a0566380cc800b0035841b40832sm667791jak.162.2022.09.20.07.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:24:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ping-Xiang Chen <p.x.chen.1005@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ping-Xiang Chen <p.x.chen@uci.edu>
In-Reply-To: <20220914074237.31621-1-p.x.chen@uci.edu>
References: <20220914074237.31621-1-p.x.chen@uci.edu>
Subject: Re: [PATCH] block: fix comment typo in submit_bio of block-core.c.
Message-Id: <166368389585.10391.5193795703873727936.b4-ty@kernel.dk>
Date:   Tue, 20 Sep 2022 08:24:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 14 Sep 2022 00:42:37 -0700, Ping-Xiang Chen wrote:
> This patch fix a comment typo in block-core.c.
> 
> 

Applied, thanks!

[1/1] block: fix comment typo in submit_bio of block-core.c.
      commit: e88480871b8d5a6bd14be2817063363202d282b9

Best regards,
-- 
Jens Axboe


