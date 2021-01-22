Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E48BC433DB
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 16:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B4F233FA
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 16:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbhAVQ7W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:59:22 -0500
Received: from mout.gmx.net ([212.227.15.19]:34455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbhAVQ5v (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 11:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611334479;
        bh=i8AlmvmcFI/Qxol88A5rstmImds1ILCafn76AKz1rmk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=h2NX5wW3K/vdNwauhlEA6ZWDtfyjRfJgP1wkwEhsa3wzOcKsUD+dO88jQeoIA3qOK
         MyJhPMhzlis1oUp6ulvFdMpxQ7UPCmqDG07mFbMfSsuB0VCSt7nc2DlLhUB21kse6/
         0MkUuw+dVxbr1a/URl6VY4eKw0P7aF3ylPLYAFt4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Valinor ([82.203.161.65]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQMuR-1lOnok1IXJ-00MIyE; Fri, 22
 Jan 2021 17:54:39 +0100
Date:   Fri, 22 Jan 2021 18:56:19 +0200
From:   Lauri Kasanen <cand@gmx.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v9] block: Add n64 cart driver
Message-Id: <20210122185619.980fa4f713b8f57528c3af9e@gmx.com>
In-Reply-To: <20210122163913.GA227449@infradead.org>
References: <20210122110043.f36cd22df1233754753518c1@gmx.com>
        <20210122111727.GA161970@infradead.org>
        <20210122155801.a24c328b7aefdcffb7d68576@gmx.com>
        <20210122161804.GA225607@infradead.org>
        <20210122182349.c98d8599f7593afefa43c9dd@gmx.com>
        <20210122163913.GA227449@infradead.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.18.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bofvDUa1+ADtnwXPN2gUPtk9nO6HaejYTkDzW1g61mubgB3ZES6
 Bx+4qEwjvSy+lzUwU7SkI+i2DKXsOdFD2Kv2ZiCNMny8jqQYkMz/0/a1HtASHvebbfy1T8F
 jV02A6oHiF+fOtj6VgCy68pSY05z1NDHThixga5on9ttAhzfhzq4NFr6qXwD4BNogIWbrDe
 nhC5CLX2y9Y9dwClhRaRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EzYGYzrK1uI=:YNi7qPDAQXc2vBGx0W+PDb
 QGnrUJEQZ8y2q583pk+1spydopA2NWUwjWt5vPIkDg17lYdf9xWBucou0UnuXwEtwDWAuNmng
 UJRCY4PhbpVdcpkvqNA91OcRwZmkkB6XzyI5+OVzytX0Xz7gbVAfvf1js1sl5pPl1+NduLVDg
 Hg2PTwxTh4lYCN72oQShY2ic28Sy0VReI08G/hRCbSvVaNkwK9jGUPGGRwBZEgh+gEA1einsT
 Woiho5pCuZH5EPVv5OhjBAzR7pOPmhd1ey6hSeaHU4VB11MS4MhdKQASPfFrEh3uj/xtYrrdE
 BTPg8Rqu1jRCa0yu5lL/m551ygjclLhvv/vxqbs/4EF0sXg+aw1+lCwmSV5o9HW8Py51Icpx8
 uz2iV2kuxsh9iJMfYqelPE8PfE1KaOclM4l5D0navoajHmSHpdLoDW5L+8aNgdyZWc71S/epY
 FeC7bxfGadwbMkiFW0ivAdNYthRctpImozHY6zilM9gZ+jxdoa/j+f3WupDX5c7LiviU8bT2c
 tGa3nFYBj57i31wju81cPlXlavlx+cCSj0JFZvSFVDvC7n8LNnibyqQOS1RXhkK5Y64Drusd0
 RS/ZzuNOAcIK+BiekchXp5pbzaOE6s3chIH8N0ifCU99OtrzPpZBC3KQ9MculKQ4ihKBqrgbQ
 cpUU+UivrEGMHjxga9K79+rFWKp5+wXbQ8XRs8VO/ahneHmfLrsGfbfLLLtTem2ce55d4Wv+N
 s48uJqkNDNu7Cu5h2FTvVGe4nbnSPu6+tPfBC0MOPywClOlGcDXCGE5GFD3aBxCLYtb4oIOAZ
 p8aL3xURFaguF6mSUwxWoPoug9+kWWQMTB5+/eogO4my6+RWNW2T0yO9+7/3AForb2x3Np0A/
 IiDSqQd+SyGvhyzRSS5w==
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 22 Jan 2021 16:39:13 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Jan 22, 2021 at 06:23:49PM +0200, Lauri Kasanen wrote:
> > > Your driver can communicate the required alignment using the
> > > blk_queue_update_dma_alignment API.
> >
> > Is it guaranteed to be physically contiguous?
>
> The alignment requirement applies to each bio_vec.
>
> What alignment does the hardware require?

It requires 8-byte alignment, but the buffer must also be physically
contiguous.

I grepped around, but apparently no driver under drivers/block does
direct DMA to the bio buffer. They all use their own buffer and memcpy,
like this patch. ps3vram, ps3disk, amiflop, etc etc.

If all existing drivers use their own buffer, why is a different
approach required for new drivers?

- Lauri
