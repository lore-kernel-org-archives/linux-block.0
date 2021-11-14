Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8484C433F5
	for <linux-block@archiver.kernel.org>; Sun, 14 Nov 2021 12:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3AB60D42
	for <linux-block@archiver.kernel.org>; Sun, 14 Nov 2021 12:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhKNMMs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Nov 2021 07:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbhKNMMd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Nov 2021 07:12:33 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FBDC061200
        for <linux-block@vger.kernel.org>; Sun, 14 Nov 2021 04:09:38 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v7so37991193ybq.0
        for <linux-block@vger.kernel.org>; Sun, 14 Nov 2021 04:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GxHh7Xf9qDW0bNwOyf54n9RvWNxiu2gzljLfng7W7Hs=;
        b=MdzNFKvZCjQLgS4svb85EjWOd4iKxSAKRoMKmMHggzgzimxZPsmu/wDxNWqifIRXS/
         xbitv67PKHF+EzCh7/aNts0d7m9cW9DAasFEN6hi6pKUqc6AX09jF6nO9EEEAFezntOe
         lXs36kchylgNtauz/+8uhRlBSzyL28R30UyQ6H8cOv5QeIwJUW5oLAnRI0Bc3lvK3r11
         QdRHVJPtJnhgx8wO7DOI2JoAZPDbvv6qSngkcfdA73Iv6ZxgUeEUZmTS5tlu0uYwj9B1
         q7SxxuhsPjcdTgP4GfvybUmUvXXdjC6i+ISOI/PaoakXA77Ty2tSHQTCwEkNNdCL7HCZ
         8h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GxHh7Xf9qDW0bNwOyf54n9RvWNxiu2gzljLfng7W7Hs=;
        b=mxP+4H3a31WRR8fgrsNaeG40vOhZmEK/gsdMxjEcyGdzVUCidrtMsLDhN8J9KSJxNL
         Dvu+fqp5OPtyR87XUUorC0rIIgQxiH/yGTB1yK8WTYyRRYLNCYKl5QmbziKATpT0fhGB
         NRk0jaG3oBUw94K2f3VmKHIivGS5x9Ha8ySIxTr/DSpl7tnsfXJHpwJqt1+MsXZBr7tR
         xtegNqbNsZMgXyJ/KWW6iCKZVVTCaqwhhGMiUqp/1m9NvfbgbjF+PsCdxb7y9Dfx8+cr
         4Xh1QSydyotqH+AKBum6zUIBg7gba2G2N4k9aJ4gO6veqvtxP5dFRgLTs0UDyn7YQ5hT
         SITw==
X-Gm-Message-State: AOAM533SALexLxLqcG4zjI156V9au70+5vKe1k9y2cNqPFe1M+AkRgko
        UbYFvUHGNslcQHsZhjnuIS/Glk9YU23R9sxGmnDTfgCJkMw=
X-Google-Smtp-Source: ABdhPJx0hsSZTaEs7tigcFfIDCmp7AjeBpcFnFGKYb69sB00DmnfLErIkudgBCbo1e00ev9435KtN1glpHXDq0loeeo=
X-Received: by 2002:a25:24d4:: with SMTP id k203mr32909890ybk.365.1636891777823;
 Sun, 14 Nov 2021 04:09:37 -0800 (PST)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <ceo.teo.en.ming@gmail.com>
Date:   Sun, 14 Nov 2021 20:09:34 +0800
Message-ID: <CAMEJMGEYEKvsfy-U5=Om9bO_mCk0jGtK0z0YoU2Z5kowmszqcw@mail.gmail.com>
Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch
 is Running an Operating System with Linux Kernel 4.4.120!
To:     linux-block@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A
Switch is Running an Operating System with Linux Kernel 4.4.120!

Good day from Singapore,

I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch is
Running an Operating System with Linux Kernel 4.4.120!

INTRODUCTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

My name is Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 14
Nov 2021. I live in Singapore. Presently I am an IT Consultant with a
Systems Integrator (SI)/computer firm in Singapore. I am also a Linux
and open source software and information technology enthusiast.

You can read my autobiography on my redundant blogs. The title of my
autobiography is:

=E2=80=9CAutobiography of Singaporean Targeted Individual Mr. Turritopsis
Dohrnii Teo En Ming (Very First Draft, Lots More to Add in Future)=E2=80=9D

Links to my redundant blogs (Blogger and WordPress) can be found in my
email signature below. These are my main blogs.

I have three other redundant blogs, namely:

https://teo-en-ming.tumblr.com/

https://teo-en-ming.medium.com/

https://teo-en-ming.livejournal.com/

Future/subsequent versions of my autobiography will be published on my
redundant blogs.

My Blog Books (in PDF format) are also available for download on my
redundant blogs.

Over the years, I have published many guides, howtos, tutorials, and
information technology articles on my redundant blogs. I hope that
they are of use to information technology professionals.

Thank you very much.





-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

***************************************************************************=
*****************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
