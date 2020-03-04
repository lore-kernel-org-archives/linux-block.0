Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8786C3F2CE
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 18:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09652467E
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 18:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="bI8y6w6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgCDSRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:17:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41119 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDSRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 13:17:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id b1so1366004pgm.8
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 10:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2HwMedrH5yyZHUhyXgGxNWpnOgjHM00DBB5ohML87p4=;
        b=bI8y6w6FV8hr035OoDuAC6Z+MhXnnyn+mHinCelG50M3lDHk6JdaROFSkEtwmAGaRh
         MelqQUYuRRg93iE9wKkAtNShlgpP/Tx0K72Nw8oeLoBHhuvYj9Ju9OtpsVMv2ewGjZ0W
         8KGvlk39mYeP3gaMHI0iFl3i4q1o1Q1IhBRXjEdHhzyv+nkS/kI8mmF4MN45QXQmLXDz
         Zbn/isVp2zlx0LH8Wtjcgl2PJYZC+PHvpCLmd9qXP53ksNTkE1XvqV3jc3wZnLU1b2uc
         GnDhNYCG3fkZOxcF9sZ+EhfA7DnYsOf9VvAavgABE3NqmA2uGukmvQTb1Zx4Wrwyz1qp
         XHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2HwMedrH5yyZHUhyXgGxNWpnOgjHM00DBB5ohML87p4=;
        b=DosOABfAB5jINIP/phaTIon+C/UM0TI3FL5IyxHvTufl5b/AEMg5wFxjESXJ7BCi70
         O1QCc2E4QcAbnHaWX11mMHRcgu1vBnKOdPV/S4bvY0EBrhfKzJPXdMW4k0xIq76BbkdZ
         PPTAh4mVQLVeb1h9DN/ZH1ByLr/zJx13yhabWYYpMUhYQN3EUeaHtyTNu1nqrJ5Ue5Im
         rH26wD2mWupTfAabwKttL1NwLC4RdqqM1lvGd6J/RAeUVi/0h8ngjYbHIZt4PFlaw4y0
         mu9rcOL6jRK54bgTh9QRbWcvsD6XDE60KTyVnzVDz0ngNHWRegmAtyPgG2gymvgJ1vzx
         Jneg==
X-Gm-Message-State: ANhLgQ1Vw6r6y2NNBt0wQyJgmo+URK0zAezr4sc2NQgeRDp67uEThbja
        zdXnvlwuadLOflwwfGzUg2beAw==
X-Google-Smtp-Source: ADFU+vvXZFsO4SzuB8Qn055AIpZpCoUxUNUEhRRDIIFBXYhHKxdDLEWz6QAC1IccsLGptMbWgDqvQw==
X-Received: by 2002:a65:669a:: with SMTP id b26mr3699418pgw.24.1583345829024;
        Wed, 04 Mar 2020 10:17:09 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id w17sm28649761pfi.56.2020.03.04.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:17:08 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:17:07 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block@vger.kernel.org, sunke32@huawei.com
Subject: Re: [PATCH blktests] nbd/003: fix compiling error with gcc version
 4.8.5
Message-ID: <20200304181707.GB271003@vader>
References: <20200220144649.16881-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220144649.16881-1-yi.zhang@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 20, 2020 at 10:46:49PM +0800, Yi Zhang wrote:
> cc  -O2 -Wall -Wshadow   -o mount_clear_sock mount_clear_sock.c
> mount_clear_sock.c: In function ‘main’:
> mount_clear_sock.c:39:2: error: ‘for’ loop initial declarations are only allowed in C99 mode
>   for (int i = 0; i < loops; i++) {
>   ^
> mount_clear_sock.c:39:2: note: use option -std=c99 or -std=gnu99 to compile your code
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Thanks, applied.
