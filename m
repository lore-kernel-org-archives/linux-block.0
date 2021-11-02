Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA30EC433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 20:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B757A60EB4
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 20:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhKBUpY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 16:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhKBUpY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 16:45:24 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3240EC061203
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 13:42:49 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h81so233926iof.6
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=K/fqbzKS7d7M3R+dtjsJkzxyoCQ0qXkQ3ZMxTQROrjY=;
        b=0jOnt+d6rkjr0xYYasEo/Cma/n2fhTr9QJnbA/Dl6G6MGmPUSK5+5R2eLkwDRV1k7U
         sBzxiL42a6mqjwsXausPbWMjLIzjKxpjYwyJ5RwlsOcoPaT6X6p/UfKxYOtHtqyC6GU7
         ugH3ygUqUOXgNZzKTne4c4ffQ42OzTL7p3xZ0IHMHerTc5oCKis+UAZPqMtiaMo6vnPK
         0izcH3MXVr187f2PCLw4kyNhDOBm1INviqGtyNz1Afr1kzgkmepYbcT1LdDFCeR8OOnW
         757T3j+hhV6QIPMDLWCjeCSOp/jTZ7Sc6M0jUC/lqnAic7kKpQEdsrWbcJTcFiRXj/3K
         BaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=K/fqbzKS7d7M3R+dtjsJkzxyoCQ0qXkQ3ZMxTQROrjY=;
        b=MnU+S9hXLR2BOw7LpULrwn9UQDyyp+QY8xZdeYWz5vW4HqmVyqH3ZxWjKivSG/nUWf
         2BJJ7WTAVFeKxh5kzQkDa97erl4vFwoLnkbo1vg4Ew+JxoUCL+053Ju0hw7KnlcBOyOK
         mMibm0mp0YdBjdGahb4A/9G2pvbqLt74HQvRMBr1UWMysgDuTClMH60gC66cqdsMrj3J
         dot/b9zL8zf9eBCDmrBwQ3yp1Zvz4+OLQMLWsjBFtmDGNEvYHq2JhyntkvJlMcvhBVR+
         e5pnkn0Rqr+ngUqLeMcsqe7i9aEh+RHHITfL7hUVasEhfF4tQNXkYfi2fhLf/BS3DuD5
         qPcg==
X-Gm-Message-State: AOAM533eLvVTzWRtO7SGhASQwQEv+AvT+MTZT/pASvNliSC88j50vwQg
        j8ETb7iZQtElU0hr828fPqGFN/+fVVAD2Q==
X-Google-Smtp-Source: ABdhPJz3m9eBOhDC5NdhELv5Gcmquw7Vd2ye9VvFsUfeC26PRRr6aNPvdUP7IEkS1SlWnuJobt6JKw==
X-Received: by 2002:a5d:8242:: with SMTP id n2mr27354163ioo.170.1635885768482;
        Tue, 02 Nov 2021 13:42:48 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n4sm84359ili.10.2021.11.02.13.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 13:42:48 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Yu Kuai <yukuai3@huawei.com>
Cc:     yi.zhang@huawei.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211101092538.1155842-1-yukuai3@huawei.com>
References: <20211101092538.1155842-1-yukuai3@huawei.com>
Subject: Re: [PATCH] nbd: error out if socket index doesn't match in nbd_handle_reply()
Message-Id: <163588576788.463006.5186111103177394887.b4-ty@kernel.dk>
Date:   Tue, 02 Nov 2021 14:42:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 1 Nov 2021 17:25:38 +0800, Yu Kuai wrote:
> commit fcf3d633d8e1 ("nbd: check sock index in nbd_read_stat()") just
> add error message when socket index doesn't match. Since the request
> and reply must be transmitted over the same socket, it's ok to error
> out in such situation.
> 
> 

Applied, thanks!

[1/1] nbd: error out if socket index doesn't match in nbd_handle_reply()
      commit: 494dbee341e7a02529ce776ee9a5e0b7733ca280

Best regards,
-- 
Jens Axboe


