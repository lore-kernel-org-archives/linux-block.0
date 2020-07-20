Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220DCC433DF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0142822CBE
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SXWKDgUs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSVnURPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgGTNIR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:08:17 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60745 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgGTNIR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 09:08:17 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E57C35C01D3;
        Mon, 20 Jul 2020 09:08:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 20 Jul 2020 09:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=K
        AezyWTLnsM7OvCpH7YLgooUG/8mor/6hEMjL8WXsKI=; b=SXWKDgUsM1w4+uIH9
        a7oZngZtyb96Em+HjrLo1gEjjZssa0blzZAHNw3NyC5fbE1O9pov056Olsa9h1Gl
        ZhN7PRND5s1bDnacsXBkEll5Gp9E3yV8ACBSBqIfdu1s2612bw0ABwn/eOU1dTV0
        Qdb751JaquCSTPWAIoPSBRh/aPogKT3I228a0xBb4q4sxVL0O8BCDj9BHGi3BJVb
        RUSqs7bEdF5HXgQSb1Vh4OIKaMEsWgq4SdjKQ5EfbsCQdgLZlmL94FyYsoY6SNcY
        bdLqbjvgYvMUTeodzosOhk1gki/Rs/oH+lva9pYSuulbOedtGiwmzhTzVpqNtwGg
        FujfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=KAezyWTLnsM7OvCpH7YLgooUG/8mor/6hEMjL8WXs
        KI=; b=GSVnURPWs+6lHVuLJsnUTu9OC6gepmOozO1/GTc4rCzP+CFoEppxaZKgJ
        PIu5kRjoa+sTBDRh4BG1wfMiUcsl8qxjE10n4ue4gkjOtjmtEshROYA7cWzUCrFJ
        vN/FNKjZJqmL/buMkr4dJ2d/tn2h1/Vy9DdlAoUFWNkdASQjai8A1grAEA3z7rHn
        2fbZOBmw8jEWKM6GG7vthjBNxBkmB0+G36Vjay28lC9R8Zq35cFDpa0aaHio3eqb
        iW0u5bpRQOpYIdr8RqnqsMYX+C6VKCSBhovezeS3ZklxEmtfa/GyAENvAlbACeyS
        LfQnBO+cmj3lmJWqHl/YhQwhZAbBA==
X-ME-Sender: <xms:P5cVX1QHQtGH_lj4r7D6tfhxwINZVYK_4b_h97uSQAJAiwbWFFYXaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrgeeggdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeejgedvhe
    duiefhjeelhefhgfeuleejueejvdefudekudfhgeehveejffefhefgieenucffohhmrghi
    nhepshhpihhnihgtshdrnhgvthenucfkphepkeefrdekiedrkeelrddutdejnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhho
    rghhrdgtohhm
X-ME-Proxy: <xmx:P5cVX-yyGE1hLoxdusxOojFObIef_UYH4oulx5wQIvuWbrRJSqyesw>
    <xmx:P5cVX62ONJXnzu33Uo3o-YsYssK--kR6BcHS4PwbV2kY9YhUexPCGw>
    <xmx:P5cVX9CZ75E3bgeLFMskNx7BI7rG9yvtsIWu2mgudx7HGI5jThMErg>
    <xmx:P5cVXwbi7Lr2p8X-zxwOPwKaixyw2_jlk9N7y1wi-h8aJv5jzX0AsQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id C8F793280064;
        Mon, 20 Jul 2020 09:08:14 -0400 (EDT)
Date:   Mon, 20 Jul 2020 15:08:22 +0200
From:   Greg KH <greg@kroah.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tony Battersby <tonyb@cybernetics.com>,
        stable <stable@vger.kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Chris Mason <clm@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix splitting segments on boundary masks
Message-ID: <20200720130822.GC494210@kroah.com>
References: <94114379-78f6-6465-49de-99aa5b3f4d0d@cybernetics.com>
 <75d5014a-d991-24f8-494c-fdca95205adb@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75d5014a-d991-24f8-494c-fdca95205adb@roeck-us.net>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 09, 2020 at 08:26:01AM -0700, Guenter Roeck wrote:
> On 7/9/20 7:35 AM, Tony Battersby wrote:
> > Although I was not originally involved in the development of these
> > patches, I recently came across them while looking over the source:
> > 
> > upstream commit 429120f3df2d ("block: fix splitting segments on boundary masks")
> >     Cc: stable@vger.kernel.org # v5.1+
> >     Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
> > 
> > upstream commit 4a2f704eb2d8 ("block: fix get_max_segment_size() overflow on 32bit arch")
> >     Fixes: 429120f3df2d ("block: fix splitting segments on boundary masks")
> > 
> > https://www.spinics.net/lists/linux-block/msg48605.html
> > https://www.spinics.net/lists/linux-block/msg48959.html
> > 
> > 
> > The first patch mentions fixing problems with filesystem corruption, so
> > it seems important, but it has never been included in any -stable
> > kernel.  Is there a specific reason these patches have been excluded
> > from -stable, or is it just a mistake?
> > 
> See here:
> 
> https://www.spinics.net/lists/stable/msg355009.html
> 
> Looks like it was queued but dropped because of the problem that
> was later fixed with the patch below. Maybe it is time to revisit
> and apply both patches now.

Ok, let me queue both up for 5.4.y now and see what happens :)

thanks,

greg k-h
