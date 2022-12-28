Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BB5C3DA7A
	for <linux-block@archiver.kernel.org>; Wed, 28 Dec 2022 17:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiL1RBX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Dec 2022 12:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiL1RAo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Dec 2022 12:00:44 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E743AA450
        for <linux-block@vger.kernel.org>; Wed, 28 Dec 2022 08:55:51 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C860332002FB;
        Wed, 28 Dec 2022 11:55:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 28 Dec 2022 11:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astier.eu; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672246550; x=1672332950; bh=Zb
        r/mnJU0JN2wDPd5xpvoUy8PqNs3xUN5jz6PCtn5w4=; b=UEz3oM56NKJ54P18gT
        c+Uua048+Evb2RNQtyrvB850/hlq3LoguW/PfYxbAw1Tna9ES/C15aKZ0vkMhroD
        3yk1+f43FdsH0ZB0CO5XNYIlS/Z+fDbSaVaJ3KR4JfsTsbPkkg0Tg+sItyLxSerN
        wGmAS/YxbIPBE4cs49eBW3cyKCS9r5IVk8E07zXn8qflv4QjmH/JVC2KOEKLkDOq
        CWkZdpUYOzkcgoucNlTEQcXnb1ojgTUN+9f00OaMOGTjWJ4HyxoTFNKqFNDyDD+a
        jma/wBCI7l5bkG4RURU5FhNDPs5GLgS1lVyfWIViQCYce+03PExurV7GsbDqkkCS
        ag3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672246550; x=1672332950; bh=Zbr/mnJU0JN2w
        DPd5xpvoUy8PqNs3xUN5jz6PCtn5w4=; b=v/+LpTveU46M5CMFsESN1BT3yxwdI
        DcSxNUozDKVQGG1ZPur7oLijVB7qAu1prbwB+BOLeJpfBMAlnJs9RRKVsr75bfYT
        57Bkgok07W0IGPVVs6XqZYpv3SXS03rMAbkA6l7/4luSr3iB/uVHkQSSgNMei1qw
        wql8NyRaGS97aOQxmesj1nlldgx3jADtfYqSJWk0NJ1e+F+v/6TBvv/Bv4Qpw/qH
        rVUZWCVfSzX7gClKbOtSY2GKjhEaZGnS123i/BUK3KIWw8qdQpy3BIhAOEG5ZR2q
        F6RuKwiGjywdKMENZ2I6HEbTuXPFZarrKTfb3jByv2nww5Dg/yi7fWX+w==
X-ME-Sender: <xms:FXWsYydeE2Pjbod-8kRP475xhNYsqUmmcEI6Hd3iQX2QQGd738sKJg>
    <xme:FXWsY8M8wHv_sNEZNy_P6Hc87Rey3Dg9ph2zDPMivyT6gAwCoMvMSVpXLCwAP3zFt
    lexdD8SH0geFG1WGdM>
X-ME-Received: <xmr:FXWsYzhplXwb143kVH61pUot0Ee_1PY6QPYNiVx7QvnJ4U0n4eW-_IbnOv6UFSqurEwJn9WhNGtpRzJZysF0__iTShizy6h_uOch1eouYTBfzVkpW1D_xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnihhsshgvucetshhtihgvrhcuoegrnhhishhsvgesrghs
    thhivghrrdgvuheqnecuggftrfgrthhtvghrnhepudduudehffeigfefkefghefhudejff
    fgfeffgfdtvdejheevfeevuefhhefhteefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprghnihhsshgvsegrshhtihgvrhdrvghu
X-ME-Proxy: <xmx:FXWsY_-IqRyLYOsoi--5y9sqFZoQBbJE_u6Bt4DiVVzEJPZNkJROkw>
    <xmx:FXWsY-synC4Gu4aXD47I8qbU89uYpowFJNH_VmMCMI7b1K349RIQ-Q>
    <xmx:FXWsY2Fsy2kx0MPVAJ1XyvVy90hYk2GvTHFAIVZbLUafZwH52gK5HQ>
    <xmx:FnWsY799DofwM3ETPemTzfTF9R4LcfHGSigI-nJ9f9NY44AQAxG1uA>
Feedback-ID: iccec46d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 11:55:48 -0500 (EST)
From:   Anisse Astier <anisse@astier.eu>
To:     mcgrof@kernel.org
Cc:     axboe@kernel.dk, hare@suse.de, hch@lst.de, jeffm@suse.com,
        kzak@redhat.com, linux-block@vger.kernel.org, ming.lei@redhat.com,
        snitzer@redhat.com
Subject: Re: [PATCH] block: default BLOCK_LEGACY_AUTOLOAD to y
Date:   Wed, 28 Dec 2022 17:55:47 +0100
Message-Id: <20221228165547.27502-1-anisse@astier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YhlI4bKqYpknNgBa@bombadil.infradead.org>
References: <YhlI4bKqYpknNgBa@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Fri, 25 Feb 2022 13:23:45 -0800, Luis Chamberlain wrote:
> On Fri, Feb 25, 2022 at 07:14:40PM +0100, Christoph Hellwig wrote:
> > As Luis reported, losetup currently doesn't properly create the loop
> > device without this if the device node already exists because old
> > scripts created it manually.  So default to y for now and remove the
> > aggressive removal schedule.
> > 
> > Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I'm saddened by the fact that we're not going to get an idea of how far
> and wide the stupid mknod prior to modprobe use is by making this
> as y default even though I know this is the right thing to do.
> 
> I think our ownly measure of success here is to really push
> Linux distributions to start disabling BLOCK_LEGACY_AUTOLOAD
> and getting their help to see what burts into flames.

I just spent some time bisecting another thing that regresses without
BLOCK_LEGACY_AUTOLOAD (which was disabled here): mdadm software raid
auto-assemble on boot (with udev).

I think it's because it tries to open /dev/md127 and then fails since it's not
created automatically.

Regards,

Anisse
