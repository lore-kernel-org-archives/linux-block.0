Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A1C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 19:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074B220CC7
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 19:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbekk.com header.i=@orbekk.com header.b="AfApRadP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="na0Ugk2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEHTSu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 15:18:50 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:58271 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbgEHTSu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 15:18:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 41ED44B3;
        Fri,  8 May 2020 15:18:48 -0400 (EDT)
Received: from imap1 ([10.202.2.51])
  by compute4.internal (MEProxy); Fri, 08 May 2020 15:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orbekk.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=W1w5N5qt6itjiZh7+7O1Ye/XCIcRKbg
        QE5+06VuAXvI=; b=AfApRadPWeWQp1NrEdtIkrqEEsjiKilMF0bEfj0U3nfN7eo
        pRTuhdOjiLisIR11EpeLkm2585TpeUY0FGz3SF6wNPVAFMKy8647oIN+Yjo1juMv
        8nsMY3Dy7VlirL1tu8qYG4vRe3v/qSqWaUSoQroAsqqg9Miirucumrc4K8kEY21T
        RXQ7PM4gbFRKm5gMwdnEC/5gvwhpuln0mlsS8gPDNi+SZmce/t0m14yylSNN/XA/
        FnBbcTMkx2sxTVaW/2reu9h4l/ApetD6sseBpEJfzGj3Xo21yDH87GIOfB8Ibjma
        oCxB0e51BAIAOjp3kxkLfSDZ/FtCbCAzOs2ALvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=W1w5N5
        qt6itjiZh7+7O1Ye/XCIcRKbgQE5+06VuAXvI=; b=na0Ugk2KaQKO54Pe8wMAuC
        wN1aJ4bTjk36TQmYzSmmhnYILaFUWZKowaFRWS5SyU/Z2IsKPiOlw4JHcaZ+zPiq
        GM08g+36Yc3FHTvIq1Pl0uQHMC8v1kolagbGC1R1U58SetdapCep5NPkjTFGOduM
        +aTX5NYVEqP+o9Vpr6V3F54gfEQgSA4IptIM6x6gK/OD/hVhmhCVplEFMziHTEVu
        ivPBR10WL+YRvh6aFuYJ5AAzQRIIS71t+7sqJf1/VwJHvtkoUTAUFJKUu+q8O4te
        13/QwmFoEsPdu9BnzK0AHR3hqHwX2MjB6svmN3oNNFpurG2Xv8KTmwV3afR5c+ng
        ==
X-ME-Sender: <xms:l7C1XvviKSMz8Kh3mfFwt_JARy6JHCHtFZvS1DCr2U3ZG-LPk7dUNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrkeefgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpehkjhesohhr
    sggvkhhkrdgtohhmnecuggftrfgrthhtvghrnhepteehuefhudevvdeflefgfeevuefhje
    fgjeekffefjeelvdetieevffelvdelkeeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepkhhjsehorhgsvghkkhdrtghomh
X-ME-Proxy: <xmx:l7C1Xl3Sr3ZZMlR6qG2CstoFNLJUTV3ERV1uJq249sUZviaurhYo_Q>
    <xmx:l7C1Xmaa7YzwV7xAUJvldDAX0ne2fUzIeFeVbWSG595uIdo3pF6ZzA>
    <xmx:l7C1XuHayoxee8hFKLTnT-SE3iIXv8mP8fvZYiSqlZucpgT4J53ALg>
    <xmx:l7C1Xl-xlg9wLOKYa_efJzeGOj5iYXSJagEIcrSui4ertD4Go4kcpA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 660CCC200A4; Fri,  8 May 2020 15:18:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-413-g750b809-fmstable-20200507v1
Mime-Version: 1.0
Message-Id: <48580ec0-fc4e-4faa-976f-0fb192cd08fa@www.fastmail.com>
In-Reply-To: <20200508001825.GC22266@agk-dp.fab.redhat.com>
References: <20200507230532.5733-1-kj@orbekk.com>
 <20200508001825.GC22266@agk-dp.fab.redhat.com>
Date:   Fri, 08 May 2020 15:18:26 -0400
From:   kj@orbekk.com
To:     "Alasdair G Kergon" <agk@redhat.com>
Cc:     "Mike Snitzer" <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, harshads@google.com,
        "Khazhismel Kumykov" <khazhy@google.com>, orbekk@google.com
Subject: Re: [PATCH] dm: track io errors per mapped device
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Alasdair,

Thank you for your time and comments.

On Thu, May 7, 2020, at 20:18, Alasdair G Kergon wrote:
> On Thu, May 07, 2020 at 07:05:33PM -0400, Kjetil Orbekk wrote:
> > This will track ioerr_cnt on all dm targets and expose it as
> > <device>/dm/ioerr_cnt.
> 
> How do you propose to use this?
> What are you trying to measure and why?
> - How exact must the number be to meet your requirements?

This is proposed in order to detect if I/O errors have occurred on the dm device. Deriving this from the ioerr_cnt from the underlying device was considered, but it's not reliable for dm devices that tolerate some underlying errors (raid setups and similar).

> Or to put it another way, do you need to know the exact number you are
> exposing, or do you derive something else from this which could also be
> derived from an alternative number?

Our use case is to detect if I/O errors have happened at all. We expect the ioerr_cnt to increase when there are errors, but the precise number is not important in our environment.

> In particular, given the way we split and clone and stack devices (so
> there may be an element of multiplication), and reload tables (so
> existing values might become irrelevant), did you consider alternative
> semantics before selecting this approach?
>
> (Or to put it another way, is there a need to reset it or track
> the value since the last resume?)

I'm not very familiar with dm and I don't follow how the cloning and stacking will lead to multiplication. Do you have any suggestions for how I might deal with that?

Resetting the value would not be desirable for our use case, because the probing process can miss I/O errors that happen right before a device is suspended and then resumed, though I can imagine that there might be cases where one would want that. Users could look at increases in ioerr_cnt instead of the absolute numbers, or I could provide a way to reset the counter if desired.

> (Documentation is also needed - which ought to explain the semantics
> and how the observed values interact with the use of device-mapper
> features.)

I will be happy to provide an updated patch with inline documentation once I have addressed your comments. Are there any other places where I need to update documentation?

-- 
Stay safe!
KJ
