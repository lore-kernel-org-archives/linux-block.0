Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EA3C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 00:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1587A20835
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 00:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOGPfuVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfCTAxx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:53:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39079 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfCTAxx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 20:53:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so599953pfo.6
        for <linux-block@vger.kernel.org>; Tue, 19 Mar 2019 17:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dpCddqCmlhGyWyhS7C7r0+CGxfO81qERzU0CKME3BPQ=;
        b=JOGPfuVp00PibJiY1lX80qZBVdsO5epnmcGnA4moddPxIant5w0zqj+2ybWCeSXZJ6
         0jCUUUZi3eW295+Sh5BtwmBYtxZ8as2yWJ1lkSvD0V3FIbVGUGdUrmSjsbBioGRy0SwT
         a6/EuOxh+DliX9Tz6xEanzUqCSWW7m3i9fUPPukpY/7muVzgmv6BgnLjRc6WRx+ZVNVu
         5Q9Su7CxEkc2/o/UE8OBtbyS5pL0hkBNHWmIRuiVmKFJd+gJGHZ6Za0G/O91bmw5R6TB
         Hn6dGyy6zJ76TZOcvfzWJ/3x+kcF43IgpGFCCVrJI7LZneZuaWvgCS4EJjgCpeSIhYcA
         CJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dpCddqCmlhGyWyhS7C7r0+CGxfO81qERzU0CKME3BPQ=;
        b=NinKnIZlq35qD+C8562HyoDzPRbfADUHufQVdwwNOeWfv34rcSRIn/2mKSrnKIScET
         oz5K++Md1qIFH+u46W2nGP9e6ygn7IagXFZcIAKCauEuh+qBfaElf7MHdLyNEJAcfg2D
         hBZ4JWwMEsVdh2phroHBWmRno0muGqeYdP5rkQHfux007C/qjZ6azqwcr+Yyxfdb+/uk
         cVKd6A4URv7Hc8TkW5l4PmRJljix03dRt5AytlS6imNt88KlEFEiFs5Yb8NyAV79pUT8
         AFMC0wRhmHp0Lg0SsQUnzmCoKC+z+mj3CsMKfhBNCm74shYekE3gWSLe76FhNltAJH6J
         2TyA==
X-Gm-Message-State: APjAAAUfcirBPHJVN1DSx8VCkp+zAMqkZ2n72maWX6bUk1mWRaBrprv8
        sGY8xXo22iWw+dNtn0JH6bKUJQ==
X-Google-Smtp-Source: APXvYqzmJ7dvx65HjZAxLlw7ltFKPcvUh2AmbHzeB3QMbmXSc2V8s1/umdgGWpPJmU3/OFGevH9fwA==
X-Received: by 2002:a63:e002:: with SMTP id e2mr5015037pgh.300.1553043232442;
        Tue, 19 Mar 2019 17:53:52 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id i126sm316612pfc.101.2019.03.19.17.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 17:53:51 -0700 (PDT)
Date:   Tue, 19 Mar 2019 17:53:51 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christopher Lameter <cl@linux.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [RFC 0/2] guarantee natural alignment for kmalloc()
In-Reply-To: <01000169988d4e34-b4178f68-c390-472b-b62f-a57a4f459a76-000000@email.amazonses.com>
Message-ID: <alpine.DEB.2.21.1903191751560.18028@chino.kir.corp.google.com>
References: <20190319211108.15495-1-vbabka@suse.cz> <01000169988d4e34-b4178f68-c390-472b-b62f-a57a4f459a76-000000@email.amazonses.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 20 Mar 2019, Christopher Lameter wrote:

> > The recent thread [1] inspired me to look into guaranteeing alignment for
> > kmalloc() for power-of-two sizes. Turns out it's not difficult and in most
> > configuration nothing really changes as it happens implicitly. More details in
> > the first patch. If we agree we want to do this, I will see where to update
> > documentation and perhaps if there are any workarounds in the tree that can be
> > converted to plain kmalloc() afterwards.
> 
> This means that the alignments are no longer uniform for all kmalloc
> caches and we get back to code making all sorts of assumptions about
> kmalloc alignments.
> 
> Currently all kmalloc objects are aligned to KMALLOC_MIN_ALIGN. That will
> no longer be the case and alignments will become inconsistent.
> 
> I think its valuable that alignment requirements need to be explicitly
> requested.
> 
> Lets add an array of power of two aligned kmalloc caches if that is really
> necessary. Add some GFP_XXX flag to kmalloc to make it ^2 aligned maybe?
> 

No objection, but I think the GFP flags should remain what they are for: 
to Get Free Pages.  If we are to add additional flags to specify 
characteristics of slab objects, can we add a kmalloc_flags() variant that 
will take a new set of flags?  SLAB_OBJ_ALIGN_POW2?
