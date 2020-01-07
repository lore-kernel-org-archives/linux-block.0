Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7609BC33C9E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBD721744
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="aTXBE9F/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgAGQxX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:53:23 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38211 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgAGQxX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 11:53:23 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so23352ioj.5
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 08:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axx5QWtMxq2b4c/GsWxRCsq8m0TaNSUhoal+YFmgkSg=;
        b=aTXBE9F/TW8mZyTYXFXXTY3Vs8XyRFCzFdDh33g69hbFsQE9qicbvE2YjDfPkM8J3u
         qkE9V4oOClLFW7x36ICgwy0qYK/yJnW7OAJAZ8L3xZi/jwjJAhOduMJpGQKg+QHcjd9u
         h2+sB+MLS/fY7+GPMteeSEmE86W4m6kbzmze8lTWtkladfva4i66fnvU2Qi+PBCX29oJ
         eCD9GiobI2VdZwLU+kfmYAdPK1wH4mcTVcVErSRl7f9m77i4uvuJQZN0ZQHwHezq+V3H
         e/bZKMsiC4WTgcNDg6iRimJIY7dkwt47MpPBCpS/qKiwC5yI+EGgsSOTPxclsmP2CXZM
         0r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axx5QWtMxq2b4c/GsWxRCsq8m0TaNSUhoal+YFmgkSg=;
        b=JZABFsR7ch5oGoNQbqlbi5Rog9vNx9SKn1CNjY3L0kT4AGTMKxBlibQGiejNysQXY2
         GUoj6qEPW+edp0baSEr+tZOQ7IgeOcBAgPgcCjF6Z4TwcAbxqMasFj5nq53vnbiOTDIu
         QheDV6EiEU5RZfah+hWfsAI4iKJyBKygAWM1neSB/in/wKJoVj4cOjxAeqBtKyaClTL6
         JgBlQySFjmnd4oqUrMF1fAJby4CyaGKZVeqdK24bKLS5wZMI5YCqi9ILa4AcYfMwCqHL
         3XYfqZuu8pI5wAJCuxFtzOtk1MIfDR4DvcMtAgj4BwqyqRI7HFHzO3t+YqsdFnUJHMMr
         MzRw==
X-Gm-Message-State: APjAAAXGpB6OwMmz1DiCanSylQgXyTwSUVfIFeGMPILV0F8MuFEeZJUl
        sEsEV+9XOtPDIGWOqxHFl31Dd8/IJJqq/SpalMwg6A==
X-Google-Smtp-Source: APXvYqy1xVOPCpEMetKlvx52b/dRNErOEuOtZUmRKb2MO12RH+NYkGwP4G+fVNpiS/3HtAtzYhj3Aj5vu0sNmeM6Ye0=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr75502479ioh.22.1578416001599;
 Tue, 07 Jan 2020 08:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-16-jinpuwang@gmail.com>
 <f8ec030c-9279-c5c0-617b-26305327a3b0@acm.org>
In-Reply-To: <f8ec030c-9279-c5c0-617b-26305327a3b0@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 17:53:10 +0100
Message-ID: <CAMGffEk1DO6atu6V3OUJ2PbqauVFLLwNjqB6jvpLGpS8jhX2+Q@mail.gmail.com>
Subject: Re: [PATCH v6 15/25] rnbd: private headers with rnbd protocol structs
 and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 2, 2020 at 11:34 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > + * @device_id:               device_id on server side to identify the device
>
> Is this a number that only has a meaning inside the RTRS software? Is
> the role of this number perhaps similar to an NVMe namespace or SCSI
> LUN? If so, please mention this. Additionally, does this number start
> from zero or from one?
device_id is only used in RNBD, RTRS doesn't care. we documented a bit
in rnbd/README,
we can extend the doc.
it is similar to SCSI LUN or NVMe namespace, it's an id to associate
the device with IO.

Thanks Bart.
