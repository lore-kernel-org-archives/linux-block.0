Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A021EC678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 02:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCBCDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Mar 2023 21:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCBCDn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2023 21:03:43 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C82C660
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 18:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677722621; x=1709258621;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=UYh+pac9ZELd8V45bei7YPHT8yAa/BIlDutDcfVNRe4=;
  b=OBSi/7j5hNAshRfyU2dFMsCjynkTavbk2T7hrJB+R063ri7K/Z2dBR62
   1VLXGVFUkZOjXvrX5S8po4r136KAEbr1cPx03Gz+AvsWDs605i3Ln6ec/
   5ncoPuj6fLUKSG/ZPqpWlMx1XZ2n6SmGqukh6duMGQMC2RaFsPKxXu83s
   f38ErBXUcaagj7Y7Al0MmkEzLiffzrtUibHzXvIa0rjNh43JCTDad6q4M
   zfb+t5oxUaDE2np3XKx8hgwxj6i/MOh8mSKnqSy+EsiMm7QQs8Pa7G0NT
   mRRPovnH0Ly1W7d63HwQOu7jwOTg7kTGFhU84mznzIZ9i4u6VML5qGWVX
   A==;
X-IronPort-AV: E=Sophos;i="5.98,226,1673884800"; 
   d="scan'208";a="328905897"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 10:03:40 +0800
IronPort-SDR: KEVZq0HCua/gHbQC0seGE1z0CQsGxHjEejaE62DzltFwQ1U4V8yQD9S6hSA1QJxK5qag+lk7MV
 Vb1q5NnPV1fkH50eA1abkEeIHAcbWugXPAWh6p2fizqi/moHolHvixaTXyMXU8Jv4izj+kHDAY
 9GZzNYIUWMEDtjIHKuWwuNjfxfEib6VVgGT1Kj3jfYyvVXJmI2iJKfAMrh3kVcwJzNSxS0AX2z
 hdwmmza8mFgPpqnkOPFgKgt1rrI6hVqgk3Kv2uf49P1HKdgebkyXz5dUztb4ZuJbLfRdBsVbsd
 JQs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2023 17:20:30 -0800
IronPort-SDR: OIJHm59nL/+VmrTkHnuvvN/iYac8H5csO9QmU+dx7JkbcDpVV+C3dKQikVQosnXWtCXH14HyQB
 o5jYLTOs8X/4YhyUTMh51Zbb77nj5bY0j3vW57uvUKlowFMWd+8kqNfBjyJEj/FOas8UMUbJ+z
 cEZzhnStqy/zbwmVCx2MHS6e97ws5w9r1sPJKVbvNfW07aCbhZKIOEoW79BZEfVJN89moy9EGg
 1alPfFJdr3uQa580azOh5tfzQL/B/MVJj7Kizi4yFlls7fJKnpJZshHcnTuZgQtZ9pbFrR/n3f
 Ik8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2023 18:03:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PRvXX1nPzz1RvTr
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 18:03:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677722619; x=1680314620; bh=UYh+pac9ZELd8V45bei7YPHT8yAa/BIlDut
        DcfVNRe4=; b=Wwu4q7HLITb/tDl/8K6xmWEyWWJ6M5eGrDobErndtm1zz35sV4T
        qRebF+MQ68/Sy4Bw7g2BgKojTzGHMiufJ0WHE7SFezYnq5PdOvObvR/G4VgBSuYL
        owX8UzA0eiUZ2bFngyoczARfprDDdJtNM5Lmwhrklvpspawp7sa+YqpKxs2paImr
        bs1lHOCmtFuAU7uv9MaLJu8E0r5/ngGMGrqlKHvAHjjtjuK/n+Jg+Sg3+V/XoYAx
        g4R+hf+hzul6jzkbAHj+IfenGIE6vE/r6PBf2pi3Z0AN5/rQl1W33bqnpdmWRzho
        Y4yTy6ZfW5tyrt/YzfI8rXAkMXwx7nEI9Og==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tqYqPoC9kFpo for <linux-block@vger.kernel.org>;
        Wed,  1 Mar 2023 18:03:39 -0800 (PST)
Received: from [10.225.163.47] (unknown [10.225.163.47])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PRvXV6yZCz1RvLy;
        Wed,  1 Mar 2023 18:03:38 -0800 (PST)
Message-ID: <8e3643a5-80bd-8c02-8e83-a2c1341babcc@opensource.wdc.com>
Date:   Thu, 2 Mar 2023 11:03:37 +0900
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
 <54fb85ac-7c45-f77f-11d7-9cb072f702fb@opensource.wdc.com>
 <569dc9d2-3e6c-0efc-560c-bfcacfbfbda7@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <569dc9d2-3e6c-0efc-560c-bfcacfbfbda7@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/2/23 09:51, Bart Van Assche wrote:
> On 3/1/23 16:06, Damien Le Moal wrote:
>> On 3/2/23 08:50, Bart Van Assche wrote:
>>> On 3/1/23 15:34, Khazhy Kumykov wrote:
>>>>    - There=E2=80=99s already support in the kernel for marking zones
>>>> online/offline and cmr/smr, but this is fixed, not dynamic. Would
>>>> there be hiccups with allowing zones to come online/offline while
>>>> running?
>>>
>>> It may be easier to convince HDD vendors to modify their firmware suc=
h
>>> that the conventional and SMR zones are reported to the Linux kernel =
as
>>> different logical units rather than adding domains & realms support i=
n
>>> the Linux kernel. If anyone else has another opinion, feel free to sh=
are
>>> that opinion.
>>
>> That would not resolve the fact that each unit would still potentially=
 have a
>> mix of active and inactive areas. Total nightmare to deal with unless =
a zone API
>> is also exposed for any user to figure out which zone is active.
>> That means that we would need to always expose these drives as zoned, =
using a
>> very weird zone model as zone domains/zone realms do not fit at all wi=
th the
>> current host-managed model. Lots of places need changes to handle thes=
e drives.
>> This will make things very messy all over.
>=20
> Do users need all the features that are supported by the domains &=20
> realms model? If not: what I had in mind is to let the HDD expose two=20
> logical units to the operating system that each have a contiguous range=
=20
> of active zones and hence not to support inactive zones.

But that is the issue: zones in the middle of each domain can be
activated/deactivated dynamically using zone activate command. So there i=
s
always the possibility of ending up with a swiss cheese lun, full of hole=
 of
unusable LBAs because the other domains (other LUN) activated some zones =
which
deactivate the equivalent zone(s) in the other domain.

With your idea, the 2 luns would not be independent as they both would be=
 using
LBAs are mapped against a single set of physical blocks. Zone activate co=
mmand
allows controlling which domains has the mapping active. So activating a =
zone in
one domains results in the zone[s] using the same mapping in the other do=
main to
be deactivated.

>=20
> Thanks,
>=20
> Bart.
>=20

--=20
Damien Le Moal
Western Digital Research

