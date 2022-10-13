Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C90C433FE
	for <linux-block@archiver.kernel.org>; Thu, 13 Oct 2022 20:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiJMUOW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJMUOV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 16:14:21 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CE618DC33
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 13:14:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id ECDC72B0672B;
        Thu, 13 Oct 2022 16:14:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 13 Oct 2022 16:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1665692040; x=1665692640; bh=l2inNZMIPI
        d3zeZXqLQOmIFTkdONrtoZr3dSGGxvchw=; b=tgF/BVNWFtwtRFCocgrr0nBgNo
        eQmIxb1Q9KG4yDHBRYQcckFqLXyiLJweg0KUIA85DylFDea5iceJ8/FgeNRQr+l8
        6x1te9qTaxp9d8GYlp9l1hmW+VWrMlAn8dYYTEKU3HKHO5gYCB1nS0Hh553D6tko
        o/42xjlz3MYNDhLuYAYSAs5ytZ7z7jnyt36JrhqUWR4CWP4whigDD7DCucAmFDYC
        ajARAttzyxqxLWdaKBHzxwfsLQhjxVsputMxtxflhbldZFpbrE9nHwpp8g3qi1fO
        z+CvewVMLWxm4LWTPauflv6etSJU/DZPgAd2IyqzQeLq4kXDWF7uPT6Nbbqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i84614614.fm3; t=1665692040; x=1665692640; bh=l2inNZMIPId3zeZXqL
        QOmIFTkdONrtoZr3dSGGxvchw=; b=s/sAGUJvyAaoesK8YQZM3cSb8fajFKCguG
        c8dVDkP2dffCP8+fFfJnMBSUKE46gIdFmWo7OLiVgSmyjzp8r2pRmkJFbDbBr2Oc
        QKRkc3TmdTrNmrh6FxlHD7NHu+PgjDjWfUoKhcl/GNF9Sdz2jfk4BabirXyizT+B
        Q4rFlICUCI/WyzUuuvjZk4XU1SUNDQdsmqnJoRCT6bQyMnP2tTiSchCP1PWNiomD
        foyEhAejQYWzO4SA8gRD/2m3zp/kwg065FhMRTuY71t+r39/bV6ZDBLrDuo4A8z1
        RflWEs59wzulUs8YZfvs90U0/TFsJdk9NNqL4aingBrnUYmAJVUw==
X-ME-Sender: <xms:h3FIY9z5aidwo31m3f0BZf21bPt87qHu4ewagN2mlmZOtb4QkH0YmA>
    <xme:h3FIY9QmzktJNtngMQOcGIVoJwiCoMKMHWCpmt6H9TCpczPY6yJgQ4U0JQrj14Ffq
    hnk-z29zXcJNTD3xEo>
X-ME-Received: <xmr:h3FIY3VYeRi-uRILr6wsLeGI4XhDgRRKCBhCnHTk4RizW1uMJAxLcnLpXQqYfxQzxxV0KdbV0ZDtoOYiWFy5TZst4EBjF8-SWRWy0YDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeektddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesth
    dtredttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghv
    khgvrhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepveelgffghfehudeitdehjeevhe
    dthfetvdfhledutedvgeeikeeggefgudeguedtnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:h3FIY_gz47da7KuQd2is5CIndb4LjHcjrhrvnzZyTjTg1RVQbtHa9Q>
    <xmx:h3FIY_C0UaFZQBDujjihE9KL54oMW7jiI2RTQdwV1LYCpx49UVTt1g>
    <xmx:h3FIY4JGgIbxz_nm-AOTXU4kFqmZS38gVuPraTXA-O0-61NrB_dXkQ>
    <xmx:iHFIY69tsxAcLbKDdtCIv74LVuTzzYt_p5ktochUIMvRYufFhl5XAh4vFcFNstrG>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 16:13:59 -0400 (EDT)
References: <20221011010044.851537-1-shr@devkernel.io>
 <Y0Wz28QzRtH+72Pu@casper.infradead.org>
User-agent: mu4e 1.6.11; emacs 28.1.91
From:   Stefan Roesch <shr@devkernel.io>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com
Subject: Re: [RFC PATCH v1 00/14] mm/block: add bdi sysfs knobs
Date:   Thu, 13 Oct 2022 13:11:22 -0700
In-reply-to: <Y0Wz28QzRtH+72Pu@casper.infradead.org>
Message-ID: <qvqwv8oneb2w.fsf@dev1180.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Oct 10, 2022 at 06:00:30PM -0700, Stefan Roesch wrote:
>> 2) Part of 10000 internal calculation
>>   The max_ratio is based on percentage. With the current machine sizes percentage
>>   values can be very high (1% of a 256GB main memory is already 2.5GB). This change
>>   uses part of 10000 instead of percentages for the internal calculations.
>
> Why 10,000?  If you need better accuracy than 1/1000, the next step
> should normally be parts per million.

For current main memory sizes 1000 is enough. I wanted to give some
additional headroom. Parts per million is too much. In the next version
of the patch, I'll change it to parts per 1000.
