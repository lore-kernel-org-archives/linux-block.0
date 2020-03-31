Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0DC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 07:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB042072A
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 07:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="h1MBawhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgCaHcM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:32:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44958 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbgCaHcL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 03:32:11 -0400
Received: by mail-io1-f68.google.com with SMTP id r25so8832865ioc.11
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tiflqmbJNy/ISkOZp3HcyDqFy69LUMoxztgvrp3UZQw=;
        b=h1MBawhNq08tgkPygGCfyEm94JSKpZ3D0eJneCxxQOIZmVxsXW1RFBHwtsC7Ptjbb+
         bQtLiJoUMyp5SR2OwwnlcfqnUrTV8PGzNmOKh7w3FMn+gb/5kfuqNHYsKzc0WvcIO0ve
         o5zlRmEimdxq1RaZaoOP4vxiWYoMDhLQF6mHzTbNIjFY/zdWO7QxsHE00MCQ6HTfO6z6
         HHaFing6eAKtuqRqYOstvDA0PQFIxSs0AHRBiPwSbF8zatLTM+CFMFf1sM6CUDt1N/EA
         S1iFtGJ0InDRMGbh07/gcvv855/jKJgmkJJuDa1pjy/8HRkuP/hJpLYL5UJoeTM6mHDH
         HFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tiflqmbJNy/ISkOZp3HcyDqFy69LUMoxztgvrp3UZQw=;
        b=A8oL7yNr5fdlBhdi98fG3zIiMUSmMcDNvY9Osd0IXyEKYvnXJmAO3u3Cn5chiBkgDa
         FT50oZP+kwuvG1HIWfgL1cU+tVrm8nvyzTzXraA9/7gCoGFmQli7OZScN0t8GXj8kCYJ
         rhVxuFHahJxmqPmgU8spstVGMk3N40EkMVcqJf4O9hSts7aIAzeWBp47x3qfT7GZyyIx
         nCx+oDO5lNwyNHr7av1rG1YcPC/GdsxG1F5qbO2sJAcQVDrOlElMScSeKTRhWjFJlO47
         SJXemd50h6ijjS+gn9nG83BmJ2KTqflPQsx7hDPLsJlQN0zAnI6RLx7Gz+ISTLeuV3Gx
         fU9g==
X-Gm-Message-State: ANhLgQ1SvlNo1Y3iJLEvAdrGANdHsBwdLyFiy/t7KXvuYIq3Ixi/xY6r
        ilqjnKQfWSUqeVQTpncM/wr4l2TaZW91Pil/jliVZQ==
X-Google-Smtp-Source: ADFU+vu/QcQ7rP5U+QEEb/x/eUTWclvPdZsvLzN7xRu9fw8Q8TU7CzMbtxNGTtpDdJWTNWgu32eC4xSwy9mb06hgeAY=
X-Received: by 2002:a02:3b0d:: with SMTP id c13mr14860699jaa.85.1585639930849;
 Tue, 31 Mar 2020 00:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-17-jinpu.wang@cloud.ionos.com> <93786c91-3008-9213-82f8-e5716596407c@acm.org>
In-Reply-To: <93786c91-3008-9213-82f8-e5716596407c@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 09:32:00 +0200
Message-ID: <CAMGffEm6XNJOxexDTGz2AZxaTV2f4icx+FkDivGqKzvLYtza9Q@mail.gmail.com>
Subject: Re: [PATCH v11 16/26] block/rnbd: private headers with rnbd protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 5:58 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +#define RTRS_PORT 1234
>
> Is this a default value? Please make this clear either by renaming this
> constant or by adding a comment

Yes, it's default port number, will add a comment!
Thanks Bart!
