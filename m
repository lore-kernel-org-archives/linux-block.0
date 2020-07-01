Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC82C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 14:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E15D20702
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 14:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgGAOOE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:14:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55467 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728712AbgGAOOE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 10:14:04 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 061EDvRt011986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Jul 2020 10:13:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0CBC14200D9; Wed,  1 Jul 2020 10:13:57 -0400 (EDT)
Date:   Wed, 1 Jul 2020 10:13:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dave Airlie <airlied@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, inux-fsdevel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: Maintainers / Kernel Summit 2020 planning kick-off
Message-ID: <20200701141356.GF5484@mit.edu>
References: <20200515163956.GA2158595@mit.edu>
 <CAPM=9tz3heu1-xTyYDA4huszt3LLgF87pKcifc+OCFqJv-KWdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tz3heu1-xTyYDA4huszt3LLgF87pKcifc+OCFqJv-KWdA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 01, 2020 at 09:12:31AM +1000, Dave Airlie wrote:
> 
> What timezone are the conferences being held in? It impacts on what I
> can attend quite heavily :-)

When you register for the Linux Plumbers Conference, there will be an
opportunity for you to indicate your timezone preferences.  The
current thinking is that the timing will be like many of the virtual
conferences, which is to run it only for at most 3-4 hours a day, at
hours when it is most, convenient for the people who have registered.
That's for the Kernel Summit.

For the Maintainer's Summit, due to the lack of topic proposals, we
are probably going to end up skipping it for this year.

Cheers,

    	     	      	     	      	     - Ted

