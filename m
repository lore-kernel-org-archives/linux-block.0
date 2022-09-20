Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C856C6FA94
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 14:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiITOT0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiITOSn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 10:18:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7266465831
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 07:16:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e205so2372129iof.1
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=l4ln2ykBhlZWW5Rwt4pQjcBchsXfZQalKEmYUz/KFhE=;
        b=KvMempRM9b+JsUs17jcSdZe4CcjpJzMUZQ2/EqNuu1uSxbx8M69qlpDbopCQKoShZ7
         8XIBuC0QVg/JHbBQywYHHq5uwzWivc5GL+ckcX24PfkwcesLnT1xaI9yJS+UqbzFdig/
         /QjreHUiNjzPHlHrvEgM3lVWeV2l4z4Cna29zQwEIPbGGHBuiL977WBTwSlSOf3M/H4p
         xhTNKGJff5HbWUDSjKS0JpmMIsYZj8jJydMDvxjbodwZCsckcV4vN1hjbl0rd/2nNiXP
         ywJ5vi0aiXd/D3dGtG5LhN+IsRXQhohdv+t/Et4oqFM7TNBHiR346sjYemRgkfitFCw1
         wUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=l4ln2ykBhlZWW5Rwt4pQjcBchsXfZQalKEmYUz/KFhE=;
        b=surNw3Lhmf4Gl7xn6cXJLftWQLsge9COyXkygywuz9a00i+HX1Vzju4Tvi+Mb8anGe
         TEnCv25cir1ipMM9ximClPo5XrgfLqH0OjoG74a6UGkeub3NZpU4N+nZkOS/gxmYeEqt
         fmW9Oq0fVBdaPmCLFUcmVGOAYa9a7JzQ+eP8emWOzmyPol/nA+z1y6lIta/BEKUa+lV1
         L0sJua+nj4urN6PVJ+gYWNWgPAIjyOt9NUB77pJsmyqmZbS3Z114cxJEcv1T6rO4so58
         v9dDqNhwfCEOS6fnNjni+UzqgHHzImsyY5whk0XXaFutnfDRXC3gEgxo2rrRNqP473bA
         FnPA==
X-Gm-Message-State: ACrzQf0y2Pfw8KVOnw97ofX7tnzmUwYGirqqigAbED9wn1hMNB2EZZGv
        eY3Q3zMUOZtFY8Oumk0Z/xIxpJUBmLwhSA==
X-Google-Smtp-Source: AMsMyM4Vxw7zSqXIqTdQr0q20rxhnWPfY6ZufIBK/gLZyuZe1YT4ssQnK92+eioctfjeJX95U/nojQ==
X-Received: by 2002:a05:6638:5a7:b0:35a:5354:9d6b with SMTP id b7-20020a05663805a700b0035a53549d6bmr10595056jar.53.1663683362653;
        Tue, 20 Sep 2022 07:16:02 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m13-20020a056e020ded00b002f19d9838c6sm106544ilj.25.2022.09.20.07.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:16:02 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, dusty@dustymabe.com,
        ming.lei@redhat.com
In-Reply-To: <20220919144049.978907-1-hch@lst.de>
References: <20220919144049.978907-1-hch@lst.de>
Subject: Re: [PATCH] Revert "block: freeze the queue earlier in del_gendisk"
Message-Id: <166368336208.9534.7513008797616860619.b4-ty@kernel.dk>
Date:   Tue, 20 Sep 2022 08:16:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 19 Sep 2022 16:40:49 +0200, Christoph Hellwig wrote:
> This reverts commit a09b314005f3a0956ebf56e01b3b80339df577cc.
> 
> Dusty Mabe reported consistent hang during CoreOS shutdown with a MD
> RAID1 setup.  Although apparently similar hangs happened before,
> and this patch most likely is not the root cause it made it much
> more severe.  Revert it until we can figure out what is going on
> with the md driver.
> 
> [...]

Applied, thanks!

[1/1] Revert "block: freeze the queue earlier in del_gendisk"
      commit: 4c66a326b5ab784cddd72de07ac5b6210e9e1b06

Best regards,
-- 
Jens Axboe


