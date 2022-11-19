Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F2DC4332F
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 01:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiKSBKA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiKSBJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:09:46 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611B3FAD3
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 16:07:25 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5D8E92B07348;
        Fri, 18 Nov 2022 19:07:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 18 Nov 2022 19:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1668816443; x=1668820043; bh=4cZ1Nb/ivj
        aUoH2+jYpa5xwRJeNDndgyHTfoDsz2wUM=; b=MxLiGOSTpQFyp7lZLrLW+szUU9
        VXlR5W5ti+KsPkzP1Bsg4AqJ8VMBZJFw8NNSLWkRY5Mj+k97ZrjdJuBJDkPrSlvV
        Ro4ZeV8zouPEHczixWM61E5lBS7Egd88ZlZ7MehfM5xZRKfRVj0MQwF1In4ZoIcE
        tU5E2ChNE2VzO2Hbba8pNF2aJXhWBq/3ZmAAeRQuxTnUJwEB5+NXg8x4u+tJsEmH
        77QwTYZXg8qh4eM07NsPMUF4yOhrS7nhLnvB0qWOSvOrkHIoL3uzDy32LruWylvP
        9uZZTLqGPhrDGnAcHeFXnJjke8siqvXMlExabcQurvsPU/8RLMktPgebG/IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668816443; x=1668820043; bh=4cZ1Nb/ivjaUoH2+jYpa5xwRJeND
        ndgyHTfoDsz2wUM=; b=NUv4NovnoN9/ddfkMGDt7t/vYd7m1TAl10lTx5r80HBu
        +v6ZqKwLwfF/FJru6V43fyulDDPQBvdfFDneWl4B6x2xkekm/1xmTBOxUOD1G74J
        rN9AXzK/EXCi7wo5S+ted7yn3aXmamymDKVO2gF5Qql1wqn45pklfuiUqtRQ2sOV
        7oqniapmmZHz1WATYM5E1my1rGXw41dAoxVF/yVF/X0a/JGcyR1WByYnVukPqoa2
        g79MefF5U9rSiOdz18ICUWkdwblHbpnxlznl3VZmhVJsp6Tdik33SjBvcwI0ts2g
        bIf1tuzXf4xXBwVEgjq67Z1rIQoN/1+j7Kvgit5uFA==
X-ME-Sender: <xms:Ox54Y7y43ATS2Uk3pWnSdPjOazvRf5tQ6hWpdbV-A4QhZH38NLwTvg>
    <xme:Ox54YzSsOf38uwuEeFxOAZYeR6iXGQt6rQbwqO5EC4oDZ9wViKtFGaNl_MupeR4ns
    MAAOcc_MDHTlvRINI4>
X-ME-Received: <xmr:Ox54Y1VilXHGiXYE10X6hVifcYH-Sk0QdQIuevzWZ41D8ohCCqCm_-nFhR0h49B-9jNhLJm-vkfzWDZ0gRSekK0Xk7eOR7hvPzf0w0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedugddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesthdtre
    dttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghvkhgv
    rhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepveelgffghfehudeitdehjeevhedthf
    etvdfhledutedvgeeikeeggefgudeguedtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:Ox54Y1ioMjSMYBLY7Jb21lAB11VNsJ-rbmNXSZjDj-paJJa1blJ0WQ>
    <xmx:Ox54Y9CBNHrp0cXAa150tKrGj9WDFxVRfPUz5fh9ZtM7ma3BCk3xJQ>
    <xmx:Ox54Y-LBosHOo0NVfoZhm6JnhmeTv800GNv_dkyxwOhTgQxvrMgkwg>
    <xmx:Ox54Y_3EGdZBY4_j0voNx9RvZwm-V1H5vrvNpjhgaTCPxGllbt-ZS6IYt1k>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 19:07:22 -0500 (EST)
References: <20221024190603.3987969-1-shr@devkernel.io>
 <20221024190603.3987969-5-shr@devkernel.io>
 <20221116132900.ab7554e7e8342c4d30739bb1@linux-foundation.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 04/14] mm: use part per 1000 for bdi ratios.
Date:   Fri, 18 Nov 2022 16:03:23 -0800
In-reply-to: <20221116132900.ab7554e7e8342c4d30739bb1@linux-foundation.org>
Message-ID: <qvqwsfif958m.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 24 Oct 2022 12:05:53 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>
>> To get finer granularity for ratio calculations use part per 1000
>> instead of percentiles. This is especially important if we want to
>> automatically convert byte values to ratios. Otherwise the values that
>> are actually used can be quite different. This is also important for
>> machines with more main memory (1% of 256GB is already 2.5GB).
>>
>> ...
>>
>
> This changes an existing userspace interface, doesn't it?
> /sys/class/bdi/<bdi>/min_ratio.  Can't do that!
>

It does not change the user interface. It maintains the percent values
in the min_ratio and max_ratio knobs.

For instance:

-BDI_SHOW(min_ratio, bdi->min_ratio)
+BDI_SHOW(min_ratio, bdi->min_ratio / BDI_RATIO_SCALE)

> We could add a new interace to the same thing, I guess.
> /sys/class/bdi/<bdi>/min_ratio_fine or whatever.
>
> We might want to go for more than 100->1000, too.  Otherwise in a few
> years we'll be adding /sys/class/bdi/<bdi>/min_ratio_even_finer.
>

The next version of the patch series will also add min_ratio_fine and
max_ratio_fine. This makes sure that also ratio values can be specified
with a finer granularity.

> Also, this patch forgot to update
> Documentation/ABI/testing/sysfs-class-bdi.

The exisiting user behavior is not changed, only the internal
calculation.
