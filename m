Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DBFC433F5
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 00:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0193E61039
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 00:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhJKAUg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Oct 2021 20:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhJKAUf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Oct 2021 20:20:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434E5C061570
        for <linux-block@vger.kernel.org>; Sun, 10 Oct 2021 17:18:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so50356922wrg.5
        for <linux-block@vger.kernel.org>; Sun, 10 Oct 2021 17:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ertAYRuBrO4o1phVoXpE4ROiBPxr5B4o34tTZaBB8A=;
        b=DPfU03D3DqsL+CkdbZ/BDchAbEN5TtBMbdvFV9GkUeSTuTTgA/INSnQlJdCMxC5cQI
         ybD0bKSGMABhPCrWhW7opF0hAycAKHYKGQbNVBRc3BJ7ls05pGAl6mLWfdu9b36B46/N
         v10OImb6nVtP5wrgqKce/WtzXxAGHx5J1Zli7xFEBtx+D/5rjv9fNVux7EcEqqyMdYOs
         xrlmUfrxBVHye0urgF/RzoZRqtuVfIN4Jlaj/QMA+AIqvaqLgAdjSgEFFNL9znvjDQpV
         2wp5dSDTPpMu9QatmmmptpJgYSK/pwe9YC2GD9i6YukCjMK04OcaIs5ypDP6Up5mWO1U
         qj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ertAYRuBrO4o1phVoXpE4ROiBPxr5B4o34tTZaBB8A=;
        b=JOy+2QDP6/MUOOaOuVysLIATtz8EdXXq1QoeUrORPoIFkJsSiL9xjnPsus8A5uKMAn
         57V0SYUwmP/YS8iTG5kSFzQ4aWuyHg1HbTX56L9XocpLbNguMkhs2sic2yEcIvfTBro/
         VM3YbqLltuNZ1AbIkjRRTrGE+AZNVnD0C6Bld5opskom7fJ83PDiLMsGCkrQNRRBWBeK
         EdKH8ZfKg6rsdq9N7/otGyyIjovkiarsCTNva3NYXxyxWrmb8IsG4mpMumA2gkMg/47j
         gFMjnlUHbexl1zJ7/P5kkCDc+K6Kyt+gwDZ1m7bWH9A0YKOXw1Qa0itcnFTnV/XCsjnN
         0Vbw==
X-Gm-Message-State: AOAM533Ff4Cb/6cmczD5ENwd1+3ETjJdvMP0lqNEAeLAxcOX55lvSr96
        /B7H+M2BOJP6yxx4Eo1adq9QMIX55s00vA==
X-Google-Smtp-Source: ABdhPJzLmNrhjQpndv3iPH0ThAst4NK4h72w8khYnDOD3zReF83j4toL6PQbN/Ipmxjv69D5fNHlSQ==
X-Received: by 2002:adf:e101:: with SMTP id t1mr21586690wrz.395.1633911514884;
        Sun, 10 Oct 2021 17:18:34 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id d8sm6190613wrz.84.2021.10.10.17.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 17:18:34 -0700 (PDT)
Date:   Mon, 11 Oct 2021 01:18:32 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lumip@lumip.de
Subject: Re: [PATCH] cdrom: docs: reformat table in
 Documentation/userspace-api/ioctl/cdrom.rst
Message-ID: <YWOC2Iyszh7WAgzf@equinox>
References: <20211007231720.31997-1-phil@philpotter.co.uk>
 <464a0b2f-c556-ccda-aa3c-26733fba4617@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464a0b2f-c556-ccda-aa3c-26733fba4617@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 07, 2021 at 04:34:13PM -0700, Randy Dunlap wrote:
> On 10/7/21 4:17 PM, Phillip Potter wrote:
> > Add extra space to the first column of ioctl values table, and also realign
> > the text in the second column, to fix a documentation build warning
> > introduced by: commit 67f1e027c270 ("drivers/cdrom: improved ioctl for
> > media change detection")
> > 
> > Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> > Fixes: 67f1e027c270 ("drivers/cdrom: improved ioctl for media change detection")
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Looks good. Thanks.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> 
> > ---
> >   Documentation/userspace-api/ioctl/cdrom.rst | 116 ++++++++++----------
> >   1 file changed, 58 insertions(+), 58 deletions(-)
> > 
> > diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
> > index bac5bbf93ca0..682948fc88a3 100644
> > --- a/Documentation/userspace-api/ioctl/cdrom.rst
> > +++ b/Documentation/userspace-api/ioctl/cdrom.rst
> 
> 
> 
> -- 
> ~Randy

Thank you for the review Randy.

Regards,
Phil
