Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D608CC28CBC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACBB21775
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 16:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbekk.com header.i=@orbekk.com header.b="ijD348UM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J+yVHs6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgEIQBe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 May 2020 12:01:34 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46269 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727092AbgEIQBe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 May 2020 12:01:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6717B5C00ED;
        Sat,  9 May 2020 12:01:32 -0400 (EDT)
Received: from imap1 ([10.202.2.51])
  by compute4.internal (MEProxy); Sat, 09 May 2020 12:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orbekk.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=SKNN2JmzVgNS9cbFPRsY/p0I0fqDJ/u
        zFHPyDwEAkTQ=; b=ijD348UMCObbpbU6cD5PVpJanzvihGYqJREbB8UCTjVAdyi
        ZUHDZPk/QJuNA1O11GwdFhCGw+c47mYyKnDgmPKtwXLpJcC75KMRGK2FKS7WUqh7
        oY9nBCZomsdH7OS8+KrjN/rYivb0IgEuP2BDR0pJ7t8fBS/9meRz/3CmSIZxpn6i
        sxKaxosAzKr2ivSSfzF+y85CYnADXHxQ3ZNHAewGkkkKxJYCfnHZcq52QdTVZxRs
        Yu1wIsqQWJUrmeB2fL1/1L3jpPhwvm2zKSTaefyQ10sUN9GHrcsOpI55Riqaf+vE
        8aQv1gO49LBFcEBExbxrHAPKDppYKRqQ/L5NUYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SKNN2J
        mzVgNS9cbFPRsY/p0I0fqDJ/uzFHPyDwEAkTQ=; b=J+yVHs6sGSwWZ8D1PcLIkb
        66rm1vt0ffc3EaHnHx47FqAtc+YghZlOhvgFZkWX+d5dEM0lju31SPyUsgaZRXr3
        EhRlFHA1akAg2SsEEHpWppP++s3gBVtryxJW5D9VPshrnTBMHp4WZLE40VWzlqsB
        hyo3SvibsvNNuH3OSt9MmfxeLG8tcaJZwiMD3//JKUPc+ZNWmXXRdKIMRu3KikHk
        JIP+h1r26Ekg2/TlUZjd1zSNIIwZOclOSoTds4J4KzT/e6sFxPauqNk/ii3F+K6W
        Bsjz3ct1wj1d0iWehf+aYgAdPBUeJ0LCywsEPiP0a/Z4Nrvm6uvF61LUZYKXdFbA
        ==
X-ME-Sender: <xms:29O2XocUXLF5hFPCQQYzhuVm0jVK7QnFzdHJzMNkXUo-W7Y6jD1svQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrkeehgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpehkjhesohhr
    sggvkhhkrdgtohhmnecuggftrfgrthhtvghrnhepteehuefhudevvdeflefgfeevuefhje
    fgjeekffefjeelvdetieevffelvdelkeeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepkhhjsehorhgsvghkkhdrtghomh
X-ME-Proxy: <xmx:29O2Xuf8Pt7JkSYiuu4NccR0TxExtTCUsDiJz0er_aKOIsCdX_kRMw>
    <xmx:29O2XkglqHASt0OzAYSMJuv22PtQB2mWCRS3f-ggrBkhfzNFhUDT5g>
    <xmx:29O2XiSZdebnkCAmOLpndBxBguYVX3GkS4F-jD4DW7C8wLbc9SIQYw>
    <xmx:3NO2XkVMTD1WOasQWeDAT7XM06Je1KvCw5snmCK50aCfd-kgvwfCJg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8C796C200A4; Sat,  9 May 2020 12:01:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-413-g750b809-fmstable-20200507v1
Mime-Version: 1.0
Message-Id: <bc077a4c-26ce-4fd1-b55c-48bded3c834b@www.fastmail.com>
In-Reply-To: <20200508210926.GB19773@redhat.com>
References: <20200507230532.5733-1-kj@orbekk.com>
 <DM6PR04MB49726E28257263F5A1C643B386A20@DM6PR04MB4972.namprd04.prod.outlook.com>
 <dd7b8b91-776b-4458-a83a-18ab4953d2f4@www.fastmail.com>
 <20200508210926.GB19773@redhat.com>
Date:   Sat, 09 May 2020 12:01:10 -0400
From:   kj@orbekk.com
To:     "Mike Snitzer" <snitzer@redhat.com>
Cc:     "Chaitanya Kulkarni" <Chaitanya.Kulkarni@wdc.com>,
        "Alasdair G Kergon" <agk@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "harshads@google.com" <harshads@google.com>,
        "Khazhismel Kumykov" <khazhy@google.com>
Subject: Re: dm: track io errors per mapped device
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 8, 2020, at 17:09, Mike Snitzer wrote:
> On Fri, May 08 2020 at  3:22pm -0400,
> kj@orbekk.com <kj@orbekk.com> wrote:
> 
> > On Thu, May 7, 2020, at 21:12, Chaitanya Kulkarni wrote:
> > > On 05/07/2020 04:06 PM, Kjetil Orbekk wrote:
> > > > +		if (tio->error)
> > > > +			atomic_inc(&md->ioerr_cnt);
> > > 
> > > Given that there are so many errors how would user know what
> > > kind of error is generated and how many times?
> > 
> > The intended use case is to provide an easy way to check if errors
> > have occurred at all, and then the user needs to investigate using
> > other means. I replied with more detail to Alasdair's email.
> 
> But most operations initiated by the user that fail will be felt by the
> upper layer that the user is interfacing with.
> 
> Only exception that springs to mind is dm-writecache's writeback that
> occurs after writes have already been acknowledged back to the upper
> layers -- in that case dm-writecache provides an error flag that is
> exposed via writecache_status.
> 
> Anyway, just not seeing why you need a upper-layer use-case agnostic
> flag to know an error occurred in DM.  That layers that interface with
> the DM device will have been notified of all errors.

It's used as a signal by a probing process which is not in the IO path itself.

> And why just for DM devices?  Why not all block devices (in which case
> DM would get this feature "for free")?

This sounds like a good idea to me. Looks like I could add this to disk_stats and expose it through the block/<device>/stats file. I'll try to see if this is feasible.
