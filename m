Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3ACC00528
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 23:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjHDXLu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 19:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHDXLt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 19:11:49 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603B74EE4
        for <linux-block@vger.kernel.org>; Fri,  4 Aug 2023 16:11:41 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63d09d886a3so15956926d6.2
        for <linux-block@vger.kernel.org>; Fri, 04 Aug 2023 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691190700; x=1691795500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7LI/S/OevvCT8dlDRfxneTW0yS08CDgZop+m3jGuRs=;
        b=HkSYGeBaNvpw9vieOK8JMxCIT6VhROgdq00s1KtCHCjgi0ciiNiuPog3mMj/jZJ/h7
         p3OrHb4Z2xWpHnHaGS6v6w1yPFpkaudUEF8F29rj1C9yxrjQ0Gh6dO3+ECyD9YjKJAsA
         4sBWjEGJWHTKU5mkgBcOx47McVJizKhsCRfPpTkwD+qZ2Gl5N4mTlGhEXbZTGrFJnkUo
         KuzXwDV+5dypiWEboy7XNYWdkQ/BY09fxtY4Tkh3E4+MCFOTKpmi0Eo0c5GtFFZzgq4N
         PJHqiErx3iS+jpgSIHxyU2j/PL+OiSskT0rdoLkutS6zHKZLNRryewGZ8JNE7BSoS1kX
         SpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691190700; x=1691795500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7LI/S/OevvCT8dlDRfxneTW0yS08CDgZop+m3jGuRs=;
        b=ftplH51v8m6jZK9C1Lp5hsyoy6Xjz9045jhYoLGW6GK8lLGsns+4AH+QCbH6arvy+K
         UoM5+u5S02RiXlKTjWEy9aCALYBlqSlGGQ7g1n4XPD80vPOBsXZAmZTQ8KeOjtGXdfpz
         V/xsMYM3uAqntKsOU24aQhSdB12x1bxQNhCu3di0mpx4Oi0tkJdirZDUUpcNWQnEFF1U
         kmi1bOTd2ehFLLoiOkwTLGGmcsBVTgqNWlejrlJCStB76GY6s/+sOELploN8W6dfybFP
         l8ZCggC1v9SpGIMTTZbz+tM8HXb83Ep58sORQlEPIwwqyXfpo1v+zYER098eSLFa9oVi
         nUsw==
X-Gm-Message-State: AOJu0YzZKvu4IPuNHMlCvaBJpHUikHrvmJ28oVn2n71V9LXzXlliHqGF
        7IaJhehPXHZQALsqRFyb6zPmMoZyyQGxZ9yY2aPNkA==
X-Google-Smtp-Source: AGHT+IFXC4PbFH1KSqnDJZtWZySsNxjZaBEs/YvKmT7aGdo6+gXK5tVnzXUIV8CoUFMh2E+atFwYfpd9MJJ3JBGDgZQ=
X-Received: by 2002:a0c:e553:0:b0:63f:726c:14ef with SMTP id
 n19-20020a0ce553000000b0063f726c14efmr2502233qvm.9.1691190700350; Fri, 04 Aug
 2023 16:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230612203314.17820-1-bvanassche@acm.org> <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk>
 <20230615041537.GB4281@lst.de> <1d55e942-5150-de4c-3a02-c3d066f87028@acm.org> <20230616070237.GC29500@lst.de>
In-Reply-To: <20230616070237.GC29500@lst.de>
From:   Juan Yescas <jyescas@google.com>
Date:   Fri, 4 Aug 2023 16:11:29 -0700
Message-ID: <CAJDx_rhf0ex9EAZcpqqDmvC96dFgVXWh0diNZ3fb3narfY0_rQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Support limits below the page size
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 16, 2023 at 12:02=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Thu, Jun 15, 2023 at 06:55:36AM -0700, Bart Van Assche wrote:
> > On 6/14/23 21:15, Christoph Hellwig wrote:
> >> I really hate having this core complexity, but I suspect trying to dri=
ver
> >> hacks would be even worse than that, especially as this goes through
> >> the SCSI midlayer.  I think the answer is simply that if Google keeps
> >> buying broken hardware for their products from Samsung they just need
> >> to stick to a 4k page size instead of moving to a larger one.
> >
> > Although I do not like it that the Exynos UFS controller does not follo=
w
> > the UFS standard, this UFS controller is used much more widely than onl=
y in
> > devices produced by my employer. See e.g. the output of the following g=
rep
> > command:
>
> But it seems like no one is insisting on using it with larger than 4k
> page sizes.  I think we should just prohibit using the driver for those
> kernel configs and be done with it.

In addition to Google, Samsung and MediaTek and other vendors have devices
that want to take advantage of 16k page size support and they use the same
Exynos UFS host controller.

For example, these phones could potentially support 16k page sizes:

Samsung Galaxy A54 5G, Exynos 1380
Samsung Galaxy A14 5G, Exynos 1330

See https://semiconductor.samsung.com/us/processor/showcase/smartphone/
