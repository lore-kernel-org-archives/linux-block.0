Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89101C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406152082D
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMInVECG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406152082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeLDPCx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:02:53 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40845 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbeLDPCx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 10:02:53 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so14835830ita.5
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qh/wV9x3S3cyWCk64DCI2ErdXYcx2GoynHE7n3HA9aQ=;
        b=aMInVECGXpVp9gtqYLDnvb5BcfP9np8PWQII82Y2aEuBlEa7Sw9CD9gasgHPM4o3Yj
         Vs91GGiObXMwIWB6Pl/mECu47VA1Y0yahyx89r8Qsjp4ZMTEw5dumA9A3M6BtPwbXh6X
         OqmWic6HiYsOu/tnsQFPXrSw7ifFGR5Hk0F98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qh/wV9x3S3cyWCk64DCI2ErdXYcx2GoynHE7n3HA9aQ=;
        b=n6wNCPsr0JCTvaAPy9O6zcYxAAJL8FDZPyzv6FDixLg9reIOR8Z087G9QqT/OQVN+s
         EJx7NORFpAt9kdKAF67CHD7S1+JNqgS1H8ykPkC6deC1Ac2IA4aoctlyHXeUZmwXoYV8
         Z1ZkqyaxhKBsF90TnMOxa4aA4vZvLLEjkfgAUkibzOnH6R4Xoz3O26KVr1cLzh+0P+0b
         BKUyXUZ81ZXyT518IBmdt7PRAsL7imi1XLGWdvVvP9zVTw4qTGYslIO99Aq1YCsgwY8A
         p7SZ8saEyotnPGNE3syoV4Mak5l/CTGcrBQuyuHJNCuDWucMX66sB5PAfeTcxdSfd9DI
         v1DQ==
X-Gm-Message-State: AA+aEWbOthADJ0Pse1XsrW1OyjhtAhcF66ov/QAbRMth6HBDnBCE7ImM
        B6Ypo1Vj2qMYyoVWQWAly3uK77VrqFZe+vy3PBSemA==
X-Google-Smtp-Source: AFSGD/UGjYsHviHw8FDYua1w6Q3GuqeTjcmI7HjCOkhpqiEsqtbU7xdmJF1cT5pvgNAEOBQQx6D5KkclXMGInHJUhdw=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr12202685itk.71.1543935769699;
 Tue, 04 Dec 2018 07:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20181204014323.1438-1-liuyun01@kylinos.cn> <20181204150124.GA23762@infradead.org>
In-Reply-To: <20181204150124.GA23762@infradead.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 4 Dec 2018 16:02:36 +0100
Message-ID: <CAKv+Gu-9uWo3xnBdNjJ_FOyuy6ifqdABppRRdxiVm=-p9Bt=EQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] arm64: provide a NEON-accelerated XOR algorithm extension
To:     Christoph Hellwig <hch@infradead.org>
Cc:     liuyun01 <liuyun01@kylinos.cn>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 4 Dec 2018 at 16:01, Christoph Hellwig <hch@infradead.org> wrote:
>
> Why does this go to linux-block?

Because xor_blocks() is part of the RAID driver?
