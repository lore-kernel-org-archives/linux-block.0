Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0437C433FF
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BCB214C6
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 15:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbxxzFHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfHEPIl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:08:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53354 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEPIl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Aug 2019 11:08:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so75123614wmj.3
        for <linux-block@vger.kernel.org>; Mon, 05 Aug 2019 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CfGlMJlJq1yx6eSWof1+4yQXKTkrtm+XZNLVyiuuYPc=;
        b=jbxxzFHHvusryD5w8vzHeuPeqU/d3yLi9SHaw+kphMYUNZbQHKRDzd0wOyUR/cmUgM
         iMB55vlb/E8GPsyr5ucRPmimQH23RpGgdFiQBLzrxFXoq1sqDkFlGV+7etEF2y6fKRcg
         mc5VTGedBcNbRLHK58Op9xwxSGRqTW4NNy2ZXqz4/zNBv9SNY0VBWz5gJVC1blrGH3jF
         vNnmQ7gxzsoLn1ExYyoQuw5LWo9CH554+vbq0kfDJVdyCK4eq5LocjSQ4KunVUAkwDaG
         7q2NuNsw16RVT8AZxS87xuORXknHwk+nYviQ763BWAYD5i9CYfsX2MjrExgAgGrwLfWf
         gQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CfGlMJlJq1yx6eSWof1+4yQXKTkrtm+XZNLVyiuuYPc=;
        b=M+Akg8mpmQ9VkY0bWHCytyoPS3qjr2SwbWemha1/lTQiaMOzgi7Up4L4Asp4DKWXF+
         MFpMe/05Wco8sShitxkeyv7lE/Z1+32QrpyTHMX+wQ6gBNOrh4LT4EgSUACD6DN2AFEK
         2+eYUglvipvVUOupJLf1AtWUaII0jD1Tds9gLeH8BNrgRNlWSNjn9b1l1vlJouWJdOsg
         esXt92K4KhohC+rv/2tEi0XLHM/HN49XRBvveayMt6fzRRmE57s7/SWOg6TAse/coW/j
         BEYFmmVcrIccq5FtT10ShZ94C1TAnbGExl6iCybjGZBBpBLPtIaHJ03SHzLUgjPPY06E
         2nvQ==
X-Gm-Message-State: APjAAAVjpiEzV5L6CYDQ0QUmbLqf58Kln10fMPDNDYnZBc7CjdHRnhd7
        YVokLga7KKUrr9KmBpkry7PlBA==
X-Google-Smtp-Source: APXvYqxRh/11CyvYNBmPNpSUQlUGVd7DPB6MVKtbk4hpZxUXI6n37AJ0hZvqbtL18gsPQ4efe74OnA==
X-Received: by 2002:a1c:1a87:: with SMTP id a129mr18849472wma.21.1565017719279;
        Mon, 05 Aug 2019 08:08:39 -0700 (PDT)
Received: from [192.168.0.100] (88-147-69-71.dyn.eolo.it. [88.147.69.71])
        by smtp.gmail.com with ESMTPSA id c3sm87272983wrx.19.2019.08.05.08.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 08:08:38 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v2 0/3] Implement BFQ per-device weight interface
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190805063807.9494-1-zhengfeiran@bytedance.com>
Date:   Mon, 5 Aug 2019 17:08:36 +0200
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Fam Zheng <fam@euphon.net>,
        duanxiongchun@bytedance.com,
        linux-block <linux-block@vger.kernel.org>, tj@kernel.org,
        cgroups@vger.kernel.org, zhangjiachen.jc@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6E36505-16B1-4E6D-BCA8-53E5FD4AEE98@linaro.org>
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
To:     Fam Zheng <zhengfeiran@bytedance.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thank you very much, Fam, for this extension.

Reviewed-by: Paolo Valente <paolo.valente@linaro.org>

> Il giorno 5 ago 2019, alle ore 08:38, Fam Zheng =
<zhengfeiran@bytedance.com> ha scritto:
>=20
> (Revision starting from v2 since v1 was used off-list)
>=20
> Hi Paolo and others,
>=20
> This adds to BFQ the missing per-device weight interfaces:
> blkio.bfq.weight_device on legacy and io.bfq.weight on unified. The
> implementation pretty closely resembles what we had in CFQ and the =
parsing code
> is basically reused.
>=20
> Tests
> =3D=3D=3D=3D=3D
>=20
> Using two cgroups and three block devices, having weights setup as:
>=20
> Cgroup          test1           test2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> default         100             500
> sda             500             100
> sdb             default         default
> sdc             200             200
>=20
> cgroup v1 runs
> --------------
>=20
>    sda.test1.out:   READ: bw=3D913MiB/s
>    sda.test2.out:   READ: bw=3D183MiB/s
>=20
>    sdb.test1.out:   READ: bw=3D213MiB/s
>    sdb.test2.out:   READ: bw=3D1054MiB/s
>=20
>    sdc.test1.out:   READ: bw=3D650MiB/s
>    sdc.test2.out:   READ: bw=3D650MiB/s
>=20
> cgroup v2 runs
> --------------
>=20
>    sda.test1.out:   READ: bw=3D915MiB/s
>    sda.test2.out:   READ: bw=3D184MiB/s
>=20
>    sdb.test1.out:   READ: bw=3D216MiB/s
>    sdb.test2.out:   READ: bw=3D1069MiB/s
>=20
>    sdc.test1.out:   READ: bw=3D621MiB/s
>    sdc.test2.out:   READ: bw=3D622MiB/s
>=20
> Fam Zheng (3):
>  bfq: Fix the missing barrier in __bfq_entity_update_weight_prio
>  bfq: Extract bfq_group_set_weight from bfq_io_set_weight_legacy
>  bfq: Add per-device weight
>=20
> block/bfq-cgroup.c  | 151 =
+++++++++++++++++++++++++++++++++++++++-------------
> block/bfq-iosched.h |   3 ++
> block/bfq-wf2q.c    |   2 +
> 3 files changed, 119 insertions(+), 37 deletions(-)
>=20
> --=20
> 2.11.0
>=20

