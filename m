Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BA4C10F13
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 03:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D0D20850
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 03:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3WI6lO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfDODJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 23:09:29 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:32976 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDODJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 23:09:29 -0400
Received: by mail-pl1-f179.google.com with SMTP id t16so7838156plo.0
        for <linux-block@vger.kernel.org>; Sun, 14 Apr 2019 20:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nGesygIbw+ginVp7uF/tcDiLFMgPfxMD6+MjqVAIIIo=;
        b=t3WI6lO9vKAOp46YbV+h5xNbm1D0nRONfqX589sX7dKwb1pdbmVcMbykZMdzWwRxAV
         OUg5aMVDjRtPDOKIoBaYpScPkkmpr41aTQ1l02+0igFs5k6IgRI7AB6B7ffuDvF5hhmX
         6yEloedIGjXmb470FwPf+GI7TWJXkAch9Pf0efX7R3JoqMBWzZrUDk4JxJRGxtana0Pr
         o/9gOhpKDtDZJwUb1GO5ZZq9XfSjNQGpaZ4DW+Za7+gyfi2pbQgU3sFSA9ESVR3n3T3y
         cKq5ps9fGxKp6oZrhzqy0jFkMEGShGM6gLaafc38KkMoeVtrbvDs1U0iFEsXMzZ8cG1O
         lgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nGesygIbw+ginVp7uF/tcDiLFMgPfxMD6+MjqVAIIIo=;
        b=n5aIZ00hWeK13ZKIUJ/+piWovn1AUof0RVUOP8LN6c/21b1EAKgPo4oraWE505ROVA
         /8xNEkcbI/Ss7shLwZT4MEpo4f7SKUv30p1UOqKqkwhf+iIq9QuXSJyVq7XOMXIZ7APm
         I5P+eE6f9iiTNEw602MYG2Kk+D5W/GetmndvQi+0ncjxaxUEA7JDUnPOAPjJVUOdlw9M
         j8PVWLJ/TQ8J7i0+nyVbwHD+JnrKnm1e2td4KnUniqb5KbP3WuwaBCvZR233F1PDxKsO
         M53Zw8KpEO+wGWJhduK+unzQYEr6aW3Jt58uZnSSqYpt8r9g1Xu8WgrcUvDR50LSsauX
         w5oQ==
X-Gm-Message-State: APjAAAUh6FWSBO53y7LDlfrQjH6YxKlxuXVWiV8dVW9AvG/u8P3iHiDh
        ISBbow26W4wJrerHlp89Tvdwg/XnJHRc3IJVganEATmxTbU=
X-Google-Smtp-Source: APXvYqy1Y9J7saNRafPQ0fQqlza5Gs2nj4UZgJzXtPD6DzWfWTZVZY91attlLbw3WjR9HVrDcAzFQ53rRz0br9KIHCw=
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr48201366plp.27.1555297768524;
 Sun, 14 Apr 2019 20:09:28 -0700 (PDT)
MIME-Version: 1.0
From:   Feng Li <lifeng1519@gmail.com>
Date:   Mon, 15 Apr 2019 11:09:02 +0800
Message-ID: <CAEK8JBAGxbVan-zsQDmu4upOVzp91fwbCU6cVtXi9D4TUs1p=A@mail.gmail.com>
Subject: io_uring is zero copy or not?
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I'm interested in the io_uring, and have a doubt about it.
If I setup io_uring with IORING_REGISTER_BUFFERS,
the kernel doesn't need copy data from user space to the kernel, right?
Does it mean this is a zero-copy feature?

From the code, kernel directly get the userspace virtual address's
pages and store them:

2475 pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
2476 pages, vmas);



-- 
Thanks and Best Regards,
Feng Li(Alex)
