Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BECC433FE
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 01:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKSBHZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiKSBHI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:07:08 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82ECCFA6F
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 16:03:02 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id F2AB02B067B7;
        Fri, 18 Nov 2022 19:02:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 18 Nov 2022 19:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1668816178; x=1668819778; bh=DVeAdFlp2K
        jM5VWV1HK0EMvnRWbCTd0/KQhr3OsmXj0=; b=blv21r3SKywYvqaw90mI5T7Y8F
        vtBp4togFVHTtbyVYPspywYMfys7EN8iUECiSGD5RUqDwy2m5YXVxCrSZQN3J+Bt
        MlmEMeewpiLo1hANuhWn/8vBJOP5iglIub/51937dRJbU2QWsZcfkQ1bPzqt4GVT
        EOcr5j0NI71cRKY+JFf+ALmo1o5/wcin+RL6SWGCbFVz97RXdsJajdVc61AavVwc
        4DAI9ibOCd2EtIeo9d98TOPPdzERPWtu7iyHt9YxMey+0bv7BUnXcScbzz0d1BtS
        IC+rLxdLYdeUB9lltebV0c+xXydOsMclnHtSHC7fAh07NGWnzMJDFGBUERsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668816178; x=1668819778; bh=DVeAdFlp2KjM5VWV1HK0EMvnRWbC
        Td0/KQhr3OsmXj0=; b=O86O6Ga/SFRS4JE2QbSNu3BqvrpN2p/JU0XYYnBt6XAw
        4jx8Gltws+gPT8ZvbKLabQe7tbvr38itxLJdmpQTYleW2U87m1wRtj4njTFPR3T6
        CPDkQzEX5Ze1G0VXMe7+cCz1jEuSpmxOeAPIsCq2X9XLdab3SEwax9Pqp3X4qGGW
        vZieGzEY5ki3D71YOSDLZCyMWUOLlmLsds1UJdn0AxgllpsZpczORs8I7YXUY7pP
        OoyvTK7R+3LZrSdJOjN23QoyqKVRUa9nwg2QLlCKtLZYO2ChGsxaT30KQYOBLPK3
        tAyzvYINgV3JWp8y0tntPRJlfo/yqokw30S+ltHcNg==
X-ME-Sender: <xms:Mh14Y1JCoHNXrihXrAN824aY0a_hOG4iDNe0FFDKxGqedVHsuoj6bg>
    <xme:Mh14YxIFYL4su9FeVrTUysdSiSoqZfNKkVH1mYQnjIJAlMhHNk_H4qCzDF-G4VF3-
    cPK10vFy1B3SEVZqCI>
X-ME-Received: <xmr:Mh14Y9usaJNk2YCK8mav2FWZnsXbZCCAGC6ZCHK9x4k4hAfCoBFVC5gwqR0Lt_w-41uuUt_NYxqw6NCDUatCjY8ZH-R_p2xz55XqLUZwjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedugddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesthdtre
    dttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghvkhgv
    rhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepveelgffghfehudeitdehjeevhedthf
    etvdfhledutedvgeeikeeggefgudeguedtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:Mh14Y2bHpVd1a2K-s5NuC_Gu22OEzdSXDzpb0AteOXzPGkb2b6df2Q>
    <xmx:Mh14Y8ZOB8Xi_5QQ0PkpZDQYZ-8rHmqEnkCtFVwFGSCBr8B35SoFzQ>
    <xmx:Mh14Y6AKUUiCTfhwg6DRI1lyUw8ND2Kv2RPTT9RA5JHon1URqxyY0w>
    <xmx:Mh14YxPgyhQvnh2YJ2fsyGcBcgL_2dUy3mPeXe--aLhwuVEvJeJT63fr7Gg>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 19:02:57 -0500 (EST)
References: <20221024190603.3987969-1-shr@devkernel.io>
 <20221024190603.3987969-2-shr@devkernel.io>
 <20221116132856.b3403e3ae1e39cc3a7a4f865@linux-foundation.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 01/14] mm: add bdi_set_strict_limit() function
Date:   Fri, 18 Nov 2022 16:01:48 -0800
In-reply-to: <20221116132856.b3403e3ae1e39cc3a7a4f865@linux-foundation.org>
Message-ID: <qvqwwn7r95g6.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 24 Oct 2022 12:05:50 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>
>> This adds the bdi_set_strict_limit function to be able to set/unset the
>> BDI_CAP_STRICTLIMIT flag.
>>
>> ...
>>
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -698,6 +698,22 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned max_ratio)
>>  }
>>  EXPORT_SYMBOL(bdi_set_max_ratio);
>>
>> +int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit)
>> +{
>> +	if (strict_limit > 1)
>> +		return -EINVAL;
>> +
>> +	spin_lock_bh(&bdi_lock);
>> +	if (strict_limit)
>> +		bdi->capabilities |= BDI_CAP_STRICTLIMIT;
>> +	else
>> +		bdi->capabilities &= ~BDI_CAP_STRICTLIMIT;
>> +	spin_unlock_bh(&bdi_lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(bdi_set_strict_limit);
>
> I don't believe the export is needed?

No, the export is not needed, the next version will remove the export.
