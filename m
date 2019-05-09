Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A26C04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 06:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6491B208C3
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 06:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNlaPYua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEIGPx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 02:15:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33665 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEIGPx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 May 2019 02:15:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id x132so682861lfd.0
        for <linux-block@vger.kernel.org>; Wed, 08 May 2019 23:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjL8S2b1N9RGB5Ej3tVGHssLMN/kO9+k5oaDAxobLrw=;
        b=PNlaPYua3Padp4UXiYdn7sRzUEoyqaJEnymtiHO5jiT8Kr4Fcfe0TSy2Pbf2SjXc4V
         MLeDiDMc8hUCnwUVyt78Fz1K+CQJJUtGfN7qeciKijkQwqY3KnO3NnskmHcY8TmpnD5T
         w+vTTP8XhwR+mTXQULq3NeIYa0jBu3NPrz+C+87ALra7ZBjS2mKaAQKpCr92cwNyHsnx
         Axoavui20MvVCZkBJH8kkV0NhU7ZaVqTd2puEK3OtGfniQu756j8BjQO7Dkrpgog1F81
         xSnqVLW6dnkv96jkReJ1xA1GdoaBBdIJr7iE9gobNTuunjL0sZX07sImUQ49CpzWKzFF
         k/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjL8S2b1N9RGB5Ej3tVGHssLMN/kO9+k5oaDAxobLrw=;
        b=GalkAWDBSl0Z2TuQ/4j6hZibEDvuT+Nj+/JG6zvRvYGPr0YxMtrFPSPAJhX8tzH4Pl
         jIdB1BNMPgQ5A+/nMFNyJnu15kT2UqdZo8GGkgLa+1Vn1VXhuLQgUdZ8hMmOr4zjn0Vo
         bigXmvDpOM2xVOtjwAhS3TvCiZrQQ050F8ohsjkX4Ht7+a5LiHbBEtXzv72HJT2MpzIF
         X4hARYdhQaS6Ul/B7YU4jDO8dMKLWn6hextNQ0opEk+PyE62EdLwWqYbHSO6KD4DyyMn
         ehLjm4vgTmeXXdt6LBXC+TV3ctpayWkD8js+UbTC2kjMU+yuRiLVBYL9/FHH5rqNKtEi
         0uyg==
X-Gm-Message-State: APjAAAVjnS3Fkwa9m86iSm9V1lvK1UoDUzGgrfHnqb2eRTI2Pj5sG1I7
        uDFTh+hRNtZC3kpnRPOUBmR1M3G+gasr8R9LjtY=
X-Google-Smtp-Source: APXvYqxMLmq4PiNfx2RlO492eAwLG0dIA9iTL4CjA/V6Ux8VFdsFh0aOY1se89IZfU+hxOcsTAQ1Em3hIHy4jx3gzuk=
X-Received: by 2002:a19:4bc5:: with SMTP id y188mr1354149lfa.24.1557382551452;
 Wed, 08 May 2019 23:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com> <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com> <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com> <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <c86fe09e-9964-123a-bc17-e9b9e6a80856@gmail.com> <SN6PR04MB45273CEE5FE1DDF38677980F86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <CAA7jztfU+AdUHp5xo8ssjgvXiBFBXJt0PyQTNA8VQU-T-SpKQA@mail.gmail.com> <SN6PR04MB4527510BF05DCBF27E0B6D2F86330@SN6PR04MB4527.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB4527510BF05DCBF27E0B6D2F86330@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Date:   Thu, 9 May 2019 15:15:39 +0900
Message-ID: <CAA7jztcSAOTrPkiN+bDW5i7E1E0MA+xhU=6iZ-nEUy1YT2c1AQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Isn't this unsigned ? as pointed out by Keith ?
>
> $ cat a.c
> int main(void)
> {
>         return -1;
> }
> $ gcc a.c -o a
> $ ./a
> $ echo $?
> 255
>
> May be I'm missing something here ?

I meant that the program returns in a signed value, but it's going to be
parsed in 8bits which is unix style, I think.  Sorry for being unclear.
That's not enough to hold nvme status value at all.

> >
> > If you have any idea about it, Please let me know.  By the way, I really do
> > agree with what you mentioned about the return value.  If it's possible,
> > I would like to too :)
>
> How about we instead of returning the NVMe Status we map the NVMe Status
> of the program to the error code and in-turn return that error code ?
>
> The above is true only when command is successfully submitted from the
> program i.e. no errno is set by any library calls and failed in the
> completion queue entry with NVMe Status != NVME_SC_SUCCESS.
>
> For your reference In kernel we already do this detailed mapping where :-
>
> 1. Please refer to the drivers/nvme/target/core.c file where we map the
> errno_to_nvme_status(), the reverse mapping of that function can be done
> with nvme_status_to_errno(). Of course you will have to add more cases
> and do in-detail reverse error mapping from NVMe status to errno and
> return that errno.
> 2. nvme_error_status() we map NVMe Status to block layer status.
> 3. blk_status_to_errno() we map the block layer status to the errno.
>
> With the help of 1, 2 and 3 you can reverse map the NVMe Status to errno
> and add that mapper function for nvme-cli which will be consistent with
> the kernel NVMe status to errno mapping.
>
> Now you might find some cases where you cannot map all the status codes
> to errno and for those default cases you may end up using something like
> EIO, this is still better way than having to return 0.

Got your point. To make this discussion short, I think we need to make it
in nvme-cli first.  Let me have a discussion on the following link:
https://github.com/linux-nvme/nvme-cli/pull/492

Thanks,
