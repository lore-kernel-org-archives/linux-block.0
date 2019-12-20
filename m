Return-Path: <SRS0=4Sb2=2K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74C0C43603
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 16:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1CE206D3
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 16:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="AEuugIbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLTQ0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:26:43 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39205 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTQ0m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Dec 2019 11:26:42 -0500
Received: by mail-il1-f193.google.com with SMTP id x5so8428578ila.6
        for <linux-block@vger.kernel.org>; Fri, 20 Dec 2019 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XckgZbhUqnPG5tRhtRl+VwNraSkfSgZlNelmEK6ect0=;
        b=AEuugIbB9WF845MSH5WI6aAhvlU0SMwnsAkN5hO2bYAsqNIwrUOXb5eSnBTsDtYftJ
         jjtpHfTfy7MvgKkeQ+aJ4scdVeZKOb7UNymDQjdYn9K290SGfuYR3Hf4wyqfvUIdpBVy
         xGnMQHopqgNrfj0GHWMUCmEy4+hBc5m9SBXIQz0b/3v6Hc9f2igwwqhCqPvqdEGD4SgH
         alwXEnkX19G7hb2LjRi97+NG4ndRVomaLuZpZ6gutg/DTRC6gggGLBEdX+1WG7yh0S29
         qCQd2aZpQmfwWcgneT49zSCxvqrBpL7IDDube6EDsAzWPfjlLHYrS4fbBvM9Ntabozew
         0FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XckgZbhUqnPG5tRhtRl+VwNraSkfSgZlNelmEK6ect0=;
        b=RD/KZPC8FkhOaLJyZgYkrtbTgWOKO7D0BonhP71Urc2ykiEXtCTOAjJ4BfbRPIC3o9
         kxjeI3zJ0OEcBBGsNyxm4P9CKQRinmZETJuFAWVCZErGKYe2zHTGptE2PLOpNvEohwDq
         Q3cxVa7ihlbb0qOQXzVOlwG1YQ0GwFFVJwWJlVKlsaTDjQhmX8VzQqwYssGVkJe+XfuI
         QV+8twfAnQXieUdUxDkAuCRN0lS23BkcCHdZztVKAkNxJ9HGDAp8PBQ8yrk742m7PdVD
         t9vLkr1/0lQDZJjleMJbYVv+om3tFau/tI08vxZvZs+q9v9/QDNyWdJs+Fg1WXKAf0nC
         83LA==
X-Gm-Message-State: APjAAAV/tzmoRu1SYSDAw/3k7Ql/tJopwAxFSFFRdkfSDdgc7oQclGck
        Rin3GUtW/FYa+1LlGTKMZaiV8xkXeWuaawWGFizjjw==
X-Google-Smtp-Source: APXvYqwuLs7NjC3AP9OHJgs9RHyJryAKeItR8Tg55boVjTWuxFzoVgvETeExPk+NFhdbfwfZE34jAox3WSo+hyDsZm8=
X-Received: by 2002:a92:8d88:: with SMTP id w8mr13316300ill.71.1576859202125;
 Fri, 20 Dec 2019 08:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20191220155109.8959-2-jinpuwang@gmail.com>
In-Reply-To: <20191220155109.8959-2-jinpuwang@gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 20 Dec 2019 17:26:31 +0100
Message-ID: <CAMGffE=GDo8BgKGXpvTHZNOuCXViyfG2QfOzNDpCJR9kjFSnmg@mail.gmail.com>
Subject: Re: [PATCH v5 01/25] sysfs: export sysfs_remove_file_self()
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.iono.com>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 20, 2019 at 4:51 PM Jack Wang <jinpuwang@gmail.com> wrote:
>
> From: Jack Wang <jinpu.wang@cloud.iono.com>
>
> Function is going to be used in transport over RDMA module
> in subsequent patches, so export it to GPL modules.
>
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> [jwang: extend the commit message]
> Signed-off-by: Jack Wang <jinpu.wang@cloud.iono.com>
Sorry, I made a mistake, the email address was wrong, should be cloud.ionos.com,
I've fixed it locally, it will be fixed next round if necessary.

Regards,
Jack Wang
