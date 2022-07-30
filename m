Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98DEC04A68
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 15:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiG3PEp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Jul 2022 11:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiG3PEm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Jul 2022 11:04:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FE618B09
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 08:04:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso7822922pjd.3
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=a1dNFgmAm8Wu6Pzrflv+CooYyq/iuFTAYujsTCWijpA=;
        b=vn+CAqxpJLIFJ4ymcVoSOlqZ1sFULAxNVLf8CWyRE7Wp0UAd0mLCiNkdGyCvkzpoQr
         BCvIElmYI7Vtbo3Zll7mO+wfqQ1932b4VSZqwZkoKkauAS7kOpnVX2BU34uBl5J4fasa
         5UZoQWGdki9jx64JauTnrtuQashLHLFUj3DDdbPklQsQT5xfOXWet8JXAYjLpQk3hV8M
         FlT+2HqIMGc4ffzEE6phKZIcHrt5aSMliNPC3DkoP8EKL/I6JgwIlNXIkx3FDt80ITgM
         jPk6Xlxe6yxFMw9QdxjmupV9hInZaUdn6TqcKSKx45Q5yang9kYiKICblZa/LYJL8zBZ
         JxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=a1dNFgmAm8Wu6Pzrflv+CooYyq/iuFTAYujsTCWijpA=;
        b=to5BetllRRhvGqUropwfA5XHGOW2EQftA/+hYMBz91VO4Od4qFb8eRNkK8QoUQa5r5
         5Qluot3tkd02UavMAXXRTXDu8KaX2xhQmbGrofff0QDOIkJepu+4ad3m1ueLMc4QFkUY
         cZlINFXoMBs+UiddzP1QjBVBUpeNcg5JLWYW3exCXmYO5p9K9tdhAVJbrVLSxnzcuzNx
         Zkv1NSY1R2y90IE3DFD8uTU8pxQ+06YHZ0x6NqWgN5UZaaV7ON2YNXyygVjwHGi79fNJ
         2cwB4kvThda3J2TT+ah3wcZeQUPj2Xd+MxbvGZXHNdFklhoJa1Nt0mnqNKLeQcwnICdA
         DMVQ==
X-Gm-Message-State: ACgBeo1J6j+LKU/xjKUBTO0pHmT9XL2NS9wHy+mhk/If0RpCeFs4KOpw
        fmRQ4QV3b/H1QHMA5v3e6VVgiVAhsaR4ug==
X-Google-Smtp-Source: AA6agR4RfhcuoJgACGQ9Z5JoR2ye/lQd2d4hE05o4Gxldtt4OU5idQt1itfODnH9r63gvUqB5N0VxQ==
X-Received: by 2002:a17:90a:6281:b0:1f2:1f17:4023 with SMTP id d1-20020a17090a628100b001f21f174023mr10359998pjj.243.1659193478280;
        Sat, 30 Jul 2022 08:04:38 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903120d00b0016b8746132esm6026211plh.105.2022.07.30.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 08:04:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     Christoph Hellwig <hch@lst.de>, ZiyangZhang@linux.alibaba.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220730092750.1118167-1-ming.lei@redhat.com>
References: <20220730092750.1118167-1-ming.lei@redhat.com>
Subject: Re: [PATCH V4 0/4] ublk_drv: add generic mechanism to get/set parameters
Message-Id: <165919347748.47051.9597383073057729123.b4-ty@kernel.dk>
Date:   Sat, 30 Jul 2022 09:04:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 30 Jul 2022 17:27:46 +0800, Ming Lei wrote:
> The 1st two patches fixes ublk device leak or hang issue in case of some
> failure path, such as, failing to start device.
> 
> The 3rd patch adds two control commands for setting/getting device
> parameters in generic way, and easy to extend to add new parameter
> type.
> 
> [...]

Applied, thanks!

[1/4] ublk_drv: cancel device even though disk isn't up
      commit: 90828a5e0d656f83f67929ece0a50ff0fb6ab7a3
[2/4] ublk_drv: fix ublk device leak in case that add_disk fails
      commit: ed772fe30a04e07e25313b62c0659b2bcf41195c
[3/4] ublk_drv: add SET_PARAMS/GET_PARAMS control command
      commit: 134ec0b02374bb85451ef90ab0d0bac233c945f1
[4/4] ublk_drv: cleanup ublksrv_ctrl_dev_info
      commit: 099d9b8d637b88a7718fe51129db4dc686ce9cea

Best regards,
-- 
Jens Axboe


