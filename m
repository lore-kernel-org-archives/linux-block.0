Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4034AC3A59D
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 11:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072412086C
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 11:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZonzP+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfHSLnA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:43:00 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39675 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfHSLnA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 07:43:00 -0400
Received: by mail-oi1-f178.google.com with SMTP id 16so1040791oiq.6;
        Mon, 19 Aug 2019 04:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqmNxlORfyVPvFfdR4js+8eyiBWsf8sAQAMxxeCmIis=;
        b=DZonzP+cBOMkcGFvdvBaZA6zR11fMO24QaQ+k+BiJROc5hYo0ocFoq0q+z0wKTMeAS
         4KyuEVp6ricrvezamSvSN3RlM/LYY1sup7dGihwepyzSrVUSO5CaM/PK3yxl6BHcGMPi
         JltYRvinYj2oC4Mw/QPYnVhmGE5QXxRB75nzc0DMIXGfn2dAvvE7UyzWMi8iTKfKtlER
         Yj4L8J2w3y3L1kXmALZEA6GfwaeaE7lyKBeFXHjbDeRiZ8NlhONbhDr/+ddrj4hJl3Nf
         bKRHPsHZSW0YQoQuvIK3NVXm0UmkSOSl33fZTxBMM1JXmQuxoGVr7qBRE6OPHjHDmNPD
         SeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqmNxlORfyVPvFfdR4js+8eyiBWsf8sAQAMxxeCmIis=;
        b=XiY5xO6ZRkb9DfHPkM2jjRYISJLAplOcsjOrwM4tKUwRSDp//4iGyHmChFKsz66b7B
         cA/GMC7DIPuKccAYxmyT5YzHxLFi2zHnTGANKXlK9DjSwckXU/BWO7J7jzm21WedccxC
         W0hsQxv+VNLOZ4ERlCCfHphi+uyZ5WHnNPjAFyWz5J29zIgmGPmQmqN875WrP2XGfpIe
         a15lBMjJL8kfR0EngTxa7QVpzVWYjcY9cCljShjuunWv3nMU5YNAu5IMvT/oVuxj3cQy
         Lv4LqwLFpEPfCOmsCdP5SPYBzGBnXJ6MEk7xtGVU/q/6ev/PMvmCkQ5BmOI50enO1zKd
         rgjw==
X-Gm-Message-State: APjAAAVJ9LKoxmcViz0Dv6Fairw6mO8JMcwvwGuKb2ttnEMN547uCEv8
        dfPuiSQaN1K5tdkah6LUWRmZ9QtEg9whVnYyNlBxDnAy
X-Google-Smtp-Source: APXvYqwV7Jh3QGQ3Sd/otaz8c/KK8sUbr9JM+yYkS60KJSEFAZLpOqN/hPKZ7PeWR+I5x93O7oSqT12IrthWSeDqGXA=
X-Received: by 2002:aca:f057:: with SMTP id o84mr13440668oih.71.1566214979032;
 Mon, 19 Aug 2019 04:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190819070823.GH12521@merlins.org>
In-Reply-To: <20190819070823.GH12521@merlins.org>
From:   o1bigtenor <o1bigtenor@gmail.com>
Date:   Mon, 19 Aug 2019 06:42:23 -0500
Message-ID: <CAPpdf5-82P0ri7KB34g_eWS6SKdVapCgUtYphwOL6E+HUwimcg@mail.gmail.com>
Subject: Re: 5.1.21 Dell 2950 terrible swraid5 I/O performance with swraid on
 top of Perc 5/i raid0/jbod
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-block@vger.kernel.org,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 19, 2019 at 2:35 AM Marc MERLIN <marc@merlins.org> wrote:
>
> (Please Cc me on replies so that I can see them more quickly)
>
> Dear Block Folks,
>
> I just inherited a Dell 2950 with a Perc 5/i.
> I really don't want to use that Perc 5/i card, but from all the reading
> I did, there is no IT/unraid mode for it, so I was stuck setting the 6
> 2TB drives as 6 independent raid0 drives using the card.
> I wish I could just bypass the card and connect the drives directly to a
> sata card, but the case and backplane do not seem to make this possible.
>

Not to discourage you from a possibly interesting and fruitful endeavor
but when I bought myself a slightly newer dell server I traded out the
PERC card for a newer version (model 700 IIRC) and then I things
were quite a big different. Said board, bought used, wasn't very
expensive. YMMV

Regards
