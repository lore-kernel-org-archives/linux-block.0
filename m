Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1050C433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 19:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbiAET0A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 14:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243475AbiAETZ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jan 2022 14:25:57 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B84C061245
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 11:25:57 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id t8so305104ilf.12
        for <linux-block@vger.kernel.org>; Wed, 05 Jan 2022 11:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=FzsUXswUhqYEQy8OwcCNbzuC03X79npbhOLwmH4zQ3A=;
        b=MW+peUHy5fzJsFssPXxnKJiwyp9ejGHC7+Aq98zxLT5QgDr1LmMjpU8nMb2OKQbyUJ
         h9il/hvvIVVdPU0rBkbk65NjXNM40l6ONc8bq+g1DeyRfqGMVU+oI+ZZPFaH3JVUJrBi
         UG96OgsszW8hF0sf3r2yqHd88CJVCQ6beT/+i08OPbkh65KHfK9XaKqnr3oIL9215we5
         qJzpFzsrbV0I3CceBb0lWFqv0YK3GEzLYHvvejN9Iv7sJALcqi61l+bp1JIhy+0O3fTU
         obizZB4vthNmn32aL7oD6b9m3LSUa2JRnrSzRm0axlOqsfM4nKizoOAf9VxKhAEWL0YN
         iX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=FzsUXswUhqYEQy8OwcCNbzuC03X79npbhOLwmH4zQ3A=;
        b=wJ/IU+TeeOFE3YHvY4aeGbvbC7DctTzK9D0wp4TrALElVVfr0hrbCpVsgFPemIQnvc
         2CC8l6jDrjIINQmCyyic7hL7POysfpmVYLrpVRLVZBE5Z+JXa0tG9exg9Nreeos1J10f
         QF4x/uy/8SSgQlK3pYMj3zowz1Ipn2u/3zmfrIl6YH9Uf7QwOmZbiZGF2VEe8Cu3dq5Y
         588+PKa71q7mRzcMIhcBgOr8IzgWawXCWuH010EyPU0CZ45b/DFVvEkZOj4IAPVKo/jy
         TGnsDRq8/FZk+e1a5szm6EJmr2ZWVb5S38IWkQHHAn12Lhd7Gi6q6Cg7w5miKScDGK/n
         5kyg==
X-Gm-Message-State: AOAM530EkKEtRi2byhZWPa3YlXpBYY5aaciHSF8wgfXePh/Az5SmGGpC
        E/N2zbO/mIO2DG8KL3UnUBbFbEPjoaV7sg==
X-Google-Smtp-Source: ABdhPJzDzyQ7qTti+zHMYNt5vw3nCHOdkI1/nZogYf1PCsUV4AYLBR7Y5fcY6gi4n8JeeUho3P5h1Q==
X-Received: by 2002:a05:6e02:1c27:: with SMTP id m7mr26446900ilh.114.1641410756794;
        Wed, 05 Jan 2022 11:25:56 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s6sm26159317ild.5.2022.01.05.11.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 11:25:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        linux-block@vger.kernel.org
Cc:     sagi@grimberg.me, hch@lst.de, mgurtovoy@nvidia.com
In-Reply-To: <20220105170518.3181469-1-kbusch@kernel.org>
References: <20220105170518.3181469-1-kbusch@kernel.org>
Subject: Re: [PATCHv3 0/4] queue_rqs error handling
Message-Id: <164141075584.313116.2242148358924227236.b4-ty@kernel.dk>
Date:   Wed, 05 Jan 2022 12:25:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 5 Jan 2022 09:05:14 -0800, Keith Busch wrote:
> The only real change since v2 is a prep patch that relocates the rq list
> macros to blk-mq.h since that's where 'struct request' is defined.
> 
> Patch 3 removes the 'next' parameter since it is trivially obtainable
> via 'rq->rq_next' anyway.
> 
> Otherwise, the series is the same as v2 and tested with lots of random
> error injection in the prep path. The same errors would have lost
> requests in the current driver, but is successful with this series.
> 
> [...]

Applied, thanks!

[1/4] block: move rq_list macros to blk-mq.h
      commit: edce22e19bfa86efa2522d041d6367f2f099e8ed
[2/4] block: introduce rq_list_for_each_safe macro
      commit: 3764fd05e1f89530e2ee5cbff0b638f2b1141b90
[3/4] block: introduce rq_list_move
      commit: d2528be7a8b09af9796a270debd14101a72bb552
[4/4] nvme-pci: fix queue_rqs list splitting
      commit: 6bfec7992ec79b63fb07330ae97f3fb43120aa37

Best regards,
-- 
Jens Axboe


