Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81852C04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 23:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5310020818
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 23:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558047902;
	bh=YBVVu0V+X1TbeXgS5CGFpdhpwfmyR0/cEgHVpu17tMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v0wmUAvHdELzf/EgR+n39uCfdl8O2QbKHIXDTvPFz5qvYzxVYg1X84RKeJCwjHxT5
	 EdQ3Mvi6o7bghy328f6ht7Cv+HU+RmMabQ0D+0ef1MIQadY+4TY5PcAicVP1ajy76R
	 gm9938WxJ6vRrWv4I65V/SipCiZyaXFLruyOdYwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfEPXFB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 19:05:01 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:47038 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfEPXFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 19:05:01 -0400
Received: by mail-lj1-f177.google.com with SMTP id h21so4544097ljk.13
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 16:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C6gmjJd7N5Nv8q9iz96Jdb1ylTkw3RMOCbKRe/2+VB8=;
        b=dxgqfs9fq2wqHK+mmo4PR9pjY/d1/hIFkR4vuEe2dGD68H7Lxiz4SeW18TGqrOEdQY
         ozZMj6Mlzb+cL2/EPgw9SpdZwXLyvMNijkm1AHy+m5NfiR/bY42dju8qX4mXfGxMHzEE
         DGd2CEi2T8RpC8XD5CJWIJUJqLtCmdrM2F6WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6gmjJd7N5Nv8q9iz96Jdb1ylTkw3RMOCbKRe/2+VB8=;
        b=HeI98u+80y7XSjjhCKbX1ElOEpmDSCUzquVDY8AA4pcUQzASs8OAz6kFwlbMRfYEUB
         okVs56tjBljMOgn9M63e2dceO/YjXXwKiieTc64OU1i+jmQ34NDEqebz7U5KguFSTMhW
         6iitEln6qFnbQnTL/jvvolkXHP8PseEc7RQpyzXS+OXgpKA8xfxyoI7a4oU3Phd2ZXs2
         k8Rl0Az1/QcJS+I78VNTb9AzKa5w+96iLX4Jgvg1Fdsu0RyjmHPIBWOizmNvXc1Q40sZ
         o7AH3WUMVeR0ZxEMzyphHs9EMSnnylUrHzSIVFKtq3QWJ/ZUZQIIEvSAK8MFfP7ZHDHy
         CFuQ==
X-Gm-Message-State: APjAAAXPSjMm/AyuCRic7PPvGjljpCbLWXK65Ppy+I5+b82uW+yFMdVj
        lPRM0EtlDRdcowsMpz/hfai65hNR25U=
X-Google-Smtp-Source: APXvYqyAjMUJt5A94Z0Kiq+jrTY3G+KVmMPiw/yWaO5HrT9r0+FPTtbGRfalJZc7w8Dpz8l9zOnQuw==
X-Received: by 2002:a2e:2b16:: with SMTP id q22mr26378764lje.20.1558047898617;
        Thu, 16 May 2019 16:04:58 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id d16sm1181219lfi.75.2019.05.16.16.04.58
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 16:04:58 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id h19so4607393ljj.4
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 16:04:58 -0700 (PDT)
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr3767139lji.189.1558047564003;
 Thu, 16 May 2019 15:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190513185948.GA26710@redhat.com> <20190516143206.GA16368@lobo>
In-Reply-To: <20190516143206.GA16368@lobo>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 15:59:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whepZ=ht0h-+XaQzag5eAVQtofDW_gUknwu+d+Cnh+yQw@mail.gmail.com>
Message-ID: <CAHk-=whepZ=ht0h-+XaQzag5eAVQtofDW_gUknwu+d+Cnh+yQw@mail.gmail.com>
Subject: Re: [git pull v2] device mapper changes for 5.2
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Bryan Gurney <bgurney@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Colin Ian King <colin.king@canonical.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Helen Koike <helen.koike@collabora.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Martin Wilck <mwilck@suse.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Peng Wang <rocking@whu.edu.cn>,
        Sheetal Singala <2396sheetal@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>, Yufen Yu <yuyufen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 16, 2019 at 7:32 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> Seems you haven't pulled my 'for-5.2/dm-changes' tag from earlier this
> week so I've added 4 additional simple commits to this v2 pull.

Hmm. Strange. I see your email from three days ago now that you
mention it, but I don't recall having ever seen it before.

I must have fat-fingered it when it came in, and it was marked as
"read" without having ever been seen. Possibly because I was traveling
for my daughter's graduation, and being on mobile.

Anyway, good that you re-sent, updates and all. Now pulled

                  Linus
