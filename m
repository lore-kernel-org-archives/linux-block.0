Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990AEC433F5
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 19:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbiERTIf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 15:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241755AbiERTIe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 15:08:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8561787A05
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 12:08:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bx33so3625445ljb.12
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 12:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=kF3fMNbDj2uCLop/ywkPZYk32NuciMTsT48drM8RaMk=;
        b=auvPhw4JGuSJHYAzB1llqvYZK8uU4QjmfKYlk5Fm1htqzIvIUx8/kvXRS2kIBr7Mlz
         YjMwuZOTTpDVqYsFPlmWWexvbn8tDXkvUwmgYyPpS6gzKsdElngn2vN6aE3cVHH9ldHA
         863wmCj6R6JLY3VW/dCVuEzvmzd3qNtXoWuER2X1fK94w1cT9NcAst83Ak87ps7oESVt
         iXLjpXtvlfyYrn7PRQGf2/fASN4Pklo1Fomw9qeke2qs/d7dqRtLb6s0aFD/AMKTbpr1
         exlqLM+k4aYcdeFUiXsVn+fAG1hN4xmS7/S70esXglDQ4cwUK2jHZ9PfTVyNLKvksc/0
         RbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kF3fMNbDj2uCLop/ywkPZYk32NuciMTsT48drM8RaMk=;
        b=21D6CMSD5+9ME1Qk7tIpkmGFy7Mz3qPdRrN2i8C4te4b7SsHNXca8SMB9iBz0UGFZj
         sdPb5Xie5C7o+8tMMmc5fsMtGuF8VQQV+Z+KVfx2kZpB76VW4grN9DvFk+HkAyUISPAk
         KLvVytcKHTCN9C+KzdWdRJPMqXe4/8G14epP7Bzf3tInukUB5sNMmwn/jnAAL51kce4I
         jeguWSURqs26ctTnRtojaTWv/bW3d8Ryt1c56hGaoiaU3QHZKU8/+VMt8de+G87CTiSi
         X4XKMXhW4UTSXxm1+aVx75o/h1oKl9I8MNuDHk/+LI2cijrMThsbgNCfY5Nvgz6lxO0U
         y4Ag==
X-Gm-Message-State: AOAM530puMEGKzUDLVgoSSFGvq8iHoBH4j78AJ1V6x+w4axyPKH2BB4Z
        OiqF9pK0I2oyz3cQRrh5Scb7oYS5r6WxUlrhqcs=
X-Google-Smtp-Source: ABdhPJy/5j+qU9SABGCZ+Lk4PWB0xIns4xsYeEODuLKyQJjxQkactz+dymVVjanXReutKLsqBhGk8g==
X-Received: by 2002:a2e:9105:0:b0:24f:2558:8787 with SMTP id m5-20020a2e9105000000b0024f25588787mr475002ljg.65.1652900911601;
        Wed, 18 May 2022 12:08:31 -0700 (PDT)
Received: from [87.92.240.253] (87-92-240-253.rev.dnainternet.fi. [87.92.240.253])
        by smtp.gmail.com with ESMTPSA id v5-20020a056512348500b004744d5f8f26sm32002lfr.52.2022.05.18.12.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 12:08:31 -0700 (PDT)
Message-ID: <ee4e6c7a-1d37-cb3c-6240-9c925e1c1aa8@gmail.com>
Date:   Wed, 18 May 2022 22:08:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [Question] Editing a bio write request
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org
References: <CAH4tiUssBd1vKjUMtbNcmHt8X+-TzdgSFCfT=3coZZedGVESsg@mail.gmail.com>
 <YoU76RzXfV6Js9T7@sol.localdomain>
From:   Jasper Surmont <surmontjasper@gmail.com>
In-Reply-To: <YoU76RzXfV6Js9T7@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Data in bios can't be modified in-place, as submitters of writes (e.g.,
> filesystems) expect that their data buffers aren't modified.  To modify the data
> you'd need to allocate a new bio with new pages and submit that instead. 

Oh wow thanks! I feel stupid. Just to be sure so that I don't send 
'noob' questions like this in the future; could I have found this 
anywhere in the documentation? The block layer is a lot to take in and I 
don't always find the right stuff online.


> What sort of device-mapper target are you trying to implement, anyway?  If
> you're trying to do encryption, dm-crypt already solves that problem.

It's more of an experiment, using compression!

Thanks!

Cheers, Jasper



