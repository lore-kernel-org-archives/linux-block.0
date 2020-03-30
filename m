Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BCAC2D0EB
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 17:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091E420781
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 17:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=blockbridge-com.20150623.gappssmtp.com header.i=@blockbridge-com.20150623.gappssmtp.com header.b="Ad+nBNSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgC3RIV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:08:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44572 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbgC3RIV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 13:08:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id a49so18825245otc.11
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2020 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzOIcpQMGry/S7KX/3i7FgRktSaDHF+E1Qb4eqLRCuI=;
        b=Ad+nBNSpjurCoWqj//saej4OFOKjZlYLa0jKuodco+te+2JVG/IANMC0ikGvaZGOg9
         ehwwvhE5XhgZpWyO0m9adpKNM4PYIQaxkbNUEHZf9Sy3sOzUQ88RnOSIl5hXYIu3symh
         2Yzv1I0vyFWGAEfDUG0zNQuf98O4BdjfDYJTUE7jFws0nGCYTn19Is7qyYIL5hrqRWgt
         rDx0G/o8YABjNrEhlFc6aY35c65jRO4QjO7+cJG871TLgXoTAxgN9C6wlTwv1MsBDXlg
         15QEJSRz69OeHuBm6MfshBiN30xhgVlJOeAU0T4Ra+XlpoI1qPuQCkRPGdDJyx4JBLRA
         whtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzOIcpQMGry/S7KX/3i7FgRktSaDHF+E1Qb4eqLRCuI=;
        b=tSjno8zA5rfiVImpCcrHqZVO93NXTsGQ2m2T6x3dAgK28XOhRICs3Fk939GRW06Kjw
         HG2LyK/F7FDti3w+ecn5+6AFjgvoqUzWp9udqtQ4F0YzAxalnufVWBqUq9S9tKEPwNSJ
         NfPg1bIP8qRwULRneS08AGHUp9xvB9l28pHmdNGi6uyKuf9x56yOdDnjN/OVL8fE+XoE
         MMX/30EBWg3FumkSEJUizL3hQyWcmyC8CbSBSPjeMTVXPE+PmGyWel/GWvWW+3ErBvT3
         aGCvYN3XQZ2t+FgA7o2tkronrE9sLyHWi9/ln3S3dlI2WtnBHIhuR/+Qku4T49/xLABQ
         Z4Dw==
X-Gm-Message-State: ANhLgQ2KrFwt6MSqaSG/6rbEMKByBbND0ZKsO3b88e7UzdEl9HVb47ie
        8RpxWthnuy0KnYan/9dmxCjkmRAumfcF0dM2I3TjNA==
X-Google-Smtp-Source: ADFU+vsZduY51eDd7FS9ubS+PNYEHKDob0M//Wghi65nlZ5LqUBQIcY9bjjm+Kk1UD2LVIpEBTaw7W/SLGM8xpAsD6U=
X-Received: by 2002:a9d:6ad8:: with SMTP id m24mr126508otq.66.1585588099575;
 Mon, 30 Mar 2020 10:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p> <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p> <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p> <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
 <20191204010529.GA3910@ming.t460p> <CAAFE1bcJmRP5OSu=5asNTpvkF=kjEZu=GafaS9h52776tVgpPA@mail.gmail.com>
 <20191204230225.GA26189@ming.t460p> <d9d39d10-d3f3-f2d8-b32e-96896ba0cdb2@grimberg.me>
 <CAAFE1beqFBQS_zVYEXFTD2qu8PAF9hBSW4j1k9ZD6MhU_gWg5Q@mail.gmail.com> <d2f633f1-57ef-4618-c3a6-c5ff0afead5b@grimberg.me>
In-Reply-To: <d2f633f1-57ef-4618-c3a6-c5ff0afead5b@grimberg.me>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Mon, 30 Mar 2020 13:08:37 -0400
Message-ID: <CAAFE1bdAbKfqbf05pKBcMUj+58fijDMT-8WBSuwiKk2Bmm4v2w@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sagi,

> Sorry for the late reply, lost track of this.

No problem!

> Can you try attached patch and see if it solves your issue?
> WARNING: very lightly tested...

I have run our tests against this patch and it is working well for our
"basic" testing as well. The test case that previously failed, now
passes with this patch. So that's encouraging! Thanks for the quick
response and quick patch.

One question we had is regarding the hard coded header length: What
happens if the initiator sends an extended CDB, like a WRITE32? Are
there any concerns with an additional header segment (AHS)?

Thanks again,
Steve
