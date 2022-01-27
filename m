Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA9DC433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 17:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiA0RRM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244422AbiA0RRL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 12:17:11 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3132C061714
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 09:17:11 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id e79so4345981iof.13
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=xT5bmm2ZQXkv90xnzpvjPoRX55jk4swWNegsJQidaMk=;
        b=lmmuvr1mDR2lpp75UuTV/YmRZ/vruMXzovUf0ufPZXQSub/rdkvpFRZ6oq6ojgC6qG
         haWfw36+0F6OBHA+fg1roo1ACTNUuWBztjpenR9yAhaRSUmTKH7AcUk2HIokYLwxTrId
         AQX/P8gG+k0rBzIbyv62WVfJI2puED+0/wVaY+hyNl56xIh6Siv/I4I3cWRdcb+gODGn
         MAMMW3FWHforNa05ny6rYXkwF6CVkdEFuwhCURKMrQ63VhBdc73lgrUlJnojKPB8G3w4
         5SjB8ZCtTIP73PJ/GMbcMx4lR3Vl911uJjRmVthc540OAyjY6Ih/c0N5zqK9jdCWP7ej
         sG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=xT5bmm2ZQXkv90xnzpvjPoRX55jk4swWNegsJQidaMk=;
        b=uWRNdaS98M+nJ0b1wWxMN9Y7IvhzQ1bNqHHrYI7VKBQGzRDkiuc1rYhX3Bja4n/zBS
         NJUgPr0b/2ThpBlIOd5QSHyaLOKos2vucWMIS8hdBer6ve2IUhNBRE1E3Z4Ko0Yi6ilV
         ZJf5yW+hlfLfg553nxsG7+J8VMpCStjcm1ZtMYrPRmm/7r30AaSMd9iW0uVv7PhN7MqO
         XDixn4RQb2nZBrBZCyp4GEIdJCd5yMEtHiT8EkH0hNe8Knb+/JAnux23YMR6i31b9imv
         Y8BuqDZvyPsBJPPTYEB91AewaGnYohIzcgZ2m/7JP6HHQK9LY9+efrKDLckEbSRDPpxk
         Wopw==
X-Gm-Message-State: AOAM532BmjBTi3znCSBz82+s+zt1LpldCPix+EC3bgxonON2NepozoFF
        XqFMd3ne0QXdqhoEQ03FVNlHiA==
X-Google-Smtp-Source: ABdhPJwbgWzbI7aMMuKcrQvqQ4HkGfjRykM9p+OlU2Z5sQrKZs5ocBKAg3laeC7po/s7XuxJ4QTbXQ==
X-Received: by 2002:a05:6638:4193:: with SMTP id az19mr664890jab.138.1643303831002;
        Thu, 27 Jan 2022 09:17:11 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a2sm5166896ilj.35.2022.01.27.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:17:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Laibin Qiu <qiulaibin@huawei.com>,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        alex_y_xu@yahoo.ca
In-Reply-To: <20220127100047.1763746-1-qiulaibin@huawei.com>
References: <20220127100047.1763746-1-qiulaibin@huawei.com>
Subject: Re: [PATCH -next] blk-mq: Fix wrong wakeup batch configuration which will cause hang
Message-Id: <164330383030.210260.14632628670635722739.b4-ty@kernel.dk>
Date:   Thu, 27 Jan 2022 10:17:10 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 27 Jan 2022 18:00:47 +0800, Laibin Qiu wrote:
> Commit 180dccb0dba4f ("blk-mq: fix tag_get wait task can't be
> awakened") will recalculating wake_batch when inc or dec active_queues
> to avoid wake_batch is > hctx_max_depth. At the same time, in order to
> not affect performance as much as possible, the minimum wakeup batch is
> set to 4. But when the QD is small (such as QD=1), if inc or dec
> active_queues will increase wakeup batch, which will lead to hang.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: Fix wrong wakeup batch configuration which will cause hang
      commit: 10825410b956dc1ed8c5fbc8bbedaffdadde7f20

Best regards,
-- 
Jens Axboe


