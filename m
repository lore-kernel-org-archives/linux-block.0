Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68971C10F0B
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 19:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350D52063F
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 19:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eIy1fJq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfBZT1v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:27:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35389 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfBZT1v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 14:27:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id m73so4978488lfa.2
        for <linux-block@vger.kernel.org>; Tue, 26 Feb 2019 11:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxqmNmB3vPxLiIOD/Vp/eA6xu4IV9Wmk6Kx9vpGJNQg=;
        b=eIy1fJq/TkcoYGKwOqOWNV2Oqs5Za8rH61I+zD2huHLiBD7XNSLYSW050QFR3I+qkd
         kyDnvyP6py9eyeyWZi+Wne8NA0n4tLFoHynrfaSEYh/IILLnhXlofWxdR5DiaoSfG0Vn
         VnwBH6+t+rVnr6PEsnv87WvtPBZeHnhU0blxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxqmNmB3vPxLiIOD/Vp/eA6xu4IV9Wmk6Kx9vpGJNQg=;
        b=c91sSb0Sc08cYtgUEqRMNHQX2p+UEvBX8ROUMO3GuVD/gxb9F8/aeXSCYDTeBvl1Uy
         2cbX7xHlR+B9qIcE7LHRErUeqH1rVPfkYg0VVPrZVKk7+7uNFNnjyD/in41PkDqkulFj
         foR9a98p5DwTEIFI7C7GLLihL4uO8JDbd6/GVGe+JRVZYQdOBbcQu9QnEwzw3AgVBOtQ
         /yEcV38cFG85i+ctExIyviQHb6fTwdgivqnX6NCd+FH+x/uv/Hw+fGPJLvZYFDU7CgYu
         yQu4dfLor+q61jaei+43O6VciGvsm0sSAaNog+72UdseiqMzDXxB8FMD8gipSGbbFuVe
         hjcQ==
X-Gm-Message-State: AHQUAuaT788KOyw55Ckwavw3BA+GKGWQcEOcwv5Qrt3OhEaT76eBIbym
        l9qMqe6ypuNTEoBgb08ldURWlfIgBnw=
X-Google-Smtp-Source: AHgI3IYwyb0/fj1Y9yCro5FwY9IphkPO45K7w++YXnMZ1nQaLxzTSyzgb/Y/PjMbeeUMrqFBvbTMLQ==
X-Received: by 2002:a19:48c3:: with SMTP id v186mr7758186lfa.40.1551209269055;
        Tue, 26 Feb 2019 11:27:49 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id p21sm3405624lfd.4.2019.02.26.11.27.47
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:27:47 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id u21so10566634lfu.1
        for <linux-block@vger.kernel.org>; Tue, 26 Feb 2019 11:27:47 -0800 (PST)
X-Received: by 2002:a19:f607:: with SMTP id x7mr14526026lfe.47.1551209267220;
 Tue, 26 Feb 2019 11:27:47 -0800 (PST)
MIME-Version: 1.0
References: <20190207205730.199332-1-evgreen@chromium.org> <20190207205730.199332-2-evgreen@chromium.org>
 <yq1h8d7qew5.fsf@oracle.com>
In-Reply-To: <yq1h8d7qew5.fsf@oracle.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 26 Feb 2019 11:27:10 -0800
X-Gmail-Original-Message-ID: <CAE=gft4UXAZqorCfA-F2O8b__ZM-iM2zn6+1KQevU7UL1tceTQ@mail.gmail.com>
Message-ID: <CAE=gft4UXAZqorCfA-F2O8b__ZM-iM2zn6+1KQevU7UL1tceTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] loop: Report EOPNOTSUPP properly
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 6:32 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Evan,
>
> > Properly plumb out EOPNOTSUPP from loop driver operations, which may
> > get returned when for instance a discard operation is attempted but
> > not supported by the underlying block device. Before this change,
> > everything was reported in the log as an I/O error, which is scary and
> > not helpful in debugging.
>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>

Hi Jens,
I think this one at least is ready to go.
-Evan
