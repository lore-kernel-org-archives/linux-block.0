Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D6EC678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 00:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCBAGL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Mar 2023 19:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCBAGK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2023 19:06:10 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AF65504B
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 16:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677715569; x=1709251569;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=T5P7Bwg5cmYMRcWUrgnVWz62kwkuKyBvDGW/C7hOzTQ=;
  b=nN++f3uw/WKVvzwIfQPP1YoOkKVVdbKxbQW+XduwbJ9LCicRZBssUE73
   YzZSoNXLSEKfL3BB0ppFXyCkWLBLOTZJqFqCtRkw5LTDtjUSl8aUeRrEi
   +N+nuemz00/Qv0EZgHt4H4QBMwWM5MsrXG3Xxq4dsX9OwkoWRSLzgqcZf
   XkCXfxQ/Xkk4cpTp0FDyyPqBamIVmqmv9G58N6jlYHpYzAJYMNhUMODEs
   CznUSCljhm93yRu4cJy4k8tdihZ9RfiQqgeUyNskjQXZ6Axr2SvIv3+pQ
   9Dq5L9ArVJcTqvhnegw4k3HBQC9tD9YPEH9rToMJka9+W0yzJRqup57PY
   A==;
X-IronPort-AV: E=Sophos;i="5.98,225,1673884800"; 
   d="scan'208";a="229536789"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 08:06:09 +0800
IronPort-SDR: SgeSx5BCXnRU2aWElE0HlYP906sFK1l5bs8LWf0PHLvUBzepsKW8C0caF0KCP/mTsnvpE1XR52
 qOTw/R3RAGI0QzszrWtxy/g5LD06vZeYMlOL/tM3gcSkdh+BBRhpq6P3fY6Z14lK0/TxKRYBnm
 /S+E/UxAjKSSqn0uldMHh8R2pM4gRLvsKedLEhAGLbzTFrff594o2SakCoILq8AslT6qDmGl2y
 6Xg6Sof21a6JtwvskPnAlquBE19dPjoPfExX4ol0vSzuZPY9j++WBX5Waodrb5dGUAlPEIju5o
 hc0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2023 15:22:58 -0800
IronPort-SDR: FLUjnyxfLb6E96g8x8/EXxY+hVSFuIU/aW9Qt5tePY2dmsUghAc9rcXJC+ddbP78EfnHu2kvdF
 x/mdrKdBgV6ubvC4cquVMpLOtIjwlF8kUOKJtoefSBMHY8pmNf69tc6t1RhMA8QwKkYyi+4xWF
 Jk15XhtFBprZqbbxalQG4SOPCfkC7sB5IoAIqcsKScDRgWDFVVK0PBubOzvn6clxLUxd4rzCvM
 yFxZILzGIXdeCJBmh9BsiB+5VRbuLQZ1A27e6wQvoCT+bRvJLPIQTxkGALGVvWeM/LvDqxgJ0z
 ZHo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2023 16:06:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PRrww2t35z1RwqL
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 16:06:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677715567; x=1680307568; bh=T5P7Bwg5cmYMRcWUrgnVWz62kwkuKyBvDGW
        /C7hOzTQ=; b=FvVORLkUyWJ1iW1uspkfKQhr2hvNykZyTbpOEFAKShHnjKyqwiv
        y17s9sAQdHW3xrlvLCpenojg2MxLktl66yN0Jz1FuoNveUGFg+hkUXeJcp76gwIi
        MaHN2GUgxDOaqZ94/lCaCldT2QHLV+8meni7vOet28n3juay0c7LgpwXiQoVfI3b
        6drmPVgGly+95+/2lNJDqHzB7HQHnQkt4OkvTUp/mUb3/dFi/CumladU85Jq3wNc
        CbnXiI/NVhYyrdAemWG3HTtr8EfRxvMm4RajxmoN6MSp1K4m3H9K5IAhorYJbDgg
        rk0elCeaiMaPR6ph4yTJG226hmRv1Xe78Cg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RsSMyeLr93yN for <linux-block@vger.kernel.org>;
        Wed,  1 Mar 2023 16:06:07 -0800 (PST)
Received: from [10.225.163.47] (unknown [10.225.163.47])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PRrwv07Rnz1RvLy;
        Wed,  1 Mar 2023 16:06:06 -0800 (PST)
Message-ID: <54fb85ac-7c45-f77f-11d7-9cb072f702fb@opensource.wdc.com>
Date:   Thu, 2 Mar 2023 09:06:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF TOPIC] Hybrid SMR HDDs / Zone Domains & Realms
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@chromium.org>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <CACGdZYKXqNe08VqcUrrAU8pJ=f88W08V==K6uZxRgynxi0Hyhg@mail.gmail.com>
 <ad8b054a-26a5-ea60-9c66-4a6b63ca27ef@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ad8b054a-26a5-ea60-9c66-4a6b63ca27ef@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/2/23 08:50, Bart Van Assche wrote:
> On 3/1/23 15:34, Khazhy Kumykov wrote:
>>   - There=E2=80=99s already support in the kernel for marking zones
>> online/offline and cmr/smr, but this is fixed, not dynamic. Would
>> there be hiccups with allowing zones to come online/offline while
>> running?
>=20
> It may be easier to convince HDD vendors to modify their firmware such=20
> that the conventional and SMR zones are reported to the Linux kernel as=
=20
> different logical units rather than adding domains & realms support in=20
> the Linux kernel. If anyone else has another opinion, feel free to shar=
e=20
> that opinion.

That would not resolve the fact that each unit would still potentially ha=
ve a
mix of active and inactive areas. Total nightmare to deal with unless a z=
one API
is also exposed for any user to figure out which zone is active.
That means that we would need to always expose these drives as zoned, usi=
ng a
very weird zone model as zone domains/zone realms do not fit at all with =
the
current host-managed model. Lots of places need changes to handle these d=
rives.
This will make things very messy all over.

>=20
> Whether or not others agree with my opinion, I think this is a good=20
> topic for LSF/MM.
>=20
> Thanks,
>=20
> Bart.
>=20

--=20
Damien Le Moal
Western Digital Research

