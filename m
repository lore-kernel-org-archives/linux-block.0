Return-Path: <SRS0=1fuv=XR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8408FC3A5A6
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 20:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4852220830
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 20:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1l0lU/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfIVUmg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Sep 2019 16:42:36 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40118 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfIVUmg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Sep 2019 16:42:36 -0400
Received: by mail-ed1-f46.google.com with SMTP id v38so10997684edm.7
        for <linux-block@vger.kernel.org>; Sun, 22 Sep 2019 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=b3+l9qLEdALtMcOAmMI9xnunfaaZTOT/5TC6cqU+47g=;
        b=Z1l0lU/dwT4vLuAwt7gRS0OlqjWMpUIRVwheqmW81AvDTwiED/wXyc6MHogW0ZnonR
         q6bD2c+inJjIr2cgsm+zYP1/h9zHYhCQY/3QkS8FLc/TAUlRyXiXrMWgrlQLZ4cQntbg
         ICC+r4Zq+knAd7KLSXDWj2RIBzLDYOe9If/T03nHsbbI2u1T6bP5orJhrPhIvc+ia2MH
         gYczWeutQLW+5XZqxaj0T8s/iB2PhxPssne3P+ht4BUTgT6y9q9euYjg4s2Yx7tFtT95
         dFX80t832qyOusyEGuRhLhqpwHZFhpFW9UXj3SMfHN8UorogBdp99WCY182tnUPPxESC
         Tk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=b3+l9qLEdALtMcOAmMI9xnunfaaZTOT/5TC6cqU+47g=;
        b=Azsd7aeWPVcNgeIAjxKmO9KSDTuiqVMvGouPtMaKs4MEQwoYDJAhPKp5DV6W9LvS+A
         D9R8A6Y4tcgslhy6XVm1NkHVbNRBzW/St6lXupa328jf9klwEVvWbG1DaOGIxXiJmzhV
         +4VICOLI1YdpfE55i4nh5wC64zdIiZ3+Y1mmcXHTjFEID5+PtQ1PpAKgDf2gdwfvG/kA
         4wYRtWo4PtFt+BOv8boJomBS1TtxKEdSpNuXEtPz7QgE2ecAYOhAfUY5ti2TP+pe587C
         a99OBLzUzJ499U5gIruyjaqaWpD27qy+rkBeViVj3hz55bc8ElxyhpPQj+pxUZlAD01s
         lQvw==
X-Gm-Message-State: APjAAAXxc3p7l01nbUU3FsN3H71GYEuz26Pt7NNl4kvQCSR26WK1kHv9
        slkN2lCRkJHF6jL8ELLm1XyEwBDmZLXs69w8fGgAlzLi
X-Google-Smtp-Source: APXvYqz7ROm14dWbX45wwr43UY64JQw3W8Il/7LJvz2JS/kpBsKiLsLswcAAmQwazSuvkQl9PziycNEZPi+IAy3nRZg=
X-Received: by 2002:a17:906:d185:: with SMTP id c5mr27088503ejz.139.1569184954386;
 Sun, 22 Sep 2019 13:42:34 -0700 (PDT)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Sun, 22 Sep 2019 23:42:22 +0300
Message-ID: <CADUzMVZPrx34ykDsd3Kn=k+ep39LUEMCyaLk6VqUww2o8G2HLQ@mail.gmail.com>
Subject: Re: [GIT PULL] libata changes for 5.4
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

can anyone have a look at my initial message? It was posted more than
a couple of weeks ago but for some reason there was no comment or
reply to that message:
https://marc.info/?t=156712230300006&r=1&w=2

The PCS quirk on Denverton patch that has just landed for 5.4 isn't
suitable for some of the latest intel PCH chipsets. For example, in
the C620-series PCH offset 92 is assumed but that isn't the case for
Lewisburg.
