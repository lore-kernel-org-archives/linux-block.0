Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF43C433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 14:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbiESOZM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbiESOZL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 10:25:11 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B288BE2791
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 07:25:03 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id b11so3759476ilr.4
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OIZ32Zk3VUOPm7o1hnSrMr6CxYgOZidxFe+dEgyko2A=;
        b=AXAN6iTJ5SfwAXe0Rbm9lEXYh70enFxxz3BeQTpMIsBam/JT8AGwZjVsidKvdMKf1E
         dIA7xuppENuQRz6D4sRi8wju+qRAzBECOopGdf8zyJB8KTrMVAcI+cqk0qrERbcwzyOR
         gFjtpU6/xHr8fUpi2HhEStPbwbK7hRTkbyMZG1tB4yYrfgAXP0I6LGzIZ4WiszAO4Kw6
         2oFVrh5CN415l4Gn0hRAetfWDfjqpPnsLMpkA9z34YzkOfKTd5kgzdR7qrAXDSJmlwqI
         m3K0sdgClucGgLdrkBtnKtmV1A0+/fJDuDDvtlUNZjBpbnZMhI6/Wnjg/0bsDwZZ1OVo
         VnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OIZ32Zk3VUOPm7o1hnSrMr6CxYgOZidxFe+dEgyko2A=;
        b=7NYoMi8s3UfGXfn1Zfy1Ras3yzZ4tko9J8yFvsjy/SINiwAWLOdTRP7b50jZYlr4S+
         bPEd6rjweH2cVg90NuncP6W2VBlRuepnazobNWvEsWSsGv2EddeXGgYsXCIY81Y+m4c/
         sul/4xOrBak/jYOEEBgkdu6CN0Z9G4t4hr7Mlvhj0jl6CIy3tm6+zNyeOjpnk1Ut8K8S
         1EQHc+WHgymQYlSn6791pn/flUWa87WyjzSlxg+55nHknpXUcBp6+DpAfR6JK+OARtBb
         V3LIwKNv7T4pWeEsR005iojYU6TW7b+Oi+Gr8GwFdDTncEpwQASBzuNTKLikQeVhdv1w
         FtuQ==
X-Gm-Message-State: AOAM531qE+QYiOOSlqRI+Y7ixO6Yh8cScmH5nvFaQoz62wboSQ2YJ2Xf
        JLHMuiqzyBvyQzqngVS5TWV3sA==
X-Google-Smtp-Source: ABdhPJxAUrp3jYlFigGNWkcaff4zeQAistuvVwROqSfIUK3cCrfVc+Dk6ckZ7iil+jQWx6+whV3I2w==
X-Received: by 2002:a05:6e02:1d1e:b0:2d1:6ef0:1777 with SMTP id i30-20020a056e021d1e00b002d16ef01777mr1147589ila.35.1652970302800;
        Thu, 19 May 2022 07:25:02 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d137-20020a6bcd8f000000b0065b2fd94d2bsm788902iog.5.2022.05.19.07.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 07:25:01 -0700 (PDT)
Message-ID: <186a4387-15b5-2fd1-0c4c-1e447503d730@kernel.dk>
Date:   Thu, 19 May 2022 08:25:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] blk-cgroup: provide stubs for blkcg_get_fc_appid()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org
References: <20220519140021.6905-1-hare@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220519140021.6905-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 8:00 AM, Hannes Reinecke wrote:
> Provide stubs for blkcg_set_fc_appid() and  blkcg_get_fc_appid() to allow
> for compilation with cgroups disabled.
> 
> Fixes: db05628435aa ("blk-cgroup: move blkcg_{get,set}_fc_appid out of line")

This isn't a valid sha.

-- 
Jens Axboe

