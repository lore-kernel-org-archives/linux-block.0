Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61323C4708D
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 15:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387BD613AB
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 15:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhE1Po1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 11:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235049AbhE1Po0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 11:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622216571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sC/4mqGVwjGmarPwyWnSGWMjis6RsnduR1OTuOfsgPQ=;
        b=aMiAGVAEjSCDtfuPEiNlfB4WzHDJXlnWiW+cA2agfALKPvSJ4LS4dc9YAc1CrBWGVdLmOY
        g4xRAZpV5A4hQc/4Njq6ZY0amSHGqqBCcG35MnFsJd/NJ7kNwUY2BJzDBneX1ggXv6ZkHL
        v65UdhEACJYcFh2udi7kDnQ8NT6eKBo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-nR56lLOhNj-QygUtCJPJiQ-1; Fri, 28 May 2021 11:42:50 -0400
X-MC-Unique: nR56lLOhNj-QygUtCJPJiQ-1
Received: by mail-ej1-f69.google.com with SMTP id mp38-20020a1709071b26b02903df8ccd76fbso1253046ejc.23
        for <linux-block@vger.kernel.org>; Fri, 28 May 2021 08:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sC/4mqGVwjGmarPwyWnSGWMjis6RsnduR1OTuOfsgPQ=;
        b=BRA5kSPq2OALQHJKREc/f2Otv1nWI0j77phoFcoA7tGt4DFndIcL3C9sxu7eoqOXbY
         BjD/3Rhj5fGK3f4XowugRBN5dUJxaW89CFwQqpUukf93i/tcTsyK5YmC31sGruci5BBn
         0xcyJ23QN5iPqcloJIrfWUI9Pr/zjGnD9ePJhJGS+s1u1Dorzuavj5XyA0zcpS5mexpj
         xb3HjjPiLSbJ7mLhBvdjlFRzukLIx6ljL0wcHag8DKdaLFceR34wHBXUbQcomz/Ua9ys
         7Ffoa7uo9b1h/XO7dlppVOfT6xGJD2d699zwyMpHP5V3dlp/dDu383L/Kla9bESNNxwk
         S1dQ==
X-Gm-Message-State: AOAM530v8avRnNeyiTw+EsfwMol9c38mczgtmZKSZAhsqifstwmnYBws
        5Wp9t8MaemqCGxouNmPMAr6O9bhOZzyzxRCHfUcsn8JBaFoHDxpEGlblAhlRSWsRUQ56AEkhuf6
        GYvEDROKSaP012EtLz6Sq4xA=
X-Received: by 2002:a50:d589:: with SMTP id v9mr10813396edi.126.1622216569044;
        Fri, 28 May 2021 08:42:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyh7puphKWIHAhTU3NrGDcpIPKc1l/cTOKXvbBu9zHj9YOh1870e+pFMIR14K/Zqb2VV4uAA==
X-Received: by 2002:a50:d589:: with SMTP id v9mr10813361edi.126.1622216568644;
        Fri, 28 May 2021 08:42:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v24sm2839644eds.19.2021.05.28.08.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 08:42:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 86A4A180720; Fri, 28 May 2021 17:42:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Greg KH <greg@kroah.com>, Christoph Lameter <cl@gentwo.de>,
        Theodore Ts'o <tytso@mit.edu>, Jiri Kosina <jikos@kernel.org>,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Maintainers / Kernel Summit 2021 planning kick-off
In-Reply-To: <YLEIKk7IuWu6W4Sy@casper.infradead.org>
References: <YH2hs6EsPTpDAqXc@mit.edu>
 <nycvar.YFH.7.76.2104281228350.18270@cbobk.fhfr.pm>
 <YIx7R6tmcRRCl/az@mit.edu>
 <alpine.DEB.2.22.394.2105271522320.172088@gentwo.de>
 <YK+esqGjKaPb+b/Q@kroah.com>
 <c46dbda64558ab884af060f405e3f067112b9c8a.camel@HansenPartnership.com>
 <YLEIKk7IuWu6W4Sy@casper.infradead.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 28 May 2021 17:42:47 +0200
Message-ID: <87im32g8zs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, May 28, 2021 at 07:58:10AM -0700, James Bottomley wrote:
>> On Thu, 2021-05-27 at 15:29 +0200, Greg KH wrote:
>> > On Thu, May 27, 2021 at 03:23:03PM +0200, Christoph Lameter wrote:
>> > > On Fri, 30 Apr 2021, Theodore Ts'o wrote:
>> > > 
>> > > > I know we're all really hungry for some in-person meetups and
>> > > > discussions, but at least for LPC, Kernel Summit, and
>> > > > Maintainer's Summit, we're going to have to wait for another
>> > > > year,
>> > > 
>> > > Well now that we are vaccinated: Can we still change it?
>> > > 
>> > 
>> > Speak for yourself, remember that Europe and other parts of the world
>> > are not as "flush" with vaccines as the US currently is :(
>> 
>> The rollout is accelerating in Europe.  At least in Germany, I know
>> people younger than me are already vaccinated.  I think by the end of
>> September the situation will be better ... especially if the EU and US
>> agree on this air bridge (and the US actually agrees to let EU people
>> in).
>> 
>> One of the things Plumbers is thinking of is having a meetup at what
>> was OSS EU but which is now in Seattle.  The Maintainer's summit could
>> do the same thing.  We couldn't actually hold Plumbers in Seattle
>> because the hotels still had masks and distancing requirements for
>> events that effectively precluded the collaborative aspects of
>> microconferences, but evening events will be governed by local
>> protocols, rather than the Hotel, which are already more relaxed.
>
> Umm.  Let's remember that the vaccines are 33-93% effective [1],
> which means that there's approximately a 100% certainty that at least
> one person arriving at the event from a trans-atlantic flight has been
> exposed to someone who has the virus.  I'm not convinced that holding a
> "more relaxed protocol" event is a great idea.

Not to mention the fact that this would exclude everyone from parts of
the world that do not have a high vaccine coverage or a cosy "air
bridge" type relationship with the US (whatever that means); aren't we
supposed to be an international community? :/

-Toke

