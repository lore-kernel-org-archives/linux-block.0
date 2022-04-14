Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7ABC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 15:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbiDNPJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349328AbiDNO17 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 10:27:59 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB1D0811
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 07:15:43 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id n5so4619534vsc.4
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=N3A5WZO3pcVrEIWupeWeNMVNjYVwvMctGEq0QmUFSSk=;
        b=qIPukvKXkbXzvCknVtIb9zhFKw4si7uhMmRYzRSey41TD6xCjEMvnU6Ya+qXKECUmo
         sCyqbhWyGzHJbZZWzmJBwmPI7baKjpglKlYg/CFOexaf4PgwO2rdY++spUtHWdgYxqRc
         uHrJ69RzVxs9Dhj7tl5ecfJr4zCYQa3qa8pJo2bXI7g2bTf43G5nEMhXPQLNyHm1RQ0f
         GgsXnImNdtEDLWFSaH28rlgi5Mefdve/99Mi7Ld5kTmXbsysE2p/kU+oeQm3HvXG7UpW
         WM7bWCL8EvymyuL03ar4oR+1hsBLnFiNe3ZaVJqznTBm0llJijyAdGRO/kL4jtMCuwUe
         OpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=N3A5WZO3pcVrEIWupeWeNMVNjYVwvMctGEq0QmUFSSk=;
        b=05LpOlUS1wfETa4fyQPqOqhS0OxXlrSAS5AxL8LiFqp6zROo3zLgti4NeEjC+P9uL5
         r1HCNzOw8NKt0mik9fWr90PZUjE3PJ/l9BCcLuZOIjkXEEojQI6ZfO3i6TK3mSZbeqgc
         QeRJeWP4ydwCgSO8pwLZgxpVqKFi6G0EbqrCm+r/4+ugJ0mFXgzoEQAvzjYa66ZIfRhd
         /iom9HVDxoXkckpZ8I14PfEs600DQh/WfFwhl7iDH+mAbXMl8SwbrEiUaa3Mlh1a0Qvm
         yKtsT9rNZulDf9MkYroGPp4i+CpAM7oWIlyQ6Og45rd0wthToQRiK2S63cazvAluNbD8
         OCoA==
X-Gm-Message-State: AOAM531Gepb1LAu/mLHtz+praflwyU2a8QDfFBZXgEnmwuiTFmcw0Hun
        W03aSiT4KPA/71jIi0oUKE9j6rrHYhGPnHf0fVCerHgvq0yBt+dtBexmAw==
X-Google-Smtp-Source: ABdhPJy8ae+FdqRy0C0c4PibjVy2nNKqpewj/0eRGd3EbKPMjOfwrx9TQCHRkC1Kr8gTWnniJ3VOpLPOshy4FaDAIdE=
X-Received: by 2002:a67:f80c:0:b0:322:8eaf:e773 with SMTP id
 l12-20020a67f80c000000b003228eafe773mr1433474vso.69.1649945741957; Thu, 14
 Apr 2022 07:15:41 -0700 (PDT)
MIME-Version: 1.0
From:   Jasper Surmont <surmontjasper@gmail.com>
Date:   Thu, 14 Apr 2022 17:15:31 +0300
Message-ID: <CAH4tiUtGuZP6QnO6L9EEDFL08O-UusHihO6CbvEf-QwJM3QPCg@mail.gmail.com>
Subject: [Question] Accessing read data in bio request
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm writing a device mapper target, and on a bio (read) request I want
to access (for example just logging) the data that was just read (by
providing a callback to bio->bio_end_io).

I've figured out I could read the data by using bvec_kmap_local() on
each bio_vec to get a pointer to the data. However, if my
understanding is correct this seems like an unefficient way: if the
bio just finished a read then shouldn't the data already be mapped
somewhere? If so, where?

2nd question: using bio_for_each_segment(...) inside the bio_end_io
callback never loops. Is this normal, and if so why?

Thanks!
