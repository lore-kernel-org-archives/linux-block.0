Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A19C433EF
	for <linux-block@archiver.kernel.org>; Sat, 12 Mar 2022 08:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiCLIEU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Mar 2022 03:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCLIEQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Mar 2022 03:04:16 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864F3427FA
        for <linux-block@vger.kernel.org>; Sat, 12 Mar 2022 00:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647072189; x=1678608189;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vWrO9cyYr6q0oBQodYPW0B4WRkzjdaFDLBb6mE58NYw=;
  b=HrlZs80SrrQqT0IYyiR9L78f2UBWffhLF58e50a2q2r2Es2pYcFM2pJ9
   jWTsL0KmpRX9KKjmcCR/uD2iv2oWhKWwVnnJCVv2ETjnWqrWZMMaEHxUL
   Iq5GVuCObGvibYEOZhH0idbd/sr8zM6cvqOa+SCS07oj8nQbsb3/wtM76
   lmc/l98kzbOGv/D30AeuPH7v8uVVoSO//HarZ0UWKMLpKUPcFhu/xWv1X
   rSrlOXH5RVaWOTm6AdZj8Zw08tgD6nsoDNnU3Lkx1A5CRGRjHqAzehIX0
   76AcJsm9B6G2ZuzSkenMpHHqJjcchPgJpZ5Z3pZtePr296be2x2rF8SX+
   A==;
X-IronPort-AV: E=Sophos;i="5.90,175,1643644800"; 
   d="scan'208";a="195172691"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2022 16:03:08 +0800
IronPort-SDR: QomU57OizNviaN8mxz7Us5TzvPRfGGV8yrAZgAWHceVXKWeq+BIMbWK2UEAsqdAIKxPhe501H9
 dL6bhlbeIHOyaYA8bpRbEbn8FyCJpRKPfZYIycTej11ABXXOMfC8j5Q33xtNhqtHGmAIOgL4hE
 YHGhxkLIzcv8FZ1iTrZvBEflyU0MV+sUB5Bl1JMlW+d/0vYRIHefAVtNDazN4ekkX9WZqu9zyk
 U0QpybxJTz9a8TJTsGFqc6OLmoemKH6oHKsvz6yr2HMUNFtFBhegii/AEUGMrHpHuK62D7N/jW
 7crGk/g8o6kRXcAQ9Shc1kFr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 23:35:19 -0800
IronPort-SDR: FoZsRWTmsLKxwb+9ptNUadEqMDZs/AeRC4KOqZuUfEdGzcpVPa+NHQeQlDdsW7mkTigACAtQzc
 gcCQugRZE8Ox1M1xXYH4moGfOlYS8RMXCe1L3Zn0TtJ2YJ+RCV7SxAaZsnZ5igdW9JKpeWM38F
 U6ZYyw41f1utFBLRIFr0eCpZu9KW3OCtLqkmE7w3+idHbLFRWwdSO+bSh9UFo2HpSfjjYMBr/I
 BMrK3lNjuV3ppJtYI/C8dMbpAOMriJasG6iHA9dBNVd9tKbST6jc0zPShOvIp9Etb5gMW2scZQ
 2No=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 00:03:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KFwK80vLtz1SHwl
        for <linux-block@vger.kernel.org>; Sat, 12 Mar 2022 00:03:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647072187; x=1649664188; bh=vWrO9cyYr6q0oBQodYPW0B4WRkzjdaFDLBb
        6mE58NYw=; b=hGDU8jKiPwONNjSz4o/NXS8gNMXzdTwkjB9gYHqv46DPfepYaUX
        TJX7GVTvZVfAg0pOqy2Fa4wDSH2yZKFGQ0zHkB3/EbVRSWbb5C7CJ1/IiYp+xJF3
        YKcWkc0IzZOAnL0qNqB3sS0maNzQ2UrA8IZ9/hNsrsgXHUVXRp3DyYrtvmJvKKNz
        Cd90uaPRXJRfkjUnTBh2vRVTMmoViRCP9Td+WfdVcQtdt9v/8DcgTQmCb4cpO3pl
        kXTvNOB/G8wurSU6lKJwI3mKTkqOJaHGq7N8YFM5GgdpygE1qbUlp1mcLPKd9Fw3
        1DXAChPQy5b22hkCOyDi3x2Kuuj8fdFm3Kw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UzppQDHX_KMT for <linux-block@vger.kernel.org>;
        Sat, 12 Mar 2022 00:03:07 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KFwK42RnNz1Rvlx;
        Sat, 12 Mar 2022 00:03:04 -0800 (PST)
Message-ID: <1d3f56c0-3f53-3609-d376-1a5ffc327bd1@opensource.wdc.com>
Date:   Sat, 12 Mar 2022 17:03:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Christoph Hellwig <hch@infradead.org>
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
 <61c1b49c-cd34-614a-876a-29b796e4ff0d@opensource.wdc.com>
 <Yir9a8HusXWApk5l@infradead.org>
 <20220311075317.fjn3mj25dpicnpgi@ArmHalley.local>
 <YisMUruNKNlV8FhW@infradead.org>
 <20220311085925.c66kly5zy6otgcer@ArmHalley.local>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220311085925.c66kly5zy6otgcer@ArmHalley.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/22 17:59, Javier Gonz=C3=A1lez wrote:
> On 11.03.2022 00:46, Christoph Hellwig wrote:
>> On Fri, Mar 11, 2022 at 08:53:17AM +0100, Javier Gonz=C3=A1lez wrote:
>>> How do you propose we meed the request from Damien to support _all_
>>> existing users if we remove the PO2 constraint from the block layer?
>>
>> By actually making the users support it.  Not by adding crap to
>> block drivers to pretend that they are exposing something totally
>> different than what they actually are.
>=20
> Ok. Is it reasonable for you that we start removing the PO2 check in th=
e
> block layer and then add btrfs support? This will mean that some
> applications that assume PO2 will not work.
>=20
> 	Damien: Are you OK with this?

See my answer to Luis's email.

>=20
> We can then work on other parts as needed (e.g., ZoneFS)


--=20
Damien Le Moal
Western Digital Research
