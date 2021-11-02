Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F1C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 16:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D4860EE3
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 16:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhKBQz6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbhKBQzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 12:55:20 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4149DC0432DB
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 09:50:48 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q127so25329030iod.12
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=+dbQrmv/b1RygKbYKHH/vVKFe1UJLRUyNsf2ThtHMLg=;
        b=yYUlBfR+AahwtMsc9t/bT1wxlAjiqYn6KCVtPJwRowvsrx3AKmWyImkeE9GwPnjJ/g
         9r8CWW3DzzktOW7KdJ+OlIqgqGDN1GfijyeI05jbdMtmJF193edHIUXQLSK9qrKKIyXc
         T3JJONJyx5Ui4jL4+9JYAlXgszMrv5YS53243mpOSaHZW+vpWNY/DKFeFrNLfikhUSAs
         TqLnNYfmmG1kaL5GvME/9tzK12cAe65XdZwEZwJPsuySH6PEDukX5HldaRI3zrpv09JU
         MVKABNXst6dfW9eTPFe4MtfuaE+J6UIZH1IgVyzy7sBLEs2j6IvB4JJcqYqTePNI7bKG
         7Sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=+dbQrmv/b1RygKbYKHH/vVKFe1UJLRUyNsf2ThtHMLg=;
        b=l+QtJwjp4ehojclmS/+5lfJtq3x9jN/AOUPgB+KgIZcDWQBpp+sHxShOX/hfh9J9ql
         WLOsrgbA7/4MO68bH4+P2gJf7h6M4kZGjEEPY0wtwVPRbkO+2PlLtEqyhobHYXmABcK+
         GPDCp/6lWYjmvt92UYMmFkH+6RBCprMEeoO1U56RYH1d1gIBOxcS/Gt+NnrxVaKQF7q/
         JzaE5vEQQXS/Acn1qSxvw2MoG+ILL7NciJnzcqCo4PXTc4prZi/kwPkerxzJjMn3+cTM
         BSI4wBZK5i7RHwrxwcVxuLG3R2SPksUsOvBW0Ku0hDInkbd9YgRWZgkqY4zdDqMSCFc4
         43ag==
X-Gm-Message-State: AOAM530zvzGTRuu9m/vYIxPsPNlg7LZswjd3CUohAZmKPVX6mvslNxvD
        WAFGd/CI+w5bJhUqWaNhEPiSJg==
X-Google-Smtp-Source: ABdhPJx6UgcW+UNHqi1soE/BIyhBzdbWrSlvz2f+AJjxo6tGbxRgXfr43Pew7zrdEGjiWWyR9zQoKw==
X-Received: by 2002:a05:6638:a2d:: with SMTP id 13mr28494972jao.12.1635871847575;
        Tue, 02 Nov 2021 09:50:47 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g17sm4870213iow.20.2021.11.02.09.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:50:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     nbd@other.debian.org, linux-block@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>, josef@toxicpanda.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20211102015237.2309763-1-yebin10@huawei.com>
References: <20211102015237.2309763-1-yebin10@huawei.com>
Subject: Re: [PATCH -next v4 0/4] Fix hungtask when nbd_config_put and sanity check for first_minor
Message-Id: <163587184699.364332.2099486260392695081.b4-ty@kernel.dk>
Date:   Tue, 02 Nov 2021 10:50:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2 Nov 2021 09:52:33 +0800, Ye Bin wrote:
> This patchset include two patchsets as follows:
> 1. Fix hungtask when nbd_config_put
> https://patchwork.kernel.org/project/linux-block/list/?series=573381
> 2. nbd: fix sanity check for first_minor
> https://lore.kernel.org/linux-block/20211021122936.758221-1-yukuai3@huawei.com/
> 
> I have consulted with Yu Kuai, and his modification has also been confirmed by him.
> 
> [...]

Applied, thanks!

[1/4] nbd: fix max value for 'first_minor'
      commit: e4c4871a73944353ea23e319de27ef73ce546623
[2/4] nbd: fix possible overflow for 'first_minor' in nbd_dev_add()
      commit: 940c264984fd1457918393c49674f6b39ee16506
[3/4] nbd: Fix incorrect error handle when first_minor is illegal in nbd_dev_add
      commit: 69beb62ff0d1723a750eebe1c4d01da573d7cd19
[4/4] nbd: Fix hungtask when nbd_config_put
      commit: e2daec488c57069a4a431d5b752f50294c4bf273

Best regards,
-- 
Jens Axboe


