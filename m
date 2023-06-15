Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477DAEB64DB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 00:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbjFOANH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 20:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFOANH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 20:13:07 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1701A2126;
        Wed, 14 Jun 2023 17:13:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 668FD3200893;
        Wed, 14 Jun 2023 20:13:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 14 Jun 2023 20:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686787983; x=1686874383; bh=Ba7r9fkiZ3rsJ
        eRyUixJVO27W6F8qX6vDYD5OJL3wBA=; b=ApIffwnrlKeKX9dEdb0PL6cDMZZ2g
        eAuzw2FtaB59gyhA/7+XPykgUM2TgTBQdCXavAl2aabfH/S90p+ziw/n+KZhgDLd
        7IWMT1L7peXigFiaKEZMSk2DvJgvjLCHcHxn8HaNF1/vqvZGNUN9IFkWn5l+RBiE
        3Fvx5+ptuVOrSt9BbbDEOcGig6LiUxdq5jTmG719JuCmrL2ss+Hsu7EDoVuQ3pvF
        Tps8kuKYpPx/sDvE+H6PXVyovBVKNk7SH0D5+KHiwMpBLLq/Jzoc4kRyvnELGaMG
        kzu2jxthfmLRtGt6W2/ncyousSaMqORcOPt3enYeoTj43jmgr6ZT/3F4g==
X-ME-Sender: <xms:jleKZHPbHogZiF6Fzn58wE8H8JpqHs8znzK6gyhJoP9J_yO_6NueVg>
    <xme:jleKZB_eRv4KLtQ4MbcBTMHH8fnVpjhvWFPRmwZDczFYgxmNlKv487eyYAREIurNE
    TZTuAfd6129nLmd2FU>
X-ME-Received: <xmr:jleKZGTFsI23zhWj5ucmSKaeY2usKJJjxe1BnedfKjAYg4MNr6j3HcqXKuLw3BCBQF_NxfYIzEwZ6AlnlXCNww9xtn9_o6_eEoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvuddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:jleKZLtPrxrC-bxy4D9MjSN1pktBD85Zln3Pofr0tCYpPamED3P-VA>
    <xmx:jleKZPe47sQhaeZCTW5x0fz7NL9-rRfDDXtfLLuzsmh3slVOWS6Wmg>
    <xmx:jleKZH1HbYrjKXQMWSM4JYKz9vIbmWcLXiwisaWxO7OUt6BpgI5ShQ>
    <xmx:j1eKZAGk1d4xuEDNDxPEyFTcdRmij-ZqzUBDMKo9uV3epBYqTb2LdQ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jun 2023 20:12:59 -0400 (EDT)
Date:   Thu, 15 Jun 2023 10:13:14 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>,
        Joanne Dow <jdow@earthlink.net>
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
In-Reply-To: <98267647-af04-d463-cb5d-c5d6b0a05777@gmail.com>
Message-ID: <82d25ec7-47cb-cb40-c800-892af48a71f6@linux-m68k.org>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com> <3748744.kQq0lBPeGt@lichtvoll.de> <86671bf8-98db-7d82-f7cb-a80d6f6c064c@gmail.com> <4507409.LvFx2qVVIh@lichtvoll.de> <98267647-af04-d463-cb5d-c5d6b0a05777@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 14 Jun 2023, Michael Schmitz wrote:

> 
> The reason why only rdb_SummedLongs, rdb_BlockBytes and 
> rdb_PartitionList are explicitly declared big endian is probably quite 
> simple - nothing else was used by the Linux RDB parser. My patch adds 
> rdb_CylBlocks to that list, so that ought to be changed to big endian, 
> too.
> 
> affs_hardblocks.h is a UAPI header - what are the rules and 
> ramifications around changes to those? Might not be worth the hassle in 
> the end.
> 

I think it's safe to fix the UAPI header if we are talking about 
endianness annotations that affect static checking and not code 
generation. The existing annotations in that struct would appear to 
support that notion, if indeed they were put there for the benefit of the 
kernel.
