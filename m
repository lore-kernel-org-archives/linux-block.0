Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881BCC4321E
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 07:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347238AbiCKHkV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 02:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347242AbiCKHkU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 02:40:20 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CFC606DF
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 23:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646984356; x=1678520356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zks+LcQgLgFnsycj932aQmZKs+2Atp/BmYrHQzR+Vug=;
  b=TDeAKwFC4Y6GzRGHcB7jVN3kWPEjV0hCnavcDxcFDKMmvKyLOdqKQgTp
   peNiU37OpX5Z5CHMJVUazBBQSznMzetBgQtpZcqOtp/vAnC4c2XldFHIj
   xXyOQwb+QAJp2n0FzHbwQViQ4+cR90KXD4uDe3jqt1a0/qr5Y5uLs04Ns
   7UdFOUGWioiX9qVSKcElG+B7luRvHEep8pJBIR0DgAnh9PTqTIQZFxwcU
   rsL8Sss6I6HlNZgkA77M/Nyzti6lBdYsopE3QOKuGffWKVcESNIXcFrws
   /UG3XaTksbAEnYq0ND0r7UxMu5dQcFqnXj9WsF+O1lIfnaEbrvWPoBvGb
   w==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643644800"; 
   d="scan'208";a="199899226"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 15:39:16 +0800
IronPort-SDR: fTarmtAmEwee2KJ2jM9FBtrVvxLe3kn20Li8dkDTqJMc1r7Y1AeSpONGCvVzmUmd3v5O20jFIS
 XvAFuPtmMxOO4CH9I+D0fy3vE3PtTaBpQxFHoebG0hfkuUNZJPu8fIJl87UjC1I7ycpAfw4+F5
 GmDZUfhuj50kTs/oBmROr+xAyseCVo4qrYgAKuiiQZNnngk2iaFqF37ATtXA4rSHrTvxUacEar
 srz1HToEuSnC8WeU9a2uCBLYoTpfZCxh79kzw8zTOGAWPl7LN6jmecjogNkUq6Pq7gQxP81HhW
 Ou/kuKb/P2ojWVXKK5uFVq4f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:10:30 -0800
IronPort-SDR: dpYlwSrxyInTtfm04OooWGCaao6/TWDLoHznlJo/lMnwNnjH92HYslGfhx5ZVfvGxZs+VSXE2y
 KYiNJNmwfEDfwuqOITQ84ksMAR67ys9tyy+lQF/bqUZRllhl2TEI9xqBn5VfuXlothFq1UcUHi
 +9cJ2KxIjkOfw3mjU+TWG4BIzOiACeW4Afx+EDUsbODN0+iFjflsDkh0VgJirTllJ3UDqIfpxO
 L652ATtt94seLWE0Ky0h3GZ+YgczIPnohapFPaHS70VzLKCnkSs7uMnuVrVkssAFk3JY2iP34D
 nBs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:39:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KFHr51xMBz1SVp4
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 23:39:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646984356; x=1649576357; bh=Zks+LcQgLgFnsycj932aQmZKs+2Atp/BmYr
        HQzR+Vug=; b=PbLBRBOue05Grp2Rhg2SQiIl2g6/F/BNft6b7yVswR8+3VZoiwc
        qvilCXrFzv3mJIfG6X0gtPE/UINZUFIdepEg9LFFjFkjv2q5T/Wo79yxyTQwPQxH
        YV+D5iZGv5Z2kNEmUjotpnYKHUyOAlIDyXQEJqrxgV5iAea5JGawdsoO3tXrKABJ
        zR+Xrge6aIKf3hIw8SuTVhLWNtaPWvyfso+4vjxhrTh72LYrt+rZo6Clg5a6rrDw
        HN7Mt58nl1rHn8CdrUT7Rp9wgTyyF8T/gkIlcyeicZ4AwTDzRw4xBYickokb10wo
        C9m9rIEbW0amtAyfvWW/6Y8uwfHTqsh0O+Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NSjLTKzpxEn5 for <linux-block@vger.kernel.org>;
        Thu, 10 Mar 2022 23:39:16 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KFHr13f4Wz1Rvlx;
        Thu, 10 Mar 2022 23:39:13 -0800 (PST)
Message-ID: <61c1b49c-cd34-614a-876a-29b796e4ff0d@opensource.wdc.com>
Date:   Fri, 11 Mar 2022 16:39:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
 <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
 <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
 <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
 <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/22 16:21, Javier Gonz=C3=A1lez wrote:
> On 08.03.2022 05:42, Damien Le Moal wrote:
>> On 3/8/22 00:15, Keith Busch wrote:
>>> On Mon, Mar 07, 2022 at 03:35:12PM +0100, Javier Gonz=C3=A1lez wrote:
>>>> As I mentioned in the last reply to to Dave, the main concern for me
>>>> at the moment is supporting arbitrary zone sizes in the kernel. If w=
e
>>>> can agree on a path towards that, we can definitely commit to focus =
on
>>>> ZoneFS and implement support for it on the different places we
>>>> maintain in user-space.
>>>
>>> FWIW, the block layer doesn't require pow2 chunk_sectors anymore, so =
it
>>> looks like that requirement for zone sizes can be relaxed, too.
>>
>> As long as:
>> 1) Userspace does not break (really not sure about that one...)
>> 2) No performance regression: the overhead of using multiplications &
>> divisions for sector to zone conversions must be acceptable for ZNS (i=
t
>> will not matter for SMR HDDs)
>=20
> Good. The emulation patches we sent should cover this.
>=20
>> All in kernel users of zoned devices will need some patching (zonefs,
>> btrfs, f2fs). Some will not work anymore (e.g. f2fs) and others will
>> need different constraints (btrfs needs 64K aligned zones). Not all
>> zoned devices will be usable anymore, and I am not sure if this
>> degradation in the support provided is acceptable.
>=20
> We will do the work for btrfs (already have a prototype) and for zonefs
> (we need to look into it). F2FS will use the emulation layer for now;
> only !PO2 devices will pay the price. We will add a knob in the block
> layer so that F2FS can force enable the emulation.

No. The FS has no business changing the device.


--=20
Damien Le Moal
Western Digital Research
