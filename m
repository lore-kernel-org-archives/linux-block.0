Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C3EC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F67222C1
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 20:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USOYqAlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfBLUAb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:00:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40680 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbfBLUAb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 15:00:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id q1so4118407wrp.7
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 12:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lofy8RA50K+szKa+a3qI2piKtixtV4KDHf5fd6Bgcow=;
        b=USOYqAlFI6o0L4l3yIu9puAZowiipcPLbPCnjdqDtaqbF7UBpPSV5a6wTiQ4iOeEyT
         DSIRRZEc9cp0Qp/sjiZjlKAdqWlz2bKdD9BNmrpjIQ1DjpndSgAg2PZ4iTbl/ZV/ZwsK
         jYDCeY54oNkv8pw1cTk40VI2CKeI8RqDChf4NGnxUiQBifUDb9NZ6J5AmmK3+vInEA7B
         njPhEwxrbmyzJpp5v6lcHMFhY7GDB41g624auJ8E2GszszttRa6TV/L3wtZMVLE5AxUm
         XtDGS8cK7XlCdy45IIwyxyKL+m1v+p2icDw2gkODWQ5Vx3jQ97q4vDJM1OUIIRMYr4AA
         +A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lofy8RA50K+szKa+a3qI2piKtixtV4KDHf5fd6Bgcow=;
        b=DoYwHBhM9BqgTkGuddKoEgXIONinyMR9X2FOdX1Q/odCcv2PQX/wESu7NRald3+Rp0
         4SMTCGAJqPcRzkxAdcJEddKq/1Br+XiG/RPUVIj384whknQ/3d2g6jrKncjCTlvx+Wtr
         zLbaLTqRNzgjwsuM8jR7vPSDNuWqs6m8lrBBLjXXTi2HJmUmlrFseOIhlAV1DC9BddGU
         qZtgxS3y5acXJc23J1+YvDHBbNIiseRHBTSXC3SeHg3qxQ00oV4CaMeIiJwx0sG2Iq7s
         vbgPtsmE/nWeHvvZ2wAJwcP6O92ULc+LsUUh38g6fHnV31mOz3EFmbMOPV/xgvZKqP+H
         QdQQ==
X-Gm-Message-State: AHQUAuYuyxWSdb3ou8y6sRIfQyhakgD8LJhaWXu04raFMFAGgqRLAHY5
        LtrCZH/MpMMgvLW0DU9qxauvk+o4TE2y21GnW+mqpw==
X-Google-Smtp-Source: AHgI3IYSTSqAUthWbrQABSgT+w5kpkBrEbysYt9vmH1EtRj+PL+qgaMlvn9dUvquuMciTojfBV6MJTm6aMUbm8XfKtY=
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr4313181wru.177.1550001629193;
 Tue, 12 Feb 2019 12:00:29 -0800 (PST)
MIME-Version: 1.0
References: <1549987525.3173.17.camel@HansenPartnership.com>
 <e9a411a2-49e2-4897-4e02-1cf790465cbd@kernel.dk> <yq1zhr1t028.fsf@oracle.com>
In-Reply-To: <yq1zhr1t028.fsf@oracle.com>
From:   Xuewei Zhang <xueweiz@google.com>
Date:   Tue, 12 Feb 2019 12:00:18 -0800
Message-ID: <CAPtwhKpqggL1k8wsh-ECS6aUr7qThUyHjgx9BGeL84bCbj9Lvw@mail.gmail.com>
Subject: Re: [PATCH] scsi: sd: fix entropy gathering for most rotational disks
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Theodore Tso <tytso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the fix James!

On Tue, Feb 12, 2019 at 8:59 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Jens,
>
> >> The fix is to set the non-rotational and add-randomness flags
> >> unconditionally early on in the disk initialization path, so they can
> >> be reset only if the device actually reports being non-rotational via
> >> the VPD page.
> >
> > Reviewed-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Xuewei Zhang <xueweiz@google.com>

>
> Yeah, this looks good to me. I'll queue it up for fixes.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
