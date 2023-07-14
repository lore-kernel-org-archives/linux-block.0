Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA998EB64DC
	for <linux-block@archiver.kernel.org>; Fri, 14 Jul 2023 21:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjGNVJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jul 2023 17:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbjGNVJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2023 17:09:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F8F2707
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 14:09:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992b66e5affso314292766b.3
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 14:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689368950; x=1689973750;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=XsdnU0b3Xz0Mjt+aMv9seQBfoJzz9nd8YW05GuB4KP4=;
        b=byc6vYPDZvu+iuG3FZ7LWYeIggSvJNcpnUIBmmqPKWbUaVdEFqHG65cQRX+unHMnb7
         O+pYY20v7lGF/5y9kNef+ohQyV4uh7QnX6CbdLGrSFGv448+Uxu8PJU9+uFD5NDoCWjF
         N/lQwQvO0//kRkJA7zS17LVue1JuLArMcyuMxNLdeP7I+DbjOU6gU2tVBP6QgKcaANKc
         t6bdYoeusWTRS7I4DX7wQK94QgMmOq06GThlH0eta70cNBksIk61lugSNtzyL/OGE20N
         cTgt6IxNrEe57bYBu0U3ZoGaDd/wJ+ffOoqFQemKQaTSXDQaqXZfT7dK/m+rzJc847hm
         oeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689368950; x=1689973750;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsdnU0b3Xz0Mjt+aMv9seQBfoJzz9nd8YW05GuB4KP4=;
        b=LOKS9PbCPnLjFEbhXRPh9pJHcJJIRgDBKXLEEB9M7k7xyDuiR389C5IgE3WuZmJt9l
         +tDws/UTzxnSi/Id7fjFsomCdHuyoDVR+qbjU73bo7AY2Ns2Q+Sqtc/QM7Pv2NOO0uHu
         HuzlM3jXDsKTYn+HvIV8Zn7rAyvgT+xDD/HUeY1NpfhDPuiJkvdC7OZw8Gm5Of0WlQh4
         f5WFw1X+7U+oxDNruOGPeIiJItkCO6agjG/n638SlsnhGpR++5Hbd6mKfJup1B1y5pWI
         tWdxkJwlc8RqtKJ0UdvAMmjZKj86jTI+ZV0jeQWVQw3cjgPPMPuLHiH/axLf2AnAqNPh
         WGxg==
X-Gm-Message-State: ABy/qLavtS6H6Mgx08KvU1nJv51XfQZJqxG6XbDOdEXbfo9KPPsYHqtE
        XsIJn+QYbhCwPWtpH3UN4T0Ad7SxEB/R9+gILs4=
X-Google-Smtp-Source: APBJJlF/O/P26+uPSb0iX05TbtDl/PwANwRiKVzvMH3q+qOWyIHb5Q4YAV+YZ5wEwYTBmFqJWhCLGQ==
X-Received: by 2002:a17:906:1d8:b0:993:d7c4:1a78 with SMTP id 24-20020a17090601d800b00993d7c41a78mr4532830ejj.10.1689368950525;
        Fri, 14 Jul 2023 14:09:10 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id h14-20020a170906110e00b009829dc0f2a0sm5950050eja.111.2023.07.14.14.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 14:09:10 -0700 (PDT)
References: <20230711072353.200873-1-nmi@metaspace.dk>
 <20230711072353.200873-2-nmi@metaspace.dk>
 <ZK6/0TKxe2q4/hi9@ovpn-8-25.pek2.redhat.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        open list <linux-kernel@vger.kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH v8 1/2] ublk: add helper to check if device supports
 user copy
Date:   Fri, 14 Jul 2023 23:08:05 +0200
In-reply-to: <ZK6/0TKxe2q4/hi9@ovpn-8-25.pek2.redhat.com>
Message-ID: <87wmz2w68n.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Tue, Jul 11, 2023 at 09:23:52AM +0200, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>> 
>> This will be used by ublk zoned storage support.
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
> BTW, both Damien and I have reviewed this one, and you can put the
> reviewed-by tag in patch.

Argh, I knew there was something I forgot for v9. Sorry.

BR Andreas

