Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C4C433EF
	for <linux-block@archiver.kernel.org>; Mon,  9 May 2022 19:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbiEITUf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 15:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiEITUe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 15:20:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20E613B8C2
        for <linux-block@vger.kernel.org>; Mon,  9 May 2022 12:16:39 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so13056663pfb.4
        for <linux-block@vger.kernel.org>; Mon, 09 May 2022 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xMQqri0afWvEcgziBjV/OJ4ZcWGFGAdMGg73mCxF+hU=;
        b=zHtsslvNtb6u8JNJWRqD5MfQ3dRa0V3IYQchS8XdDoQuJuD9ZvqcNiIhTE/1lhBhAB
         hXgR5iVG8hX2IIdbKwiPrn6oylVmu92m/pz8l66klVElDzyQdpQ6P4oEz+779UbIyMgO
         4QjVAHKSuOaIjRrqQf+pagUwFIO54zGvp0mgkzEjChMVmsdYsZ3wO2Bjt20At62Gl0+R
         hQw3HFLZRzfiz5V1H1eqZFOCZoIwLJarC/sbIZCDMhMiREvpgtyoJ/aFri/yV77rryOW
         vlhGXJYKdlb5bcIAJCtkrPFb0ZSCxy5OUxySyBzDxleC9HzJeY99bo6lyfdg61CgdKB2
         /kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xMQqri0afWvEcgziBjV/OJ4ZcWGFGAdMGg73mCxF+hU=;
        b=UKHIyjKPMMcpltr6yP96Z4YFxyDHcbI9y5duM/DjMsLENldkXM5ox9zxOMnNYekLz3
         QnFj6znUb8SoL5tIdVOUC5wTbbUVEZORGYUzRgawK/9R4pbvcVZ4y24X5NmwxhPJj64q
         zlVd6/DGDRLh25Ko2k2khVkab27NY5XPcWO9g80sOaWe9cUH71I4b/JqWJcM/WlMii8B
         PrieHxJn1q7AoiM4DjZqM7YIY8p4pU9Wy9eNmChQ+ce+GeTLmSO5Z+9CBgz++QRmhMrB
         7lV5qJQjyjCW41h8qwjHg8T/NN6eMnOA5nVFip8sNf/FkJyPGpc4C9NyLVQ3GoukZM+E
         K8iw==
X-Gm-Message-State: AOAM532v5l65ejW/pfdYTc1on5SzRagHqQdPQKvF+XcMy5gCySioWBe9
        /kXTMEv2rBrIf2NUQVraXznhPQ==
X-Google-Smtp-Source: ABdhPJzDhURpCVvAG7i6HKR3FeCLri2Fh3G+sdoU6dYC/cLVLHF9hR+M5ZXRFAy2xmi1vr1UG+uozQ==
X-Received: by 2002:a63:5464:0:b0:3c1:4930:fbd5 with SMTP id e36-20020a635464000000b003c14930fbd5mr13844414pgm.94.1652123799270;
        Mon, 09 May 2022 12:16:39 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:500::3:a403])
        by smtp.gmail.com with ESMTPSA id n52-20020a056a000d7400b0050dc762812asm9009919pfv.4.2022.05.09.12.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 12:16:38 -0700 (PDT)
Date:   Mon, 9 May 2022 12:16:36 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH blktests 0/6] extend zoned mode coverage for scsi devices
Message-ID: <YnlolE+R/MHTW18s@relinquished.localdomain>
References: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 30, 2022 at 10:32:09AM +0900, Shin'ichiro Kawasaki wrote:
> This patch series extends blktests coverage in zoned mode on scsi devices.
> Recently scsi_debug introduced ZBC support and can work in zoned mode. The first
> patch adds a new test case zbd/008 using scsi_debug in zoned mode. The second
> and third patches allow test cases block/027 and scsi/004 to run in zoned mode
> using scsi_debug. Following three patches are scsi test group improvements
> unrelated to scsi_debug. The fourth patch allows scsi/006 to run on SCSI devices
> in zoned mode. The fifth patch is a bug fix in scsi/006. The last patch removes
> an unnecessary scsi/003 out file.
> 
> Shin'ichiro Kawasaki (6):
>   zbd/008: check no stale page cache after BLKRESETZONE ioctl
>   common/scsi_debug: prepare scsi_debug in zoned mode
>   block/027, scsi/004: whitelist scsi_debug test cases for zoned mode
>   scsi/006: whitelist for zoned mode
>   scsi/006: skip cache types which disable read cache for SATA drives
>   scsi/003: remove unnecessary out file
> 
>  common/scsi_debug  | 11 +++++++++-
>  tests/block/027    |  1 +
>  tests/scsi/003.out |  7 ------
>  tests/scsi/004     |  1 +
>  tests/scsi/006     |  5 +++++
>  tests/scsi/rc      |  4 ++++
>  tests/zbd/008      | 54 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/zbd/008.out  |  2 ++
>  8 files changed, 77 insertions(+), 8 deletions(-)
>  delete mode 100644 tests/scsi/003.out
>  create mode 100755 tests/zbd/008
>  create mode 100644 tests/zbd/008.out

Thank you for the patches, applied.
