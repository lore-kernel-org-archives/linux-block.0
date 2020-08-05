Return-Path: <SRS0=yU/V=BP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC1C433DF
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 23:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5AB21D95
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 23:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHEXwZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:52:25 -0400
Received: from namei.org ([65.99.196.166]:57738 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgHEXwY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Aug 2020 19:52:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 075Npvex020649;
        Wed, 5 Aug 2020 23:51:57 GMT
Date:   Thu, 6 Aug 2020 09:51:57 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        snitzer@redhat.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com, paul@paul-moore.com,
        corbet@lwn.net, nramas@linux.microsoft.com, serge@hallyn.com,
        pasha.tatashin@soleen.com, jannh@google.com,
        linux-block@vger.kernel.org, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, mdsakib@microsoft.com,
        linux-kernel@vger.kernel.org, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
In-Reply-To: <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.2008060949410.20084@namei.org>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>   <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>   <20200802143143.GB20261@amd>   <1596386606.4087.20.camel@HansenPartnership.com>   <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
  <1596639689.3457.17.camel@HansenPartnership.com>  <alpine.LRH.2.21.2008050934060.28225@namei.org> <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 5 Aug 2020, Mimi Zohar wrote:

> If block layer integrity was enough, there wouldn't have been a need
> for fs-verity.   Even fs-verity is limited to read only filesystems,
> which makes validating file integrity so much easier.  From the
> beginning, we've said that fs-verity signatures should be included in
> the measurement list.  (I thought someone signed on to add that support
> to IMA, but have not yet seen anything.)
> 
> Going forward I see a lot of what we've accomplished being incorporated
> into the filesystems.  When IMA will be limited to defining a system
> wide policy, I'll have completed my job.

What are your thoughts on IPE being a standalone LSM? Would you prefer to 
see its functionality integrated into IMA?

