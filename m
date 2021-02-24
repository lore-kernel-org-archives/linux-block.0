Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F15FC433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 08:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8CD64ECB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 08:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhBXIyr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 03:54:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234654AbhBXIyd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 03:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614156785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYX3O7xufjYNf15XEImsk+LomkH45mrlcqP2kQFdtWI=;
        b=EBtAhro3XLt1JclgTBdWhvOZCCTnzu/SZKKi03hTM3THn9W+lnY94xatz4AMAyVLVKL11m
        lS418eQObN4uQh6vc1RwicH+COCez6dgU3E1tbsZDW9mhhlEsWPac41ey/S/mlo3sUBFa4
        PZBj0liHUfeADqtbHaTliYRnav566j0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-cUdaB8ncMEKIsB0dS2sLHA-1; Wed, 24 Feb 2021 03:53:03 -0500
X-MC-Unique: cUdaB8ncMEKIsB0dS2sLHA-1
Received: by mail-oo1-f69.google.com with SMTP id n9so788682oom.5
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 00:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYX3O7xufjYNf15XEImsk+LomkH45mrlcqP2kQFdtWI=;
        b=P+7N/zFN/wKZWjCbKWcu0JrAEAC8KE9K6n3Goew4x6Ybe5OQcy21F1Unhfi7kEVMKx
         6DlrVGtj0yRmEcRYbAwVsZPYfYl1NIAfJ8SfXtufh9DI/YNZsfItyEi4e+HOwsDf8fwu
         3ZKIeb3mPaeRmRwpLmn/5ji2N8/mhOriAi7HX+xP848MG53pCwWuyAgcPK++nsAt6rHw
         PgR/SaRbp24n1/5kn2pFlLh4sg+Ta/gAIEDH9HiRFNpOxvOlTw1CvOn/2aNYDYxFVGQv
         sZpy/W+F3oD3ROzQcpQWFCW2hWAkFGTXnjA3VkmbnIy/c8GTkE+duYP5Vmeyy5p8BC50
         gSDA==
X-Gm-Message-State: AOAM533sztch/RsoiTgtpcHDkZNTova+Yn5tJulsj6jEMUKmhR5aj3M1
        mZUIut3blJFcC9s6xP7A8wOVcMvG5qqUN72LOF4H35C8K1ryAQUuWGHSc/q19bYi2ytLsjs1GDc
        KQkrMUGFp8NeIz9mxYGiTiKzK4w2SQMvx5HqlIqA=
X-Received: by 2002:a05:6808:93:: with SMTP id s19mr2022400oic.115.1614156780100;
        Wed, 24 Feb 2021 00:53:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzO4cfy0bUojTjyHdSrD56xVGttP1p7Ju2D2F8oBtKZrrAad0081kuiYlpozxqxkKAwaStqgXIGaI3LDQ9nT1I=
X-Received: by 2002:a05:6808:93:: with SMTP id s19mr2022383oic.115.1614156779840;
 Wed, 24 Feb 2021 00:52:59 -0800 (PST)
MIME-Version: 1.0
References: <cki.1891A5313F.9U2FASPBG7@redhat.com> <CA+QYu4qihd=wkrknUjaLtGFa4AGpweMWL4Wg=ZPyn=_Mdsx_jg@mail.gmail.com>
 <6e0146f1-fdf4-0727-87f2-dd057e8496a1@kernel.dk>
In-Reply-To: <6e0146f1-fdf4-0727-87f2-dd057e8496a1@kernel.dk>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Wed, 24 Feb 2021 09:52:48 +0100
Message-ID: <CA+QYu4p1Ya_NW69q=UizOh5j-B2rjPs0s3kzG8f2yipKW_EbJA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOKdjCBGQUlMOiBUZXN0IHJlcG9ydCBmb3Iga2VybmVsIDUuMTEuMCAoYmxvY2sp?=
To:     Jens Axboe <axboe@kernel.dk>
Cc:     CKI Project <cki-project@redhat.com>,
        skt-results-master@redhat.com, linux-block@vger.kernel.org,
        Guangwu Zhang <guazhang@redhat.com>, Lin Li <lilin@redhat.com>,
        Xiong Zhou <xzhou@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Zorro Lang <zlang@redhat.com>,
        Marco Patalano <mpatalan@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>, Al Stone <ahs3@redhat.com>,
        Fine Fan <ffan@redhat.com>, Jeff Bastian <jbastian@redhat.com>,
        Yi Zhang <yizhan@redhat.com>, Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 23, 2021 at 7:59 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/23/21 6:36 AM, Bruno Goncalves wrote:
> > Hello,
> >
> > In this run a lot of tests failed due to a known issue with SELinux policy, but 1 failure reported on LTP io_uring01 test when running on ppc64le might be a kernel bug [1].
> > Note the sefgault (io_uring01[138555]: User access of kernel address (c0000000005a0258) - exploit attempt? (uid: 0)) on console log [2] when executing the test. The test logs are [3].
> >
> > [1] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/02/23/624525/build_ppc64le_redhat%3A1110530/tests/LTP/9600734_ppc64le_1_syscalls.fail.log
> > [2] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/02/23/624525/build_ppc64le_redhat%3A1110530/tests/9600734_ppc64le_1_console.log
> > [3] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/02/23/624525/build_ppc64le_redhat%3A1110530/tests/LTP/
>
> That's my fault, for some reason I totally overlooked parisc and powerpc
> in the PF_IO_WORKER change. Current for-next should work for you, this
> is the change that fixes it:
>
> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-worker.v3&id=e4595c30ec3053a15d12615195b7a8726f9bee79

Thanks for the fix, the test now passes.

Bruno Goncalves

>
> --
> Jens Axboe
>

