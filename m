Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43FECD98F5
	for <linux-block@archiver.kernel.org>; Wed, 11 Oct 2023 07:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbjJKH3U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 03:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345633AbjJKH2q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 03:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B2B0
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 00:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697009275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lN+nHYaMZzqp47oL2lmqJq2Wc18V3JSZX1gh7W8sHLc=;
        b=gHGReVCEjbxlah7ASONN08ABKNZX7zxeKKvadWhTshkVlS8rqcRWhVzahxOPLcClB7dj8T
        xlXtSqAJJ9MW3UEWumlBtQ1pAEcXLMXO8Wg/aNp//wX1UGv6hgDT2yQH0E9crAS8uogZpW
        85FAHuAUuMWnkWdqgjAS+nLDrwI8orY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-JZvY5O4xPjaawHApoypw_g-1; Wed, 11 Oct 2023 03:27:44 -0400
X-MC-Unique: JZvY5O4xPjaawHApoypw_g-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-58928325328so4871260a12.1
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 00:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697009263; x=1697614063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lN+nHYaMZzqp47oL2lmqJq2Wc18V3JSZX1gh7W8sHLc=;
        b=FK2KtB4Y1V+EQebZmVfRNnbxWONKwuhMhwpgV+i32sif9LStT4lBPZYP37cxqPAFC3
         kEZ0ymstXuOtGKNtfZiuuiYg9aI32D1eV6yOLd/UfsoGPnUkUUDIz8sSlrmuPhO2Wfud
         TrQ3VOjFLXvyPs0qagGmaxODBA5MUGacolamvQbzVx2l1bKCcvEAJETMirw5vXI1X1tX
         utg7RRvz4hjbZQZ2o787JbyGL/zgBFevLxIBX5cOluwOn8e1EQmgAa5HL97VUD+7K6pP
         EXZCm4jKL+a1i2KukgEmvtlCDTlYoNJg8JIivHwSGyuvC0lMJ/TQK66tTSp6J7ywe/8F
         pvTw==
X-Gm-Message-State: AOJu0YzrJ6uzYh3i5vCIq6kwS7Cco8zoHriRR+YYOxlcxjuwoSg6sksz
        tPvA9OXL0bL8RQVwHljFcYGbRWtvuTHdDYEwnkW+qWjWBCOb5jNSY59OYIY5PTQ/p5sYX/gtRwa
        6o6TyrWkc11ZnH86gSWOvDB9Jj5WQPPMfyiP4Yu8=
X-Received: by 2002:a05:6a21:8cc5:b0:153:63b9:8bf9 with SMTP id ta5-20020a056a218cc500b0015363b98bf9mr20683285pzb.0.1697009263118;
        Wed, 11 Oct 2023 00:27:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLcVqqpTdBIiqqZlqD6KRMw+tilgE8JW3wYJBs803zChAjYZbPiq6BP3J59MrgcrrjDY6Lb7oNCMiXTjlhp1E=
X-Received: by 2002:a05:6a21:8cc5:b0:153:63b9:8bf9 with SMTP id
 ta5-20020a056a218cc500b0015363b98bf9mr20683270pzb.0.1697009262819; Wed, 11
 Oct 2023 00:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231011034832.1650797-1-yi.zhang@redhat.com> <xhh4o6xisfaybzozsia5owr5mzs4eyqn2yvrxogw5u55ht2lgd@hp3k4jb5mwsd>
In-Reply-To: <xhh4o6xisfaybzozsia5owr5mzs4eyqn2yvrxogw5u55ht2lgd@hp3k4jb5mwsd>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 11 Oct 2023 15:27:30 +0800
Message-ID: <CAHj4cs-YaU8fpCrt2cFJ5SjaJbbP3BQAVU_Q3M_PEwDC1f1iyg@mail.gmail.com>
Subject: Re: [PATCH blktests] check: define TMPDIR before running the test
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 11, 2023 at 2:53=E2=80=AFPM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> Hi,
>
> On Wed, Oct 11, 2023 at 11:48:32AM +0800, Yi Zhang wrote:
> > @@ -478,6 +475,10 @@ _run_test() {
> >       # runs to suppress job status output.
> >       set +m
> >
> > +     if ! TMPDIR=3D"$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_N=
AME//\//.}.XXX")"; then
> > +             return
> > +     fi
> > +
> >       # shellcheck disable=3DSC1090
> >       . "tests/${TEST_NAME}"
>
> Are you sure about the placement here? I went through the call chain
> and I figured that the TMPDIR should be set in _run_group before
> we call the 'rc' files.

Yeah, you are right, just send v2 for the change.

>
> Currently it is:
>
> _check
>   _run_group
>     tests/${group}/rc
>     _run_test
>       _call_test
>         TMPDIR=3D...
>         $test_func
>
> Thanks,
> Daniel
>


--=20
Best Regards,
  Yi Zhang

