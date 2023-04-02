Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ECBC7619A
	for <linux-block@archiver.kernel.org>; Sun,  2 Apr 2023 14:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDBOuK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Apr 2023 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBOuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Apr 2023 10:50:09 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E234686
        for <linux-block@vger.kernel.org>; Sun,  2 Apr 2023 07:50:05 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id f188so13612906ybb.3
        for <linux-block@vger.kernel.org>; Sun, 02 Apr 2023 07:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680447004; x=1683039004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSJkeczsRCJsz2ttU8oQJ8eXqzZE348TERtH4FIpWw4=;
        b=yw4uYmYD8WH74wmJIB+gwT/m7zOP7RyfMSPKPBt552l1pO+VhYou2JmjBX8Z44dyXv
         9YKYkpaUIrim5hWpeAnUbfY0HckQNTa3TKJItwCYPgYaGyi2LHSX10vlPt7qT/bvFU8d
         KOqfYK0Ai85+Xn8ZspL5RIQm1ECu4uBgudBrXhgqtJdUMKnSMs0LzJ8In8pJ3wEeYC3e
         dvHwVyrcRLQn7X81tPR18naC/S9ss4u6n64HFNpMoHh64lvqMWFKCiEBMMxgY2nA+r8I
         3w9ZzT+uVFYalCboiM1Qq6HyDlN6Oa4ML6r4fgfHTIje60Eqc7sSVDv+DgvzuUSmEhif
         Vgpg==
X-Gm-Message-State: AAQBX9ejF5A2h1hKOX8f24Sgd/SoiGs7JS69gryyjObtRY3ljBXNLjAU
        FkhfHAS0E0fwrFIZ1HjvNnPI73B4ZEfjdQ==
X-Google-Smtp-Source: AKy350YDC51pfRC1iE5hbO2R/dHHTWgGrh1cFEEXdbYEEml+tcLvqcgdZ4Xs91aEMi2nJAoJIZcbNg==
X-Received: by 2002:a25:e68b:0:b0:b72:ec3d:c670 with SMTP id d133-20020a25e68b000000b00b72ec3dc670mr27717767ybh.10.1680447004014;
        Sun, 02 Apr 2023 07:50:04 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id g16-20020a25ef10000000b00b7d2204cd4bsm1927019ybd.21.2023.04.02.07.50.01
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 07:50:02 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id i6so32097389ybu.8
        for <linux-block@vger.kernel.org>; Sun, 02 Apr 2023 07:50:01 -0700 (PDT)
X-Received: by 2002:a05:6902:1586:b0:b76:ceb2:661b with SMTP id
 k6-20020a056902158600b00b76ceb2661bmr21171344ybu.3.1680447001548; Sun, 02 Apr
 2023 07:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230322151604.401680-1-okozina@redhat.com>
In-Reply-To: <20230322151604.401680-1-okozina@redhat.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Sun, 2 Apr 2023 15:49:50 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnRHomfw33tnnMNAz+WyhH8bWjiZ1-2qQm3tqevNtkOOVA@mail.gmail.com>
Message-ID: <CAMw=ZnRHomfw33tnnMNAz+WyhH8bWjiZ1-2qQm3tqevNtkOOVA@mail.gmail.com>
Subject: Re: [PATCH 0/5] sed-opal: add command to read locking range attributes
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, gmazyland@gmail.com,
        hch@infradead.org, brauner@kernel.org, rafael.antognolli@intel.com,
        Ondrej Kozina <okozina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 22 Mar 2023 at 15:16, Ondrej Kozina <okozina@redhat.com> wrote:
>
> This patch set aims to add ability to user authorities to read locking
> range attributes.
>
> It's achieved in two steps (except SUM enabled drives):
>
> 1) Patch IOC_OPAL_ADD_USR_TO_LR command so that user authority (together with
> OPAL_ADMIN1) is added in ACE that allows getting locking range attributes.
>
> 2) Add new ioctl command IOC_OPAL_GET_LR_STATUS to get locking range
> attributes to user authority assigned to specific locking range.
>
> libcryptsetup plans to support OPAL2 drives and needs to verify locking
> range parameters before device activation (LR unlock) takes place since
> it's considered undesirable to have (for example) partition mapped beyond
> locking range boundaries.
>
> Ondrej Kozina (5):
>   sed-opal: do not add user authority twice in boolean ace.
>   sed-opal: add helper for adding user authorities in ACE.
>   sed-opal: allow user authority to get locking range attributes.
>   sed-opal: add helper to get multiple columns at once.
>   sed-opal: Add command to read locking range parameters.
>
>  block/opal_proto.h            |   1 +
>  block/sed-opal.c              | 263 ++++++++++++++++++++++++++++------
>  include/linux/sed-opal.h      |   1 +
>  include/uapi/linux/sed-opal.h |  11 ++
>  4 files changed, 233 insertions(+), 43 deletions(-)

Hi Jens,

Any chance we could get this series looked at, please? It's the last
thing we need to get userspace support going:
https://gitlab.com/cryptsetup/cryptsetup/-/merge_requests/461

Thanks!

Kind regards,
Luca Boccassi
