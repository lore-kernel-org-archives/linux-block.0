Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100BFC54FCB
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A3B2082E
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 16:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDVQnY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:43:24 -0400
Received: from namei.org ([65.99.196.166]:52006 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgDVQnY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 12:43:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 03MGgnwT012761;
        Wed, 22 Apr 2020 16:42:49 GMT
Date:   Thu, 23 Apr 2020 02:42:49 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     deven.desai@linux.microsoft.com
cc:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        "Serge E. Hallyn" <serge@hallyn.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, jannh@google.com,
        tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chad Sellers <csellers@tresys.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [RFC PATCH v3 05/12] fs: add security blob and hooks for
 block_device
In-Reply-To: <20200415162550.2324-6-deven.desai@linux.microsoft.com>
Message-ID: <alpine.LRH.2.21.2004230234420.12318@namei.org>
References: <20200415162550.2324-1-deven.desai@linux.microsoft.com> <20200415162550.2324-6-deven.desai@linux.microsoft.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 15 Apr 2020, deven.desai@linux.microsoft.com wrote:

> From: Deven Bowers <deven.desai@linux.microsoft.com>
> 
> Add a security blob and associated allocation, deallocation and set hooks
> for a block_device structure.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>

Is there any feedback from block or LSM folk on the addition of a security 
blob for block_device here?

IPE uses this is to track the status of integrity verification of e.g. 
DM-Verity devices, per this code from a subsequent patch:


+       ret = security_bdev_setsecurity(dm_table_get_md(v->ti->table)->bdev,
+                                       DM_VERITY_SIGNATURE_SEC_NAME,
+                                       v->sig->sig, v->sig->sig_size);


-- 
James Morris
<jmorris@namei.org>

