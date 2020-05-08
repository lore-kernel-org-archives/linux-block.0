Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746F0C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 19:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5127B218AC
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 19:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbekk.com header.i=@orbekk.com header.b="EL43W3mY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jq/X6T0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgEHTW5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 15:22:57 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:36693 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbgEHTW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 15:22:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 46EC74C6;
        Fri,  8 May 2020 15:22:56 -0400 (EDT)
Received: from imap1 ([10.202.2.51])
  by compute4.internal (MEProxy); Fri, 08 May 2020 15:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orbekk.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=pxEyzXWoFGZXI6Arfcxv5uOUuPIVne5
        6u5opE0FLF4k=; b=EL43W3mYTh/FBLvlnJbO8vBhPBKxVP23vJZkEsO31HEQ27q
        oIl+J9wtFWSpxGeV5OWyGA9hhRYuQFYvxmxOQk4E/g8ToBvjM7DB3w4AA+hKhDFM
        NynxZGB4EuS3MDlEBteJzKCjZpY2EewP3vonZjQ1q8A+9kt9u5pOygHf5uR6DZjh
        I66F+O6PGCw+XX3LzXIxR5lPYfarcgxQBTGhki2cOEDiCJ4jgamNYzOVsUIEzkcn
        dlBI4klJWOJn6YHuo3vtuvFTFpycpLbMJ0b4zdFRv0tuKpliHrjK5JP+mh8ajrX+
        szYzdzqM/wekJKKLSahblLsjM2zAWayx2oQW4gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=pxEyzX
        WoFGZXI6Arfcxv5uOUuPIVne56u5opE0FLF4k=; b=jq/X6T0YCzVs2Y+3ZcnYtW
        3CZTxd9K0VJYJzx51HWCAf4ZHf5ulHVPs6EmCjd8nblPy1hVPdX3muDIQJ+nFM/U
        9xKDYzhasTWWfi0Xmmq4nxWNrl1WiweJlOKg/lXBSxjvlrI4Qr7JMIQRaBou9XRs
        22bqkqo4ZEzSyjteELnadPmUI7lm1UtkspholjS7WLetTDILeEPvwaZajtJDds9B
        LRlntFg+0jFect5v6J26fqCzYqyAPunKW6xj1vlotBUIKKCGUXYmH3VlXvNOPoHU
        N5oNcbfgAW/8ZBvBzP5fBAWlbYIQrD5jbepCAp1olNntKz/A3BYsKif9gWCB30Hw
        ==
X-ME-Sender: <xms:j7G1XikzBgVczNg3jVBNBPXtHYhfwUq22JYabuBbvn8Pf_VC6xDHQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrkeefgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpehkjhesohhr
    sggvkhhkrdgtohhmnecuggftrfgrthhtvghrnhepteehuefhudevvdeflefgfeevuefhje
    fgjeekffefjeelvdetieevffelvdelkeeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepkhhjsehorhgsvghkkhdrtghomh
X-ME-Proxy: <xmx:j7G1XtLiP8ICnbAgYdpollYqTfScgh2ftg2WP9BWxtOsVFavJztjWQ>
    <xmx:j7G1XsctJkdSSDt3QzKngkXF892-cWvHZMQAGbBWfQ6Ql9Q2ocru7w>
    <xmx:j7G1XpzxDWy9N-hjBX8uBVEh9vwW4JQhfUocrWU8jLbUAVlhF2hq_A>
    <xmx:j7G1XrU7nBYjcuglBF_n0NVSMSiLPhQcj7jlmmoJmal20w_JDhLj_g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2910FC200A4; Fri,  8 May 2020 15:22:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-413-g750b809-fmstable-20200507v1
Mime-Version: 1.0
Message-Id: <dd7b8b91-776b-4458-a83a-18ab4953d2f4@www.fastmail.com>
In-Reply-To: <DM6PR04MB49726E28257263F5A1C643B386A20@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20200507230532.5733-1-kj@orbekk.com>
 <DM6PR04MB49726E28257263F5A1C643B386A20@DM6PR04MB4972.namprd04.prod.outlook.com>
Date:   Fri, 08 May 2020 15:22:33 -0400
From:   kj@orbekk.com
To:     "Chaitanya Kulkarni" <Chaitanya.Kulkarni@wdc.com>,
        "Alasdair G Kergon" <agk@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "harshads@google.com" <harshads@google.com>,
        "Khazhismel Kumykov" <khazhy@google.com>
Subject: Re: [PATCH] dm: track io errors per mapped device
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 7, 2020, at 21:12, Chaitanya Kulkarni wrote:
> On 05/07/2020 04:06 PM, Kjetil Orbekk wrote:
> > +		if (tio->error)
> > +			atomic_inc(&md->ioerr_cnt);
> 
> Given that there are so many errors how would user know what
> kind of error is generated and how many times?

The intended use case is to provide an easy way to check if errors have occurred at all, and then the user needs to investigate using other means. I replied with more detail to Alasdair's email.

-- 
KJ
