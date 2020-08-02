Return-Path: <SRS0=z7Vg=BM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C88C433DF
	for <linux-block@archiver.kernel.org>; Sun,  2 Aug 2020 11:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B18B2075B
	for <linux-block@archiver.kernel.org>; Sun,  2 Aug 2020 11:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHBLzy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Aug 2020 07:55:54 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51100 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgHBLzy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Aug 2020 07:55:54 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 24A5A1C0BDB; Sun,  2 Aug 2020 13:55:51 +0200 (CEST)
Date:   Sun, 2 Aug 2020 13:55:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Deven Bowers <deven.desai@linux.microsoft.com>
Cc:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, eparis@redhat.com,
        jannh@google.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com, tyhicks@linux.microsoft.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM (IPE)
Message-ID: <20200802115545.GA1162@bug>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

> IPE is a Linux Security Module which allows for a configurable
> policy to enforce integrity requirements on the whole system. It
> attempts to solve the issue of Code Integrity: that any code being
> executed (or files being read), are identical to the version that
> was built by a trusted source.

How is that different from security/integrity/ima?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
