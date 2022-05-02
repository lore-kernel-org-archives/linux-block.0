Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7291AC433F5
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384945AbiEBMSI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 08:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiEBMSH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 08:18:07 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D011A2C
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651493677; x=1683029677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=upcjxMBu+P7WwqT0zp8eXVNlC+8I1RqcfjsnBpDAUsk=;
  b=oQNNigMMSD4R/DgQZl/4+lIFfWU+cHXBSi3an6/SFADHAK0Bc+5r334l
   f7jmVr0u8RUtHzh9IbSS3Wpfp3LvZoM4/EU1IzmODgagzDtDxG87STNLw
   rEd+Toeky71MXH6vqaVikseVsOdI7htSjPkd3F3/0mEfv3wWeOxnxtExG
   uCJDNq3lqXgBaJDW2yHSyDd3cz5wqhC8mDsBuIiAXJ8cBqdvdtuFD3SsN
   FVXZg/+Q4mFvWCyKJDQAn+w62Jcyo+G4VXSojSm+D0oanOV6vWIdUhvMK
   kIcozyhAHrNbw5RvCsizRmWT6HL3Dhl23XWrlydE+44Vq6s5Wr42zeXZo
   g==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; 
   d="scan'208";a="303545438"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 20:14:35 +0800
IronPort-SDR: DCABGRS+FEejI7+hdu1qqqWQXaAYFzO3rI0MYK4oVf8CoxxBNbN/gfR2oujtUs1Q74zn7di6/e
 HNSymaGwHpG7CTF/okSBPSL6WOQl1wPdjfOilwbUtsja3rhgO2H9Ip/tXjGvYMUD8xACJU9mq+
 JN7XQh0eCH3T51nnfLOF+Cbw9G1UDiQm/xcnHkH12h2oU+mVtJVSDptEHA6nZdYKY9kysmTXbK
 Jzy8/mitKgyjBvNMVzW8HW683jyJE/dTLhDT6v+Kq17LbX/bo48WpdBFcUVjh6XZ+uZAOAa/Z0
 IBZZF2CbbXtya7eYMq3yiOxF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2022 04:44:40 -0700
IronPort-SDR: Hl1/d36splzmWeb44BTkdrKP14eTnPHkiURMpnHc6EfbWyJvo0F9SFjiFC557hIMXgDGt4kqqC
 3SujPYLQafnrfmhNPOdx9KKIT+Y/2Z7ZfADpK+iuWMJXzv9+ByEWQG/kOjB3kDfX96vLH0O35c
 55/gsNdR93wwWbOCkFYn6KODIVfezfDxiauxKbOLIpJkpA0mgoxgjkI45uLzax6+ntQOfbjOqD
 sxpVz9QnhunAxE6mIUoBkHiRd1A6RFZl1iX8XByoAaJQy4j4u0jVJVPI/hwGzw0T7virXBhusd
 fQU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2022 05:14:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KsMTm53xqz1Rvlx
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 05:14:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651493676; x=1654085677; bh=upcjxMBu+P7WwqT0zp8eXVNlC+8I1Rqcfjs
        nBpDAUsk=; b=ciG1pDAWwoPGHqJ1HX4eF9v2xlPWggbWDb1uKGSNO/jkj8TEDpa
        ILi9HAbkAFNq5EiDhdSuVQosgo82rHtnp1u+5RraiVW1JKJnulP6lgEwewflYcZn
        SLU2nqSrCmvaBlOlhq/SwUz0aYIxD59HoZfzPFAJDB0k2U9prTJ30nuAfheIJUi6
        cxSGNnQB+pIT+qHg0gj218RXQsNIz7HUN6KLbDp7SK40cYGKfLGC+QPoZ1ef02fi
        CGm1HBmySTkuifTYQNn+nm3D/0IlH3vsNc4RSAOlTiP0Ce5dxFXvF9P5lhzKnytM
        U2jRb8KhbGXd9hS/QVpsB1BuBNTzztKOoGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3L53E8IW2oa4 for <linux-block@vger.kernel.org>;
        Mon,  2 May 2022 05:14:36 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KsMTl4knDz1Rvlc;
        Mon,  2 May 2022 05:14:35 -0700 (PDT)
Message-ID: <260b95e8-74bf-9460-cf0d-7e3df1b1a3c7@opensource.wdc.com>
Date:   Mon, 2 May 2022 21:14:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [dm-devel] [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427124951.GA9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/04/27 21:49, Nitesh Shetty wrote:
> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>> The patch series covers the points discussed in November 2021 virtual=
 call
>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>> We have covered the Initial agreed requirements in this patchset.
>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>> implementation.
>>>
>>> Overall series supports =E2=80=93
>>>
>>> 1. Driver
>>> - NVMe Copy command (single NS), including support in nvme-target (fo=
r
>>>     block and file backend)
>>
>> It would also be nice to have copy offload emulation in null_blk for t=
esting.
>>
>=20
> We can plan this in next phase of copy support, once this series settle=
s down.

Why ? How do you expect people to test simply without null_blk ? Sutre, y=
ou said
QEMU can be used. But if copy offload is not upstream for QEMU either, th=
ere is
no easy way to test.

Adding that support to null_blk would not be hard at all.



--=20
Damien Le Moal
Western Digital Research
