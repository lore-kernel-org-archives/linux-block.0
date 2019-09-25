Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB6CC4320D
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 09:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980DC21D7E
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 09:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="hlL+PGhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfIYJat (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:30:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36713 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731555AbfIYJat (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 05:30:49 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so12049264iof.3
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2019 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoKG+LEFGGjI80cfy/D8ELzKAiYahl1c5RXmUNYC+MI=;
        b=hlL+PGhKZHqXkIrAM8xIuFShQ8wQnlsRZcnM2vj3YkeSeWJpVR88bFQhXz4MZtuGeS
         kqJjXt/mGlSEPAYOOkZLIWazJf71G+XBErbJCPU4PUmInALl+VVLucN8zUeHkdxYs2bw
         bg13NOTniesCBXTZZr2monswaTop11zSrbQ7yduFSvZlzO6MxmpApMQ0e5A2Nh40ZlqZ
         HeTgbTCwvsJpHEfZnqI6tN/iVidSxoht3RfM1usHk3PfIRFU1urbk3A0RclOkcoDucfK
         ipYqYLE+eXjwch+gfdRKpFGphdi3XdiDZglTG8GDVnIKMhaBbesreNxF7KAgIMB5DkUg
         /4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoKG+LEFGGjI80cfy/D8ELzKAiYahl1c5RXmUNYC+MI=;
        b=M0AK5RNIZjeH7Dm0VACaTXA5Il7+3mPExdNDXRNRktmXN6QjVZw+Oj3xpkQlNusleT
         2DI/f4Lqi6w68o9m/NVD+xGwnB1yVt7jxXqIh+OLGKTUmX7b3J5O91GjRYXX9BMW4T2w
         ucvcTMrc/pJi+qeEAoHCVXDJjGopQJ1CYdrjPBQduUOMeBTKhvJq0Nzi4rC2tWYNeCE5
         Y6q/ar6Wymeg3c6ioozBP5acdoT/QOdeZSHmSvAVh296xdBO3utS0D/f1r1bDQm8/pw2
         0l6WqXzgaAcad6CaROyH5tYsEeNUwPyQpvUA2gpQR+3F77SxLsUcQf0Klhbxbkw7dOSn
         Yz9Q==
X-Gm-Message-State: APjAAAV6m2kEQc3t9cQtNi4Tkl1Sv1n013l6QPo9cBRcvnS+wWN5VWcz
        DZa+RrGebzEAZRHCkH5EN7oBEGhD7kw3okzz8+81O14=
X-Google-Smtp-Source: APXvYqyyT66uWyKaxU76gMaJXwjt3UXvaHQdez83u1Nu9ZObDjlxmg6jMKi37TKZg1HGf9jqZA0a8/XAG7TcZU/VniY=
X-Received: by 2002:a5e:cb49:: with SMTP id h9mr8756390iok.307.1569403848522;
 Wed, 25 Sep 2019 02:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-2-jinpuwang@gmail.com>
 <4cad763a-e803-1dd8-4ea5-d7ceab929841@acm.org>
In-Reply-To: <4cad763a-e803-1dd8-4ea5-d7ceab929841@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 25 Sep 2019 11:30:37 +0200
Message-ID: <CAHg0Huxk5fFxzzjSR0FnGfWk6cGjfad022J_R2f60mVFeE423w@mail.gmail.com>
Subject: Re: [PATCH v4 01/25] sysfs: export sysfs_remove_file_self()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 23, 2019 at 7:21 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > Function is going to be used in transport over RDMA module
> > in subsequent patches.
>
> It seems like several words are missing from this patch description.
Will extend with corresponding description of the function from
fs/sysfs/file.c and explanation why we need it.
