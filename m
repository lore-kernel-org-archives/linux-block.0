Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8F1C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C74E20870
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAPr9dFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfA2AfC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:35:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44148 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfA2AfB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 19:35:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id g16so12392911otg.11
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 16:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdqnjnELcialeL5mLvaxxFksiDX0wKYSZofCUZ7eeFM=;
        b=FAPr9dFUr0993TKkYI9kA4QJqLgvYzT/dO3ARb0RjeCsBJVpUoUbWgknjQX1a7nrQO
         mhXVuPUa1HL8eTmYhfw2NUmFXFzZMOogPmLxSY9tbzDzBx4sdIsFZN5WI7EKEPX8BHAG
         IMTuqRpewQ2Ompu2kePGuoZrsoVfxDrd/coK+/7t4kh7pSDr7zBXpH/f77wVTAuah7u1
         ImMIYVcj3uUfr7v8oyy9Hb8v65h+Y5Pahn0dp64nriCb/JUOHkpsgBLvOk9VD/1ThRv/
         Py4ny9cKBGli+F0+l06cscwjRu+vGjAgePZEwrgwxL80GwXfnWBHGR1FRBATx6P5bGQ1
         9wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdqnjnELcialeL5mLvaxxFksiDX0wKYSZofCUZ7eeFM=;
        b=Vu+c7Ywbxvd/IIlQULC23j8kUbq4ooiQL7kb8f6d2L1LVHZwK/qms/r4KSoV05upGJ
         YeFBCrK9u6LaaREi5d2t3AAxgkk6rM3LJSGhHG3OC3RDEi0OzU+OJVGbgP243kL/JNKp
         81sIgl0VWxls89nbw3hTFuf8Li2pywnaDUtSEOMT6bjA3nN+4w3o3722PRVJB6FP/P+k
         mvGLd/kHhZ41Z2UBj21KSWKck8EkxBNhKG9950Y0aLEfdHm/6CGJVt/oWrHLeSmrN1Ko
         sMjYvlPAMLyaEPBDVLNfJQZG+bdjvcL4yKDZMmCn3Oaby7HThtx7rL67KRURJXq1kvHC
         lGPw==
X-Gm-Message-State: AJcUukf+/RCp5JKYEzH7/AfwkQCcKRLsE7we1yX5i/YfuzRsLtyN0IMv
        BIjhcgRzTP8HggI0WamhBTWJUsDVBK36RyCiPmj8XQ==
X-Google-Smtp-Source: ALg8bN78a4++HxVi+g8b+DrsH7QKalSzeLlhlnBqbjllxK1IbOlT6asLYZrbv0swufX2EiJUDj+eFBwgTX7sC8ZVmQY=
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr16881560otr.292.1548722101272;
 Mon, 28 Jan 2019 16:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez0vDqDH4ks7q4L3F+xt-4kVQrN1yw34QwFAmwQyy27FTw@mail.gmail.com>
 <e9326a77-54c5-e2b8-d9e5-663261462597@kernel.dk> <CAG48ez17NW0GJVRC6dFcHZTgQifFz5og1XCUbXkHKhr6f=j74Q@mail.gmail.com>
 <c20a1250-9f3f-a286-9baf-5b71db0c128f@kernel.dk> <51c759f4-7ce5-182b-98e8-2c0e99ca4f9a@kernel.dk>
In-Reply-To: <51c759f4-7ce5-182b-98e8-2c0e99ca4f9a@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 01:34:34 +0100
Message-ID: <CAG48ez3XGjFZbPiof4u4QGtoumBXXfCsFxOQ_2pGt=MnqqY7ZQ@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 1:32 AM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/28/19 5:03 PM, Jens Axboe wrote:
> >> But you only do that teardown on ->release, right? And ->release
> >> doesn't have much to do with the process lifetime.
> >
> > Yes, only on ->relase().
>
> OK, so I reworked the files struct to just grab it, then we ensure that
> doesn't go away. For mm, it's a bit more tricky. I think the best
> solution here is to add a fops->flush() and check for the process
> exiting its files. If it does, we quiesce the async contexts and prevent
> further use of that mm. We can't just keep holding a reference to the mm
> like we do with the files.
>
> That should solve both cases.

You still have to hold a reference on the mm though, I think (for
example, because two tasks might be sharing the fd table without
sharing the mm).
