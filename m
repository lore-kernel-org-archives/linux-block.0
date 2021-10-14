Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A95C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 01:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF500611C7
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 01:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhJNBip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 21:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbhJNBip (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 21:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634175401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ojdf6628VplIf3Ky6Hl21LjxxayitntGvwBqERQmdDg=;
        b=XHLeEFMS5JD/gArvWjViP+sl4Ri7ouWZc7ZzrAaDwoj3B/oTp0baXjGb/D/32bwVTwFZ0Q
        1vFB1aIi6sD/UqTET/n6rdjfuExr67NKGpjLUCvdL5nsE/W6UzRe4pq1l3mKupbBogriJ2
        991uZ5qxqgsv8mMKFCWLTMcaPBaSZH0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-GwCG2IgMOWaBuUjDBwRTrA-1; Wed, 13 Oct 2021 21:36:39 -0400
X-MC-Unique: GwCG2IgMOWaBuUjDBwRTrA-1
Received: by mail-yb1-f199.google.com with SMTP id f8-20020a2585480000b02905937897e3daso5303407ybn.2
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 18:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ojdf6628VplIf3Ky6Hl21LjxxayitntGvwBqERQmdDg=;
        b=UJCvlmInK8oUx/ewvbqRfPHDzHNB2Pkfty7uxEmcFS6CuCeKqyFgAwxv0LXDKEr7EE
         b1TThDILO1AuqPJNX4ECbnwUfvGTTUqtMINi5fymIS1DIgHhjArMqIqtux03seIMAUmM
         l+hBkpCvHT+ghc3/0eGZH3ix1IXF8XhjC0DptsZUgKQfNc93ecxC+xkHxs/yQ8++PAZg
         3CShfK8cffEmFP/Pz04dGAPyLgH0OxIi/4/xS0mD8WSrYmkFAgbzqr2c02GAwtE6ALZT
         XKjIMmNl1j3rjefETprot9AKZU3SyEKKpPxFeluwFdrxDZplyUZvMT9vbHfsiejG2BUH
         FgFw==
X-Gm-Message-State: AOAM53279ruNMWvEFoBtvA+sPjwd8SiZ+3+9dMtCn7FJqVc1Man4cPd9
        aWyhkf85zyVEUAuA1Qn3jg8NqHPwFQxoVKbUbDG8xjB9H1scMdqi4J+n46QuZ13PuDSqwjSFshn
        GQIpb6kA1NkYABVZL7PPqFin2C+8SiQo5D7hp/Mw=
X-Received: by 2002:a25:bd03:: with SMTP id f3mr2924869ybk.412.1634175398983;
        Wed, 13 Oct 2021 18:36:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiY3lIjTxO3clXNFiyfz05/uB3sTV9uNsyPOaKWIxDySFH3jYGmdCMD3aQTwqA03xAlUL/rLe/N3pUYpN2U+M=
X-Received: by 2002:a25:bd03:: with SMTP id f3mr2924862ybk.412.1634175398848;
 Wed, 13 Oct 2021 18:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8poXTLdC+j6u7zypLKR7RpAaG-vxK4dWDz6bCMfPOjsQ@mail.gmail.com>
 <YWaiLsQkwe9aq8pE@infradead.org>
In-Reply-To: <YWaiLsQkwe9aq8pE@infradead.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 14 Oct 2021 09:36:27 +0800
Message-ID: <CAHj4cs-=DbnXS_552yyYxd5dae3wRXzoQftPUpUhSPjNfD-RBQ@mail.gmail.com>
Subject: Re: kernel NULL pointer triggered with blktests block/025 on latest linux-block/for-next
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 5:10 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Oct 13, 2021 at 04:50:13PM +0800, Yi Zhang wrote:
> > Hello
> > The below NULL pointer issue was triggered on the latest
> > linux-block/for-next with blktests, is it one known issue?
>
> Please try this patchset:
>
> https://lore.kernel.org/linux-block/20210929071241.934472-1-hch@lst.de/T/#m6591be7882bf30f3538a8baafbac1712f0763ebb
>

Yeah,  the issue was fixed with the patchset, feel free to add:

Tested-by: Yi Zhang <yi.zhang@redhat.com>


-- 
Best Regards,
  Yi Zhang

