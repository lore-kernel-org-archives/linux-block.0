Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33801C433EF
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 14:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbiCaOce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbiCaOcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 10:32:33 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E851D67DA
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 07:30:46 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id 8so16869465ilq.4
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=l8CekeoQZXHX4U3TiS2vpp4O2YuTCmdU/BDSBQosw7Q=;
        b=2t3SM0cZXUR72lsXD7aWv01f4VUP1+TsCWH1VXhR9gW8eeqvvAYm8IPed6tPPC/+bT
         /wf9r2P3V48ygYra/UM1VT50ENC51HGaz5CRa65IhBEmNu5LJEGBB7CqL0dNZJ++bP5l
         ZuFHQmFFFJgh/P90XI1k0WCdnaV/65iQKBTWubWDoonZK3zxaSLZQXZus5lAGOBhywkZ
         TrV5h5uml6+9t1iFBJ5FnSDBddgz0muYcbWXUBl6LXRAAfpdksB4eK30BIE/mJJM1ZHC
         rmY/8/X0BmT2ei/CA6CADJPhXxCAdFQCskc1lcm8c4RtAGPxzECZY8oM8CNOmAkuRemv
         /OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=l8CekeoQZXHX4U3TiS2vpp4O2YuTCmdU/BDSBQosw7Q=;
        b=aY653s7DWdZPIjyt/f0LIrEvUW/QpdFFnzEA5ksFy0ahTEpX/OP8mm2GPUUeeVoMUt
         oF7UA6sdv0s5fzoQisWUXWD57zt8h4I7e7Ti2Qk386bGYofIFim+Qxcr2EpQ6ceKRfOG
         UVPF2X2qLN1BzylejusRdt+NdIUmgmDG5JR76PFasXYdC5t8AzY0Ai7gaeeXG1Udd6uR
         8dloQl207pkh5r5l10/QNxqaa4deEmj6iTPeOsvUZgSjk6XDX3zwn+9XdMMSsZ1A1KcE
         N/UtroYJ6z/oae6LWs65z9IRcgU/ksJJqu+bW5/phe/K/CNnKsaw1eKIaXhPcDcGAuZN
         mAMA==
X-Gm-Message-State: AOAM532A27XhRvyLRhP3Kel4Rz5hDxByy/rxbXV727KGoqbX8bjHL/h/
        I0V/vahlhQN1qN2rPf+GzpR1lA==
X-Google-Smtp-Source: ABdhPJz25adczaNwDR175aQhqMn4WdHp4yEMllsYZBu8VTCksFw0OQj+38m10GkF9u9YGSPT+0qfJg==
X-Received: by 2002:a05:6e02:1c0a:b0:2c7:75de:d84 with SMTP id l10-20020a056e021c0a00b002c775de0d84mr13381733ilh.186.1648737045567;
        Thu, 31 Mar 2022 07:30:45 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i3-20020a056602134300b0064620a85b6dsm13883109iov.12.2022.03.31.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:30:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
In-Reply-To: <20220310093224.4002895-1-zhangwensheng5@huawei.com>
References: <20220310093224.4002895-1-zhangwensheng5@huawei.com>
Subject: Re: [PATCH -next] nbd: fix possible overflow on 'first_minor' in nbd_dev_add()
Message-Id: <164873704446.46490.778795283218997371.b4-ty@kernel.dk>
Date:   Thu, 31 Mar 2022 08:30:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 10 Mar 2022 17:32:24 +0800, Zhang Wensheng wrote:
> When 'index' is a big numbers, it may become negative which forced
> to 'int'. then 'index << part_shift' might overflow to a positive
> value that is not greater than '0xfffff', then sysfs might complains
> about duplicate creation. Because of this, move the 'index' judgment
> to the front will fix it and be better.
> 
> 
> [...]

Applied, thanks!

[1/1] nbd: fix possible overflow on 'first_minor' in nbd_dev_add()
      commit: 6d35d04a9e18990040e87d2bbf72689252669d54

Best regards,
-- 
Jens Axboe


