Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B7AC54EBD
	for <linux-block@archiver.kernel.org>; Sat,  7 Jan 2023 01:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjAGB5B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 20:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjAGB5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 20:57:00 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F95BE19
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 17:56:37 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id o66so2532441oia.6
        for <linux-block@vger.kernel.org>; Fri, 06 Jan 2023 17:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9ykbBgKBZV6FU4/LOBwCWniqrM4IT15rEg/LDaszi0=;
        b=Hp7RDK1T4MTeLPWqoateGOJUUNQXKsaqDz53JVg8WmdPsfDAh7yOnQByCLm/cz69ao
         xujnVoSsVoSpwYTwojx8VRI6xyaRQO32MQ3MdWcCuWz0wUY8My1LjRJU4BgJ7L4LG0fB
         jCR5fPkFRpPWvzmGtqDF9m946/zeiPegD21MRirOZ/Qfnuw/hMeuhGNCHaT+i6bq5Rt5
         0Wy+BlUcdnv1+cXLmGWZOytIUH8X2P1U8xn4S/TZCdpH2VsuMF2/f+aSPt3LCpcMenDn
         3YF9kKedrkqXj70gUSYik3Cf+C2nwcqvUg0x1kOGsM/YFAEtEpQGwxdpuls0Q5cla1Z+
         ZZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9ykbBgKBZV6FU4/LOBwCWniqrM4IT15rEg/LDaszi0=;
        b=cTv/mlByXcHf2a5nntwEIVEHGR9Rvz//vMDsfOvsXXmUTxLBIteqOF9bZyFZEPsTvd
         /DSWAvolDj2pMc/lG73FLQgYap3dI+vYuo174y5nSiob0K3WL/A4hNUNIMOdJ9ZPidCJ
         p7/+ZMqe/yHICPZIwFNKksYYPeS837BLuNMln4ML/y9LiQKYq9PnjW/a5c5Yj4dTQQNy
         8C2SWki782Ymg1ilhH0qdRULuTNckhAqYXc8WFjSWYO8VzeOjCF38m099SSfuC8l3yOt
         u2yx2SrtYCXmIm4hF3Pd5i36HqjkLVzYpxJjxWv/SnKz+Sy4lNgJxUscOP3NYPKgcO7z
         jyYA==
X-Gm-Message-State: AFqh2kpq98kR6XXLTL+I6MKtweIthDq7VOAv6r1nAWhTm5TxnWaicz1h
        BHSLq9hhHKNhOyBPqXPKsaIYfw==
X-Google-Smtp-Source: AMrXdXsX7/ocgMuBmhZAyTiWEsO26xIEVMPm87p+6teNszs25TWA/cRXzEPG3ohOcSqgH7/lPrPTRQ==
X-Received: by 2002:a05:6808:1414:b0:35e:d937:7d35 with SMTP id w20-20020a056808141400b0035ed9377d35mr35703216oiv.11.1673056596809;
        Fri, 06 Jan 2023 17:56:36 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id w18-20020a056830411200b00670747b88c9sm1287038ott.39.2023.01.06.17.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2023 17:56:36 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
Date:   Fri, 6 Jan 2023 17:56:24 -0800
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jan 6, 2023, at 11:30 AM, Viacheslav Dubeyko <slava@dubeyko.com> =
wrote:
>=20
>=20
>=20
>> On Jan 6, 2023, at 11:18 AM, Luis Chamberlain <mcgrof@kernel.org> =
wrote:
>>=20
>> On Fri, Jan 06, 2023 at 11:17:19AM -0800, Viacheslav Dubeyko wrote:
>>> Hello,
>>>=20
>>> As far as I can see, I have two topics for discussion.
>>=20
>> What's that?
>=20
> I am going to share these topics in separate emails. :)
>=20
> (1) I am going to share SSDFS patchset soon. And topic is:
> SSDFS + ZNS SSD: deterministic architecture decreasing TCO cost of =
data infrastructure.
>=20
> (2) Second topic is:
> How to achieve better lifetime and performance of caching layer with =
ZNS SSD?
>=20

I think we can consider such discussions:
(1) I assume that we still need to discuss PO2 zone sizes?
(2) Status of ZNS SSD support in F2FS, btrfs (maybe, bcachefs and other =
file systems)
(3) Any news from ZoneFS (+ ZenFS maybe)?
(4) New ZNS standard features that we need to support on block layer + =
FS levels?
(5) ZNS drive emulation + additional testing features?
(6) ZNS + computational drive? What new features would we like to see =
from ZNS SSD?
(7) ZNS + CXL: does it make sense?

Thanks,
Slava



