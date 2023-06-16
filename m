Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C0DEB64DB
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 09:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbjFPJkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 05:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344407AbjFPJkK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 05:40:10 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163362117
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 02:40:09 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so151875ab.0
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686908408; x=1689500408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43PrIaNilwLVOBaGJgg3FhjL+CYuMOw3V/XLZiBQlYE=;
        b=yKrw35JciWVKtv0Yy+RXVoVaEA9wuX/nelST7hHhfAOkFL2FkdHfykVwC7K37WIPsh
         GhS4gCLqMvOyYRHo2Le16NAXgZGrnckfTr9G9YAk1YcYG+HZMHBr3EHuEjVtcrJOZx8S
         8aRccrcvczj3fVY928UAXdnZPn8c5M4qZopfbGBtMvbNTZMd5MHxz8S7zN0nr03Qf3ic
         8Q/AZzMB7wEMIADV6tEJXAX5v6yfJ8oHP9dYudDQ5FUQUDxw3KdGNSr46G6ROPRUndKD
         sn31joB99Ma6r/Rk2uKKpxsJ68yvzXdByPm17oMMvDqLvj9jXS4M0FQ0YspfGi69i5uB
         ebJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686908408; x=1689500408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43PrIaNilwLVOBaGJgg3FhjL+CYuMOw3V/XLZiBQlYE=;
        b=CPcD2A3HqVqGm8pol7kEGP94SGQrgi6y4grYX+NhBVTNRJHc+ooGz98kAEWYZF91oz
         Lu93PTxPz2DicF53bTJLWT+Hro4B2oj2jSFnAX5DWFItr8oqysVV2ZzUuqmpMQQrPPEI
         hJKSyke3/vDBXtwXwTDbgGeJHVhTCLBJz0MDXSVq7PYj2uX4n4Z1d5TWUGMsMtNks+jt
         V/SnDA8npk743G6X4yPvY3GAA+/u6lZgdICiOgozNyEHjBcGJ/Q+1Mfhs6/qBTaaNliM
         JIfcGE+hHe/ZyK28LO1Jm/T6hTc76eEGJW63xh3DmiJTlHFlTeQlLPABDd0ttg/JLnEF
         7bWA==
X-Gm-Message-State: AC+VfDykIcqrSz5JKEwOqW9+lFXJX/4Ln2L6vvEHiPzgbnWfzZPi013V
        pQ7voq2/XeylvGn+AKXc/RFgJ8ozXP2RfX81PunnDg==
X-Google-Smtp-Source: ACHHUZ4CLjc42sgoycpHkixS7s+Qk0aypo3zCVJ/AGY8A/3PTK8S+fQ75d1iH45DeHuHotIaZnyTETriUMEXxyuSRHA=
X-Received: by 2002:a05:6e02:1569:b0:338:55b9:f1a3 with SMTP id
 k9-20020a056e02156900b0033855b9f1a3mr454946ilu.7.1686908408312; Fri, 16 Jun
 2023 02:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230612110040.849318-1-jordyzomer@google.com>
 <20230612110040.849318-2-jordyzomer@google.com> <20230615163125.td3aodpfwth5n4mc@desk>
 <ZIufZn+reW0rza1H@equinox> <20230616031447.yslq6ep7lxe6sjv4@desk>
In-Reply-To: <20230616031447.yslq6ep7lxe6sjv4@desk>
From:   Jordy Zomer <jordyzomer@google.com>
Date:   Fri, 16 Jun 2023 11:39:57 +0200
Message-ID: <CABjM8Zc4WU-QXVDDtfKtGPnsHOhjXYufg+HZ=cdSudXYeKS7YQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cdrom: Fix spectre-v1 gadget
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the explanation Pawan, a little bit off-topic for this patch but
shall I send a patch to add this to the documentation of array_index_nospec=
()
and fix other calls to that function where the upper bound is not a constan=
t? :)

On Fri, Jun 16, 2023 at 5:15=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Jun 16, 2023 at 12:31:50AM +0100, Phillip Potter wrote:
> > I've now looked at this. It is possible for cdi->capacity to be > 1, as
> > it is set via get_capabilities() -> cdrom_number_of_slots(), if the
> > device is an individual or cartridge changer.
>
> Ohk. Is there an upper limit to cdi->capacity? If not, we are left with
> barrier_nospec().
>
> > Therefore, I think using CDI_MAX_CAPACITY of 1 is not the correct
> > approach. Jordy's V2 patch is fine therefore, but perhaps using
> > array_index_nospec() with cdi->capacity is still better than a
> > do/while loop from a performance perspective, given it would be cached
> > etc. at that point, so possibly quicker. Thoughts? (I'm no expert on
> > spectre-v1 I'll admit).
>
> array_index_nospec() can only clip the arg correctly if the upper bound
> is correct. Problem with array_index_nospec(arg, cdi->capacity) is
> cdi->capacity is not a constant, so it suffers from the same problem as
> arg i.e. cdi->capacity could also be speculated. Although having to
> control 2 loads makes the attack difficult, but does not rules out
> completely.
>
> barrier_nospec() makes the CPU wait for all previous loads to retire
> before executing following instructions speculatively. This causes the
> conditional branch to resolve correctly. I hope this does not fall into
> a hotpath.
