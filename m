Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA5C433E4
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 22:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3982075D
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 22:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgG1Wkj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgG1Wkj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 18:40:39 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66393C061794;
        Tue, 28 Jul 2020 15:40:39 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0YGR-004arw-Eo; Tue, 28 Jul 2020 22:40:03 +0000
Date:   Tue, 28 Jul 2020 23:40:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Deven Bowers <deven.desai@linux.microsoft.com>, agk@redhat.com,
        axboe@kernel.dk, snitzer@redhat.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, paul@paul-moore.com,
        eparis@redhat.com, jannh@google.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com, tyhicks@linux.microsoft.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v5 05/11] fs: add security blob and hooks for
 block_device
Message-ID: <20200728224003.GC951209@ZenIV.linux.org.uk>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200728213614.586312-6-deven.desai@linux.microsoft.com>
 <ef0fff6f-410a-6444-f1e3-03499a2f52b7@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0fff6f-410a-6444-f1e3-03499a2f52b7@schaufler-ca.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 28, 2020 at 03:22:59PM -0700, Casey Schaufler wrote:

> > +	hlist_for_each_entry(p, &security_hook_heads.bdev_setsecurity, list) {
> > +		rc = p->hook.bdev_setsecurity(bdev, name, value, size);
> > +
> > +		if (rc == -ENOSYS)
> > +			rc = 0;
> > +
> > +		if (rc != 0)
> 
> Perhaps:
> 		else if (rc != 0)
> 
> > +			break;
> > +	}
> > +
> > +	return rc;

	hlist_for_each_entry(p, &security_hook_heads.bdev_setsecurity, list) {
		rc = p->hook.bdev_setsecurity(bdev, name, value, size);
		if (rc && rc != -ENOSYS)
			return rc;
	}
	return 0;

Easier to reason about that way...
