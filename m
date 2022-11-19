Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6877C4332F
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 01:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiKSBRr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiKSBR3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:17:29 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED3016811F
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 16:15:05 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id C803C2B0734F;
        Fri, 18 Nov 2022 19:15:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 18 Nov 2022 19:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1668816904; x=1668820504; bh=vYshvlUCFO
        duyzjRxT5gWAZISjMz1/wRvk7ABmxlu9I=; b=ty47UutXUmggBC8sPvCJzvwpnU
        A1AhFBWtLmWvCP7feuD9FD90QD5/OMYvWW/3jO/9bSprbT6IhWGQpCM1kSDXGWq8
        UoHVVyiEejy8069xN5gfbuDcW8wCZeHlunkTjD3l5Hz8nUMY6fAolmQ9b04qpX7v
        Z2IBsHtS3p0KR9keu5ylbHgcz9C/5YU5MUI4fyrKdLx44aedVW1AgNN18MJFOPNS
        3kMD2+TFzBGlrNcJXd1WzBlI0rvZA+DpA2JXjvMR5F9+5UZTfi92BeEmp6F7Ch+7
        8hkRfSH+KKgpr1ZJeSzf+WTBIw+UbfhHiNBimWmSPRHxQy67ctrGUAZZogxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668816904; x=1668820504; bh=vYshvlUCFOduyzjRxT5gWAZISjMz
        1/wRvk7ABmxlu9I=; b=GdCONXenBqlcyDXwVjHol2Ypb+7IIkXigvuT/Q31c9wa
        X1M3wZIlehmHnySrXW1eoEW15nvT4zzHFLVvEBb4Ju0DQwPQgYy8myr9MLNJdYHK
        trjlrfhwOw6iO/1h7I5B5JFg5cEpJWpKnyXh1dqGfOMdwZ65yOceHJn2DUK1vH57
        4Qnq+ZSyiiuzj+EgB8brqyx8bER0b9K/41g7lmmedJ+9Ixlg0tZAGSZ8jtO1D7z0
        ggGNA2caALUO7D0HHPnZIGFMvOlNHQgbWtgHwATrqm/7sNHBBjfEQq1dUcruFYy8
        eIZ66vdJBPsaan/bY86hvzxuh0Bf3U6DVYFk9UQMpw==
X-ME-Sender: <xms:CCB4Y2oCgSdTktmdOQdC0-BpYTphXD9MfTDLyKAve3Vci_ztWTDPLw>
    <xme:CCB4Y0pfxydkV_M_P-qgE9O2xC8wwGNhb7ENz6LxoPGXg4nH0yiAFAPNPVA5wDz-U
    _gB8C2PF_qRdi6AuFU>
X-ME-Received: <xmr:CCB4Y7NmGAtR9DZSMYEwCyddFcmuNdcPkC6njtQ3AaLgoSQcCcJZjPa_42_f-lfXXSyveI8q7OKfLUvXTm4gnulvKFSIYwfQ_BZNyS8O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedugddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesthdtre
    dttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghvkhgv
    rhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepveelgffghfehudeitdehjeevhedthf
    etvdfhledutedvgeeikeeggefgudeguedtnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:CCB4Y174j9F71bSXxPYehUB6TAVZMyE7rV1fjYDrf5aTiA2pq2kGgA>
    <xmx:CCB4Y174XEqD6meOzzi5Jggh63WH-aU33fw8Pq-YwguAPiXhW0aoQw>
    <xmx:CCB4Y1jQSCxLzQH8K52eUZAh_Dpaqe-X4RljFEyjFPuoroqah64gnA>
    <xmx:CCB4YyvWO41ta4Y5H-QDpO8bxZrZqwbgzXK3evLYsUP22VILjExbwNzaELM>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 19:15:03 -0500 (EST)
References: <20221024190603.3987969-1-shr@devkernel.io>
 <20221024190603.3987969-8-shr@devkernel.io>
 <20221116132913.7105e98f7c7111f87ad37797@linux-foundation.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 07/14] mm: add bdi_set_max_bytes() function.
Date:   Fri, 18 Nov 2022 16:14:33 -0800
In-reply-to: <20221116132913.7105e98f7c7111f87ad37797@linux-foundation.org>
Message-ID: <qvqwk03r94vt.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 24 Oct 2022 12:05:56 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>
>> This introduces the bdi_set_max_bytes() function. The max_bytes function
>> does not store the max_bytes value. Instead it converts the max_bytes
>> value into the corresponding ratio value.
>>
>> ...
>>
>> +EXPORT_SYMBOL_GPL(bdi_set_max_bytes);
>
> Is this needed?

I removed the export in the next version.
