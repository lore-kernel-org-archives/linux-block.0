Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF26C61DA4
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 05:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBNFyg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 00:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBNFyf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 00:54:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F91B57C
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 21:54:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso12891581wms.0
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 21:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSUWe6XuUo2xCHgVdW0f8rgDICtT8qqUf3ph40X9Ffc=;
        b=NC1/UFWhbMcdBljQK/HTc1gC8pCUKg4tASanFo8FiQEyoI/R44NdEI6GRLy5x9XSHf
         EI/ec5kU9oidRZND5HnXW+DlPUhAcMkPRG8cfKV5Sb3kVMpyQArrwo8dfaGQe+HhFGN2
         iXaGkVAcWqF7/duMW74ZkhAZSgYhjQ8lmo9Ay4ePxf25X4zj/2Pbf6mifnTYNG0oda0h
         Jcfo27h9FANCIXp4HdnWv7+T2WN97cYdIa2Hq70ASdOWaPSW/aEJP7YCJonj5dd5QQpH
         vzL2zmoutKdzNz+0wwHw8yM+yVQxeNYvFrCMI0BSanwghO3pE2SAd5tSkFXpVrwuvKgW
         5zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSUWe6XuUo2xCHgVdW0f8rgDICtT8qqUf3ph40X9Ffc=;
        b=dTAeBu3Bc7TILhUjHu/hB2vl1wFf9faCEo+jaZ+8I2XhM+OdIL6Rr3wtB6khMVVzA7
         ZH7IHp9dImTb7arfeBTbpphqHf4QcOZJb9YTgfCao4tH/jEAIXIDv2RU1V2lu05Xq0fe
         dR5vGBCBZDP7gw+yKOpG0WSUiWzPJy/fKq4bbpzK+k9Hegf1Im+dbAL1FpsXo8sbCmJc
         +hq9gT2lrezcp9kuS5TBAgcjhj63jzDmPlCegQ15qbnRsxMyPkCaz8MdvKbzHkDbJq8R
         DJJdYbhdJ+qa6dpTVhHAv7e6hvRdgth4C6jw0CUmwA4LpAbXse8w7EZII/XM1PvU3q8g
         1EWQ==
X-Gm-Message-State: AO0yUKVjUhs9Tu7rXzWlB0sawXX1gGTHrISZ0lrT9Va55m681Rs0v3rI
        aywAyHJCBSKtibB/gGrFAMHvYME9gAu1i5zs8OufraSY
X-Google-Smtp-Source: AK7set9EoIHAXOzq8uCc8a3C8r3/cHSGddxVuAIiydzPgaQQDWGjL68JkEGTOaH63VgxcU7B4JbMoPuHEHdeK5WFQeY=
X-Received: by 2002:a05:600c:1992:b0:3df:f128:1a32 with SMTP id
 t18-20020a05600c199200b003dff1281a32mr904539wmq.101.1676354067754; Mon, 13
 Feb 2023 21:54:27 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230209094631epcas5p436d4f54caa91ff6d258928bba76206de@epcas5p4.samsung.com>
 <20230209094541.248729-1-joshi.k@samsung.com> <20230210020114.zzmazatkxeomowxq@shindev>
 <20230210111212.GA17396@green5> <20230214045707.sf7hu4b7hzgzbyns@shindev>
In-Reply-To: <20230214045707.sf7hu4b7hzgzbyns@shindev>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Tue, 14 Feb 2023 11:24:00 +0530
Message-ID: <CA+1E3rL+CrVD4HjRjq0Dx0OFDPDBMqq72S2j3-LtZTXiPX=o7w@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme/046: add test for unprivileged passthrough
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 14, 2023 at 10:32 AM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Feb 10, 2023 / 16:42, Kanchan Joshi wrote:
> > On Fri, Feb 10, 2023 at 02:01:14AM +0000, Shinichiro Kawasaki wrote:
> [...]
> > > If you don't mind, I can create another patch for further discussion based on
> > > the suggestion above, and modify your patch to use the new helper functions.
> > Sure. Please remove "_have_fio" line also in v2.
>
> Okay. I've sent out v2 [1]. Please check and confirm that it works for you.

Thanks. I am PTO for a few days; will come to it next week.
